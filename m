Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 05/25] spufs: fix race condition on gang->aff_ref_spu
Message-Id: <1189751574.100972.716660077844.5.gpush@pokey>
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

From: Andre Detsch <adetsch@br.ibm.com>

Affinity reference point location (gang->aff_ref_spu) is reset
when the whole gang is descheduled. However, the last member of
a gang can be descheduled while we are trying to schedule another
member of the gang. This was leading to a race condition, and
the code was using gang->aff_ref_spu in an unsafe manner.

By holding the gang->aff_mutex a little bit longer, and increment
gang->aff_sched_count (which controls when gang->aff_ref_spu
should be reset) a little bit earlier, the problem is fixed.

Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/sched.c |   49 +++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index c784edd..17806e0 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -230,8 +230,6 @@ static void spu_bind_context(struct spu *spu, struct spu_context *ctx)
 
 	if (ctx->flags & SPU_CREATE_NOSCHED)
 		atomic_inc(&cbe_spu_info[spu->node].reserved_spus);
-	if (!list_empty(&ctx->aff_list))
-		atomic_inc(&ctx->gang->aff_sched_count);
 
 	ctx->stats.slb_flt_base = spu->stats.slb_flt;
 	ctx->stats.class2_intr_base = spu->stats.class2_intr;
@@ -392,7 +390,6 @@ static int has_affinity(struct spu_context *ctx)
 	if (list_empty(&ctx->aff_list))
 		return 0;
 
-	mutex_lock(&gang->aff_mutex);
 	if (!gang->aff_ref_spu) {
 		if (!(gang->aff_flags & AFF_MERGED))
 			aff_merge_remaining_ctxs(gang);
@@ -400,7 +397,6 @@ static int has_affinity(struct spu_context *ctx)
 			aff_set_offsets(gang);
 		aff_set_ref_point_location(gang);
 	}
-	mutex_unlock(&gang->aff_mutex);
 
 	return gang->aff_ref_spu != NULL;
 }
@@ -418,9 +414,16 @@ static void spu_unbind_context(struct spu *spu, struct spu_context *ctx)
 
  	if (spu->ctx->flags & SPU_CREATE_NOSCHED)
 		atomic_dec(&cbe_spu_info[spu->node].reserved_spus);
- 	if (!list_empty(&ctx->aff_list))
- 		if (atomic_dec_and_test(&ctx->gang->aff_sched_count))
- 			ctx->gang->aff_ref_spu = NULL;
+
+	if (ctx->gang){
+		mutex_lock(&ctx->gang->aff_mutex);
+		if (has_affinity(ctx)) {
+			if (atomic_dec_and_test(&ctx->gang->aff_sched_count))
+				ctx->gang->aff_ref_spu = NULL;
+		}
+		mutex_unlock(&ctx->gang->aff_mutex);
+	}
+
 	spu_switch_notify(spu, NULL);
 	spu_unmap_mappings(ctx);
 	spu_save(&ctx->csa, spu);
@@ -511,20 +514,32 @@ static void spu_prio_wait(struct spu_context *ctx)
 
 static struct spu *spu_get_idle(struct spu_context *ctx)
 {
-	struct spu *spu;
+	struct spu *spu, *aff_ref_spu;
 	int node, n;
 
-	if (has_affinity(ctx)) {
-		node = ctx->gang->aff_ref_spu->node;
+	if (ctx->gang) {
+		mutex_lock(&ctx->gang->aff_mutex);
+		if (has_affinity(ctx)) {
+			aff_ref_spu = ctx->gang->aff_ref_spu;
+			atomic_inc(&ctx->gang->aff_sched_count);
+			mutex_unlock(&ctx->gang->aff_mutex);
+			node = aff_ref_spu->node;
 
-		mutex_lock(&cbe_spu_info[node].list_mutex);
-		spu = ctx_location(ctx->gang->aff_ref_spu, ctx->aff_offset, node);
-		if (spu && spu->alloc_state == SPU_FREE)
-			goto found;
-		mutex_unlock(&cbe_spu_info[node].list_mutex);
-		return NULL;
-	}
+			mutex_lock(&cbe_spu_info[node].list_mutex);
+			spu = ctx_location(aff_ref_spu, ctx->aff_offset, node);
+			if (spu && spu->alloc_state == SPU_FREE)
+				goto found;
+			mutex_unlock(&cbe_spu_info[node].list_mutex);
 
+			mutex_lock(&ctx->gang->aff_mutex);
+			if (atomic_dec_and_test(&ctx->gang->aff_sched_count))
+				ctx->gang->aff_ref_spu = NULL;
+			mutex_unlock(&ctx->gang->aff_mutex);
+
+			return NULL;
+		}
+		mutex_unlock(&ctx->gang->aff_mutex);
+	}
 	node = cpu_to_node(raw_smp_processor_id());
 	for (n = 0; n < MAX_NUMNODES; n++, node++) {
 		node = (node < MAX_NUMNODES) ? node : 0;
