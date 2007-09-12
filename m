Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b5facc2fa4801181f21f5f0705892adf28766569.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 05/15] Write some SPU coredump values as ASCII
Date: Wed, 12 Sep 2007 17:43:42 +1000 (EST)
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unfortunately GDB expects some of the SPU coredump values to be identical
in format to what is found in spufs. This means we need to dump some of
the values as ASCII strings, not the actual values.

Because we don't know what the values will be, we always print the values
with the format "0x%.16lx", that way we know the result will be 19 bytes.

do_coredump_read() doesn't take a __user buffer, so remove the annotation,
and because we know that it's safe to just snprintf() directly to it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |    8 +++++---
 arch/powerpc/platforms/cell/spufs/file.c     |   14 +++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 21283f6..c65b717 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -31,7 +31,7 @@
 
 #include "spufs.h"
 
-static ssize_t do_coredump_read(int num, struct spu_context *ctx, void __user *buffer,
+static ssize_t do_coredump_read(int num, struct spu_context *ctx, void *buffer,
 				size_t size, loff_t *off)
 {
 	u64 data;
@@ -41,8 +41,10 @@ static ssize_t do_coredump_read(int num, struct spu_context *ctx, void __user *b
 		return spufs_coredump_read[num].read(ctx, buffer, size, off);
 
 	data = spufs_coredump_read[num].get(ctx);
-	ret = copy_to_user(buffer, &data, 8);
-	return ret ? -EFAULT : 8;
+	ret = snprintf(buffer, size, "0x%.16lx", data);
+	if (ret >= size)
+		return size;
+	return ++ret; /* count trailing NULL */
 }
 
 /*
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 18ddde8..85edbec 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2233,16 +2233,16 @@ struct tree_descr spufs_dir_nosched_contents[] = {
 struct spufs_coredump_reader spufs_coredump_read[] = {
 	{ "regs", __spufs_regs_read, NULL, sizeof(struct spu_reg128[128])},
 	{ "fpcr", __spufs_fpcr_read, NULL, sizeof(struct spu_reg128) },
-	{ "lslr", NULL, __spufs_lslr_get, 11 },
-	{ "decr", NULL, __spufs_decr_get, 11 },
-	{ "decr_status", NULL, __spufs_decr_status_get, 11 },
+	{ "lslr", NULL, __spufs_lslr_get, 19 },
+	{ "decr", NULL, __spufs_decr_get, 19 },
+	{ "decr_status", NULL, __spufs_decr_status_get, 19 },
 	{ "mem", __spufs_mem_read, NULL, LS_SIZE, },
 	{ "signal1", __spufs_signal1_read, NULL, sizeof(u32) },
-	{ "signal1_type", NULL, __spufs_signal1_type_get, 2 },
+	{ "signal1_type", NULL, __spufs_signal1_type_get, 19 },
 	{ "signal2", __spufs_signal2_read, NULL, sizeof(u32) },
-	{ "signal2_type", NULL, __spufs_signal2_type_get, 2 },
-	{ "event_mask", NULL, __spufs_event_mask_get, 8 },
-	{ "event_status", NULL, __spufs_event_status_get, 8 },
+	{ "signal2_type", NULL, __spufs_signal2_type_get, 19 },
+	{ "event_mask", NULL, __spufs_event_mask_get, 19 },
+	{ "event_status", NULL, __spufs_event_status_get, 19 },
 	{ "mbox_info", __spufs_mbox_info_read, NULL, sizeof(u32) },
 	{ "ibox_info", __spufs_ibox_info_read, NULL, sizeof(u32) },
 	{ "wbox_info", __spufs_wbox_info_read, NULL, 4 * sizeof(u32)},
-- 
1.5.1.3.g7a33b
