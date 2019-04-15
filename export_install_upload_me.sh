#!/bin/bash

REMOTE=""
PROFILE="android24_clang8_armv8"

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -r | --remote)
            REMOTE=$VALUE
            ;;
        -pr | --profile)
            REMOTE=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

conan export . wagcampbell/testing
conan install android-ndk-r19c/0.1@wagcampbell/testing --build=android-ndk-r19c --profile=${PROFILE}
conan upload android-ndk-r19c/0.1@wagcampbell/testing --all -r=${REMOTE}

