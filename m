Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDZpX197qzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:44:03 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H3i1pe074191
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:01 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vfth0ut1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:00 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 17 Aug 2016 13:43:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1CF822CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H3hq5927263018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H3hpt2023505
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:51 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: mikey@neuling.org, anton@samba.org, paulus@samba.org
Subject: [PATCH v3 06/21] powerpc: signals: Stop using current in signal code
Date: Wed, 17 Aug 2016 13:43:08 +1000
In-Reply-To: <20160817034323.23053-1-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
Message-Id: <20160817034323.23053-7-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Much of the signal code takes a pt_regs on which it operates. Over
time the signal code has needed to know more about the thread than
what pt_regs can supply, this information is obtained as needed by
using 'current'.

This approach is not strictly incorrect however it does mean that
there is now a hard requirement that the pt_regs being passed around
does belong to current, this is never checked. A safer approach is for
the majority of the signal functions to take a task_struct from which
they can obtain pt_regs and any other information they need. The
caveat that the task_struct they are passed must be current doesn't go
away but can more easily be checked for.

Functions called from outside powerpc signal code are passed a pt_regs
and they can confirm that the pt_regs is that of current and pass
current to other functions, furthurmore, powerpc signal functions can
check that the task_struct they are passed is the same as current
avoiding possible corruption of current (or the task they are passed)
if this assertion ever fails.

CC: paulus@samba.org
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/signal.h |   2 -
 arch/powerpc/kernel/signal.c      |  41 ++++----
 arch/powerpc/kernel/signal.h      |  10 +-
 arch/powerpc/kernel/signal_32.c   |  31 +++---
 arch/powerpc/kernel/signal_64.c   | 192 +++++++++++++++++++++-----------------
 5 files changed, 154 insertions(+), 122 deletions(-)

diff --git a/arch/powerpc/include/asm/signal.h b/arch/powerpc/include/asm/signal.h
index 9322c28..5ff7772 100644
--- a/arch/powerpc/include/asm/signal.h
+++ b/arch/powerpc/include/asm/signal.h
@@ -5,6 +5,4 @@
 #include <uapi/asm/signal.h>
 #include <uapi/asm/ptrace.h>
 
-extern unsigned long get_tm_stackpointer(struct pt_regs *regs);
-
 #endif /* _ASM_POWERPC_SIGNAL_H */
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index cb64d6f..bbe77ae 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -99,22 +99,24 @@ static void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 	}
 }
 
-static void do_signal(struct pt_regs *regs)
+static void do_signal(struct task_struct *tsk)
 {
 	sigset_t *oldset = sigmask_to_save();
 	struct ksignal ksig;
 	int ret;
 	int is32 = is_32bit_task();
 
+	BUG_ON(tsk != current);
+
 	get_signal(&ksig);
 
 	/* Is there any syscall restart business here ? */
-	check_syscall_restart(regs, &ksig.ka, ksig.sig > 0);
+	check_syscall_restart(tsk->thread.regs, &ksig.ka, ksig.sig > 0);
 
 	if (ksig.sig <= 0) {
 		/* No signal to deliver -- put the saved sigmask back */
 		restore_saved_sigmask();
-		regs->trap = 0;
+		tsk->thread.regs->trap = 0;
 		return;               /* no signals delivered */
 	}
 
@@ -124,23 +126,22 @@ static void do_signal(struct pt_regs *regs)
 	 * user space. The DABR will have been cleared if it
 	 * triggered inside the kernel.
 	 */
-	if (current->thread.hw_brk.address &&
-		current->thread.hw_brk.type)
-		__set_breakpoint(&current->thread.hw_brk);
+	if (tsk->thread.hw_brk.address && tsk->thread.hw_brk.type)
+		__set_breakpoint(&tsk->thread.hw_brk);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
-	thread_change_pc(current, regs);
+	thread_change_pc(tsk, tsk->thread.regs);
 
 	if (is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
-			ret = handle_rt_signal32(&ksig, oldset, regs);
+			ret = handle_rt_signal32(&ksig, oldset, tsk);
 		else
-			ret = handle_signal32(&ksig, oldset, regs);
+			ret = handle_signal32(&ksig, oldset, tsk);
 	} else {
-		ret = handle_rt_signal64(&ksig, oldset, regs);
+		ret = handle_rt_signal64(&ksig, oldset, tsk);
 	}
 
-	regs->trap = 0;
+	tsk->thread.regs->trap = 0;
 	signal_setup_done(ret, &ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
@@ -151,8 +152,10 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_UPROBE)
 		uprobe_notify_resume(regs);
 
-	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs);
+	if (thread_info_flags & _TIF_SIGPENDING) {
+		BUG_ON(regs != current->thread.regs);
+		do_signal(current);
+	}
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
@@ -162,7 +165,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	user_enter();
 }
 
-unsigned long get_tm_stackpointer(struct pt_regs *regs)
+unsigned long get_tm_stackpointer(struct task_struct *tsk)
 {
 	/* When in an active transaction that takes a signal, we need to be
 	 * careful with the stack.  It's possible that the stack has moved back
@@ -187,11 +190,13 @@ unsigned long get_tm_stackpointer(struct pt_regs *regs)
 	 */
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (MSR_TM_ACTIVE(regs->msr)) {
+	BUG_ON(tsk != current);
+
+	if (MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
 		tm_reclaim_current(TM_CAUSE_SIGNAL);
-		if (MSR_TM_TRANSACTIONAL(regs->msr))
-			return current->thread.ckpt_regs.gpr[1];
+		if (MSR_TM_TRANSACTIONAL(tsk->thread.regs->msr))
+			return tsk->thread.ckpt_regs.gpr[1];
 	}
 #endif
-	return regs->gpr[1];
+	return tsk->thread.regs->gpr[1];
 }
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index be305c8..254ca07 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -16,10 +16,10 @@ extern void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
 				  size_t frame_size, int is_32);
 
 extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
-			   struct pt_regs *regs);
+			   struct task_struct *tsk);
 
 extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
-			      struct pt_regs *regs);
+			      struct task_struct *tsk);
 
 extern unsigned long copy_fpr_to_user(void __user *to,
 				      struct task_struct *task);
@@ -29,6 +29,8 @@ extern unsigned long copy_fpr_from_user(struct task_struct *task,
 					void __user *from);
 extern unsigned long copy_transact_fpr_from_user(struct task_struct *task,
 						 void __user *from);
+extern unsigned long get_tm_stackpointer(struct task_struct *tsk);
+
 #ifdef CONFIG_VSX
 extern unsigned long copy_vsx_to_user(void __user *to,
 				      struct task_struct *task);
@@ -43,12 +45,12 @@ extern unsigned long copy_transact_vsx_from_user(struct task_struct *task,
 #ifdef CONFIG_PPC64
 
 extern int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
-			      struct pt_regs *regs);
+			      struct task_struct *tsk);
 
 #else /* CONFIG_PPC64 */
 
 static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
-				     struct pt_regs *regs)
+				     struct task_struct *tsk)
 {
 	return -EFAULT;
 }
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378..d11cc9d 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -971,7 +971,7 @@ int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
  * (one which gets siginfo).
  */
 int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
-		       struct pt_regs *regs)
+		       struct task_struct *tsk)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
@@ -980,10 +980,13 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
+	struct pt_regs *regs = tsk->thread.regs;
+
+	BUG_ON(tsk != current);
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
@@ -1000,9 +1003,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
 	addr = frame;
-	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
+	if (vdso32_rt_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
-		tramp = current->mm->context.vdso_base + vdso32_rt_sigtramp;
+		tramp = tsk->mm->context.vdso_base + vdso32_rt_sigtramp;
 	} else {
 		sigret = __NR_rt_sigreturn;
 		tramp = (unsigned long) frame->tramp;
@@ -1029,7 +1032,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	}
 	regs->link = tramp;
 
-	current->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
+	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
 
 	/* create a stack frame for the caller of the handler */
 	newsp = ((unsigned long)rt_sf) - (__SIGNAL_FRAMESIZE + 16);
@@ -1054,7 +1057,7 @@ badframe:
 		printk_ratelimited(KERN_INFO
 				   "%s[%d]: bad frame in handle_rt_signal32: "
 				   "%p nip %08lx lr %08lx\n",
-				   current->comm, current->pid,
+				   tsk->comm, tsk->pid,
 				   addr, regs->nip, regs->link);
 
 	return 1;
@@ -1396,7 +1399,8 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 /*
  * OK, we're invoking a handler
  */
-int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs)
+int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
+		struct task_struct *tsk)
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
@@ -1404,9 +1408,12 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
+	struct pt_regs *regs = tsk->thread.regs;
+
+	BUG_ON(tsk != current);
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 1);
+	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
@@ -1425,9 +1432,9 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	    || __put_user(ksig->sig, &sc->signal))
 		goto badframe;
 
-	if (vdso32_sigtramp && current->mm->context.vdso_base) {
+	if (vdso32_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
-		tramp = current->mm->context.vdso_base + vdso32_sigtramp;
+		tramp = tsk->mm->context.vdso_base + vdso32_sigtramp;
 	} else {
 		sigret = __NR_sigreturn;
 		tramp = (unsigned long) frame->mctx.tramp;
@@ -1449,7 +1456,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 
 	regs->link = tramp;
 
-	current->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
+	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
 
 	/* create a stack frame for the caller of the handler */
 	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
@@ -1469,7 +1476,7 @@ badframe:
 		printk_ratelimited(KERN_INFO
 				   "%s[%d]: bad frame in handle_signal32: "
 				   "%p nip %08lx lr %08lx\n",
-				   current->comm, current->pid,
+				   tsk->comm, tsk->pid,
 				   frame, regs->nip, regs->link);
 
 	return 1;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 7e49984..6c1f99b 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -90,9 +90,9 @@ static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
  * Set up the sigcontext for the signal frame.
  */
 
-static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
-		 int signr, sigset_t *set, unsigned long handler,
-		 int ctx_has_vsx_region)
+static long setup_sigcontext(struct sigcontext __user *sc,
+		struct task_struct *tsk, int signr, sigset_t *set,
+		unsigned long handler, int ctx_has_vsx_region)
 {
 	/* When CONFIG_ALTIVEC is set, we _always_ setup v_regs even if the
 	 * process never used altivec yet (MSR_VEC is zero in pt_regs of
@@ -106,17 +106,20 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
 	unsigned long vrsave;
 #endif
+	struct pt_regs *regs = tsk->thread.regs;
 	unsigned long msr = regs->msr;
 	long err = 0;
 
+	BUG_ON(tsk != current);
+
 #ifdef CONFIG_ALTIVEC
 	err |= __put_user(v_regs, &sc->v_regs);
 
 	/* save altivec registers */
-	if (current->thread.used_vr) {
-		flush_altivec_to_thread(current);
+	if (tsk->thread.used_vr) {
+		flush_altivec_to_thread(tsk);
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
-		err |= __copy_to_user(v_regs, &current->thread.vr_state,
+		err |= __copy_to_user(v_regs, &tsk->thread.vr_state,
 				      33 * sizeof(vector128));
 		/* set MSR_VEC in the MSR value in the frame to indicate that sc->v_reg)
 		 * contains valid data.
@@ -129,16 +132,16 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	vrsave = 0;
 	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
 		vrsave = mfspr(SPRN_VRSAVE);
-		current->thread.vrsave = vrsave;
+		tsk->thread.vrsave = vrsave;
 	}
 
 	err |= __put_user(vrsave, (u32 __user *)&v_regs[33]);
 #else /* CONFIG_ALTIVEC */
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
-	flush_fp_to_thread(current);
+	flush_fp_to_thread(tsk);
 	/* copy fpr regs and fpscr */
-	err |= copy_fpr_to_user(&sc->fp_regs, current);
+	err |= copy_fpr_to_user(&sc->fp_regs, tsk);
 
 	/*
 	 * Clear the MSR VSX bit to indicate there is no valid state attached
@@ -151,10 +154,10 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	 * then out to userspace.  Update v_regs to point after the
 	 * VMX data.
 	 */
-	if (current->thread.used_vsr && ctx_has_vsx_region) {
-		flush_vsx_to_thread(current);
+	if (tsk->thread.used_vsr && ctx_has_vsx_region) {
+		flush_vsx_to_thread(tsk);
 		v_regs += ELF_NVRREG;
-		err |= copy_vsx_to_user(v_regs, current);
+		err |= copy_vsx_to_user(v_regs, tsk);
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
 		 */
@@ -187,7 +190,7 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
  */
 static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 				 struct sigcontext __user *tm_sc,
-				 struct pt_regs *regs,
+				 struct task_struct *tsk,
 				 int signr, sigset_t *set, unsigned long handler)
 {
 	/* When CONFIG_ALTIVEC is set, we _always_ setup v_regs even if the
@@ -202,9 +205,12 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
 	elf_vrreg_t __user *tm_v_regs = sigcontext_vmx_regs(tm_sc);
 #endif
-	unsigned long msr = regs->msr;
+	struct pt_regs *regs = tsk->thread.regs;
+	unsigned long msr = tsk->thread.ckpt_regs.msr;
 	long err = 0;
 
+	BUG_ON(tsk != current);
+
 	BUG_ON(!MSR_TM_ACTIVE(regs->msr));
 
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
@@ -214,28 +220,28 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 */
 	regs->msr &= ~MSR_TS_MASK;
 
-	flush_fp_to_thread(current);
+	flush_fp_to_thread(tsk);
 
 #ifdef CONFIG_ALTIVEC
 	err |= __put_user(v_regs, &sc->v_regs);
 	err |= __put_user(tm_v_regs, &tm_sc->v_regs);
 
 	/* save altivec registers */
-	if (current->thread.used_vr) {
-		flush_altivec_to_thread(current);
+	if (tsk->thread.used_vr) {
+		flush_altivec_to_thread(tsk);
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
-		err |= __copy_to_user(v_regs, &current->thread.vr_state,
+		err |= __copy_to_user(v_regs, &tsk->thread.vr_state,
 				      33 * sizeof(vector128));
 		/* If VEC was enabled there are transactional VRs valid too,
 		 * else they're a copy of the checkpointed VRs.
 		 */
 		if (msr & MSR_VEC)
 			err |= __copy_to_user(tm_v_regs,
-					      &current->thread.transact_vr,
+					      &tsk->thread.transact_vr,
 					      33 * sizeof(vector128));
 		else
 			err |= __copy_to_user(tm_v_regs,
-					      &current->thread.vr_state,
+					      &tsk->thread.vr_state,
 					      33 * sizeof(vector128));
 
 		/* set MSR_VEC in the MSR value in the frame to indicate
@@ -247,13 +253,13 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * use altivec.
 	 */
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.vrsave = mfspr(SPRN_VRSAVE);
-	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
+		tsk->thread.vrsave = mfspr(SPRN_VRSAVE);
+	err |= __put_user(tsk->thread.vrsave, (u32 __user *)&v_regs[33]);
 	if (msr & MSR_VEC)
-		err |= __put_user(current->thread.transact_vrsave,
+		err |= __put_user(tsk->thread.transact_vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	else
-		err |= __put_user(current->thread.vrsave,
+		err |= __put_user(tsk->thread.vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 
 #else /* CONFIG_ALTIVEC */
@@ -262,11 +268,11 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 #endif /* CONFIG_ALTIVEC */
 
 	/* copy fpr regs and fpscr */
-	err |= copy_fpr_to_user(&sc->fp_regs, current);
+	err |= copy_fpr_to_user(&sc->fp_regs, tsk);
 	if (msr & MSR_FP)
-		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, current);
+		err |= copy_transact_fpr_to_user(&tm_sc->fp_regs, tsk);
 	else
-		err |= copy_fpr_to_user(&tm_sc->fp_regs, current);
+		err |= copy_fpr_to_user(&tm_sc->fp_regs, tsl);
 
 #ifdef CONFIG_VSX
 	/*
@@ -274,17 +280,17 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * then out to userspace.  Update v_regs to point after the
 	 * VMX data.
 	 */
-	if (current->thread.used_vsr) {
-		flush_vsx_to_thread(current);
+	if (tsk->thread.used_vsr) {
+		flush_vsx_to_thread(tsk);
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
 
-		err |= copy_vsx_to_user(v_regs, current);
+		err |= copy_vsx_to_user(v_regs, tsk);
 
 		if (msr & MSR_VSX)
-			err |= copy_transact_vsx_to_user(tm_v_regs, current);
+			err |= copy_transact_vsx_to_user(tm_v_regs, tsk);
 		else
-			err |= copy_vsx_to_user(tm_v_regs, current);
+			err |= copy_vsx_to_user(tm_v_regs, tsk);
 
 		/* set MSR_VSX in the MSR value in the frame to
 		 * indicate that sc->vs_reg) contains valid data.
@@ -298,7 +304,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&tm_sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __copy_to_user(&sc->gp_regs,
-			      &current->thread.ckpt_regs, GP_REGS_SIZE);
+			      &tsk->thread.ckpt_regs, GP_REGS_SIZE);
 	err |= __put_user(msr, &tm_sc->gp_regs[PT_MSR]);
 	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
 	err |= __put_user(signr, &sc->signal);
@@ -314,7 +320,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
  * Restore the sigcontext from the signal frame.
  */
 
-static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
+static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
 			      struct sigcontext __user *sc)
 {
 #ifdef CONFIG_ALTIVEC
@@ -323,10 +329,13 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	unsigned long err = 0;
 	unsigned long save_r13 = 0;
 	unsigned long msr;
+	struct pt_regs *regs = tsk->thread.regs;
 #ifdef CONFIG_VSX
 	int i;
 #endif
 
+	BUG_ON(tsk != current);
+
 	/* If this is not a signal return, we preserve the TLS in r13 */
 	if (!sig)
 		save_r13 = regs->gpr[13];
@@ -356,7 +365,7 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 
 	/*
 	 * Force reload of FP/VEC.
-	 * This has to be done before copying stuff into current->thread.fpr/vr
+	 * This has to be done before copying stuff into tsk->thread.fpr/vr
 	 * for the reasons explained in the previous comment.
 	 */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC | MSR_VSX);
@@ -369,20 +378,20 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != NULL && (msr & MSR_VEC) != 0)
-		err |= __copy_from_user(&current->thread.vr_state, v_regs,
+		err |= __copy_from_user(&tsk->thread.vr_state, v_regs,
 					33 * sizeof(vector128));
-	else if (current->thread.used_vr)
-		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
+	else if (tsk->thread.used_vr)
+		memset(&tsk->thread.vr_state, 0, 33 * sizeof(vector128));
 	/* Always get VRSAVE back */
 	if (v_regs != NULL)
-		err |= __get_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
+		err |= __get_user(tsk->thread.vrsave, (u32 __user *)&v_regs[33]);
 	else
-		current->thread.vrsave = 0;
+		tsk->thread.vrsave = 0;
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.vrsave);
+		mtspr(SPRN_VRSAVE, tsk->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
-	err |= copy_fpr_from_user(current, &sc->fp_regs);
+	err |= copy_fpr_from_user(tsk, &sc->fp_regs);
 #ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
@@ -391,10 +400,10 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	 */
 	v_regs += ELF_NVRREG;
 	if ((msr & MSR_VSX) != 0)
-		err |= copy_vsx_from_user(current, v_regs);
+		err |= copy_vsx_from_user(tsk, v_regs);
 	else
 		for (i = 0; i < 32 ; i++)
-			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+			tsk->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 #endif
 	return err;
 }
@@ -404,7 +413,7 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
  * Restore the two sigcontexts from the frame of a transactional processes.
  */
 
-static long restore_tm_sigcontexts(struct pt_regs *regs,
+static long restore_tm_sigcontexts(struct task_struct *tsk,
 				   struct sigcontext __user *sc,
 				   struct sigcontext __user *tm_sc)
 {
@@ -413,12 +422,16 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 #endif
 	unsigned long err = 0;
 	unsigned long msr;
+	struct pt_regs *regs = tsk->thread.regs;
 #ifdef CONFIG_VSX
 	int i;
 #endif
+
+	BUG_ON(tsk != current);
+
 	/* copy the GPRs */
 	err |= __copy_from_user(regs->gpr, tm_sc->gp_regs, sizeof(regs->gpr));
-	err |= __copy_from_user(&current->thread.ckpt_regs, sc->gp_regs,
+	err |= __copy_from_user(&tsk->thread.ckpt_regs, sc->gp_regs,
 				sizeof(regs->gpr));
 
 	/*
@@ -430,7 +443,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	 * we don't need to re-copy them here.
 	 */
 	err |= __get_user(regs->nip, &tm_sc->gp_regs[PT_NIP]);
-	err |= __get_user(current->thread.tm_tfhar, &sc->gp_regs[PT_NIP]);
+	err |= __get_user(tsk->thread.tm_tfhar, &sc->gp_regs[PT_NIP]);
 
 	/* get MSR separately, transfer the LE bit if doing signal return */
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
@@ -449,13 +462,13 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	err |= __get_user(regs->link, &tm_sc->gp_regs[PT_LNK]);
 	err |= __get_user(regs->xer, &tm_sc->gp_regs[PT_XER]);
 	err |= __get_user(regs->ccr, &tm_sc->gp_regs[PT_CCR]);
-	err |= __get_user(current->thread.ckpt_regs.ctr,
+	err |= __get_user(tsk->thread.ckpt_regs.ctr,
 			  &sc->gp_regs[PT_CTR]);
-	err |= __get_user(current->thread.ckpt_regs.link,
+	err |= __get_user(tsk->thread.ckpt_regs.link,
 			  &sc->gp_regs[PT_LNK]);
-	err |= __get_user(current->thread.ckpt_regs.xer,
+	err |= __get_user(tsk->thread.ckpt_regs.xer,
 			  &sc->gp_regs[PT_XER]);
-	err |= __get_user(current->thread.ckpt_regs.ccr,
+	err |= __get_user(tsk->thread.ckpt_regs.ccr,
 			  &sc->gp_regs[PT_CCR]);
 
 	/* These regs are not checkpointed; they can go in 'regs'. */
@@ -466,7 +479,7 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 
 	/*
 	 * Force reload of FP/VEC.
-	 * This has to be done before copying stuff into current->thread.fpr/vr
+	 * This has to be done before copying stuff into tsk->thread.fpr/vr
 	 * for the reasons explained in the previous comment.
 	 */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC | MSR_VSX);
@@ -483,32 +496,32 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != NULL && tm_v_regs != NULL && (msr & MSR_VEC) != 0) {
-		err |= __copy_from_user(&current->thread.vr_state, v_regs,
+		err |= __copy_from_user(&tsk->thread.vr_state, v_regs,
 					33 * sizeof(vector128));
-		err |= __copy_from_user(&current->thread.transact_vr, tm_v_regs,
+		err |= __copy_from_user(&tsk->thread.transact_vr, tm_v_regs,
 					33 * sizeof(vector128));
 	}
-	else if (current->thread.used_vr) {
-		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
-		memset(&current->thread.transact_vr, 0, 33 * sizeof(vector128));
+	else if (tsk->thread.used_vr) {
+		memset(&tsk->thread.vr_state, 0, 33 * sizeof(vector128));
+		memset(&tsk->thread.transact_vr, 0, 33 * sizeof(vector128));
 	}
 	/* Always get VRSAVE back */
 	if (v_regs != NULL && tm_v_regs != NULL) {
-		err |= __get_user(current->thread.vrsave,
+		err |= __get_user(tsk->thread.vrsave,
 				  (u32 __user *)&v_regs[33]);
-		err |= __get_user(current->thread.transact_vrsave,
+		err |= __get_user(tsk->thread.transact_vrsave,
 				  (u32 __user *)&tm_v_regs[33]);
 	}
 	else {
-		current->thread.vrsave = 0;
-		current->thread.transact_vrsave = 0;
+		tsk->thread.vrsave = 0;
+		tsk->thread.transact_vrsave = 0;
 	}
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		mtspr(SPRN_VRSAVE, current->thread.vrsave);
+		mtspr(SPRN_VRSAVE, tsk->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
-	err |= copy_fpr_from_user(current, &sc->fp_regs);
-	err |= copy_transact_fpr_from_user(current, &tm_sc->fp_regs);
+	err |= copy_fpr_from_user(tsk, &sc->fp_regs);
+	err |= copy_transact_fpr_from_user(tsk, &tm_sc->fp_regs);
 #ifdef CONFIG_VSX
 	/*
 	 * Get additional VSX data. Update v_regs to point after the
@@ -518,29 +531,29 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	if (v_regs && ((msr & MSR_VSX) != 0)) {
 		v_regs += ELF_NVRREG;
 		tm_v_regs += ELF_NVRREG;
-		err |= copy_vsx_from_user(current, v_regs);
-		err |= copy_transact_vsx_from_user(current, tm_v_regs);
+		err |= copy_vsx_from_user(tsk, v_regs);
+		err |= copy_transact_vsx_from_user(tsk, tm_v_regs);
 	} else {
 		for (i = 0; i < 32 ; i++) {
-			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
-			current->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
+			tsk->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
+			tsk->thread.transact_fp.fpr[i][TS_VSRLOWOFFSET] = 0;
 		}
 	}
 #endif
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
-	current->thread.tm_texasr |= TEXASR_FS;
+	tsk->thread.tm_texasr |= TEXASR_FS;
 	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&current->thread, msr);
+	tm_recheckpoint(&tsk->thread, msr);
 
 	/* This loads the speculative FP/VEC state, if used */
 	if (msr & MSR_FP) {
-		do_load_up_transact_fpu(&current->thread);
-		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
+		do_load_up_transact_fpu(&tsk->thread);
+		regs->msr |= (MSR_FP | tsk->thread.fpexc_mode);
 	}
 #ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
-		do_load_up_transact_altivec(&current->thread);
+		do_load_up_transact_altivec(&tsk->thread);
 		regs->msr |= MSR_VEC;
 	}
 #endif
@@ -594,6 +607,8 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
 	unsigned long new_msr = 0;
 	int ctx_has_vsx_region = 0;
 
+	BUG_ON(regs != current->thread.regs);
+
 	if (new_ctx &&
 	    get_user(new_msr, &new_ctx->uc_mcontext.gp_regs[PT_MSR]))
 		return -EFAULT;
@@ -616,7 +631,7 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
 
 	if (old_ctx != NULL) {
 		if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
-		    || setup_sigcontext(&old_ctx->uc_mcontext, regs, 0, NULL, 0,
+		    || setup_sigcontext(&old_ctx->uc_mcontext, current, 0, NULL, 0,
 					ctx_has_vsx_region)
 		    || __copy_to_user(&old_ctx->uc_sigmask,
 				      &current->blocked, sizeof(sigset_t)))
@@ -644,7 +659,7 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
 	if (__copy_from_user(&set, &new_ctx->uc_sigmask, sizeof(set)))
 		do_exit(SIGSEGV);
 	set_current_blocked(&set);
-	if (restore_sigcontext(regs, NULL, 0, &new_ctx->uc_mcontext))
+	if (restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext))
 		do_exit(SIGSEGV);
 
 	/* This returns like rt_sigreturn */
@@ -667,6 +682,8 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 	unsigned long msr;
 #endif
 
+	BUG_ON(current->thread.regs != regs);
+
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
@@ -684,14 +701,14 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 		struct ucontext __user *uc_transact;
 		if (__get_user(uc_transact, &uc->uc_link))
 			goto badframe;
-		if (restore_tm_sigcontexts(regs, &uc->uc_mcontext,
+		if (restore_tm_sigcontexts(current, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	}
 	else
 	/* Fall through, for non-TM restore */
 #endif
-	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
+	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
 		goto badframe;
 
 	if (restore_altstack(&uc->uc_stack))
@@ -710,13 +727,17 @@ badframe:
 	return 0;
 }
 
-int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
+int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
+		struct task_struct *tsk)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long newsp = 0;
 	long err = 0;
+	struct pt_regs *regs = tsk->thread.regs;
+
+	BUG_ON(tsk != current);
 
-	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 0);
+	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 
@@ -737,14 +758,13 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 		err |= __put_user(&frame->uc_transact, &frame->uc.uc_link);
 		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
 					    &frame->uc_transact.uc_mcontext,
-					    regs, ksig->sig,
-					    NULL,
+					    tsk, ksig->sig, NULL,
 					    (unsigned long)ksig->ka.sa.sa_handler);
 	} else
 #endif
 	{
 		err |= __put_user(0, &frame->uc.uc_link);
-		err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, ksig->sig,
+		err |= setup_sigcontext(&frame->uc.uc_mcontext, tsk, ksig->sig,
 					NULL, (unsigned long)ksig->ka.sa.sa_handler,
 					1);
 	}
@@ -753,11 +773,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 		goto badframe;
 
 	/* Make sure signal handler doesn't get spurious FP exceptions */
-	current->thread.fp_state.fpscr = 0;
+	tsk->thread.fp_state.fpscr = 0;
 
 	/* Set up to return from userspace. */
-	if (vdso64_rt_sigtramp && current->mm->context.vdso_base) {
-		regs->link = current->mm->context.vdso_base + vdso64_rt_sigtramp;
+	if (vdso64_rt_sigtramp && tsk->mm->context.vdso_base) {
+		regs->link = tsk->mm->context.vdso_base + vdso64_rt_sigtramp;
 	} else {
 		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
 		if (err)
@@ -807,7 +827,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 badframe:
 	if (show_unhandled_signals)
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   current->comm, current->pid, "setup_rt_frame",
+				   tsk->comm, tsk->pid, "setup_rt_frame",
 				   (long)frame, regs->nip, regs->link);
 
 	return 1;
-- 
2.9.3
