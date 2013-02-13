Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 13/17] powerpc: Add new transactional memory state to the
 signal context
Date: Wed, 13 Feb 2013 15:31:31 +1100
Message-Id: <1360729895-304-14-git-send-email-mikey@neuling.org>
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

This adds the new transactional memory archtected state to the signal context
in both 32 and 64 bit.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h  |    1 +
 arch/powerpc/kernel/signal.h    |    8 +
 arch/powerpc/kernel/signal_32.c |  500 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/signal_64.c |  337 +++++++++++++++++++++++++-
 4 files changed, 830 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index eee2a60..7035e60 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -120,6 +120,7 @@
 #define TM_CAUSE_FAC_UNAV	0xfa
 #define TM_CAUSE_SYSCALL	0xf9 /* Persistent */
 #define TM_CAUSE_MISC		0xf6
+#define TM_CAUSE_SIGNAL		0xf4
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index e00acb4..ec84c90 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -25,13 +25,21 @@ extern int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 
 extern unsigned long copy_fpr_to_user(void __user *to,
 				      struct task_struct *task);
+extern unsigned long copy_transact_fpr_to_user(void __user *to,
+					       struct task_struct *task);
 extern unsigned long copy_fpr_from_user(struct task_struct *task,
 					void __user *from);
+extern unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+						 void __user *from);
 #ifdef CONFIG_VSX
 extern unsigned long copy_vsx_to_user(void __user *to,
 				      struct task_struct *task);
+extern unsigned long copy_transact_vsx_to_user(void __user *to,
+					       struct task_struct *task);
 extern unsigned long copy_vsx_from_user(struct task_struct *task,
 					void __user *from);
+extern unsigned long copy_transact_vsx_from_user(struct task_struct *task,
+						 void __user *from);
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 804e323..e4a88d3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -43,6 +43,7 @@
 #include <asm/sigcontext.h>
 #include <asm/vdso.h>
 #include <asm/switch_to.h>
+#include <asm/tm.h>
 #ifdef CONFIG_PPC64
 #include "ppc32.h"
 #include <asm/unistd.h>
@@ -293,6 +294,10 @@ long sys_sigaction(int sig, struct old_sigaction __user *act,
 struct sigframe {
 	struct sigcontext sctx;		/* the sigcontext */
 	struct mcontext	mctx;		/* all the register values */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	struct sigcontext sctx_transact;
+	struct mcontext	mctx_transact;
+#endif
 	/*
 	 * Programs using the rs6000/xcoff abi can save up to 19 gp
 	 * regs and 18 fp regs below sp before decrementing it.
@@ -321,6 +326,9 @@ struct rt_sigframe {
 	struct siginfo info;
 #endif
 	struct ucontext	uc;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	struct ucontext	uc_transact;
+#endif
 	/*
 	 * Programs using the rs6000/xcoff abi can save up to 19 gp
 	 * regs and 18 fp regs below sp before decrementing it.
@@ -381,6 +389,61 @@ unsigned long copy_vsx_from_user(struct task_struct *task,
 		task->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 	return 0;
 }
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+unsigned long copy_transact_fpr_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	double buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_TRANS_FPR(i);
+	memcpy(&buf[i], &task->thread.transact_fpscr, sizeof(double));
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	double buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_TRANS_FPR(i) = buf[i];
+	memcpy(&task->thread.transact_fpscr, &buf[i], sizeof(double));
+
+	return 0;
+}
+
+unsigned long copy_transact_vsx_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	double buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.transact_fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_transact_vsx_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	double buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.transact_fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #else
 inline unsigned long copy_fpr_to_user(void __user *to,
 				      struct task_struct *task)
@@ -395,6 +458,22 @@ inline unsigned long copy_fpr_from_user(struct task_struct *task,
 	return __copy_from_user(task->thread.fpr, from,
 			      ELF_NFPREG * sizeof(double));
 }
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+inline unsigned long copy_transact_fpr_to_user(void __user *to,
+					 struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.transact_fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_transact_fpr_from_user(struct task_struct *task,
+						 void __user *from)
+{
+	return __copy_from_user(task->thread.transact_fpr, from,
+				ELF_NFPREG * sizeof(double));
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #endif
 
 /*
@@ -483,6 +562,156 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 	return 0;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Save the current user registers on the user stack.
+ * We only save the altivec/spe registers if the process has used
+ * altivec/spe instructions at some point.
+ * We also save the transactional registers to a second ucontext in the
+ * frame.
+ *
+ * See save_user_regs() and signal_64.c:setup_tm_sigcontexts().
+ */
+static int save_tm_user_regs(struct pt_regs *regs,
+			     struct mcontext __user *frame,
+			     struct mcontext __user *tm_frame, int sigret)
+{
+	unsigned long msr = regs->msr;
+
+	/* tm_reclaim rolls back all reg states, updating thread.ckpt_regs,
+	 * thread.transact_fpr[], thread.transact_vr[], etc.
+	 */
+	tm_enable();
+	tm_reclaim(&current->thread, msr, TM_CAUSE_SIGNAL);
+
+	/* Make sure floating point registers are stored in regs */
+	flush_fp_to_thread(current);
+
+	/* Save both sets of general registers */
+	if (save_general_regs(&current->thread.ckpt_regs, frame)
+	    || save_general_regs(regs, tm_frame))
+		return 1;
+
+	/* Stash the top half of the 64bit MSR into the 32bit MSR word
+	 * of the transactional mcontext.  This way we have a backward-compatible
+	 * MSR in the 'normal' (checkpointed) mcontext and additionally one can
+	 * also look at what type of transaction (T or S) was active at the
+	 * time of the signal.
+	 */
+	if (__put_user((msr >> 32), &tm_frame->mc_gregs[PT_MSR]))
+		return 1;
+
+#ifdef CONFIG_ALTIVEC
+	/* save altivec registers */
+	if (current->thread.used_vr) {
+		flush_altivec_to_thread(current);
+		if (__copy_to_user(&frame->mc_vregs, current->thread.vr,
+				   ELF_NVRREG * sizeof(vector128)))
+			return 1;
+		if (msr & MSR_VEC) {
+			if (__copy_to_user(&tm_frame->mc_vregs,
+					   current->thread.transact_vr,
+					   ELF_NVRREG * sizeof(vector128)))
+				return 1;
+		} else {
+			if (__copy_to_user(&tm_frame->mc_vregs,
+					   current->thread.vr,
+					   ELF_NVRREG * sizeof(vector128)))
+				return 1;
+		}
+
+		/* set MSR_VEC in the saved MSR value to indicate that
+		 * frame->mc_vregs contains valid data
+		 */
+		msr |= MSR_VEC;
+	}
+
+	/* We always copy to/from vrsave, it's 0 if we don't have or don't
+	 * use altivec. Since VSCR only contains 32 bits saved in the least
+	 * significant bits of a vector, we "cheat" and stuff VRSAVE in the
+	 * most significant bits of that same vector. --BenH
+	 */
+	if (__put_user(current->thread.vrsave,
+		       (u32 __user *)&frame->mc_vregs[32]))
+		return 1;
+	if (msr & MSR_VEC) {
+		if (__put_user(current->thread.transact_vrsave,
+			       (u32 __user *)&tm_frame->mc_vregs[32]))
+			return 1;
+	} else {
+		if (__put_user(current->thread.vrsave,
+			       (u32 __user *)&tm_frame->mc_vregs[32]))
+			return 1;
+	}
+#endif /* CONFIG_ALTIVEC */
+
+	if (copy_fpr_to_user(&frame->mc_fregs, current))
+		return 1;
+	if (msr & MSR_FP) {
+		if (copy_transact_fpr_to_user(&tm_frame->mc_fregs, current))
+			return 1;
+	} else {
+		if (copy_fpr_to_user(&tm_frame->mc_fregs, current))
+			return 1;
+	}
+
+#ifdef CONFIG_VSX
+	/*
+	 * Copy VSR 0-31 upper half from thread_struct to local
+	 * buffer, then write that to userspace.  Also set MSR_VSX in
+	 * the saved MSR value to indicate that frame->mc_vregs
+	 * contains valid data
+	 */
+	if (current->thread.used_vsr) {
+		__giveup_vsx(current);
+		if (copy_vsx_to_user(&frame->mc_vsregs, current))
+			return 1;
+		if (msr & MSR_VSX) {
+			if (copy_transact_vsx_to_user(&tm_frame->mc_vsregs,
+						      current))
+				return 1;
+		} else {
+			if (copy_vsx_to_user(&tm_frame->mc_vsregs, current))
+				return 1;
+		}
+
+		msr |= MSR_VSX;
+	}
+#endif /* CONFIG_VSX */
+#ifdef CONFIG_SPE
+	/* SPE regs are not checkpointed with TM, so this section is
+	 * simply the same as in save_user_regs().
+	 */
+	if (current->thread.used_spe) {
+		flush_spe_to_thread(current);
+		if (__copy_to_user(&frame->mc_vregs, current->thread.evr,
+				   ELF_NEVRREG * sizeof(u32)))
+			return 1;
+		/* set MSR_SPE in the saved MSR value to indicate that
+		 * frame->mc_vregs contains valid data */
+		msr |= MSR_SPE;
+	}
+
+	/* We always copy to/from spefscr */
+	if (__put_user(current->thread.spefscr, (u32 __user *)&frame->mc_vregs + ELF_NEVRREG))
+		return 1;
+#endif /* CONFIG_SPE */
+
+	if (__put_user(msr, &frame->mc_gregs[PT_MSR]))
+		return 1;
+	if (sigret) {
+		/* Set up the sigreturn trampoline: li r0,sigret; sc */
+		if (__put_user(0x38000000UL + sigret, &frame->tramp[0])
+		    || __put_user(0x44000002UL, &frame->tramp[1]))
+			return 1;
+		flush_icache_range((unsigned long) &frame->tramp[0],
+				   (unsigned long) &frame->tramp[2]);
+	}
+
+	return 0;
+}
+#endif
+
 /*
  * Restore the current user register values from the user stack,
  * (except for MSR).
@@ -588,6 +817,139 @@ static long restore_user_regs(struct pt_regs *regs,
 	return 0;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Restore the current user register values from the user stack, except for
+ * MSR, and recheckpoint the original checkpointed register state for processes
+ * in transactions.
+ */
+static long restore_tm_user_regs(struct pt_regs *regs,
+				 struct mcontext __user *sr,
+				 struct mcontext __user *tm_sr)
+{
+	long err;
+	unsigned long msr;
+#ifdef CONFIG_VSX
+	int i;
+#endif
+
+	/*
+	 * restore general registers but not including MSR or SOFTE. Also
+	 * take care of keeping r2 (TLS) intact if not a signal.
+	 * See comment in signal_64.c:restore_tm_sigcontexts();
+	 * TFHAR is restored from the checkpointed NIP; TEXASR and TFIAR
+	 * were set by the signal delivery.
+	 */
+	err = restore_general_regs(regs, tm_sr);
+	err |= restore_general_regs(&current->thread.ckpt_regs, sr);
+
+	err |= __get_user(current->thread.tm_tfhar, &sr->mc_gregs[PT_NIP]);
+
+	err |= __get_user(msr, &sr->mc_gregs[PT_MSR]);
+	if (err)
+		return 1;
+
+	/* Restore the previous little-endian mode */
+	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
+
+	/*
+	 * Do this before updating the thread state in
+	 * current->thread.fpr/vr/evr.  That way, if we get preempted
+	 * and another task grabs the FPU/Altivec/SPE, it won't be
+	 * tempted to save the current CPU state into the thread_struct
+	 * and corrupt what we are writing there.
+	 */
+	discard_lazy_cpu_state();
+
+#ifdef CONFIG_ALTIVEC
+	regs->msr &= ~MSR_VEC;
+	if (msr & MSR_VEC) {
+		/* restore altivec registers from the stack */
+		if (__copy_from_user(current->thread.vr, &sr->mc_vregs,
+				     sizeof(sr->mc_vregs)) ||
+		    __copy_from_user(current->thread.transact_vr,
+				     &tm_sr->mc_vregs,
+				     sizeof(sr->mc_vregs)))
+			return 1;
+	} else if (current->thread.used_vr) {
+		memset(current->thread.vr, 0, ELF_NVRREG * sizeof(vector128));
+		memset(current->thread.transact_vr, 0,
+		       ELF_NVRREG * sizeof(vector128));
+	}
+
+	/* Always get VRSAVE back */
+	if (__get_user(current->thread.vrsave,
+		       (u32 __user *)&sr->mc_vregs[32]) ||
+	    __get_user(current->thread.transact_vrsave,
+		       (u32 __user *)&tm_sr->mc_vregs[32]))
+		return 1;
+#endif /* CONFIG_ALTIVEC */
+
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
+
+	if (copy_fpr_from_user(current, &sr->mc_fregs) ||
+	    copy_transact_fpr_from_user(current, &tm_sr->mc_fregs))
+		return 1;
+
+#ifdef CONFIG_VSX
+	regs->msr &= ~MSR_VSX;
+	if (msr & MSR_VSX) {
+		/*
+		 * Restore altivec registers from the stack to a local
+		 * buffer, then write this out to the thread_struct
+		 */
+		if (copy_vsx_from_user(current, &sr->mc_vsregs) ||
+		    copy_transact_vsx_from_user(current, &tm_sr->mc_vsregs))
+			return 1;
+	} else if (current->thread.used_vsr)
+		for (i = 0; i < 32 ; i++) {
+			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
+			current->thread.transact_fpr[i][TS_VSRLOWOFFSET] = 0;
+		}
+#endif /* CONFIG_VSX */
+
+#ifdef CONFIG_SPE
+	/* SPE regs are not checkpointed with TM, so this section is
+	 * simply the same as in restore_user_regs().
+	 */
+	regs->msr &= ~MSR_SPE;
+	if (msr & MSR_SPE) {
+		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
+				     ELF_NEVRREG * sizeof(u32)))
+			return 1;
+	} else if (current->thread.used_spe)
+		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
+
+	/* Always get SPEFSCR back */
+	if (__get_user(current->thread.spefscr, (u32 __user *)&sr->mc_vregs
+		       + ELF_NEVRREG))
+		return 1;
+#endif /* CONFIG_SPE */
+
+	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
+	 * registers, including FP and V[S]Rs.  After recheckpointing, the
+	 * transactional versions should be loaded.
+	 */
+	tm_enable();
+	/* This loads the checkpointed FP/VEC state, if used */
+	tm_recheckpoint(&current->thread, msr);
+	/* The task has moved into TM state S, so ensure MSR reflects this */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | MSR_TS_S;
+
+	/* This loads the speculative FP/VEC state, if used */
+	if (msr & MSR_FP) {
+		do_load_up_transact_fpu(&current->thread);
+		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
+	}
+	if (msr & MSR_VEC) {
+		do_load_up_transact_altivec(&current->thread);
+		regs->msr |= MSR_VEC;
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PPC64
 long compat_sys_rt_sigaction(int sig, const struct sigaction32 __user *act,
 		struct sigaction32 __user *oact, size_t sigsetsize)
@@ -827,6 +1189,8 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	struct mcontext __user *frame;
 	void __user *addr;
 	unsigned long newsp = 0;
+	int sigret;
+	unsigned long tramp;
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
@@ -838,7 +1202,6 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	/* Put the siginfo & fill in most of the ucontext */
 	if (copy_siginfo_to_user(&rt_sf->info, info)
 	    || __put_user(0, &rt_sf->uc.uc_flags)
-	    || __put_user(0, &rt_sf->uc.uc_link)
 	    || __put_user(current->sas_ss_sp, &rt_sf->uc.uc_stack.ss_sp)
 	    || __put_user(sas_ss_flags(regs->gpr[1]),
 			  &rt_sf->uc.uc_stack.ss_flags)
@@ -852,14 +1215,37 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	frame = &rt_sf->uc.uc_mcontext;
 	addr = frame;
 	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
-		if (save_user_regs(regs, frame, 0, 1))
-			goto badframe;
-		regs->link = current->mm->context.vdso_base + vdso32_rt_sigtramp;
+		sigret = 0;
+		tramp = current->mm->context.vdso_base + vdso32_rt_sigtramp;
 	} else {
-		if (save_user_regs(regs, frame, __NR_rt_sigreturn, 1))
+		sigret = __NR_rt_sigreturn;
+		tramp = (unsigned long) frame->tramp;
+	}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		if (save_tm_user_regs(regs, &rt_sf->uc.uc_mcontext,
+				      &rt_sf->uc_transact.uc_mcontext, sigret))
 			goto badframe;
-		regs->link = (unsigned long) frame->tramp;
 	}
+	else
+#endif
+		if (save_user_regs(regs, frame, sigret, 1))
+			goto badframe;
+	regs->link = tramp;
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		if (__put_user((unsigned long)&rt_sf->uc_transact,
+			       &rt_sf->uc.uc_link)
+		    || __put_user(to_user_ptr(&rt_sf->uc_transact.uc_mcontext),
+				  &rt_sf->uc_transact.uc_regs))
+			goto badframe;
+	}
+	else
+#endif
+		if (__put_user(0, &rt_sf->uc.uc_link))
+			goto badframe;
 
 	current->thread.fpscr.val = 0;	/* turn off all fp exceptions */
 
@@ -878,6 +1264,13 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
+	 * just indicates to userland that we were doing a transaction, but we
+	 * don't want to return in transactional state:
+	 */
+	regs->msr &= ~MSR_TS_MASK;
+#endif
 	return 1;
 
 badframe:
@@ -925,6 +1318,35 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
 	return 0;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static int do_setcontext_tm(struct ucontext __user *ucp,
+			    struct ucontext __user *tm_ucp,
+			    struct pt_regs *regs)
+{
+	sigset_t set;
+	struct mcontext __user *mcp;
+	struct mcontext __user *tm_mcp;
+	u32 cmcp;
+	u32 tm_cmcp;
+
+	if (get_sigset_t(&set, &ucp->uc_sigmask))
+		return -EFAULT;
+
+	if (__get_user(cmcp, &ucp->uc_regs) ||
+	    __get_user(tm_cmcp, &tm_ucp->uc_regs))
+		return -EFAULT;
+	mcp = (struct mcontext __user *)(u64)cmcp;
+	tm_mcp = (struct mcontext __user *)(u64)tm_cmcp;
+	/* no need to check access_ok(mcp), since mcp < 4GB */
+
+	set_current_blocked(&set);
+	if (restore_tm_user_regs(regs, mcp, tm_mcp))
+		return -EFAULT;
+
+	return 0;
+}
+#endif
+
 long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx,
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
@@ -1020,7 +1442,12 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 		     struct pt_regs *regs)
 {
 	struct rt_sigframe __user *rt_sf;
-
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	struct ucontext __user *uc_transact;
+	unsigned long msr_hi;
+	unsigned long tmp;
+	int tm_restore = 0;
+#endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
@@ -1028,6 +1455,34 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
 	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
 		goto bad;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (__get_user(tmp, &rt_sf->uc.uc_link))
+		goto bad;
+	uc_transact = (struct ucontext __user *)(uintptr_t)tmp;
+	if (uc_transact) {
+		u32 cmcp;
+		struct mcontext __user *mcp;
+
+		if (__get_user(cmcp, &uc_transact->uc_regs))
+			return -EFAULT;
+		mcp = (struct mcontext __user *)(u64)cmcp;
+		/* The top 32 bits of the MSR are stashed in the transactional
+		 * ucontext. */
+		if (__get_user(msr_hi, &mcp->mc_gregs[PT_MSR]))
+			goto bad;
+
+		if (MSR_TM_SUSPENDED(msr_hi<<32)) {
+			/* We only recheckpoint on return if we're
+			 * transaction.
+			 */
+			tm_restore = 1;
+			if (do_setcontext_tm(&rt_sf->uc, uc_transact, regs))
+				goto bad;
+		}
+	}
+	if (!tm_restore)
+		/* Fall through, for non-TM restore */
+#endif
 	if (do_setcontext(&rt_sf->uc, regs, 1))
 		goto bad;
 
@@ -1179,6 +1634,8 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
 	unsigned long newsp = 0;
+	int sigret;
+	unsigned long tramp;
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ka, regs, sizeof(*frame), 1);
@@ -1201,14 +1658,25 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 		goto badframe;
 
 	if (vdso32_sigtramp && current->mm->context.vdso_base) {
-		if (save_user_regs(regs, &frame->mctx, 0, 1))
-			goto badframe;
-		regs->link = current->mm->context.vdso_base + vdso32_sigtramp;
+		sigret = 0;
+		tramp = current->mm->context.vdso_base + vdso32_sigtramp;
 	} else {
-		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn, 1))
+		sigret = __NR_sigreturn;
+		tramp = (unsigned long) frame->mctx.tramp;
+	}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
+				      sigret))
 			goto badframe;
-		regs->link = (unsigned long) frame->mctx.tramp;
 	}
+	else
+#endif
+		if (save_user_regs(regs, &frame->mctx, sigret, 1))
+			goto badframe;
+
+	regs->link = tramp;
 
 	current->thread.fpscr.val = 0;	/* turn off all fp exceptions */
 
@@ -1223,7 +1691,13 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
-
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
+	 * just indicates to userland that we were doing a transaction, but we
+	 * don't want to return in transactional state:
+	 */
+	regs->msr &= ~MSR_TS_MASK;
+#endif
 	return 1;
 
 badframe:
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1ca045d..7a76ee4 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -34,6 +34,7 @@
 #include <asm/syscalls.h>
 #include <asm/vdso.h>
 #include <asm/switch_to.h>
+#include <asm/tm.h>
 
 #include "signal.h"
 
@@ -56,6 +57,9 @@
 struct rt_sigframe {
 	/* sys_rt_sigreturn requires the ucontext be the first field */
 	struct ucontext uc;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	struct ucontext uc_transact;
+#endif
 	unsigned long _unused[2];
 	unsigned int tramp[TRAMP_SIZE];
 	struct siginfo __user *pinfo;
@@ -145,6 +149,145 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	return err;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * As above, but Transactional Memory is in use, so deliver sigcontexts
+ * containing checkpointed and transactional register states.
+ *
+ * To do this, we treclaim to gather both sets of registers and set up the
+ * 'normal' sigcontext registers with rolled-back register values such that a
+ * simple signal handler sees a correct checkpointed register state.
+ * If interested, a TM-aware sighandler can examine the transactional registers
+ * in the 2nd sigcontext to determine the real origin of the signal.
+ */
+static long setup_tm_sigcontexts(struct sigcontext __user *sc,
+				 struct sigcontext __user *tm_sc,
+				 struct pt_regs *regs,
+				 int signr, sigset_t *set, unsigned long handler)
+{
+	/* When CONFIG_ALTIVEC is set, we _always_ setup v_regs even if the
+	 * process never used altivec yet (MSR_VEC is zero in pt_regs of
+	 * the context). This is very important because we must ensure we
+	 * don't lose the VRSAVE content that may have been set prior to
+	 * the process doing its first vector operation
+	 * Userland shall check AT_HWCAP to know wether it can rely on the
+	 * v_regs pointer or not.
+	 */
+#ifdef CONFIG_ALTIVEC
+	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)
+		(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
+	elf_vrreg_t __user *tm_v_regs = (elf_vrreg_t __user *)
+		(((unsigned long)tm_sc->vmx_reserve + 15) & ~0xful);
+#endif
+	unsigned long msr = regs->msr;
+	long err = 0;
+
+	BUG_ON(!MSR_TM_ACTIVE(regs->msr));
+
+	/* tm_reclaim rolls back all reg states, saving checkpointed (older)
+	 * GPRs to thread.ckpt_regs and (if used) FPRs to (newer)
+	 * thread.transact_fp and/or VRs to (newer) thread.transact_vr.
+	 * THEN we save out FP/VRs, if necessary, to the checkpointed (older)
+	 * thread.fr[]/vr[]s.  The transactional (newer) GPRs are on the
+	 * stack, in *regs.
+	 */
+	tm_enable();
+	tm_reclaim(&current->thread, msr, TM_CAUSE_SIGNAL);
+
+	flush_fp_to_thread(current);
+
+#ifdef CONFIG_ALTIVEC
+	err |= __put_user(v_regs, &sc->v_regs);
+	err |= __put_user(tm_v_regs, &tm_sc->v_regs);
+
+	/* save altivec registers */
+	if (current->thread.used_vr) {
+		flush_altivec_to_thread(current);
+		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
+		err |= __copy_to_user(v_regs, current->thread.vr,
+				      33 * sizeof(vector128));
+		/* If VEC was enabled there are transactional VRs valid too,
+		 * else they're a copy of the checkpointed VRs.
+		 */
+		if (msr & MSR_VEC)
+			err |= __copy_to_user(tm_v_regs,
+					      current->thread.transact_vr,
+					      33 * sizeof(vector128));
+		else
+			err |= __copy_to_user(tm_v_regs,
+					      current->thread.vr,
+					      33 * sizeof(vector128));
+
+		/* set MSR_VEC in the MSR value in the frame to indicate
+		 * that sc->v_reg contains valid data.
+		 */
+		msr |= MSR_VEC;
+	}
+	/* We always copy to/from vrsave, it's 0 if we don't have or don't
+	 * use altivec.
+	 */
+	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
+	if (msr & MSR_VEC)
+		err |= __put_user(current->thread.transact_vrsave,
+				  (u32 __user *)&tm_v_regs[33]);
+	else
+		err |= __put_user(current->thread.vrsave,
+				  (u32 __user *)&tm_v_regs[33]);
+
+#else /* CONFIG_ALTIVEC */
+	err |= __put_user(0, &sc->v_regs);
+	err |= __put_user(0, &tm_sc->v_regs);
+#endif /* CONFIG_ALTIVEC */
+
+	/* copy fpr regs and fpscr */
+	err |= copy_fpr_to_user(&sc->fp_regs, current);
+	if (msr & MSR_FP)
+		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, current);
+	else
+		err |= copy_fpr_to_user(&tm_sc->fp_regs, current);
+
+#ifdef CONFIG_VSX
+	/*
+	 * Copy VSX low doubleword to local buffer for formatting,
+	 * then out to userspace.  Update v_regs to point after the
+	 * VMX data.
+	 */
+	if (current->thread.used_vsr) {
+		__giveup_vsx(current);
+		v_regs += ELF_NVRREG;
+		tm_v_regs += ELF_NVRREG;
+
+		err |= copy_vsx_to_user(v_regs, current);
+
+		if (msr & MSR_VSX)
+			err |= copy_transact_vsx_to_user(tm_v_regs, current);
+		else
+			err |= copy_vsx_to_user(tm_v_regs, current);
+
+		/* set MSR_VSX in the MSR value in the frame to
+		 * indicate that sc->vs_reg) contains valid data.
+		 */
+		msr |= MSR_VSX;
+	}
+#endif /* CONFIG_VSX */
+
+	err |= __put_user(&sc->gp_regs, &sc->regs);
+	err |= __put_user(&tm_sc->gp_regs, &tm_sc->regs);
+	WARN_ON(!FULL_REGS(regs));
+	err |= __copy_to_user(&tm_sc->gp_regs, regs, GP_REGS_SIZE);
+	err |= __copy_to_user(&sc->gp_regs,
+			      &current->thread.ckpt_regs, GP_REGS_SIZE);
+	err |= __put_user(msr, &tm_sc->gp_regs[PT_MSR]);
+	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
+	err |= __put_user(signr, &sc->signal);
+	err |= __put_user(handler, &sc->handler);
+	if (set != NULL)
+		err |=  __put_user(set->sig[0], &sc->oldmask);
+
+	return err;
+}
+#endif
+
 /*
  * Restore the sigcontext from the signal frame.
  */
@@ -241,6 +384,153 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	return err;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Restore the two sigcontexts from the frame of a transactional processes.
+ */
+
+static long restore_tm_sigcontexts(struct pt_regs *regs,
+				   struct sigcontext __user *sc,
+				   struct sigcontext __user *tm_sc)
+{
+#ifdef CONFIG_ALTIVEC
+	elf_vrreg_t __user *v_regs, *tm_v_regs;
+#endif
+	unsigned long err = 0;
+	unsigned long msr;
+#ifdef CONFIG_VSX
+	int i;
+#endif
+	/* copy the GPRs */
+	err |= __copy_from_user(regs->gpr, tm_sc->gp_regs, sizeof(regs->gpr));
+	err |= __copy_from_user(&current->thread.ckpt_regs, sc->gp_regs,
+				sizeof(regs->gpr));
+
+	/*
+	 * TFHAR is restored from the checkpointed 'wound-back' ucontext's NIP.
+	 * TEXASR was set by the signal delivery reclaim, as was TFIAR.
+	 * Users doing anything abhorrent like thread-switching w/ signals for
+	 * TM-Suspended code will have to back TEXASR/TFIAR up themselves.
+	 * For the case of getting a signal and simply returning from it,
+	 * we don't need to re-copy them here.
+	 */
+	err |= __get_user(regs->nip, &tm_sc->gp_regs[PT_NIP]);
+	err |= __get_user(current->thread.tm_tfhar, &sc->gp_regs[PT_NIP]);
+
+	/* get MSR separately, transfer the LE bit if doing signal return */
+	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
+	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
+
+	/* The following non-GPR non-FPR non-VR state is also checkpointed: */
+	err |= __get_user(regs->ctr, &tm_sc->gp_regs[PT_CTR]);
+	err |= __get_user(regs->link, &tm_sc->gp_regs[PT_LNK]);
+	err |= __get_user(regs->xer, &tm_sc->gp_regs[PT_XER]);
+	err |= __get_user(regs->ccr, &tm_sc->gp_regs[PT_CCR]);
+	err |= __get_user(current->thread.ckpt_regs.ctr,
+			  &sc->gp_regs[PT_CTR]);
+	err |= __get_user(current->thread.ckpt_regs.link,
+			  &sc->gp_regs[PT_LNK]);
+	err |= __get_user(current->thread.ckpt_regs.xer,
+			  &sc->gp_regs[PT_XER]);
+	err |= __get_user(current->thread.ckpt_regs.ccr,
+			  &sc->gp_regs[PT_CCR]);
+
+	/* These regs are not checkpointed; they can go in 'regs'. */
+	err |= __get_user(regs->trap, &sc->gp_regs[PT_TRAP]);
+	err |= __get_user(regs->dar, &sc->gp_regs[PT_DAR]);
+	err |= __get_user(regs->dsisr, &sc->gp_regs[PT_DSISR]);
+	err |= __get_user(regs->result, &sc->gp_regs[PT_RESULT]);
+
+	/*
+	 * Do this before updating the thread state in
+	 * current->thread.fpr/vr.  That way, if we get preempted
+	 * and another task grabs the FPU/Altivec, it won't be
+	 * tempted to save the current CPU state into the thread_struct
+	 * and corrupt what we are writing there.
+	 */
+	discard_lazy_cpu_state();
+
+	/*
+	 * Force reload of FP/VEC.
+	 * This has to be done before copying stuff into current->thread.fpr/vr
+	 * for the reasons explained in the previous comment.
+	 */
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC | MSR_VSX);
+
+#ifdef CONFIG_ALTIVEC
+	err |= __get_user(v_regs, &sc->v_regs);
+	err |= __get_user(tm_v_regs, &tm_sc->v_regs);
+	if (err)
+		return err;
+	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
+		return -EFAULT;
+	if (tm_v_regs && !access_ok(VERIFY_READ,
+				    tm_v_regs, 34 * sizeof(vector128)))
+		return -EFAULT;
+	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
+	if (v_regs != 0 && tm_v_regs != 0 && (msr & MSR_VEC) != 0) {
+		err |= __copy_from_user(current->thread.vr, v_regs,
+					33 * sizeof(vector128));
+		err |= __copy_from_user(current->thread.transact_vr, tm_v_regs,
+					33 * sizeof(vector128));
+	}
+	else if (current->thread.used_vr) {
+		memset(current->thread.vr, 0, 33 * sizeof(vector128));
+		memset(current->thread.transact_vr, 0, 33 * sizeof(vector128));
+	}
+	/* Always get VRSAVE back */
+	if (v_regs != 0 && tm_v_regs != 0) {
+		err |= __get_user(current->thread.vrsave,
+				  (u32 __user *)&v_regs[33]);
+		err |= __get_user(current->thread.transact_vrsave,
+				  (u32 __user *)&tm_v_regs[33]);
+	}
+	else {
+		current->thread.vrsave = 0;
+		current->thread.transact_vrsave = 0;
+	}
+#endif /* CONFIG_ALTIVEC */
+	/* restore floating point */
+	err |= copy_fpr_from_user(current, &sc->fp_regs);
+	err |= copy_transact_fpr_from_user(current, &tm_sc->fp_regs);
+#ifdef CONFIG_VSX
+	/*
+	 * Get additional VSX data. Update v_regs to point after the
+	 * VMX data.  Copy VSX low doubleword from userspace to local
+	 * buffer for formatting, then into the taskstruct.
+	 */
+	if (v_regs && ((msr & MSR_VSX) != 0)) {
+		v_regs += ELF_NVRREG;
+		tm_v_regs += ELF_NVRREG;
+		err |= copy_vsx_from_user(current, v_regs);
+		err |= copy_transact_vsx_from_user(current, tm_v_regs);
+	} else {
+		for (i = 0; i < 32 ; i++) {
+			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
+			current->thread.transact_fpr[i][TS_VSRLOWOFFSET] = 0;
+		}
+	}
+#endif
+	tm_enable();
+	/* This loads the checkpointed FP/VEC state, if used */
+	tm_recheckpoint(&current->thread, msr);
+	/* The task has moved into TM state S, so ensure MSR reflects this: */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | __MASK(33);
+
+	/* This loads the speculative FP/VEC state, if used */
+	if (msr & MSR_FP) {
+		do_load_up_transact_fpu(&current->thread);
+		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
+	}
+	if (msr & MSR_VEC) {
+		do_load_up_transact_altivec(&current->thread);
+		regs->msr |= MSR_VEC;
+	}
+
+	return err;
+}
+#endif
+
 /*
  * Setup the trampoline code on the stack
  */
@@ -355,6 +645,9 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 {
 	struct ucontext __user *uc = (struct ucontext __user *)regs->gpr[1];
 	sigset_t set;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	unsigned long msr;
+#endif
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -365,6 +658,21 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
 		goto badframe;
 	set_current_blocked(&set);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
+		goto badframe;
+	if (MSR_TM_SUSPENDED(msr)) {
+		/* We recheckpoint on return. */
+		struct ucontext __user *uc_transact;
+		if (__get_user(uc_transact, &uc->uc_link))
+			goto badframe;
+		if (restore_tm_sigcontexts(regs, &uc->uc_mcontext,
+					   &uc_transact->uc_mcontext))
+			goto badframe;
+	}
+	else
+	/* Fall through, for non-TM restore */
+#endif
 	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
 		goto badframe;
 
@@ -415,19 +723,42 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
 	err |= __put_user(current->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->gpr[1]),
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr, NULL,
-				(unsigned long)ka->sa.sa_handler, 1);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		/* The ucontext_t passed to userland points to the second
+		 * ucontext_t (for transactional state) with its uc_link ptr.
+		 */
+		err |= __put_user(&frame->uc_transact, &frame->uc.uc_link);
+		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
+					    &frame->uc_transact.uc_mcontext,
+					    regs, signr,
+					    NULL,
+					    (unsigned long)ka->sa.sa_handler);
+	} else
+#endif
+	{
+		err |= __put_user(0, &frame->uc.uc_link);
+		err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr,
+					NULL, (unsigned long)ka->sa.sa_handler,
+					1);
+	}
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto badframe;
 
 	/* Make sure signal handler doesn't get spurious FP exceptions */
 	current->thread.fpscr.val = 0;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
+	 * just indicates to userland that we were doing a transaction, but we
+	 * don't want to return in transactional state:
+	 */
+	regs->msr &= ~MSR_TS_MASK;
+#endif
 
 	/* Set up to return from userspace. */
 	if (vdso64_rt_sigtramp && current->mm->context.vdso_base) {
-- 
1.7.10.4
