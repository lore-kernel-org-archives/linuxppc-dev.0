Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17421.32092.442696.49291@cargo.ozlabs.ibm.com>
Date: Tue, 7 Mar 2006 23:32:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: signal/syscall/swapcontext fixes
Cc: dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the current set of changes I have for fixing various problems
and potential problems I found in the syscall entry/exit code.
Briefly, the changes are:

* The TIF_SAVE_NVGPRS mechanism was only being used by swapcontext, so
  I removed it and put swapcontext back the way it was in 2.6.15, with
  an assembler stub to save the non-volatile GPRs before calling the C
  code.  The save_general_regs functions now WARN_ON(!FULL_REGS(regs)).

* 32-bit wasn't testing the _TIF_NOERROR bit in the syscall fast exit
  path, so it was only doing anything with it once it saw some other
  bit being set.

* 32-bit wasn't doing the call to ptrace_notify in the syscall exit
  path when the _TIF_SINGLESTEP bit was set.

* _TIF_RESTOREALL was in both _TIF_USER_WORK_MASK and
  _TIF_PERSYSCALL_MASK, which is odd since _TIF_RESTOREALL is only set
  by system calls.  I took it out of _TIF_USER_WORK_MASK.

* On 64-bit, _TIF_RESTOREALL wasn't causing the non-volatile registers
  to be restored (unless perhaps a signal was delivered or the syscall
  was traced or single-stepped).  Thus the non-volatile registers
  weren't restored on exit from a signal handler.  We probably got
  away with it mostly because signal handlers written in C wouldn't
  alter the non-volatile registers.

* On 32-bit I simplified the code and made it more like 64-bit by
  making the syscall exit path jump to ret_from_except to handle
  preemption and signal delivery.

* 32-bit was calling do_signal unnecessarily when _TIF_RESTOREALL was
  set - but I think because of that 32-bit was actually restoring the
  non-volatile registers on exit from a signal handler.

* I changed the order of enabling interrupts and saving the
  non-volatile registers before calling do_syscall_trace_leave; now we
  enable interrupts first.

Any comments before I send this off to Linus to go in 2.6.16?

Paul.

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 840aad4..c9a660e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -92,7 +92,6 @@ int main(void)
 
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
-	DEFINE(TI_SIGFRAME, offsetof(struct thread_info, nvgprs_frame));
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 #ifdef CONFIG_PPC32
 	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index f20a672..4827ca1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -227,7 +227,7 @@ ret_from_syscall:
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_RESTORE_SIGMASK)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
 	blt+	syscall_exit_cont
@@ -287,8 +287,10 @@ syscall_dotrace:
 
 syscall_exit_work:
 	andi.	r0,r9,_TIF_RESTOREALL
-	bne-	2f
-	cmplw	0,r3,r8
+	beq+	0f
+	REST_NVGPRS(r1)
+	b	2f
+0:	cmplw	0,r3,r8
 	blt+	1f
 	andi.	r0,r9,_TIF_NOERROR
 	bne-	1f
@@ -302,9 +304,7 @@ syscall_exit_work:
 2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
 	beq	4f
 
-	/* Clear per-syscall TIF flags if any are set, but _leave_
-	_TIF_SAVE_NVGPRS set in r9 since we haven't dealt with that
-	yet.  */
+	/* Clear per-syscall TIF flags if any are set.  */
 
 	li	r11,_TIF_PERSYSCALL_MASK
 	addi	r12,r12,TI_FLAGS
@@ -318,8 +318,13 @@ syscall_exit_work:
 	subi	r12,r12,TI_FLAGS
 	
 4:	/* Anything which requires enabling interrupts? */
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SAVE_NVGPRS)
-	beq	7f
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	beq	ret_from_except
+
+	/* Re-enable interrupts */
+	ori	r10,r10,MSR_EE
+	SYNC
+	MTMSRD(r10)
 
 	/* Save NVGPRS if they're not saved already */
 	lwz	r4,_TRAP(r1)
@@ -328,71 +333,11 @@ syscall_exit_work:
 	SAVE_NVGPRS(r1)
 	li	r4,0xc00
 	stw	r4,_TRAP(r1)
-
-	/* Re-enable interrupts */
-5:	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)
-
-	andi.	r0,r9,_TIF_SAVE_NVGPRS
-	bne	save_user_nvgprs
-
-save_user_nvgprs_cont:
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
-	beq	7f
-
+5:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_syscall_trace_leave
-	REST_NVGPRS(r1)
-
-6:	lwz	r3,GPR3(r1)
-	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
-	SYNC
-	MTMSRD(r10)		/* disable interrupts again */
-	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
-7:
-	andi.	r0,r9,_TIF_NEED_RESCHED
-	bne	8f
-	lwz	r5,_MSR(r1)
-	andi.	r5,r5,MSR_PR
-	beq	ret_from_except
-	andi.	r0,r9,_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK
-	beq	ret_from_except
-	b	do_user_signal
-8:
-	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)		/* re-enable interrupts */
-	bl	schedule
-	b	6b
-
-save_user_nvgprs:
-	lwz	r8,TI_SIGFRAME(r12)
-
-.macro savewords start, end
-  1:	stw \start,4*(\start)(r8)
-	.section __ex_table,"a"
-	.align	2
-	.long	1b,save_user_nvgprs_fault
-	.previous
-	.if \end - \start
-	savewords "(\start+1)",\end
-	.endif
-.endm	
-	savewords 14,31
-	b	save_user_nvgprs_cont
-
-	
-save_user_nvgprs_fault:
-	li	r3,11		/* SIGSEGV */
-	lwz	r4,TI_TASK(r12)
-	bl	force_sigsegv
+	b	ret_from_except_full
 
-	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
-	b	save_user_nvgprs_cont
-	
 #ifdef SHOW_SYSCALLS
 do_show_syscall:
 #ifdef SHOW_SYSCALLS_TASK
@@ -490,6 +435,14 @@ ppc_clone:
 	stw	r0,_TRAP(r1)		/* register set saved */
 	b	sys_clone
 
+	.globl	ppc_swapcontext
+ppc_swapcontext:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_swapcontext
+
 /*
  * Top-level page fault handling.
  * This is in assembler because if do_page_fault tells us that
@@ -683,7 +636,7 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_RESTORE_SIGMASK)
+	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NEED_RESCHED)
 	bne	do_work
 
 restore_user:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 388f861..24be0cf 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -160,7 +160,7 @@ syscall_exit:
 	mtmsrd	r10,1
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR|_TIF_RESTORE_SIGMASK)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmpld	r3,r11
 	ld	r5,_CCR(r1)
@@ -216,8 +216,10 @@ syscall_exit_work:
 	 If TIF_NOERROR is set, just save r3 as it is. */
 
 	andi.	r0,r9,_TIF_RESTOREALL
-	bne-	2f
-	cmpld	r3,r11		/* r10 is -LAST_ERRNO */
+	beq+	0f
+	REST_NVGPRS(r1)
+	b	2f
+0:	cmpld	r3,r11		/* r10 is -LAST_ERRNO */
 	blt+	1f
 	andi.	r0,r9,_TIF_NOERROR
 	bne-	1f
@@ -229,9 +231,7 @@ syscall_exit_work:
 2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
 	beq	4f
 
-	/* Clear per-syscall TIF flags if any are set, but _leave_
-	_TIF_SAVE_NVGPRS set in r9 since we haven't dealt with that
-	yet.  */
+	/* Clear per-syscall TIF flags if any are set.  */
 
 	li	r11,_TIF_PERSYSCALL_MASK
 	addi	r12,r12,TI_FLAGS
@@ -240,10 +240,9 @@ syscall_exit_work:
 	stdcx.	r10,0,r12
 	bne-	3b
 	subi	r12,r12,TI_FLAGS
-	
-4:	bl	.save_nvgprs
-	/* Anything else left to do? */
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SAVE_NVGPRS)
+
+4:	/* Anything else left to do? */
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq	.ret_from_except_lite
 
 	/* Re-enable interrupts */
@@ -251,26 +250,10 @@ syscall_exit_work:
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
 
-	andi.	r0,r9,_TIF_SAVE_NVGPRS
-	bne	save_user_nvgprs
-
-	/* If tracing, re-enable interrupts and do it */
-save_user_nvgprs_cont:	
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
-	beq	5f
-	
+	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_leave
-	REST_NVGPRS(r1)
-	clrrdi	r12,r1,THREAD_SHIFT
-
-	/* Disable interrupts again and handle other work if any */
-5:	mfmsr	r10
-	rldicl	r10,r10,48,1
-	rotldi	r10,r10,16
-	mtmsrd	r10,1
-
-	b	.ret_from_except_lite
+	b	.ret_from_except
 
 /* Save non-volatile GPRs, if not already saved. */
 _GLOBAL(save_nvgprs)
@@ -282,51 +265,6 @@ _GLOBAL(save_nvgprs)
 	std	r0,_TRAP(r1)
 	blr
 
-
-save_user_nvgprs:
-	ld	r10,TI_SIGFRAME(r12)
-	andi.	r0,r9,_TIF_32BIT
-	beq-	save_user_nvgprs_64
-
-	/* 32-bit save to userspace */
-
-.macro savewords start, end
-  1:	stw \start,4*(\start)(r10)
-	.section __ex_table,"a"
-	.align	3
-	.llong	1b,save_user_nvgprs_fault
-	.previous
-	.if \end - \start
-	savewords "(\start+1)",\end
-	.endif
-.endm	
-	savewords 14,31
-	b	save_user_nvgprs_cont
-
-save_user_nvgprs_64:
-	/* 64-bit save to userspace */
-
-.macro savelongs start, end
-  1:	std \start,8*(\start)(r10)
-	.section __ex_table,"a"
-	.align	3
-	.llong	1b,save_user_nvgprs_fault
-	.previous
-	.if \end - \start
-	savelongs "(\start+1)",\end
-	.endif
-.endm	
-	savelongs 14,31
-	b	save_user_nvgprs_cont
-
-save_user_nvgprs_fault:
-	li	r3,11		/* SIGSEGV */
-	ld	r4,TI_TASK(r12)
-	bl	.force_sigsegv
-
-	clrrdi	r12,r1,THREAD_SHIFT
-	ld	r9,TI_FLAGS(r12)
-	b	save_user_nvgprs_cont
 	
 /*
  * The sigsuspend and rt_sigsuspend system calls can call do_signal
@@ -352,6 +290,16 @@ _GLOBAL(ppc_clone)
 	bl	.sys_clone
 	b	syscall_exit
 
+_GLOBAL(ppc32_swapcontext)
+	bl	.save_nvgprs
+	bl	.compat_sys_swapcontext
+	b	syscall_exit
+
+_GLOBAL(ppc64_swapcontext)
+	bl	.save_nvgprs
+	bl	.sys_swapcontext
+	b	syscall_exit
+
 _GLOBAL(ret_from_fork)
 	bl	.schedule_tail
 	REST_NVGPRS(r1)
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 400793c..bcb8357 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -561,10 +561,7 @@ void do_syscall_trace_leave(struct pt_re
 				   regs->result);
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)
-#ifdef CONFIG_PPC64
-	     || test_thread_flag(TIF_SINGLESTEP)
-#endif
-	     )
+	     || test_thread_flag(TIF_SINGLESTEP))
 	    && (current->ptrace & PT_PTRACED))
 		do_syscall_trace();
 }
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index bd837b5..d7a4e81 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -151,10 +151,7 @@ static inline int save_general_regs(stru
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
 
-	if (!FULL_REGS(regs)) {
-		set_thread_flag(TIF_SAVE_NVGPRS);
-		current_thread_info()->nvgprs_frame = frame->mc_gregs;
-	}
+	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
 		if (i == 14 && !FULL_REGS(regs))
@@ -215,15 +212,7 @@ static inline int get_old_sigaction(stru
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
 {
-	if (!FULL_REGS(regs)) {
-		/* Zero out the unsaved GPRs to avoid information
-		   leak, and set TIF_SAVE_NVGPRS to ensure that the
-		   registers do actually get saved later. */
-		memset(&regs->gpr[14], 0, 18 * sizeof(unsigned long));
-		current_thread_info()->nvgprs_frame = &frame->mc_gregs;
-		set_thread_flag(TIF_SAVE_NVGPRS);
-	}
-
+	WARN_ON(!FULL_REGS(regs));
 	return __copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE);
 }
 
@@ -826,8 +815,8 @@ static int do_setcontext(struct ucontext
 }
 
 long sys_swapcontext(struct ucontext __user *old_ctx,
-		       struct ucontext __user *new_ctx,
-		       int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
+		     struct ucontext __user *new_ctx,
+		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
 	unsigned char tmp;
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 497a5d3..4324f8a 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -118,14 +118,7 @@ static long setup_sigcontext(struct sigc
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
 	err |= __put_user(&sc->gp_regs, &sc->regs);
-	if (!FULL_REGS(regs)) {
-		/* Zero out the unsaved GPRs to avoid information
-		   leak, and set TIF_SAVE_NVGPRS to ensure that the
-		   registers do actually get saved later. */
-		memset(&regs->gpr[14], 0, 18 * sizeof(unsigned long));
-		set_thread_flag(TIF_SAVE_NVGPRS);
-		current_thread_info()->nvgprs_frame = &sc->gp_regs;
-	}
+	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
 	err |= __put_user(signr, &sc->signal);
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 8a9f994..1ad55f0 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -288,7 +288,7 @@ COMPAT_SYS(clock_settime)
 COMPAT_SYS(clock_gettime)
 COMPAT_SYS(clock_getres)
 COMPAT_SYS(clock_nanosleep)
-COMPAT_SYS(swapcontext)
+SYSX(ppc64_swapcontext,ppc32_swapcontext,ppc_swapcontext)
 COMPAT_SYS(tgkill)
 COMPAT_SYS(utimes)
 COMPAT_SYS(statfs64)
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index 237fc2b..ffc7462 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -37,7 +37,6 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	struct restart_block restart_block;
-	void __user *nvgprs_frame;
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
@@ -120,7 +119,6 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
 #define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
-#define TIF_SAVE_NVGPRS		13	/* Save r14-r31 in signal frame */
 #define TIF_NOERROR		14	/* Force successful syscall return */
 #define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
 
@@ -137,15 +135,13 @@ static inline struct thread_info *curren
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
-#define _TIF_SAVE_NVGPRS	(1<<TIF_SAVE_NVGPRS)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
-				 _TIF_NEED_RESCHED | _TIF_RESTOREALL | \
-				 _TIF_RESTORE_SIGMASK)
-#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR|_TIF_SAVE_NVGPRS)
+				 _TIF_NEED_RESCHED | _TIF_RESTORE_SIGMASK)
+#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 #endif /* __KERNEL__ */
 
