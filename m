Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D9D81DDF22
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 22:47:38 +1000 (EST)
Date: Wed, 11 Jun 2008 16:47:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3] powerpc/83xx: update mpc83xx_defconfig to support
	MPC8360E-RDK
Message-ID: <20080611124737.GA15869@polina.dev.rtsoft.ru>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190049.GE21203@polina.dev.rtsoft.ru>
	<67EC8BE5-3BF0-4107-8FA9-A058283E7EB5@kernel.crashing.org>
	<20080610193215.GA14162@polina.dev.rtsoft.ru>
	<057C3E99-B1DC-49BF-B9A8-4C72D943E920@kernel.crashing.org>
	<20080610231654.GA12300@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080610231654.GA12300@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates mpc83xx_defconfig to support MPC8360E-RDK board.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Completely forgot about BROADCOM_PHY, added now. Without it, only
u-boot initialized BCM PHY will work, second one will unable to
receive/transmit any data.

 arch/powerpc/configs/mpc83xx_defconfig |   67 +++++++++++++++++++++++++++++---
 1 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 4293c8b..0e16364 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.26-rc5
-# Mon Jun  9 08:52:14 2008
+# Wed Jun 11 15:35:09 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -38,6 +38,7 @@ CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -166,6 +167,7 @@ CONFIG_MPC832x_RDB=y
 CONFIG_MPC834x_MDS=y
 CONFIG_MPC834x_ITX=y
 CONFIG_MPC836x_MDS=y
+CONFIG_MPC836x_RDK=y
 CONFIG_MPC837x_MDS=y
 CONFIG_MPC837x_RDB=y
 CONFIG_SBC834x=y
@@ -241,6 +243,8 @@ CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
+CONFIG_FSL_LBC=y
+CONFIG_FSL_GTM=y
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
@@ -356,7 +360,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -398,7 +402,7 @@ CONFIG_MTD_CFI_I1=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
@@ -438,6 +442,7 @@ CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ALAUDA is not set
 CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_UPM=y
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -445,6 +450,7 @@ CONFIG_MTD_NAND_FSL_ELBC=y
 #
 # CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_GPIO=y
 CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -535,7 +541,7 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_CICADA_PHY is not set
 CONFIG_VITESSE_PHY=y
 # CONFIG_SMSC_PHY is not set
-# CONFIG_BROADCOM_PHY is not set
+CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 # CONFIG_REALTEK_PHY is not set
 # CONFIG_FIXED_PHY is not set
@@ -636,7 +642,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_OF_PLATFORM is not set
-# CONFIG_SERIAL_QE is not set
+CONFIG_SERIAL_QE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -655,6 +661,7 @@ CONFIG_I2C_CHARDEV=y
 #
 # I2C Hardware Bus support
 #
+# CONFIG_I2C_GPIO is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
@@ -672,6 +679,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
@@ -679,6 +687,21 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+CONFIG_HAVE_GPIO_LIB=y
+
+#
+# GPIO Support
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# SPI GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
@@ -780,13 +803,43 @@ CONFIG_DAB=y
 #
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+CONFIG_FB_FOREIGN_ENDIAN=y
+CONFIG_FB_BOTH_ENDIAN=y
+# CONFIG_FB_BIG_ENDIAN is not set
+# CONFIG_FB_LITTLE_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+CONFIG_FB_MACMODES=y
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+CONFIG_FB_OF=y
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_FSL_DIU is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_LOGO is not set
 
 #
 # Sound
@@ -1012,8 +1065,10 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SYSV68_PARTITION is not set
 # CONFIG_NLS is not set
 # CONFIG_DLM is not set
+CONFIG_UCC_SLOW=y
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
+CONFIG_QE_GPIO=y
 
 #
 # Library routines
-- 
1.5.5.4
