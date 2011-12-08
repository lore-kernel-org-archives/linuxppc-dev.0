Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05DD41007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 18:11:28 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB87BPmd013165
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 01:11:25 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Update defconfigs to enable some standard FSL HW
 features
Date: Thu,  8 Dec 2011 01:11:25 -0600
Message-Id: <1323328285-11969-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

corenet64_smp_defconfig:
 - enabled rapidio

corenet32_smp_defconfig:
 - enabled hugetlbfs, rapidio

mpc85xx_smp_defconfig:
 - enabled P1010RDB, hugetlbfs, SPI, SDHC, Crypto/CAAM

mpc85xx_smp_defconfig:
 - enabled hugetlbfs, SPI, SDHC, Crypto/CAAM

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/corenet32_smp_defconfig |   10 ++++++----
 arch/powerpc/configs/corenet64_smp_defconfig |    3 ++-
 arch/powerpc/configs/mpc85xx_defconfig       |   17 ++++++++++++-----
 arch/powerpc/configs/mpc85xx_smp_defconfig   |   18 +++++++++++++-----
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index f087de6..c398779 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -37,6 +37,8 @@ CONFIG_FSL_LBC=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 # CONFIG_PCIEASPM is not set
+CONFIG_RAPIDIO=y
+CONFIG_FSL_RIO=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -94,12 +96,11 @@ CONFIG_SATA_SIL24=y
 CONFIG_SATA_SIL=y
 CONFIG_PATA_SIL680=y
 CONFIG_NETDEVICES=y
-CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
+CONFIG_FSL_PQ_MDIO=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
-CONFIG_FSL_PQ_MDIO=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -155,6 +156,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 782822c..006bd94 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -23,6 +23,8 @@ CONFIG_P5020_DS=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
+CONFIG_RAPIDIO=y
+CONFIG_FSL_RIO=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -57,7 +59,6 @@ CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index a1e5a17..f37a2ab 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -1,5 +1,4 @@
 CONFIG_PPC_85xx=y
-CONFIG_PHYS_64BIT=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -93,15 +92,14 @@ CONFIG_SATA_FSL=y
 CONFIG_PATA_ALI=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_FS_ENET=y
+CONFIG_UCC_GETH=y
+CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_FS_ENET=y
-CONFIG_GIANFAR=y
-CONFIG_UCC_GETH=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -120,6 +118,9 @@ CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_SPI_FSL_ESPI=y
 CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
@@ -163,6 +164,10 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
@@ -182,6 +187,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
@@ -213,4 +219,5 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index dd1e413..abdcd31 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -1,5 +1,4 @@
 CONFIG_PPC_85xx=y
-CONFIG_PHYS_64BIT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_EXPERIMENTAL=y
@@ -26,6 +25,7 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
+CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
@@ -94,15 +94,14 @@ CONFIG_SATA_FSL=y
 CONFIG_PATA_ALI=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_FS_ENET=y
+CONFIG_UCC_GETH=y
+CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_FS_ENET=y
-CONFIG_GIANFAR=y
-CONFIG_UCC_GETH=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -121,6 +120,9 @@ CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_SPI_FSL_ESPI=y
 CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
@@ -164,6 +166,10 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
@@ -183,6 +189,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
+CONFIG_HUGETLBFS=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
@@ -214,4 +221,5 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_TALITOS=y
-- 
1.7.3.4
