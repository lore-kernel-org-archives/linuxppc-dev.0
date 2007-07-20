Return-Path: <rrnelson@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA822DDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 05:21:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6KJLmtx008024
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:21:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6KJLmKV205386
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:21:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6KJLlZv024015
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:21:48 -0600
From: Bob Nelson <rrnelson@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] OProfile - Enable SPU switch notification to detect
	currently active SPU tasks - update
Date: Fri, 20 Jul 2007 14:24:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707201424.07292.rrnelson@linux.vnet.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>,
	Maynard Johnson <maynardj@linux.vnet.ibm.com>,
	oprofile <oprofile-list@lists.sf.net>, Arnd Bergmann <arndb@de.ibm.com>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Maynard Johnson <mpjohn@us.ibm.com>

This patch adds to the capability of spu_switch_event_register so that
the caller is also notified of currently active SPU tasks.
Exports spu_switch_event_register and spu_switch_event_unregister so
that OProfile can get access to the notifications provided.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>

---

We would like this patch included in -mm and 2.6.23

Changed "for (node = 0; node < MAX_NUMNODES; node++)" loop to 
for_each_online_node(node).
Added comment to memory barrier.
Better info in changelog.

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/sched.c
@@ -204,21 +204,51 @@ static void spu_remove_from_active_list(
 
 static BLOCKING_NOTIFIER_HEAD(spu_switch_notifier);
 
-static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
+void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
 {
 	blocking_notifier_call_chain(&spu_switch_notifier,
 			    ctx ? ctx->object_id : 0, spu);
 }
 
+static void notify_spus_active(void)
+{
+	int node;
+
+	/*
+	 * Wake up the active spu_contexts.
+	 *
+	 * When the awakened processes see their "notify_active" flag is set,
+	 * they will call spu_switch_notify();
+	 */
+	for_each_online_node(node) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+		list_for_each_entry(spu, &spu_prio->active_list[node], list) {
+			struct spu_context *ctx = spu->ctx;
+			set_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags);
+			mb();	/* make sure any tasks woken up below */
+				/* can see the bit(s) set above */
+			wake_up_all(&ctx->stop_wq);
+		}
+		mutex_unlock(&spu_prio->active_mutex[node]);
+	}
+}
+
 int spu_switch_event_register(struct notifier_block * n)
 {
-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active();
+	return ret;
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
 
 int spu_switch_event_unregister(struct notifier_block * n)
 {
 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
 
 /**
  * spu_bind_context - bind spu context to physical spu
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -53,6 +53,11 @@ enum spuctx_execution_state {
 	SPUCTX_UTIL_MAX
 };
 
+/* ctx->sched_flags */
+enum {
+	SPU_SCHED_NOTIFY_ACTIVE,
+};
+
 struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
 	struct spu_state csa;		  /* SPU context save area. */
@@ -231,6 +236,7 @@ void spu_acquire_saved(struct spu_contex
 int spu_activate(struct spu_context *ctx, unsigned long flags);
 void spu_deactivate(struct spu_context *ctx);
 void spu_yield(struct spu_context *ctx);
+void spu_switch_notify(struct spu *spu, struct spu_context *ctx);
 void spu_set_timeslice(struct spu_context *ctx);
 void spu_update_sched_info(struct spu_context *ctx);
 void __spu_update_sched_info(struct spu_context *ctx);
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/run.c
@@ -18,15 +18,17 @@ void spufs_stop_callback(struct spu *spu
 	wake_up_all(&ctx->stop_wq);
 }
 
-static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
+static inline int spu_stopped(struct spu_context *ctx, u32 *stat)
 {
 	struct spu *spu;
 	u64 pte_fault;
 
 	*stat = ctx->ops->status_read(ctx);
-	if (ctx->state != SPU_STATE_RUNNABLE)
-		return 1;
+
 	spu = ctx->spu;
+	if (ctx->state != SPU_STATE_RUNNABLE ||
+	    test_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags))
+		return 1;
 	pte_fault = spu->dsisr &
 	    (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED);
 	return (!(*stat & SPU_STATUS_RUNNING) || pte_fault || spu->class_0_pending) ?
@@ -124,7 +126,7 @@ out:
 	return ret;
 }
 
-static int spu_run_init(struct spu_context *ctx, u32 * npc)
+static int spu_run_init(struct spu_context *ctx, u32 *npc)
 {
 	if (ctx->flags & SPU_CREATE_ISOLATE) {
 		unsigned long runcntl;
@@ -154,8 +156,8 @@ static int spu_run_init(struct spu_conte
 	return 0;
 }
 
-static int spu_run_fini(struct spu_context *ctx, u32 * npc,
-			       u32 * status)
+static int spu_run_fini(struct spu_context *ctx, u32 *npc,
+			       u32 *status)
 {
 	int ret = 0;
 
@@ -293,6 +295,7 @@ long spufs_run_spu(struct file *file, st
 		   u32 *npc, u32 *event)
 {
 	int ret;
+	struct spu *spu;
 	u32 status;
 
 	if (mutex_lock_interruptible(&ctx->run_mutex))
@@ -326,8 +329,16 @@ long spufs_run_spu(struct file *file, st
 
 	do {
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
+		spu = ctx->spu;
 		if (unlikely(ret))
 			break;
+		if (unlikely(test_and_clear_bit(SPU_SCHED_NOTIFY_ACTIVE,
+						&ctx->sched_flags))) {
+			if (!(status & SPU_STATUS_STOPPED_BY_STOP)) {
+				spu_switch_notify(spu, ctx);
+				continue;
+			}
+		}
 		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
 		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
 			ret = spu_process_callback(ctx);
