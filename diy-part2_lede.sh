#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Clear the login password
# sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

# 修改版本为编译日期
# date_version=$(date +"%y.%m.%d")
# orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
# sed -i "s/${orig_version}/R${date_version} by AoThen/g" package/lean/default-settings/files/zzz-default-settings

#替换aliyundrive-webdav高版本
# sed -i 's/1.10.3/1.10.6/g' feeds/packages/multimedia/aliyundrive-webdav/Makefile


#删除原默认主题
rm -rf feeds/luci/themes/luci-theme-argon


#设置luci-theme-argon默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' `find package -type f -path '*/default-settings/files/zzz-default-settings'`

#添加额外软件包
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon-18.06 #Lean源码
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config package/lean/luci-app-argon-config #加入JerryKuKu’s Argon Config

git clone https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr


# 修改默认wifi名称ssid为AX6S
sed -i 's/ssid=OpenWrt/ssid=AX6S/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh