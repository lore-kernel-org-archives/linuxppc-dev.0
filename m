Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 6611A67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 07:19:19 +1100 (EST)
Message-ID: <42374345.6080704@timesys.com>
Date: Tue, 15 Mar 2005 15:19:17 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------080208060005040201060508"
Subject: [patch] mpc8560ads mtd platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080208060005040201060508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add an MTD partitions in the platform code for the mpc8560ads board.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com>



--------------080208060005040201060508
Content-Type: text/x-patch;
 name="mpc8560ads.mtd.paltform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8560ads.mtd.paltform.patch"

--- ppc-mpc8560ads/arch/ppc/configs/mpc8560_ads_defconfig-orig
+++ ppc-mpc8560ads/arch/ppc/configs/mpc8560_ads_defconfig

@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc1
-# Thu Jan 20 01:24:56 2005
+# Linux kernel version: 2.6.11.3
+# Tue Mar 15 15:06:17 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -75,6 +75,7 @@
 # CONFIG_MPC8555_CDS is not set
 CONFIG_MPC8560_ADS=y
 # CONFIG_SBC8560 is not set
+# CONFIG_STX_GP3 is not set
 CONFIG_MPC8560=y
 
 #
@@ -134,7 +135,78 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
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
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_XIP is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xff000000
+CONFIG_MTD_PHYSMAP_LEN=0x01000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -540,7 +612,6 @@
 # Graphics support
 #
 # CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -587,6 +658,10 @@
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -631,6 +706,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -648,7 +725,6 @@
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set

--- ppc-mpc8560ads/arch/ppc/platforms/85xx/mpc8560_ads.c-orig
+++ ppc-mpc8560ads/arch/ppc/platforms/85xx/mpc8560_ads.c

@@ -30,6 +30,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
+#include <linux/mtd/physmap.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
@@ -220,3 +221,39 @@
 
 	return;
 }
+
+#ifdef CONFIG_MTD_PHYSMAP
+static struct mtd_partition mpc85xxads_partitions[] = {
+	{
+		.name =   "Linux JFFS2 Filesystem",
+		.offset = 0x0,
+		.size =   0x00800000,
+	},
+	{
+		.name =   "Linux Kernel",
+		.offset = 0x00800000,
+		.size =   0x00200000,
+	},
+	{
+		.name =   "Linux INITRD",
+		.offset = 0x00a00000,
+		.size =   0x00580000,
+	},
+	{
+		.name	= "Bootloader",
+		.offset	= 0x00f80000,
+		.size	= 0x00080000,
+	}
+};
+
+static int __init
+mpc8560ads_setup_mtd(void)
+{
+
+	physmap_set_partitions(&mpc85xxads_partitions[0], 4);
+	return 0;
+}
+
+arch_initcall(mpc8560ads_setup_mtd);
+
+#endif

--------------080208060005040201060508--
