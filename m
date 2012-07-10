Return-Path: <B36685@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D7C82C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 20:59:34 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/fsl: Update corenet32_smp_defconfig
Date: Tue, 10 Jul 2012 18:38:20 +0800
Message-ID: <1341916701-19551-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Enable NAND, MSI, PAMU,
* Enable FSL RAID on P5020
* Enable general RAID features (MD + async-tx)
* Enable RTC on P2041RDB
* Enable UIO SRIO & UIO DMA

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 91db656..eafb64f 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -34,8 +34,10 @@ CONFIG_BINFMT_MISC=m
 CONFIG_KEXEC=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_FSL_LBC=y
+CONFIG_FSL_PAMU=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MSI=y
 # CONFIG_PCIEASPM is not set
 CONFIG_RAPIDIO=y
 CONFIG_FSL_RIO=y
@@ -76,11 +78,16 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_BLK_DEV_RAM_SIZE=262144
 CONFIG_MISC_DEVICES=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -95,6 +102,10 @@ CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
 CONFIG_SATA_SIL=y
 CONFIG_PATA_SIL680=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_MD_RAID456=y
+CONFIG_MULTICORE_RAID456=y
 CONFIG_NETDEVICES=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_E1000=y
@@ -136,13 +147,21 @@ CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_OF=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_MPC85XX=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_RAID=y
+CONFIG_ASYNC_TX_DMA=y
 CONFIG_UIO=y
+CONFIG_UIO_FSL_SRIO=y
+CONFIG_UIO_FSL_DMA=y
 CONFIG_STAGING=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
@@ -171,6 +190,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-- 
1.6.4
