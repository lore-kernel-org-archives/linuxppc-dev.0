Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00AE41A018A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 01:40:47 +1000 (EST)
Message-ID: <53EB86E9.9070702@freescale.com>
Date: Wed, 13 Aug 2014 18:40:25 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl-booke64: add missing virtualization options in
 defconfig
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 32-bit defconfig version has these enabled
for years so make the 64-bit defconfig have them too.
This patch only adds CONFIG_VIRT_DRIVERS,
CONFIG_FSL_HV_MANAGER and CONFIG_PPC_EPAPR_HV_BYTECHAN
other changes being "make savedefconfig" artifacts.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
based on git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

 arch/powerpc/configs/corenet64_smp_defconfig | 44 +++++-----------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 4b07bad..9402b00 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -49,7 +49,6 @@ CONFIG_NET_IPIP=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
 CONFIG_INET_ESP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
@@ -59,33 +58,17 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_FTL=y
 CONFIG_MTD_CFI=y
-CONFIG_MTD_GEN_PROBE=y
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
-CONFIG_MTD_MAP_BANK_WIDTH_4=y
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_CFI_UTIL=y
-CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_WL_THRESHOLD=4096
-CONFIG_MTD_UBI_BEB_RESERVE=1
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
@@ -101,6 +84,7 @@ CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=y
+CONFIG_PPC_EPAPR_HV_BYTECHAN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
@@ -114,7 +98,6 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
@@ -123,14 +106,17 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_VIRT_DRIVERS=y
+CONFIG_FSL_HV_MANAGER=y
+CONFIG_FSL_CORENET_CF=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
@@ -143,16 +129,9 @@ CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
-CONFIG_MISC_FILESYSTEMS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=1
-CONFIG_JFFS2_FS_WRITEBUFFER=y
-CONFIG_JFFS2_ZLIB=y
-CONFIG_JFFS2_RTIME=y
 CONFIG_UBIFS_FS=y
-CONFIG_UBIFS_FS_XATTR=y
-CONFIG_UBIFS_FS_LZO=y
-CONFIG_UBIFS_FS_ZLIB=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
@@ -160,18 +139,12 @@ CONFIG_NFSD=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_CRC_T10DIF=y
-CONFIG_CRC16=y
-CONFIG_ZLIB_DEFLATE=y
-CONFIG_LZO_COMPRESS=y
-CONFIG_LZO_DECOMPRESS=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
+CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=1024
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
@@ -179,4 +152,3 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
-CONFIG_FSL_CORENET_CF=y
-- 
1.9.2
