Return-Path: <arnd@arndb.de>
Message-Id: <20061120180521.991897000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:44:59 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 05/22] spufs: Remove /spu_tag_mask file
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Dwayne Grant McConnell <decimal@us.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dwayne Grant McConnell <decimal@us.ibm.com>
This patch removes the /spu_tag_mask file from spufs. The data provided by
this file is also available from the /dma_info file in the dma_info_mask
of the spu_dma_info struct.

The file was intended to be used by gdb, but that never used it, and
now it has been replaced with the more verbose dma_info file.

Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann  <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1439,28 +1439,6 @@ static u64 spufs_decr_status_get(void *d
 DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_status_ops, spufs_decr_status_get,
 			spufs_decr_status_set, "0x%llx\n")
 
-static void spufs_spu_tag_mask_set(void *data, u64 val)
-{
-	struct spu_context *ctx = data;
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
-	spu_acquire_saved(ctx);
-	lscsa->tag_mask.slot[0] = (u32) val;
-	spu_release(ctx);
-}
-
-static u64 spufs_spu_tag_mask_get(void *data)
-{
-	struct spu_context *ctx = data;
-	struct spu_lscsa *lscsa = ctx->csa.lscsa;
-	u64 ret;
-	spu_acquire_saved(ctx);
-	ret = lscsa->tag_mask.slot[0];
-	spu_release(ctx);
-	return ret;
-}
-DEFINE_SIMPLE_ATTRIBUTE(spufs_spu_tag_mask_ops, spufs_spu_tag_mask_get,
-			spufs_spu_tag_mask_set, "0x%llx\n")
-
 static void spufs_event_mask_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
@@ -1678,7 +1656,6 @@ struct tree_descr spufs_dir_contents[] =
 	{ "srr0", &spufs_srr0_ops, 0666, },
 	{ "decr", &spufs_decr_ops, 0666, },
 	{ "decr_status", &spufs_decr_status_ops, 0666, },
-	{ "spu_tag_mask", &spufs_spu_tag_mask_ops, 0666, },
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
 	{ "event_status", &spufs_event_status_ops, 0444, },
 	{ "psmap", &spufs_psmap_fops, 0666, },

--
