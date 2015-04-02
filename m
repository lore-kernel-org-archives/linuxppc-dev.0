Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A2E41A0C8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 08:56:15 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8C4B14009B
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2015 08:56:13 +1100 (AEDT)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/85xx: miscellaneous changes on mpc85xx_defconfig
Date: Thu, 2 Apr 2015 16:37:51 -0500
Message-ID: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge Freescale's Internal mpc85xx_defconfig with upstream's.
Run savedefconfig to get the minimal change.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 6ecf7bd..0a04104 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -15,7 +15,6 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
@@ -42,7 +41,8 @@ CONFIG_TQM8548=y
 CONFIG_TQM8555=y
 CONFIG_TQM8560=y
 CONFIG_SBC8548=y
-CONFIG_MVME2500=y
+CONFIG_PPC_QEMU_E500=y
+CONFIG_KVM_GUEST=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_HIGHMEM=y
@@ -50,8 +50,6 @@ CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEASPM is not set
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
 CONFIG_NET=y
@@ -88,21 +86,17 @@ CONFIG_FTL=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_LEGACY=y
+CONFIG_IDE=y
+CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
@@ -127,7 +121,6 @@ CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
-CONFIG_BROADCOM_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -136,8 +129,8 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=6
-CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
@@ -190,14 +183,9 @@ CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
-CONFIG_EDAC_MPC85XX=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_DS1374=y
-CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
@@ -218,9 +206,6 @@ CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
-CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
-CONFIG_EFS_FS=m
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=1
 CONFIG_UBIFS_FS=y
@@ -243,6 +228,7 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
-- 
1.9.3
