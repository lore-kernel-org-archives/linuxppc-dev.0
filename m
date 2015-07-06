Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01EE71A0D7D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 20:54:30 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53E8F140DBC
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 20:54:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 16:24:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E4F43125804F
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 16:27:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t66AsMQr47972440
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 16:24:22 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t66AsL6M031255
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 16:24:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH] powerpc/tm: Drop tm_orig_msr from thread_struct
Date: Mon,  6 Jul 2015 16:24:10 +0530
Message-Id: <1436180050-27397-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tm_orig_msr is getting used during process context switch only.
Then there is ckpt_regs which saves the checkpointed userspace context
The MSR slot contained in ckpt_regs structure can be used during process
context switch instead of tm_orig_msr, thus allowing us to drop it from
thread_struct structure. This patch does that change.

Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
RFC: https://patchwork.ozlabs.org/patch/462736/

 arch/powerpc/include/asm/processor.h |  1 -
 arch/powerpc/kernel/process.c        | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 28ded5d..5afea36 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -264,7 +264,6 @@ struct thread_struct {
 	u64		tm_tfhar;	/* Transaction fail handler addr */
 	u64		tm_texasr;	/* Transaction exception & summary */
 	u64		tm_tfiar;	/* Transaction fail instr address reg */
-	unsigned long	tm_orig_msr;	/* Thread's MSR on ctx switch */
 	struct pt_regs	ckpt_regs;	/* Checkpointed registers */
 
 	unsigned long	tm_tar;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8005e18..99adcba 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -86,7 +86,7 @@ void giveup_fpu_maybe_transactional(struct task_struct *tsk)
 	if (tsk == current && tsk->thread.regs &&
 	    MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
 	    !test_thread_flag(TIF_RESTORE_TM)) {
-		tsk->thread.tm_orig_msr = tsk->thread.regs->msr;
+		tsk->thread.ckpt_regs.msr = tsk->thread.regs->msr;
 		set_thread_flag(TIF_RESTORE_TM);
 	}
 
@@ -104,7 +104,7 @@ void giveup_altivec_maybe_transactional(struct task_struct *tsk)
 	if (tsk == current && tsk->thread.regs &&
 	    MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
 	    !test_thread_flag(TIF_RESTORE_TM)) {
-		tsk->thread.tm_orig_msr = tsk->thread.regs->msr;
+		tsk->thread.ckpt_regs.msr = tsk->thread.regs->msr;
 		set_thread_flag(TIF_RESTORE_TM);
 	}
 
@@ -543,7 +543,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	 * the thread will no longer be transactional.
 	 */
 	if (test_ti_thread_flag(ti, TIF_RESTORE_TM)) {
-		msr_diff = thr->tm_orig_msr & ~thr->regs->msr;
+		msr_diff = thr->ckpt_regs.msr & ~thr->regs->msr;
 		if (msr_diff & MSR_FP)
 			memcpy(&thr->transact_fp, &thr->fp_state,
 			       sizeof(struct thread_fp_state));
@@ -594,10 +594,10 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	/* Stash the original thread MSR, as giveup_fpu et al will
 	 * modify it.  We hold onto it to see whether the task used
 	 * FP & vector regs.  If the TIF_RESTORE_TM flag is set,
-	 * tm_orig_msr is already set.
+	 * ckpt_regs.msr is already set.
 	 */
 	if (!test_ti_thread_flag(task_thread_info(tsk), TIF_RESTORE_TM))
-		thr->tm_orig_msr = thr->regs->msr;
+		thr->ckpt_regs.msr = thr->regs->msr;
 
 	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
 		 "ccr=%lx, msr=%lx, trap=%lx)\n",
@@ -666,7 +666,7 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		tm_restore_sprs(&new->thread);
 		return;
 	}
-	msr = new->thread.tm_orig_msr;
+	msr = new->thread.ckpt_regs.msr;
 	/* Recheckpoint to restore original checkpointed register state. */
 	TM_DEBUG("*** tm_recheckpoint of pid %d "
 		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
@@ -726,7 +726,7 @@ void restore_tm_state(struct pt_regs *regs)
 	if (!MSR_TM_ACTIVE(regs->msr))
 		return;
 
-	msr_diff = current->thread.tm_orig_msr & ~regs->msr;
+	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
 	if (msr_diff & MSR_FP) {
 		fp_enable();
-- 
2.1.0
