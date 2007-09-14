Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3123ADDE1D
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:01:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ1CNx027254
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:01:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ1ChU497298
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ1B8Q012190
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:12 -0600
Message-Id: <20070914185649.551007000@linux.vnet.ibm.com>>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
Date: Fri, 14 Sep 2007 13:54:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 4/4] 4xx: Convert Seqouia flash mappings to new binding
In-Reply-To: <20070914185410.387074000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A new binding for flash devices was recently introduced.  This updates the
Sequoia DTS to use the new binding and enabled MTD in the defconfig.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/sequoia.dts      |   38 +++++++++----
 arch/powerpc/configs/sequoia_defconfig |   91 +++++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 14 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts
@@ -142,19 +142,35 @@
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
-					device_type = "rom";
-					compatible = "direct-mapped";
-					probe-type = "CFI";
+					compatible = "amd,s29gl256n", "cfi-flash";
 					bank-width = <2>;
-					partitions = <	0	180000
-							180000	200000
-							380000	3aa0000
-							3e20000	140000
-							3f60000	40000
-							3fa0000	60000>;
-					partition-names = "Kernel", "ramdisk", "file system",
-								"kozio", "env", "u-boot";
 					reg = <0 000000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "Kernel";
+						reg = <0 180000>;
+					};
+					partition@180000 {
+						label = "ramdisk";
+						reg = <180000 200000>;
+					};
+					partition@380000 {
+						label = "file system";
+						reg = <380000 3aa0000>;
+					};
+					partition@3e20000 {
+						label = "kozio";
+						reg = <3e20000 140000>;
+					};
+					partition@3f60000 {
+						label = "env";
+						reg = <3f60000 40000>;
+					};
+					partition@3fa0000 {
+						label = "u-boot";
+						reg = <3fa0000 60000>;
+					};
 				};
 
 			};
--- linux-2.6.orig/arch/powerpc/configs/sequoia_defconfig
+++ linux-2.6/arch/powerpc/configs/sequoia_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc3
-# Mon Aug 27 20:19:13 2007
+# Linux kernel version: 2.6.23-rc6
+# Fri Sep 14 13:20:06 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -146,6 +146,7 @@ CONFIG_440A=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
 
 #
 # Kernel options
@@ -317,7 +318,81 @@ CONFIG_FW_LOADER=y
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
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
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
+CONFIG_MTD_CFI_INTELEXT=y
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
@@ -613,6 +688,15 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -671,6 +755,7 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y

-- 
