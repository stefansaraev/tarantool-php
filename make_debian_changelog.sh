#!/bin/bash
VERSION=$(date +%Y%m%d-%H%M%S)
DATE=$(date -R)
LASTCOMMIT=$(git log -1 --oneline)

phpversion="$1"

sed -e "s/VERSION/${VERSION}/g;s/DATE/${DATE}/g;s/LASTCOMMIT/Last commit/g" debian/changelog.template > debian/changelog
sed -e "s/\${phpversion}/${phpversion}/" debian/control.in > debian/control
chmod 755 debian/rules

sed -e "s/\${phpversion}/${phpversion}/" debian/php-tarantool.postinst.in \
    > debian/php${phpversion}-tarantool.postinst
sed -e "s/\${phpversion}/${phpversion}/" debian/php-tarantool.postrm.in \
    > debian/php${phpversion}-tarantool.postrm
