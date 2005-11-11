Return-Path: <SRS0+3406f1c45d8385a99246+810+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55A6968704
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 08:36:39 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Fri, 11 Nov 2005 21:37:26 +0000
Message-Id: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We currently play tricks with assembly wrappers for various syscalls, in
case a signal is delivered. We need to make sure the registers are all
saved for the benefit of ptrace, and we need to return to userspace
without clobbering r4 and r5, as the normal syscall exit path would.

As usual, these tricks differ subtly between ppc32 and ppc64 too.

This is an attempt to get rid of it all, motivated mostly because I want
to add two _new_ functions which would need such treatment (pselect,
ppoll).

We define a new thread flag TIF_RESTOREALL which is set by the syscall
which needs this treatment, and make the syscall return path honour it.
This seems to work as far as I've tested it (i.e. the system boots) for
ppc64, but I haven't even attempted to compile the 32-bit version yet.

I've also removed the explicit calls to ptrace_notify() which were in
#ifdef CONFIG_PPC64 -- if we're now stopping on the way back to
userspace, we don't need to do that any more. I'm going to need to go
through some of the sigsuspend/signal cases with a fine-tooth comb and
make sure we're still getting a ptrace stop (and only _one_ ptrace stop)
in all cases where that's appropriate.

I also tried to clean up entry_64.S so it only checks the thread flags
in the fast path _once_. This means that for ptrace we'll disable
interrupts, then check the flags and enable interrupts again before
calling do_syscall_trace_leave(). That makes the slow path match the
PPC32 code and makes the fast path smaller.

Comments?

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 2e99ae4..59dc2e7 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -222,25 +222,25 @@ ret_from_syscall:
 	bl	do_show_syscall_exit
 #endif
 	mr	r6,r3
-	li	r11,-_LAST_ERRNO
-	cmplw	0,r3,r11
+	lwz	r11,_CCR(r1)			/* Load CR */
+	li	r10,-_LAST_ERRNO
+	cmplw	0,r3,r10
 	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	blt+	30f
-	lbz	r11,TI_SC_NOERR(r12)
-	cmpwi	r11,0
+	lbz	r10,TI_SC_NOERR(r12)
+	cmpwi	r10,0
 	bne	30f
 	neg	r3,r3
-	lwz	r10,_CCR(r1)	/* Set SO bit in CR */
-	oris	r10,r10,0x1000
-	stw	r10,_CCR(r1)
+	oris	r11,r11,0x1000	/* Set SO bit in CR */
 
 	/* disable interrupts so current_thread_info()->flags can't change */
 30:	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
 	bne-	syscall_exit_work
+	stw	r11,_CCR(r1)
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The single
@@ -292,9 +292,13 @@ syscall_dotrace:
 	b	syscall_dotrace_cont
 
 syscall_exit_work:
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	3f
+
 	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
+	stw	r11,_CCR(r1)
+3:	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
 	beq	5f
 	ori	r10,r10,MSR_EE
 	SYNC
@@ -407,22 +411,6 @@ show_syscalls_task:
  * to save all the nonvolatile registers (r13 - r31) before calling
  * the C code.
  */
-	.globl	ppc_sigsuspend
-ppc_sigsuspend:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_sigsuspend
-
-	.globl	ppc_rt_sigsuspend
-ppc_rt_sigsuspend:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30
-	stw	r0,_TRAP(r1)
-	b	sys_rt_sigsuspend
-
 	.globl	ppc_fork
 ppc_fork:
 	SAVE_NVGPRS(r1)
@@ -447,14 +435,6 @@ ppc_clone:
 	stw	r0,_TRAP(r1)		/* register set saved */
 	b	sys_clone
 
-	.globl	ppc_swapcontext
-ppc_swapcontext:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_swapcontext
-
 /*
  * Top-level page fault handling.
  * This is in assembler because if do_page_fault tells us that
@@ -626,16 +606,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	.long	ret_from_except
 #endif
 
-	.globl	sigreturn_exit
-sigreturn_exit:
-	subi	r1,r3,STACK_FRAME_OVERHEAD
-	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
-	beq+	ret_from_except_full
-	bl	do_syscall_trace_leave
-	/* fall through */
-
 	.globl	ret_from_except_full
 ret_from_except_full:
 	REST_NVGPRS(r1)
@@ -658,7 +628,7 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
 	bne	do_work
 
 restore_user:
@@ -876,6 +846,8 @@ load_dbcr0:
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
 
 do_work:			/* r10 contains MSR_KERNEL here */
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	do_clear_restoreall	
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	beq	do_user_signal
 
@@ -890,6 +862,8 @@ recheck:
 	MTMSRD(r10)		/* disable interrupts */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	do_clear_restoreall
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
 	andi.	r0,r9,_TIF_SIGPENDING
@@ -911,6 +885,9 @@ do_user_signal:			/* r10 contains MSR_KE
 	REST_NVGPRS(r1)
 	b	recheck
 
+do_clear_restoreall:
+	bl	do_clear_tif_restoreall
+	b	recheck
 /*
  * We come here when we are at the end of handling an exception
  * that occurred at a place where taking an exception will lose
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2d22bf0..756663e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -157,12 +157,6 @@ syscall_exit:
 	bge-	syscall_error
 syscall_error_cont:
 
-	/* check for syscall tracing or audit */
-	ld	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
-	bne-	syscall_exit_trace
-syscall_exit_trace_cont:
-
 	/* disable interrupts so current_thread_info()->flags can't change,
 	   and so that we don't get interrupted after loading SRR0/1. */
 	ld	r8,_MSR(r1)
@@ -173,8 +167,9 @@ syscall_exit_trace_cont:
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
 	ld	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
 	bne-	syscall_exit_work
+	std	r5,_CCR(r1)
 	ld	r7,_NIP(r1)
 	stdcx.	r0,0,r1			/* to clear the reservation */
 	andi.	r6,r8,MSR_PR
@@ -205,7 +200,6 @@ syscall_error:
 	bne-	syscall_error_cont
 	neg	r3,r3
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
-	std	r5,_CCR(r1)
 	b	syscall_error_cont
         
 /* Traced system call support */
@@ -225,8 +219,22 @@ syscall_dotrace:
 	ld	r10,TI_FLAGS(r10)
 	b	syscall_dotrace_cont
 
-syscall_exit_trace:
+syscall_exit_work:
+	/* Avoid saving r3 and ccr if TIF_RESTOREALL flag is set */
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	1f
+
 	std	r3,GPR3(r1)
+	std	r5,_CCR(r1)
+
+	/* If tracing, re-enable interrupts and do it */
+1:	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	beq	.ret_from_except_lite
+
+	mfmsr	r10
+	ori	r10,r10,MSR_EE
+	mtmsrd	r10,1
+	
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_leave
@@ -234,12 +242,14 @@ syscall_exit_trace:
 	ld	r3,GPR3(r1)
 	ld	r5,_CCR(r1)
 	clrrdi	r12,r1,THREAD_SHIFT
-	b	syscall_exit_trace_cont
 
-/* Stuff to do on exit from a system call. */
-syscall_exit_work:
-	std	r3,GPR3(r1)
-	std	r5,_CCR(r1)
+	/* Disable interrupts again and handle other work if any */
+	mfmsr	r10
+	rldicl	r10,r10,48,1
+	rotldi	r10,r10,16
+	mtmsrd	r10,1
+	
+	ld	r9,TI_FLAGS(r12)
 	b	.ret_from_except_lite
 
 /* Save non-volatile GPRs, if not already saved. */
@@ -260,35 +270,6 @@ _GLOBAL(save_nvgprs)
  * the C code.  Similarly, fork, vfork and clone need the full
  * register state on the stack so that it can be copied to the child.
  */
-_GLOBAL(ppc32_sigsuspend)
-	bl	.save_nvgprs
-	bl	.compat_sys_sigsuspend
-	b	70f
-
-_GLOBAL(ppc64_rt_sigsuspend)
-	bl	.save_nvgprs
-	bl	.sys_rt_sigsuspend
-	b	70f
-
-_GLOBAL(ppc32_rt_sigsuspend)
-	bl	.save_nvgprs
-	bl	.compat_sys_rt_sigsuspend
-70:	cmpdi	0,r3,0
-	/* If it returned an error, we need to return via syscall_exit to set
-	   the SO bit in cr0 and potentially stop for ptrace. */
-	bne	syscall_exit
-	/* If sigsuspend() returns zero, we are going into a signal handler. We
-	   may need to call audit_syscall_exit() to mark the exit from sigsuspend() */
-#ifdef CONFIG_AUDITSYSCALL
-	ld	r3,PACACURRENT(r13)
-	ld	r4,AUDITCONTEXT(r3)
-	cmpdi	0,r4,0
-	beq	.ret_from_except	/* No audit_context: Leave immediately. */
-	li	r4, 2			/* AUDITSC_FAILURE */
-	li	r5,-4			/* It's always -EINTR */
-	bl	.audit_syscall_exit
-#endif
-	b	.ret_from_except
 
 _GLOBAL(ppc_fork)
 	bl	.save_nvgprs
@@ -305,37 +286,6 @@ _GLOBAL(ppc_clone)
 	bl	.sys_clone
 	b	syscall_exit
 
-_GLOBAL(ppc32_swapcontext)
-	bl	.save_nvgprs
-	bl	.compat_sys_swapcontext
-	b	80f
-	
-_GLOBAL(ppc64_swapcontext)
-	bl	.save_nvgprs
-	bl	.sys_swapcontext
-	b	80f
-
-_GLOBAL(ppc32_sigreturn)
-	bl	.compat_sys_sigreturn
-	b	80f
-
-_GLOBAL(ppc32_rt_sigreturn)
-	bl	.compat_sys_rt_sigreturn
-	b	80f
-
-_GLOBAL(ppc64_rt_sigreturn)
-	bl	.sys_rt_sigreturn
-
-80:	cmpdi	0,r3,0
-	blt	syscall_exit
-	clrrdi	r4,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r4)
-	andi.	r4,r4,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
-	beq+	81f
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_syscall_trace_leave
-81:	b	.ret_from_except
-
 _GLOBAL(ret_from_fork)
 	bl	.schedule_tail
 	REST_NVGPRS(r1)
@@ -602,7 +552,12 @@ user_work:
 	bl	.schedule
 	b	.ret_from_except_lite
 
-1:	bl	.save_nvgprs
+1:	andi.	r0,r4,_TIF_RESTOREALL
+	beq	2f
+	bl	.do_clear_tif_restoreall
+	b	.ret_from_except_lite
+
+2:	bl	.save_nvgprs
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 081d931..d18aebd 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -75,7 +75,6 @@
  * registers from *regs.  This is what we need
  * to do when a signal has been delivered.
  */
-#define sigreturn_exit(regs)	return 0
 
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t32), sizeof(struct pt_regs32))
 #undef __SIGNAL_FRAMESIZE
@@ -178,8 +177,6 @@ static inline int restore_general_regs(s
 
 #else /* CONFIG_PPC64 */
 
-extern void sigreturn_exit(struct pt_regs *);
-
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 
 static inline int put_sigset_t(sigset_t __user *uset, sigset_t *set)
@@ -255,8 +252,10 @@ long sys_sigsuspend(old_sigset_t mask, i
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&saveset, regs))
-			sigreturn_exit(regs);
+		if (do_signal(&saveset, regs)) {
+			set_thread_flag(TIF_RESTOREALL);
+			return 0;
+		}
 	}
 }
 
@@ -291,8 +290,10 @@ long sys_rt_sigsuspend(
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&saveset, regs))
-			sigreturn_exit(regs);
+		if (do_signal(&saveset, regs)) {
+			set_thread_flag(TIF_RESTOREALL);
+			return 0;
+		}
 	}
 }
 
@@ -829,12 +830,6 @@ static int handle_rt_signal(unsigned lon
 	regs->gpr[6] = (unsigned long) rt_sf;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	regs->trap = 0;
-#ifdef CONFIG_PPC64
-	regs->result = 0;
-
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
-#endif
 	return 1;
 
 badframe:
@@ -912,8 +907,8 @@ long sys_swapcontext(struct ucontext __u
 	 */
 	if (do_setcontext(new_ctx, regs, 0))
 		do_exit(SIGSEGV);
-	sigreturn_exit(regs);
-	/* doesn't actually return back to here */
+
+	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
 
@@ -946,12 +941,11 @@ long sys_rt_sigreturn(int r3, int r4, in
 	 * nobody does any...
 	 */
 	compat_sys_sigaltstack((u32)(u64)&rt_sf->uc.uc_stack, 0, 0, 0, 0, 0, regs);
-	return (int)regs->result;
 #else
 	do_sigaltstack(&rt_sf->uc.uc_stack, NULL, regs->gpr[1]);
-	sigreturn_exit(regs);		/* doesn't return here */
-	return 0;
 #endif
+	set_thread_flag(TIF_RESTOREALL);
+	return 0;
 
  bad:
 	force_sig(SIGSEGV, current);
@@ -1042,9 +1036,7 @@ int sys_debug_setcontext(struct ucontext
 	 */
 	do_sigaltstack(&ctx->uc_stack, NULL, regs->gpr[1]);
 
-	sigreturn_exit(regs);
-	/* doesn't actually return back to here */
-
+	set_thread_flag(TIF_RESTOREALL);
  out:
 	return 0;
 }
@@ -1109,12 +1101,6 @@ static int handle_signal(unsigned long s
 	regs->gpr[4] = (unsigned long) sc;
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	regs->trap = 0;
-#ifdef CONFIG_PPC64
-	regs->result = 0;
-
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
-#endif
 
 	return 1;
 
@@ -1162,12 +1148,8 @@ long sys_sigreturn(int r3, int r4, int r
 	    || restore_user_regs(regs, sr, 1))
 		goto badframe;
 
-#ifdef CONFIG_PPC64
-	return (int)regs->result;
-#else
-	sigreturn_exit(regs);		/* doesn't return */
+	set_thread_flag(TIF_RESTOREALL);
 	return 0;
-#endif
 
 badframe:
 	force_sig(SIGSEGV, current);
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 58194e1..7520ad4 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -96,8 +96,10 @@ long sys_rt_sigsuspend(sigset_t __user *
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&saveset, regs))
+		if (do_signal(&saveset, regs)) {
+			set_thread_flag(TIF_RESTOREALL);
 			return 0;
+		}
 	}
 }
 
@@ -343,6 +345,7 @@ int sys_swapcontext(struct ucontext __us
 		do_exit(SIGSEGV);
 
 	/* This returns like rt_sigreturn */
+	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
 
@@ -375,7 +378,8 @@ int sys_rt_sigreturn(unsigned long r3, u
 	 */
 	do_sigaltstack(&uc->uc_stack, NULL, regs->gpr[1]);
 
-	return regs->result;
+	set_thread_flag(TIF_RESTOREALL);
+	return 0;
 
 badframe:
 #if DEBUG_SIG
@@ -454,9 +458,6 @@ static int setup_rt_frame(int signr, str
 	if (err)
 		goto badframe;
 
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
-
 	return 1;
 
 badframe:
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index f72ced1..f8ec816 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -356,3 +356,8 @@ void do_show_syscall_exit(unsigned long 
 {
 	printk(" -> %lx, current=%p cpu=%d\n", r3, current, smp_processor_id());
 }
+
+void do_clear_tif_restoreall(void)
+{
+	clear_thread_flag(TIF_RESTOREALL);
+}
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 65eaea9..4bb3650 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -113,7 +113,7 @@ SYSCALL(sgetmask)
 COMPAT_SYS(ssetmask)
 SYSCALL(setreuid)
 SYSCALL(setregid)
-SYSX(sys_ni_syscall,ppc32_sigsuspend,ppc_sigsuspend)
+SYS32ONLY(sigsuspend)
 COMPAT_SYS(sigpending)
 COMPAT_SYS(sethostname)
 COMPAT_SYS(setrlimit)
@@ -160,7 +160,7 @@ SYSCALL(swapoff)
 COMPAT_SYS(sysinfo)
 COMPAT_SYS(ipc)
 SYSCALL(fsync)
-SYSX(sys_ni_syscall,ppc32_sigreturn,sys_sigreturn)
+SYS32ONLY(sigreturn)
 PPC_SYS(clone)
 COMPAT_SYS(setdomainname)
 PPC_SYS(newuname)
@@ -213,13 +213,13 @@ COMPAT_SYS(nfsservctl)
 SYSCALL(setresgid)
 SYSCALL(getresgid)
 COMPAT_SYS(prctl)
-SYSX(ppc64_rt_sigreturn,ppc32_rt_sigreturn,sys_rt_sigreturn)
+COMPAT_SYS(rt_sigreturn)
 COMPAT_SYS(rt_sigaction)
 COMPAT_SYS(rt_sigprocmask)
 COMPAT_SYS(rt_sigpending)
 COMPAT_SYS(rt_sigtimedwait)
 COMPAT_SYS(rt_sigqueueinfo)
-SYSX(ppc64_rt_sigsuspend,ppc32_rt_sigsuspend,ppc_rt_sigsuspend)
+COMPAT_SYS(rt_sigsuspend)
 COMPAT_SYS(pread64)
 COMPAT_SYS(pwrite64)
 SYSCALL(chown)
@@ -290,7 +290,7 @@ COMPAT_SYS(clock_settime)
 COMPAT_SYS(clock_gettime)
 COMPAT_SYS(clock_getres)
 COMPAT_SYS(clock_nanosleep)
-SYSX(ppc64_swapcontext,ppc32_swapcontext,ppc_swapcontext)
+COMPAT_SYS(swapcontext)
 COMPAT_SYS(tgkill)
 COMPAT_SYS(utimes)
 COMPAT_SYS(statfs64)
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index e525f49..d10ec17 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -123,6 +123,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
+#define TIF_RESTOREALL		12	/* signal handler invoked */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -136,10 +137,11 @@ static inline struct thread_info *curren
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
-				 _TIF_NEED_RESCHED)
+				 _TIF_NEED_RESCHED | _TIF_RESTOREALL)
 
 #endif /* __KERNEL__ */
 


-- 
dwmw2
