Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/17] powerpc: Add reclaim and recheckpoint functions for
 context switching transactional memory processes
Date: Wed, 13 Feb 2013 15:31:27 +1100
Message-Id: <1360729895-304-10-git-send-email-mikey@neuling.org>
In-Reply-To: <1360729895-304-1-git-send-email-mikey@neuling.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we switch out a task, we need to save both the checkpointed and the
speculated state into the thread struct.

Similarly when we are switching in a task we need to load both the checkpointed
and speculated state.  If the task was using FP, we non-lazily reload both the
original and the speculative FP register states.  This is because the kernel
doesn't see if/when a TM rollback occurs, so if we take an FP unavoidable
later, we are unable to determine which set of FP regs need to be restored.

This simply adds these functions.  It doesn't hook them into the existing code
yet.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c |  112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1cc4053..48a9875 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -50,6 +50,7 @@
 #include <asm/runlatch.h>
 #include <asm/syscalls.h>
 #include <asm/switch_to.h>
+#include <asm/tm.h>
 #include <asm/debug.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
@@ -467,6 +468,117 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
 		return false;
 	return true;
 }
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline void tm_reclaim_task(struct task_struct *tsk)
+{
+	/* We have to work out if we're switching from/to a task that's in the
+	 * middle of a transaction.
+	 *
+	 * In switching we need to maintain a 2nd register state as
+	 * oldtask->thread.ckpt_regs.  We tm_reclaim(oldproc); this saves the
+	 * checkpointed (tbegin) state in ckpt_regs and saves the transactional
+	 * (current) FPRs into oldtask->thread.transact_fpr[].
+	 *
+	 * We also context switch (save) TFHAR/TEXASR/TFIAR in here.
+	 */
+	struct thread_struct *thr = &tsk->thread;
+
+	if (!thr->regs)
+		return;
+
+	if (!MSR_TM_ACTIVE(thr->regs->msr))
+		goto out_and_saveregs;
+
+	/* Stash the original thread MSR, as giveup_fpu et al will
+	 * modify it.  We hold onto it to see whether the task used
+	 * FP & vector regs.
+	 */
+	thr->tm_orig_msr = thr->regs->msr;
+
+	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
+		 "ccr=%lx, msr=%lx, trap=%lx)\n",
+		 tsk->pid, thr->regs->nip,
+		 thr->regs->ccr, thr->regs->msr,
+		 thr->regs->trap);
+
+	tm_reclaim(thr, thr->regs->msr, TM_CAUSE_RESCHED);
+
+	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
+		 tsk->pid);
+
+out_and_saveregs:
+	/* Always save the regs here, even if a transaction's not active.
+	 * This context-switches a thread's TM info SPRs.  We do it here to
+	 * be consistent with the restore path (in recheckpoint) which
+	 * cannot happen later in _switch().
+	 */
+	tm_save_sprs(thr);
+}
+
+static inline void __maybe_unused tm_recheckpoint_new_task(struct task_struct *new)
+{
+	unsigned long msr;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return;
+
+	/* Recheckpoint the registers of the thread we're about to switch to.
+	 *
+	 * If the task was using FP, we non-lazily reload both the original and
+	 * the speculative FP register states.  This is because the kernel
+	 * doesn't see if/when a TM rollback occurs, so if we take an FP
+	 * unavoidable later, we are unable to determine which set of FP regs
+	 * need to be restored.
+	 */
+	if (!new->thread.regs)
+		return;
+
+	/* The TM SPRs are restored here, so that TEXASR.FS can be set
+	 * before the trecheckpoint and no explosion occurs.
+	 */
+	tm_restore_sprs(&new->thread);
+
+	if (!MSR_TM_ACTIVE(new->thread.regs->msr))
+		return;
+	msr = new->thread.tm_orig_msr;
+	/* Recheckpoint to restore original checkpointed register state. */
+	TM_DEBUG("*** tm_recheckpoint of pid %d "
+		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
+		 new->pid, new->thread.regs->msr, msr);
+
+	/* This loads the checkpointed FP/VEC state, if used */
+	tm_recheckpoint(&new->thread, msr);
+
+	/* This loads the speculative FP/VEC state, if used */
+	if (msr & MSR_FP) {
+		do_load_up_transact_fpu(&new->thread);
+		new->thread.regs->msr |=
+			(MSR_FP | new->thread.fpexc_mode);
+	}
+	if (msr & MSR_VEC) {
+		do_load_up_transact_altivec(&new->thread);
+		new->thread.regs->msr |= MSR_VEC;
+	}
+	/* We may as well turn on VSX too since all the state is restored now */
+	if (msr & MSR_VSX)
+		new->thread.regs->msr |= MSR_VSX;
+
+	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
+		 "(kernel msr 0x%lx)\n",
+		 new->pid, mfmsr());
+}
+
+static inline void __switch_to_tm(struct task_struct *prev)
+{
+	if (cpu_has_feature(CPU_FTR_TM)) {
+		tm_enable();
+		tm_reclaim_task(prev);
+	}
+}
+#else
+#define tm_recheckpoint_new_task(new)
+#define __switch_to_tm(prev)
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
-- 
1.7.10.4
