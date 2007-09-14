Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 14/25] spufs: Use computed sizes/#defines rather than literals
	in SPU coredump code
Message-Id: <1189751574.106876.425023515652.14.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

The spufs_coredump_reader array contains the size of the data that will be
returned by the read routine. Currently these are specified as literals, and
though some are obvious, sizeof(u32) == 4, others are not, 69 * 8 ==  ???

Instead, use sizeof() whatever type is returned by each routine, or in
the case of spufs_mem_read() the #define LS_SIZE.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/file.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index a4a8770..18ddde8 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2231,23 +2231,24 @@ struct tree_descr spufs_dir_nosched_contents[] = {
 };
 
 struct spufs_coredump_reader spufs_coredump_read[] = {
-	{ "regs", __spufs_regs_read, NULL, 128 * 16 },
-	{ "fpcr", __spufs_fpcr_read, NULL, 16 },
+	{ "regs", __spufs_regs_read, NULL, sizeof(struct spu_reg128[128])},
+	{ "fpcr", __spufs_fpcr_read, NULL, sizeof(struct spu_reg128) },
 	{ "lslr", NULL, __spufs_lslr_get, 11 },
 	{ "decr", NULL, __spufs_decr_get, 11 },
 	{ "decr_status", NULL, __spufs_decr_status_get, 11 },
-	{ "mem", __spufs_mem_read, NULL, 256 * 1024, },
-	{ "signal1", __spufs_signal1_read, NULL, 4 },
+	{ "mem", __spufs_mem_read, NULL, LS_SIZE, },
+	{ "signal1", __spufs_signal1_read, NULL, sizeof(u32) },
 	{ "signal1_type", NULL, __spufs_signal1_type_get, 2 },
-	{ "signal2", __spufs_signal2_read, NULL, 4 },
+	{ "signal2", __spufs_signal2_read, NULL, sizeof(u32) },
 	{ "signal2_type", NULL, __spufs_signal2_type_get, 2 },
 	{ "event_mask", NULL, __spufs_event_mask_get, 8 },
 	{ "event_status", NULL, __spufs_event_status_get, 8 },
-	{ "mbox_info", __spufs_mbox_info_read, NULL, 4 },
-	{ "ibox_info", __spufs_ibox_info_read, NULL, 4 },
-	{ "wbox_info", __spufs_wbox_info_read, NULL, 16 },
-	{ "dma_info", __spufs_dma_info_read, NULL, 69 * 8 },
-	{ "proxydma_info", __spufs_proxydma_info_read, NULL, 35 * 8 },
+	{ "mbox_info", __spufs_mbox_info_read, NULL, sizeof(u32) },
+	{ "ibox_info", __spufs_ibox_info_read, NULL, sizeof(u32) },
+	{ "wbox_info", __spufs_wbox_info_read, NULL, 4 * sizeof(u32)},
+	{ "dma_info", __spufs_dma_info_read, NULL, sizeof(struct spu_dma_info)},
+	{ "proxydma_info", __spufs_proxydma_info_read,
+			   NULL, sizeof(struct spu_proxydma_info)},
 	{ "object-id", NULL, __spufs_object_id_get, 19 },
 	{ },
 };
