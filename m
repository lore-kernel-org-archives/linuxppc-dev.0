Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B7C3DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 19:33:52 +1100 (EST)
From: Grzegorz Bernacki <gjb@semihalf.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Defconfig for mpc5200 updates.
Date: Mon,  9 Feb 2009 09:33:44 +0100
Message-Id: <1234168424311-git-send-email-gjb@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for:
 - LXT phy
 - AT24 eeprom
 - RTC (DS1337)
 - MTD partitioning based on OF description

Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
---
 arch/powerpc/configs/mpc5200_defconfig |   72 ++++++++++++++++++++++++++++----
 1 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 81afc8b..8afcaac 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc2
-# Mon Jan 26 21:40:44 2009
+# Linux kernel version: 2.6.29-rc3
+# Fri Feb  6 09:48:53 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -166,6 +166,7 @@ CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 CONFIG_PPC_EFIKA=y
 CONFIG_PPC_LITE5200=y
+# CONFIG_PPC_MEDIA5200 is not set
 CONFIG_PPC_MPC5200_BUGFIX=y
 # CONFIG_PPC_MPC5200_GPIO is not set
 # CONFIG_PPC_PMAC is not set
@@ -388,7 +389,10 @@ CONFIG_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_TESTS is not set
-# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_OF_PARTS is not set
 # CONFIG_MTD_AR7_PARTS is not set
@@ -502,7 +506,7 @@ CONFIG_MISC_DEVICES=y
 #
 # EEPROM support
 #
-# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_AT24=y
 # CONFIG_EEPROM_LEGACY is not set
 # CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
@@ -678,7 +682,7 @@ CONFIG_PHYLIB=y
 # CONFIG_MARVELL_PHY is not set
 # CONFIG_DAVICOM_PHY is not set
 # CONFIG_QSEMI_PHY is not set
-# CONFIG_LXT_PHY is not set
+CONFIG_LXT_PHY=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
@@ -815,8 +819,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1281,7 +1283,61 @@ CONFIG_NEW_LEDS=y
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+CONFIG_RTC_DRV_DS1307=y
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_RTC_DRV_PPC is not set
 # CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
-- 
1.6.0.6
