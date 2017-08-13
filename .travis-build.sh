#!/bin/bash
ROOT=$TRAVIS_BUILD_DIR/..

# Fail the whole script if any command fails
set -e

## Build Checker Framework
(cd $ROOT && git clone --depth 1 https://github.com/typetools/checker-framework.git)
# This also builds annotation-tools and jsr308-langtools
(cd $ROOT/checker-framework/ && ./.travis-build-without-test.sh downloadjdk)
export CHECKERFRAMEWORK=$ROOT/checker-framework

## Obtain daikon
(cd $ROOT && git clone --depth 1 https://github.com/codespecs/daikon.git)
make -C $ROOT/daikon/java compile dyncomp-jdk
make -C $ROOT/daikon daikon.jar

make -C $ROOT/daikon/java check-signature
