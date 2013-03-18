Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D0352C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 19:31:42 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: add CONFIG(s) require for using flash controller
Date: Mon, 18 Mar 2013 14:01:23 +0530
Message-ID: <1363595483-7248-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add CONFIG(s) required for NAND and NOR flash controller usage.
It defines MTD, Jffs2 and UBIFS file system required for controllers.

It also enables IFC controller

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
 branch next

 arch/powerpc/configs/corenet64_smp_defconfig |   35 +++++++++++++++++++++++++-
 arch/powerpc/configs/mpc85xx_defconfig       |   31 +++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_smp_defconfig   |   31 +++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 36a5c41..1c6eb66 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -26,6 +26,7 @@ CONFIG_P5040_DS=y
 CONFIG_T4240_QDS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
+CONFIG_FSL_IFC=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
@@ -58,16 +59,33 @@ CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
+CONFIG_FTL=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -122,7 +140,16 @@ CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_MISC_FILESYSTEMS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_XATTR=y
+CONFIG_UBIFS_FS_LZO=y
+CONFIG_UBIFS_FS_ZLIB=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
@@ -130,6 +157,12 @@ CONFIG_NFSD=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_CRC_T10DIF=y
+CONFIG_CRC16=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index e12146f..37812b4 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -47,6 +47,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_FSL_IFC=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
@@ -78,18 +79,33 @@ CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_FTL=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
@@ -207,6 +223,15 @@ CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_XATTR=y
+CONFIG_UBIFS_FS_LZO=y
+CONFIG_UBIFS_FS_ZLIB=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
@@ -225,6 +250,12 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_CRC_T10DIF=y
+CONFIG_CRC16=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
 CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 8d00ea5b..7fc3e6f 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -50,6 +50,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_FSL_IFC=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
@@ -81,18 +82,33 @@ CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_FTL=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
@@ -207,6 +223,15 @@ CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_XATTR=y
+CONFIG_UBIFS_FS_LZO=y
+CONFIG_UBIFS_FS_ZLIB=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
@@ -225,6 +250,12 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_CRC_T10DIF=y
+CONFIG_CRC16=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
 CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-- 
1.7.9.5
