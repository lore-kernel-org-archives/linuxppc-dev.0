Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 6/6] spufs,scheduler: fix wakeup races
Message-Id: <1180963611.993141.979727924562.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

Fix the race between checking for contexts on the runqueue and actually
waking them in spu_deactive and spu_yield.

The guts of spu_reschedule are split into a new helper called
grab_runnable_context which shows if there is a runnable thread below
a specified priority and if yes removes if from the runqueue and uses
it.  This function is used by the new __spu_deactivate hepler shared
by preemption and spu_yield to grab a new context before deactivating
a specified priority and if yes removes if from the runqueue and uses
it.  This function is used by the new __spu_deactivate hepler shared
by preemption and spu_yield to grab a new context before deactivating
the old one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index b6ecb30..68fcdc4 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -93,43 +93,6 @@ void spu_stop_tick(struct spu_context *ctx)
 	}
 }
 
-void spu_sched_tick(struct work_struct *work)
-{
-	struct spu_context *ctx =
-		container_of(work, struct spu_context, sched_work.work);
-	struct spu *spu;
-	int preempted = 0;
-
-	/*
-	 * If this context is being stopped avoid rescheduling from the
-	 * scheduler tick because we would block on the state_mutex.
-	 * The caller will yield the spu later on anyway.
-	 */
-	if (test_bit(SPU_SCHED_EXITING, &ctx->sched_flags))
-		return;
-
-	mutex_lock(&ctx->state_mutex);
-	spu = ctx->spu;
-	if (spu) {
-		int best = sched_find_first_bit(spu_prio->bitmap);
-		if (best <= ctx->prio) {
-			spu_deactivate(ctx);
-			preempted = 1;
-		}
-	}
-	mutex_unlock(&ctx->state_mutex);
-
-	if (preempted) {
-		/*
-		 * We need to break out of the wait loop in spu_run manually
-		 * to ensure this context gets put on the runqueue again
-		 * ASAP.
-		 */
-		wake_up(&ctx->stop_wq);
-	} else
-		spu_start_tick(ctx);
-}
-
 /**
  * spu_add_to_active_list - add spu to active list
  * @spu:	spu to add to the active list
@@ -273,34 +236,6 @@ static void spu_prio_wait(struct spu_context *ctx)
 	remove_wait_queue(&ctx->stop_wq, &wait);
 }
 
-/**
- * spu_reschedule - try to find a runnable context for a spu
- * @spu:       spu available
- *
- * This function is called whenever a spu becomes idle.  It looks for the
- * most suitable runnable spu context and schedules it for execution.
- */
-static void spu_reschedule(struct spu *spu)
-{
-	int best;
-
-	spu_free(spu);
-
-	spin_lock(&spu_prio->runq_lock);
-	best = sched_find_first_bit(spu_prio->bitmap);
-	if (best < MAX_PRIO) {
-		struct list_head *rq = &spu_prio->runq[best];
-		struct spu_context *ctx;
-
-		BUG_ON(list_empty(rq));
-
-		ctx = list_entry(rq->next, struct spu_context, rq);
-		__spu_del_from_rq(ctx);
-		wake_up(&ctx->stop_wq);
-	}
-	spin_unlock(&spu_prio->runq_lock);
-}
-
 static struct spu *spu_get_idle(struct spu_context *ctx)
 {
 	struct spu *spu = NULL;
@@ -429,6 +364,51 @@ int spu_activate(struct spu_context *ctx, unsigned long flags)
 }
 
 /**
+ * grab_runnable_context - try to find a runnable context
+ *
+ * Remove the highest priority context on the runqueue and return it
+ * to the caller.  Returns %NULL if no runnable context was found.
+ */
+static struct spu_context *grab_runnable_context(int prio)
+{
+	struct spu_context *ctx = NULL;
+	int best;
+
+	spin_lock(&spu_prio->runq_lock);
+	best = sched_find_first_bit(spu_prio->bitmap);
+	if (best < prio) {
+		struct list_head *rq = &spu_prio->runq[best];
+
+		BUG_ON(list_empty(rq));
+
+		ctx = list_entry(rq->next, struct spu_context, rq);
+		__spu_del_from_rq(ctx);
+	}
+	spin_unlock(&spu_prio->runq_lock);
+
+	return ctx;
+}
+
+static int __spu_deactivate(struct spu_context *ctx, int force, int max_prio)
+{
+	struct spu *spu = ctx->spu;
+	struct spu_context *new = NULL;
+
+	if (spu) {
+		new = grab_runnable_context(max_prio);
+		if (new || force) {
+			spu_unbind_context(spu, ctx);
+			spu_free(spu);
+			if (new)
+				wake_up(&new->stop_wq);
+		}
+
+	}
+
+	return new != NULL;
+}
+
+/**
  * spu_deactivate - unbind a context from it's physical spu
  * @ctx:	spu context to unbind
  *
@@ -437,12 +417,7 @@ int spu_activate(struct spu_context *ctx, unsigned long flags)
  */
 void spu_deactivate(struct spu_context *ctx)
 {
-	struct spu *spu = ctx->spu;
-
-	if (spu) {
-		spu_unbind_context(spu, ctx);
-		spu_reschedule(spu);
-	}
+	__spu_deactivate(ctx, 1, MAX_PRIO);
 }
 
 /**
@@ -455,18 +430,38 @@ void spu_deactivate(struct spu_context *ctx)
  */
 void spu_yield(struct spu_context *ctx)
 {
-	struct spu *spu;
+	mutex_lock(&ctx->state_mutex);
+	__spu_deactivate(ctx, 0, MAX_PRIO);
+	mutex_unlock(&ctx->state_mutex);
+}
 
-	if (mutex_trylock(&ctx->state_mutex)) {
-		if ((spu = ctx->spu) != NULL) {
-			int best = sched_find_first_bit(spu_prio->bitmap);
-			if (best < MAX_PRIO) {
-				pr_debug("%s: yielding SPU %d NODE %d\n",
-					 __FUNCTION__, spu->number, spu->node);
-				spu_deactivate(ctx);
-			}
-		}
-		mutex_unlock(&ctx->state_mutex);
+void spu_sched_tick(struct work_struct *work)
+{
+	struct spu_context *ctx =
+		container_of(work, struct spu_context, sched_work.work);
+	int preempted;
+
+	/*
+	 * If this context is being stopped avoid rescheduling from the
+	 * scheduler tick because we would block on the state_mutex.
+	 * The caller will yield the spu later on anyway.
+	 */
+	if (test_bit(SPU_SCHED_EXITING, &ctx->sched_flags))
+		return;
+
+	mutex_lock(&ctx->state_mutex);
+	preempted = __spu_deactivate(ctx, 0, ctx->prio + 1);
+	mutex_unlock(&ctx->state_mutex);
+
+	if (preempted) {
+		/*
+		 * We need to break out of the wait loop in spu_run manually
+		 * to ensure this context gets put on the runqueue again
+		 * ASAP.
+		 */
+		wake_up(&ctx->stop_wq);
+	} else {
+		spu_start_tick(ctx);
 	}
 }
 
-- 
1.5.0.rc4.g85b1
