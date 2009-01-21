Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E060FDDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:09:39 +1100 (EST)
Date: Tue, 20 Jan 2009 20:09:36 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: Defconfig support
Message-ID: <20090120200936.1cdc91b4@lappy.seanm.ca>
In-Reply-To: <20090120112930.GF3853@zod.rchland.ibm.com>
References: <20090119232136.717eddf3@lappy.seanm.ca>
	<20090120112930.GF3853@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 Jan 2009 06:29:30 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> Since I'll be doing defconfig updates today, just tell me which
> options you need set or disabled.

Let's try this patch and see how it goes. If it doesn't apply easily, I
will just give you a list. 

Note a few of the options will be disabled with the make oldconfig and
that is fine.

The ones I know will be disabled are the PIKA_SD driver and the
PIKA_LEDS driver. Also I don't think it will let you disabled
SCSI_WAIT_SCAN :( You have to patch a Kconfig for that.

Cheers,
   Sean

--- /tmp/orig-config	2009-01-20 19:49:57.000000000 -0500
+++ arch/powerpc/configs/44x/warp_defconfig	2009-01-20 19:59:23.000000000 -0500
@@ -390,7 +390,7 @@
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
-# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_OF_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
 
@@ -405,7 +405,7 @@
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
-CONFIG_MTD_OOPS=m
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -459,7 +459,7 @@
 CONFIG_MTD_NAND_ECC_SMC=y
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_IDS=y
-# CONFIG_MTD_NAND_NDFC is not set
+CONFIG_MTD_NAND_NDFC=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
@@ -529,7 +529,7 @@
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
+# CONFIG_SCSI_WAIT_SCAN is not set
 
 #
 # SCSI Transports
@@ -663,7 +663,7 @@
 #
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
-# CONFIG_I2C_IBM_IIC is not set
+CONFIG_I2C_IBM_IIC=y
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_SIMTEC is not set
@@ -685,8 +685,8 @@
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_AT24=y
+# CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -704,7 +704,7 @@
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_AD7414 is not set
+CONFIG_SENSORS_AD7414=y
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
@@ -757,8 +757,21 @@
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 CONFIG_THERMAL=y
-# CONFIG_THERMAL_HWMON is not set
-# CONFIG_WATCHDOG is not set
+CONFIG_THERMAL_HWMON=y
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_PIKA_WDT=y
+# CONFIG_BOOKE_WDT is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
 #
@@ -916,14 +929,14 @@
 #
 # OTG and related infrastructure
 #
-CONFIG_MMC=m
+CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
 # MMC/SD/SDIO Card Drivers
 #
-CONFIG_MMC_BLOCK=m
+CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_SDIO_UART is not set
 # CONFIG_MMC_TEST is not set
@@ -933,9 +946,21 @@
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_WBSD is not set
-# CONFIG_MMC_PIKASD is not set
+CONFIG_MMC_PIKASD=y
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_WARP=y
+# CONFIG_LEDS_PCA955X is not set
+
+#
+# LED Triggers
+#
+# CONFIG_LEDS_TRIGGERS is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
@@ -949,8 +974,11 @@
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -990,7 +1018,8 @@
 CONFIG_PROC_SYSCTL=y
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
 CONFIG_MISC_FILESYSTEMS=y
@@ -1178,7 +1207,7 @@
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
 # CONFIG_XMON is not set
-# CONFIG_IRQSTACKS is not set
+CONFIG_IRQSTACKS=y
 # CONFIG_VIRQ_DEBUG is not set
 CONFIG_BDI_SWITCH=y
 # CONFIG_PPC_EARLY_DEBUG is not set
