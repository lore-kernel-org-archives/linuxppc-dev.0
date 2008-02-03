Return-Path: <kaloz@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [195.56.146.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88C63DDE17
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 21:47:21 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 8707D7840FE
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 11:41:45 +0100 (CET)
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUYBNNBNejAO for <linuxppc-dev@ozlabs.org>;
	Sun,  3 Feb 2008 11:41:45 +0100 (CET)
Received: from localhost.localdomain (catv-50626a0d.catv.broadband.hu
	[80.98.106.13])
	by arrakis.dune.hu (Postfix) with ESMTP id 595907840FC
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 11:41:45 +0100 (CET)
From: Imre Kaloz <kaloz@openwrt.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] MTD support for the AMCC Taishan
Date: Sun,  3 Feb 2008 11:41:44 +0100
Message-Id: <120203530465-git-send-email-kaloz@openwrt.org>
In-Reply-To: y
References: y
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
 arch/powerpc/boot/dts/taishan.dts      |   33 +++++++++++-
 arch/powerpc/configs/taishan_defconfig |   89 ++++++++++++++++++++++++++++++--
 2 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 0706a4a..28c14dd 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -174,7 +174,38 @@
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
+						reg = <380000 3a80000>;
+					};
+					partition@3e00000 {
+						label = "kozio";
+						reg = <3e00000 140000>;
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
index ade84b9..4d17a5d 100644
--- a/arch/powerpc/configs/taishan_defconfig
+++ b/arch/powerpc/configs/taishan_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24-rc6
-# Mon Dec 24 11:23:39 2007
+# Linux kernel version: 2.6.24
+# Sun Feb  3 00:40:49 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -103,6 +103,7 @@ CONFIG_SLUB_DEBUG=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -146,7 +147,9 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_TAISHAN=y
 # CONFIG_KATMAI is not set
 # CONFIG_RAINIER is not set
+# CONFIG_WARP is not set
 CONFIG_440GX=y
+# CONFIG_IPIC is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -330,7 +333,83 @@ CONFIG_FW_LOADER=y
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
@@ -385,7 +464,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -414,6 +492,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
 # CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -641,6 +720,7 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -675,7 +755,6 @@ CONFIG_SUNRPC=y
 CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 # CONFIG_DLM is not set
-# CONFIG_UCC_SLOW is not set
 
 #
 # Library routines
-- 
1.5.2.5
