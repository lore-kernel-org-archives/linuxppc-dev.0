Return-Path: <kaloz@openwrt.org>
Received: from mail.ahiv.hu (mail.ahiv.hu [195.228.168.219])
	by ozlabs.org (Postfix) with ESMTP id 00078DDF06
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 01:21:40 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ahiv.hu (Postfix) with ESMTP id 028F813DC0F8
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 14:44:22 +0100 (CET)
Received: from mail.ahiv.hu ([127.0.0.1])
	by localhost (mail.ahiv.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIopSv-Fz2a4 for <linuxppc-dev@ozlabs.org>;
	Mon, 17 Mar 2008 14:44:21 +0100 (CET)
Received: from localhost.localdomain (firewall.ahiv.hu [195.228.168.220])
	by mail.ahiv.hu (Postfix) with ESMTP id D719413DC0BF
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 14:44:21 +0100 (CET)
From: Imre Kaloz <kaloz@openwrt.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] MTD support for the AMCC Taishan
Date: Mon, 17 Mar 2008 14:48:23 +0100
Message-Id: <12057617031716-git-send-email-kaloz@openwrt.org>
In-Reply-To: <200802081532.42717.sr@denx.de>
References: <200802081532.42717.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/powerpc/boot/dts/taishan.dts      |   29 +++++++++++-
 arch/powerpc/configs/taishan_defconfig |   79 +++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 8278068..db102e9 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -174,7 +174,34 @@
 				interrupts = <5 4>;
 				interrupt-parent = <&UIC1>;
 
-				/* TODO: Add other EBC devices */
+				nor_flash@0,0 {
+					compatible = "cfi-flash";
+					bank-width = <4>;
+					device-width = <2>;
+					reg = <0 000000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0 180000>;
+					};
+					partition@180000 {
+						label = "root";
+						reg = <180000 200000>;
+					};
+					partition@380000 {
+						label = "user";
+						reg = <380000 3bc0000>;
+					};
+					partition@3f40000 {
+						label = "env";
+						reg = <3f40000 80000>;
+					};
+					partition@3fc0000 {
+						label = "u-boot";
+						reg = <3fc0000 40000>;
+					};
+				};
 			};
 
 
diff --git a/arch/powerpc/configs/taishan_defconfig b/arch/powerpc/configs/taishan_defconfig
index 087aedc..e53c926 100644
--- a/arch/powerpc/configs/taishan_defconfig
+++ b/arch/powerpc/configs/taishan_defconfig
@@ -348,7 +348,83 @@ CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -660,6 +736,7 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
-- 
1.5.2.5
