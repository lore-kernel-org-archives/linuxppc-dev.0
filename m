Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 19/25] spufs: Internal __spufs_get_foo() routines should take
	a spu_context *
Message-Id: <1189751574.109563.102927754470.19.gpush@pokey>
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

The SPUFS attribute get routines take a void * because the generic attribute
code doesn't know what sort of data it's passing around.

However our internal __spufs_get_foo() routines can take a spu_context *
directly, which saves plonking it in and out of a void * again.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/cell/spufs/file.c  |   40 ++++++++++++------------------
 arch/powerpc/platforms/cell/spufs/spufs.h |    2 -
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 6095fb1..4cd34e5 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1085,9 +1085,8 @@ static void spufs_signal1_type_set(void *data, u64 val)
 	spu_release(ctx);
 }
 
-static u64 __spufs_signal1_type_get(void *data)
+static u64 __spufs_signal1_type_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	return ctx->ops->signal1_type_get(ctx);
 }
 
@@ -1097,7 +1096,7 @@ static u64 spufs_signal1_type_get(void *data)
 	u64 ret;
 
 	spu_acquire(ctx);
-	ret = __spufs_signal1_type_get(data);
+	ret = __spufs_signal1_type_get(ctx);
 	spu_release(ctx);
 
 	return ret;
@@ -1114,9 +1113,8 @@ static void spufs_signal2_type_set(void *data, u64 val)
 	spu_release(ctx);
 }
 
-static u64 __spufs_signal2_type_get(void *data)
+static u64 __spufs_signal2_type_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	return ctx->ops->signal2_type_get(ctx);
 }
 
@@ -1126,7 +1124,7 @@ static u64 spufs_signal2_type_get(void *data)
 	u64 ret;
 
 	spu_acquire(ctx);
-	ret = __spufs_signal2_type_get(data);
+	ret = __spufs_signal2_type_get(ctx);
 	spu_release(ctx);
 
 	return ret;
@@ -1629,9 +1627,8 @@ static void spufs_decr_set(void *data, u64 val)
 	spu_release_saved(ctx);
 }
 
-static u64 __spufs_decr_get(void *data)
+static u64 __spufs_decr_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	return lscsa->decr.slot[0];
 }
@@ -1641,7 +1638,7 @@ static u64 spufs_decr_get(void *data)
 	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = __spufs_decr_get(data);
+	ret = __spufs_decr_get(ctx);
 	spu_release_saved(ctx);
 	return ret;
 }
@@ -1659,9 +1656,8 @@ static void spufs_decr_status_set(void *data, u64 val)
 	spu_release_saved(ctx);
 }
 
-static u64 __spufs_decr_status_get(void *data)
+static u64 __spufs_decr_status_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	if (ctx->csa.priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING)
 		return SPU_DECR_STATUS_RUNNING;
 	else
@@ -1673,7 +1669,7 @@ static u64 spufs_decr_status_get(void *data)
 	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = __spufs_decr_status_get(data);
+	ret = __spufs_decr_status_get(ctx);
 	spu_release_saved(ctx);
 	return ret;
 }
@@ -1689,9 +1685,8 @@ static void spufs_event_mask_set(void *data, u64 val)
 	spu_release_saved(ctx);
 }
 
-static u64 __spufs_event_mask_get(void *data)
+static u64 __spufs_event_mask_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
 	return lscsa->event_mask.slot[0];
 }
@@ -1701,16 +1696,15 @@ static u64 spufs_event_mask_get(void *data)
 	struct spu_context *ctx = data;
 	u64 ret;
 	spu_acquire_saved(ctx);
-	ret = __spufs_event_mask_get(data);
+	ret = __spufs_event_mask_get(ctx);
 	spu_release_saved(ctx);
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
 			spufs_event_mask_set, "0x%llx\n")
 
-static u64 __spufs_event_status_get(void *data)
+static u64 __spufs_event_status_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	struct spu_state *state = &ctx->csa;
 	u64 stat;
 	stat = state->spu_chnlcnt_RW[0];
@@ -1725,7 +1719,7 @@ static u64 spufs_event_status_get(void *data)
 	u64 ret = 0;
 
 	spu_acquire_saved(ctx);
-	ret = __spufs_event_status_get(data);
+	ret = __spufs_event_status_get(ctx);
 	spu_release_saved(ctx);
 	return ret;
 }
@@ -1770,16 +1764,15 @@ static u64 spufs_id_get(void *data)
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, NULL, "0x%llx\n")
 
-static u64 __spufs_object_id_get(void *data)
+static u64 __spufs_object_id_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	return ctx->object_id;
 }
 
 static u64 spufs_object_id_get(void *data)
 {
 	/* FIXME: Should there really be no locking here? */
-	return __spufs_object_id_get(data);
+	return __spufs_object_id_get((struct spu_context *)data);
 }
 
 static void spufs_object_id_set(void *data, u64 id)
@@ -1791,9 +1784,8 @@ static void spufs_object_id_set(void *data, u64 id)
 DEFINE_SIMPLE_ATTRIBUTE(spufs_object_id_ops, spufs_object_id_get,
 		spufs_object_id_set, "0x%llx\n");
 
-static u64 __spufs_lslr_get(void *data)
+static u64 __spufs_lslr_get(struct spu_context *ctx)
 {
-	struct spu_context *ctx = data;
 	return ctx->csa.priv2.spu_lslr_RW;
 }
 
@@ -1803,7 +1795,7 @@ static u64 spufs_lslr_get(void *data)
 	u64 ret;
 
 	spu_acquire_saved(ctx);
-	ret = __spufs_lslr_get(data);
+	ret = __spufs_lslr_get(ctx);
 	spu_release_saved(ctx);
 
 	return ret;
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 3dbffeb..f869a4b 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -296,7 +296,7 @@ struct spufs_coredump_reader {
 	char *name;
 	ssize_t (*read)(struct spu_context *ctx,
 			char __user *buffer, size_t size, loff_t *pos);
-	u64 (*get)(void *data);
+	u64 (*get)(struct spu_context *ctx);
 	size_t size;
 };
 extern struct spufs_coredump_reader spufs_coredump_read[];
