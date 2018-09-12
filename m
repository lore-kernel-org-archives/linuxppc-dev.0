Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFc002QzF3Rg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJY34R101707
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:50 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf8mj1cfc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:49 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:49 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 06/11] powerpc/tm: Refactor the __switch_to_tm code
Date: Wed, 12 Sep 2018 16:40:14 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-7-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__switch_to_tm is the function that switches between two tasks which might
have TM enabled. This function is clearly split in two parts, the task that
is leaving the CPU, known as 'prev' and the task that is being scheduled,
known as new.

It starts checking if the previous task had TM enable, if so, it increases
the load_tm (this is the only place we increment load_tm). It also saves
the TM SPRs here.

If the previous task was scheduled out with a transaction active, the
failure cause needs to be updated, since it might contain the failure cause
that caused the exception, as TM_CAUSE_MISC. In this case, since there was
a context switch, overwrite the failure cause.

If the previous task has overflowed load_tm, disable TM, putting the
facility save/restore lazy mechanism at lazy mode.

Regarding the new task, when loading it, it basically restore the SPRs, and
TIF_RESTORE_TM (already set by tm_reclaim_current if the transaction was
active) would invoke the recheckpoint process later in restore_tm_state()
if recheckpoint is somehow required.

On top of that, both tm_reclaim_task() and tm_recheckpoint_new_task()
functions are not used anymore, removing them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 163 +++++++++++++++-------------------
 1 file changed, 74 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fe063c0142e3..5cace1b744b1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -921,48 +921,6 @@ void tm_reclaim_current(uint8_t cause)
 	tm_reclaim_thread(&current->thread, cause);
 }
 
-static inline void tm_reclaim_task(struct task_struct *tsk)
-{
-	/* We have to work out if we're switching from/to a task that's in the
-	 * middle of a transaction.
-	 *
-	 * In switching we need to maintain a 2nd register state as
-	 * oldtask->thread.ckpt_regs.  We tm_reclaim(oldproc); this saves the
-	 * checkpointed (tbegin) state in ckpt_regs, ckfp_state and
-	 * ckvr_state
-	 *
-	 * We also context switch (save) TFHAR/TEXASR/TFIAR in here.
-	 */
-	struct thread_struct *thr = &tsk->thread;
-
-	if (!thr->regs)
-		return;
-
-	if (!MSR_TM_ACTIVE(thr->regs->msr))
-		goto out_and_saveregs;
-
-	WARN_ON(tm_suspend_disabled);
-
-	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
-		 "ccr=%lx, msr=%lx, trap=%lx)\n",
-		 tsk->pid, thr->regs->nip,
-		 thr->regs->ccr, thr->regs->msr,
-		 thr->regs->trap);
-
-	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
-
-	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
-		 tsk->pid);
-
-out_and_saveregs:
-	/* Always save the regs here, even if a transaction's not active.
-	 * This context-switches a thread's TM info SPRs.  We do it here to
-	 * be consistent with the restore path (in recheckpoint) which
-	 * cannot happen later in _switch().
-	 */
-	tm_save_sprs(thr);
-}
-
 extern void __tm_recheckpoint(struct thread_struct *thread);
 
 void tm_recheckpoint(struct thread_struct *thread)
@@ -997,59 +955,87 @@ static void tm_fix_failure_cause(struct task_struct *task, uint8_t cause)
 	task->thread.tm_texasr |= (unsigned long) cause << 56;
 }
 
-static inline void tm_recheckpoint_new_task(struct task_struct *new)
+static inline void __switch_to_tm(struct task_struct *prev,
+		struct task_struct *new)
 {
 	if (!cpu_has_feature(CPU_FTR_TM))
 		return;
 
-	/* Recheckpoint the registers of the thread we're about to switch to.
-	 *
-	 * If the task was using FP, we non-lazily reload both the original and
-	 * the speculative FP register states.  This is because the kernel
-	 * doesn't see if/when a TM rollback occurs, so if we take an FP
-	 * unavailable later, we are unable to determine which set of FP regs
-	 * need to be restored.
-	 */
-	if (!tm_enabled(new))
-		return;
-
-	if (!MSR_TM_ACTIVE(new->thread.regs->msr)){
-		tm_restore_sprs(&new->thread);
-		return;
-	}
-	/* Recheckpoint to restore original checkpointed register state. */
-	TM_DEBUG("*** tm_recheckpoint of pid %d (new->msr 0x%lx)\n",
-		 new->pid, new->thread.regs->msr);
-
-	tm_recheckpoint(&new->thread);
-
-	/*
-	 * The checkpointed state has been restored but the live state has
-	 * not, ensure all the math functionality is turned off to trigger
-	 * restore_math() to reload.
-	 */
-	new->thread.regs->msr &= ~(MSR_FP | MSR_VEC | MSR_VSX);
+	/* The task leaving the CPU was using TM, let's handle it */
+	if (tm_enabled(prev)) {
+		/*
+		 * Load_tm is incremented only when the task is scheduled out
+		 */
+		prev->thread.load_tm++;
 
-	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
-		 "(kernel msr 0x%lx)\n",
-		 new->pid, mfmsr());
-}
+		/*
+		 * If TM is enabled for the thread, it needs to, at least,
+		 * save the SPRs
+		 */
+		tm_enable();
+		tm_save_sprs(&prev->thread);
 
-static inline void __switch_to_tm(struct task_struct *prev,
-		struct task_struct *new)
-{
-	if (cpu_has_feature(CPU_FTR_TM)) {
-		if (tm_enabled(prev) || tm_enabled(new))
-			tm_enable();
+		/*
+		 * If we got here with an active transaction, then, it was
+		 * aborted by TM_KERNEL_ENTRY and the fix the failure case
+		 * needs to be fixed, so, indepedently how we arrived here, the
+		 * new TM abort case will be TM_CAUSE_RESCHED now.
+		 */
+		if (MSR_TM_ACTIVE(prev->thread.regs->msr)) {
+			/*
+			 * If there was an IRQ during trecheckpoint, it will
+			 * cause an IRQ to be replayed. This replayed IRQ can
+			 * invoke SCHEDULE_USER, thus, we arrive here with a TM
+			 * active transaction.
+			 * I.e, the task was leaving kernelspace to userspace,
+			 * already trecheckpointed, but there was a IRQ during
+			 * the trecheckpoint process (soft irq disabled), and
+			 * on the IRQ replay, the process was de-scheduled, so,
+			 * SCHEDULE_USER was called and here we are.
+			 *
+			 */
+			if (MSR_TM_ACTIVE(mfmsr())) {
+				/*
+				 * This is the only other case other than
+				 * TM_KERNEL_ENTRY that does a TM reclaim
+				 */
+				tm_reclaim_current(TM_CAUSE_RESCHED);
+			}
 
-		if (tm_enabled(prev)) {
-			prev->thread.load_tm++;
-			tm_reclaim_task(prev);
-			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+			/*
+			 * If rescheduled with TM active, update the
+			 * failure cause
+			 */
+			tm_fix_failure_cause(prev, TM_CAUSE_RESCHED);
+		} else {
+			/*
+			 * TM enabled but not transactional. Just disable TM
+			 * if load_tm overflows. This should be the only place
+			 * that disables the TM and reenables the laziness
+			 * save/restore
+			 */
+			if (prev->thread.load_tm == 0)
 				prev->thread.regs->msr &= ~MSR_TM;
 		}
+	}
 
-		tm_recheckpoint_new_task(new);
+	/*
+	 * It is a *bug* if we arrived so late with a transaction active
+	 * (more precisely suspended)
+	 */
+	if (WARN_ON(MSR_TM_ACTIVE(mfmsr()))) {
+		/* Recovery path. 0x99 shouldn't be exported to UAPI */
+		tm_reclaim_current(0x99);
+	}
+
+	/*
+	 * If the next task has TM enabled, restore the SPRs. Do not need to
+	 * care about recheckpoint at this time. It will be done later if
+	 * TIF_RESTORE_TM was set when the task was scheduled out
+	 */
+	if (tm_enabled(new)) {
+		tm_enable();
+		tm_restore_sprs(&new->thread);
 	}
 }
 
@@ -1101,7 +1087,6 @@ void restore_tm_state(struct pt_regs *regs)
 }
 
 #else
-#define tm_recheckpoint_new_task(new)
 #define __switch_to_tm(prev, new)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
@@ -1588,9 +1573,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	/*
 	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
 	 * flush but it removes the checkpointed state from the current CPU and
-	 * transitions the CPU out of TM mode.  Hence we need to call
-	 * tm_recheckpoint_new_task() (on the same task) to restore the
-	 * checkpointed state back and the TM mode.
+	 * transitions the CPU out of TM mode.  Hence we need to make sure
+	 * TIF_RESTORE_TM is set so restore_tm_state is called to restore the
+	 * checkpointed state and back to TM mode.
 	 *
 	 * Can't pass dst because it isn't ready. Doesn't matter, passing
 	 * dst is only important for __switch_to()
-- 
2.19.0
