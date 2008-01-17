Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67CEADE29B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:37:51 +1100 (EST)
Date: Thu, 17 Jan 2008 16:38:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/3] Update mpc8313erdb defconfig for MTD, NAND, JFFS2.
Message-ID: <20080117223811.GC20697@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc8313_rdb_defconfig |   46 ++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/configs/mpc8313_rdb_defconfig b/arch/powerpc/configs/mpc8313_rdb_defconfig
index c9af905..db08e73 100644
--- a/arch/powerpc/configs/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/mpc8313_rdb_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24-rc4
-# Thu Dec  6 16:48:31 2007
+# Linux kernel version: 2.6.24-rc6
+# Thu Jan 17 16:35:55 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -144,6 +144,7 @@ CONFIG_MPC8313_RDB=y
 # CONFIG_MPC834x_MDS is not set
 # CONFIG_MPC834x_ITX is not set
 # CONFIG_MPC836x_MDS is not set
+# CONFIG_MPC837x_MDS is not set
 CONFIG_PPC_MPC831x=y
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
@@ -336,15 +337,16 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_CONCAT is not set
-# CONFIG_MTD_PARTITIONS is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
 
 #
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
-# CONFIG_MTD_BLKDEVS is not set
-# CONFIG_MTD_BLOCK is not set
-# CONFIG_MTD_BLOCK_RO is not set
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
@@ -381,11 +383,8 @@ CONFIG_MTD_CFI_UTIL=y
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_START=0xfe000000
-CONFIG_MTD_PHYSMAP_LEN=0x1000000
-CONFIG_MTD_PHYSMAP_BANKWIDTH=2
-# CONFIG_MTD_PHYSMAP_OF is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
@@ -406,7 +405,16 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -1178,7 +1186,17 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -1242,6 +1260,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
-- 
1.5.3.8
