Return-Path: <SRS0+a1718e32b9545b33bd94+813+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B1AB68753
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2005 07:04:44 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17272.5610.562107.359574@cargo.ozlabs.ibm.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
	<1131874887.27347.221.camel@baythorne.infradead.org>
	<17271.4290.486710.929502@cargo.ozlabs.ibm.com>
	<1131883101.27347.233.camel@baythorne.infradead.org>
	<17272.5610.562107.359574@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 20:05:33 +0000
Message-Id: <1131998735.21212.243.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-14 at 15:43 +1100, Paul Mackerras wrote:
> Ah ok, I see now, that sounds all right.

I've also changed force_successful_syscall_return() to use a TIF flag,
so we don't have to clear ti->syscall_noerror in the syscall entry path
and that can shrink too.

The syscall exit path now checks ti->flags only once in the fast path,
instead of checking it twice as it did before. All the interesting stuff
is done in the slow path.

We lose the assembly wrappers for the signal-related functions, and
clean up the syscall table to call them directly.

It looks a bit like this... I still need to test it a little harder than
"Yes, it boots", and I need to sync up the 32-bit version. Then we can
have syscall entry/exit paths that actually look similar to each other.

What do you think?

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b757572..e3e6081 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -92,9 +92,9 @@ int main(void)
 
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
-	DEFINE(TI_SC_NOERR, offsetof(struct thread_info, syscall_noerror));
-#ifdef CONFIG_PPC32
+	DEFINE(TI_SIGFRAME, offsetof(struct thread_info, nvgprs_frame));
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
+#ifdef CONFIG_PPC32
 	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 #endif /* CONFIG_PPC32 */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2d22bf0..564452b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -113,9 +113,7 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 #endif
 	clrrdi	r11,r1,THREAD_SHIFT
-	li	r12,0
 	ld	r10,TI_FLAGS(r11)
-	stb	r12,TI_SC_NOERR(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -145,23 +143,11 @@ system_call:			/* label this so stack tr
 
 syscall_exit:
 #ifdef SHOW_SYSCALLS
-	std	r3,GPR3(r1)
+	std	r3,RESULT(r1)
 	bl	.do_show_syscall_exit
-	ld	r3,GPR3(r1)
+	ld	r3,RESULT(r1)
 #endif
-	std	r3,RESULT(r1)
-	ld	r5,_CCR(r1)
-	li	r10,-_LAST_ERRNO
-	cmpld	r3,r10
 	clrrdi	r12,r1,THREAD_SHIFT
-	bge-	syscall_error
-syscall_error_cont:
-
-	/* check for syscall tracing or audit */
-	ld	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
-	bne-	syscall_exit_trace
-syscall_exit_trace_cont:
 
 	/* disable interrupts so current_thread_info()->flags can't change,
 	   and so that we don't get interrupted after loading SRR0/1. */
@@ -173,8 +159,14 @@ syscall_exit_trace_cont:
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
 	ld	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	li	r11,-_LAST_ERRNO
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR)
 	bne-	syscall_exit_work
+	std	r3,RESULT(r1)
+	cmpld	r3,r11
+	ld	r5,_CCR(r1)
+	bge-	syscall_error
+syscall_error_cont:
 	ld	r7,_NIP(r1)
 	stdcx.	r0,0,r1			/* to clear the reservation */
 	andi.	r6,r8,MSR_PR
@@ -193,21 +185,13 @@ syscall_exit_trace_cont:
 	rfid
 	b	.	/* prevent speculative execution */
 
-syscall_enosys:
-	li	r3,-ENOSYS
-	std	r3,RESULT(r1)
-	clrrdi	r12,r1,THREAD_SHIFT
-	ld	r5,_CCR(r1)
-
-syscall_error:
-	lbz	r11,TI_SC_NOERR(r12)
-	cmpwi	0,r11,0
-	bne-	syscall_error_cont
+syscall_error:	
 	neg	r3,r3
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
+	std	r3,RESULT(r1)
 	std	r5,_CCR(r1)
 	b	syscall_error_cont
-        
+	
 /* Traced system call support */
 syscall_dotrace:
 	bl	.save_nvgprs
@@ -225,21 +209,72 @@ syscall_dotrace:
 	ld	r10,TI_FLAGS(r10)
 	b	syscall_dotrace_cont
 
-syscall_exit_trace:
+syscall_enosys:
+	li	r3,-ENOSYS
+	b	syscall_exit
+	
+syscall_exit_work:
+	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
+	 If TIF_NOERROR is set, just save r3 as it is. */
+
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	2f
+	cmpld	r3,r11		/* r10 is -LAST_ERRNO */
+	blt-	1f
+	andi.	r0,r9,_TIF_NOERROR
+	bne-	1f
+	ld	r5,_CCR(r1)
+	neg	r3,r3
+	oris	r5,r5,0x1000	/* Set SO bit in CR */
+	std	r5,_CCR(r1)
+1:
+	std	r3,RESULT(r1)
 	std	r3,GPR3(r1)
-	bl	.save_nvgprs
+
+2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
+	beq	4f
+
+	/* Clear per-syscall TIF flags if any are set, but _leave_
+	_TIF_SAVE_NVGPRS set in r9 since we haven't dealt with that
+	yet.  */
+
+	li r11,_TIF_PERSYSCALL_MASK
+	addi	r12,r12,TI_FLAGS
+3:	ldarx	r10,0,r12
+	andc	r10,r10,r11
+	stdcx.	r10,0,r12
+	bne-	3b
+	subi	r12,r12,TI_FLAGS
+	
+4:	bl	save_nvgprs
+	/* Anything else left to do? */
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SAVE_NVGPRS)
+	beq	.ret_from_except_lite
+
+	/* Re-enable interrupts */
+	mfmsr	r10
+	ori	r10,r10,MSR_EE
+	mtmsrd	r10,1
+
+	andi.	r0,r9,_TIF_SAVE_NVGPRS
+	bne	save_user_nvgprs
+
+	/* If tracing, re-enable interrupts and do it */
+save_user_nvgprs_cont:	
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	beq	5f
+	
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_leave
 	REST_NVGPRS(r1)
-	ld	r3,GPR3(r1)
-	ld	r5,_CCR(r1)
 	clrrdi	r12,r1,THREAD_SHIFT
-	b	syscall_exit_trace_cont
 
-/* Stuff to do on exit from a system call. */
-syscall_exit_work:
-	std	r3,GPR3(r1)
-	std	r5,_CCR(r1)
+	/* Disable interrupts again and handle other work if any */
+5:	mfmsr	r10
+	rldicl	r10,r10,48,1
+	rotldi	r10,r10,16
+	mtmsrd	r10,1
+
 	b	.ret_from_except_lite
 
 /* Save non-volatile GPRs, if not already saved. */
@@ -252,6 +288,109 @@ _GLOBAL(save_nvgprs)
 	std	r0,_TRAP(r1)
 	blr
 
+
+save_user_nvgprs:
+	/* Re-enable interrupts before copying to user */
+	mfmsr	r10
+	ori	r10,r10,MSR_EE
+	mtmsrd	r10,1
+
+	ld	r10,TI_SIGFRAME(r9)
+	andi.	r0,r9,_TIF_32BIT
+	beq-	save_user_nvgprs_64
+
+	/* 32-bit save to userspace */
+101:	stw	r14,56(r10)
+102:	stw	r15,60(r10)
+103:	stw	r16,64(r10)
+104:	stw	r17,68(r10)
+105:	stw	r18,72(r10)
+106:	stw	r19,76(r10)
+107:	stw	r20,80(r10)
+108:	stw	r21,84(r10)
+109:	stw	r22,88(r10)
+110:	stw	r23,92(r10)
+111:	stw	r24,96(r10)
+112:	stw	r25,100(r10)	
+113:	stw	r26,104(r10)
+114:	stw	r27,108(r10)
+115:	stw	r28,112(r10)
+116:	stw	r29,116(r10)
+117:	stw	r30,120(r10)
+118:	stw	r31,124(r10)
+	b	save_user_nvgprs_cont
+
+save_user_nvgprs_64:
+	/* 64-bit save to userspace */
+119:	std	r14,112(r10)
+120:	std	r15,120(r10)
+121:	std	r16,128(r10)
+122:	std	r17,136(r10)
+123:	std	r18,144(r10)
+124:	std	r19,152(r10)
+125:	std	r20,160(r10)
+126:	std	r21,168(r10)
+127:	std	r22,176(r10)
+128:	std	r23,184(r10)
+129:	std	r24,192(r10)
+130:	std	r25,200(r10)
+131:	std	r26,208(r10)
+132:	std	r27,216(r10)
+133:	std	r28,224(r10)
+134:	std	r28,232(r10)
+135:	std	r28,240(r10)
+136:	std	r28,248(r10)
+	b	save_user_nvgprs_cont
+	
+	.section __ex_table,"a"
+	.align 3
+	.llong	101b,save_user_nvgprs_fault
+	.llong	102b,save_user_nvgprs_fault
+	.llong	103b,save_user_nvgprs_fault
+	.llong	104b,save_user_nvgprs_fault
+	.llong	105b,save_user_nvgprs_fault
+	.llong	106b,save_user_nvgprs_fault
+	.llong	107b,save_user_nvgprs_fault
+	.llong	108b,save_user_nvgprs_fault
+	.llong	109b,save_user_nvgprs_fault
+	.llong	110b,save_user_nvgprs_fault
+	.llong	111b,save_user_nvgprs_fault
+	.llong	112b,save_user_nvgprs_fault
+	.llong	113b,save_user_nvgprs_fault
+	.llong	114b,save_user_nvgprs_fault
+	.llong	115b,save_user_nvgprs_fault
+	.llong	116b,save_user_nvgprs_fault
+	.llong	117b,save_user_nvgprs_fault
+	.llong	118b,save_user_nvgprs_fault
+	.llong	119b,save_user_nvgprs_fault
+	.llong	120b,save_user_nvgprs_fault
+	.llong	121b,save_user_nvgprs_fault
+	.llong	122b,save_user_nvgprs_fault
+	.llong	123b,save_user_nvgprs_fault
+	.llong	124b,save_user_nvgprs_fault
+	.llong	125b,save_user_nvgprs_fault
+	.llong	126b,save_user_nvgprs_fault
+	.llong	127b,save_user_nvgprs_fault
+	.llong	128b,save_user_nvgprs_fault
+	.llong	129b,save_user_nvgprs_fault
+	.llong	130b,save_user_nvgprs_fault
+	.llong	131b,save_user_nvgprs_fault
+	.llong	132b,save_user_nvgprs_fault
+	.llong	133b,save_user_nvgprs_fault
+	.llong	134b,save_user_nvgprs_fault
+	.llong	135b,save_user_nvgprs_fault
+	.llong	136b,save_user_nvgprs_fault
+	.previous
+
+save_user_nvgprs_fault:
+	li	r3,9			// SIGSEGV
+	ld	r4,TI_TASK(r9)
+	bl	.force_sigsegv
+
+	clrrdi	r12,r1,THREAD_SHIFT
+	ld	r9,TI_FLAGS(r12)
+	b	save_user_nvgprs_cont
+	
 /*
  * The sigsuspend and rt_sigsuspend system calls can call do_signal
  * and thus put the process into the stopped state where we might
@@ -260,35 +399,6 @@ _GLOBAL(save_nvgprs)
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
@@ -305,37 +415,6 @@ _GLOBAL(ppc_clone)
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
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 081d931..88b86ac 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -75,7 +75,6 @@
  * registers from *regs.  This is what we need
  * to do when a signal has been delivered.
  */
-#define sigreturn_exit(regs)	return 0
 
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t32), sizeof(struct pt_regs32))
 #undef __SIGNAL_FRAMESIZE
@@ -155,9 +154,18 @@ static inline int save_general_regs(stru
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
 
-	for (i = 0; i <= PT_RESULT; i ++)
+	if (!FULL_REGS(regs)) {
+		printk("Save NVGPRS at %lx\n", (unsigned long)frame->mc_gregs);
+		set_thread_flag(TIF_SAVE_NVGPRS);
+		current_thread_info()->nvgprs_frame = frame->mc_gregs;
+	}
+
+	for (i = 0; i <= PT_RESULT; i ++) {
+		if (i == 14 && !FULL_REGS(regs))
+			i = 32;
 		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
 			return -EFAULT;
+	}
 	return 0;
 }
 
@@ -178,8 +186,6 @@ static inline int restore_general_regs(s
 
 #else /* CONFIG_PPC64 */
 
-extern void sigreturn_exit(struct pt_regs *);
-
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 
 static inline int put_sigset_t(sigset_t __user *uset, sigset_t *set)
@@ -255,8 +261,10 @@ long sys_sigsuspend(old_sigset_t mask, i
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
 
@@ -291,8 +299,10 @@ long sys_rt_sigsuspend(
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
 
@@ -829,12 +839,6 @@ static int handle_rt_signal(unsigned lon
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
@@ -912,8 +916,8 @@ long sys_swapcontext(struct ucontext __u
 	 */
 	if (do_setcontext(new_ctx, regs, 0))
 		do_exit(SIGSEGV);
-	sigreturn_exit(regs);
-	/* doesn't actually return back to here */
+
+	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
 
@@ -946,12 +950,11 @@ long sys_rt_sigreturn(int r3, int r4, in
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
@@ -1042,9 +1045,7 @@ int sys_debug_setcontext(struct ucontext
 	 */
 	do_sigaltstack(&ctx->uc_stack, NULL, regs->gpr[1]);
 
-	sigreturn_exit(regs);
-	/* doesn't actually return back to here */
-
+	set_thread_flag(TIF_RESTOREALL);
  out:
 	return 0;
 }
@@ -1109,12 +1110,6 @@ static int handle_signal(unsigned long s
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
 
@@ -1162,12 +1157,8 @@ long sys_sigreturn(int r3, int r4, int r
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
index 58194e1..e071e95 100644
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
 
@@ -155,6 +157,14 @@ static long setup_sigcontext(struct sigc
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
 	err |= __put_user(&sc->gp_regs, &sc->regs);
+	if (!FULL_REGS(regs)) {
+		/* Zero out the unsaved GPRs to avoid information
+		   leak, and set TIF_SAVE_NVGPRS to ensure that the
+		   registers do actually get saved later. */
+		memset(&regs->gpr[14], 0, 18 * sizeof(unsigned long));
+		set_thread_flag(TIF_SAVE_NVGPRS);
+		current_thread_info()->nvgprs_frame = &sc->gp_regs;
+	}
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
 	err |= __put_user(signr, &sc->signal);
@@ -343,6 +353,7 @@ int sys_swapcontext(struct ucontext __us
 		do_exit(SIGSEGV);
 
 	/* This returns like rt_sigreturn */
+	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
 
@@ -375,7 +386,8 @@ int sys_rt_sigreturn(unsigned long r3, u
 	 */
 	do_sigaltstack(&uc->uc_stack, NULL, regs->gpr[1]);
 
-	return regs->result;
+	set_thread_flag(TIF_RESTOREALL);
+	return 0;
 
 badframe:
 #if DEBUG_SIG
@@ -454,9 +466,6 @@ static int setup_rt_frame(int signr, str
 	if (err)
 		goto badframe;
 
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
-
 	return 1;
 
 badframe:
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
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 32f2158..2010d35 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -205,8 +205,8 @@ void _exception(int signr, struct pt_reg
 		if (handler == SIG_DFL) {
 			/* init has generated a synchronous exception
 			   and it doesn't have a handler for the signal */
-			printk(KERN_CRIT "init has generated signal %d "
-			       "but has no handler for it\n", signr);
+			die("init has generated signal %d "
+			    "but has no handler for it\n", regs, signr);
 			do_exit(signr);
 		}
 	}
diff --git a/include/asm-powerpc/ptrace.h b/include/asm-powerpc/ptrace.h
index 1f7ecdb..9c550b3 100644
--- a/include/asm-powerpc/ptrace.h
+++ b/include/asm-powerpc/ptrace.h
@@ -87,7 +87,7 @@ extern unsigned long profile_pc(struct p
 
 #define force_successful_syscall_return()   \
 	do { \
-		current_thread_info()->syscall_noerror = 1; \
+		set_thread_flag(TIF_NOERROR); \
 	} while(0)
 
 /*
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index e525f49..ac1e80e 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -37,8 +37,7 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	struct restart_block restart_block;
-	/* set by force_successful_syscall_return */
-	unsigned char	syscall_noerror;
+	void *nvgprs_frame;
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
@@ -123,6 +122,9 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
+#define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
+#define TIF_SAVE_NVGPRS		13	/* Save r14-r31 in signal frame */
+#define TIF_NOERROR		14	/* Force successful syscall return */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -136,10 +138,14 @@ static inline struct thread_info *curren
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
+#define _TIF_SAVE_NVGPRS	(1<<TIF_SAVE_NVGPRS)
+#define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
-				 _TIF_NEED_RESCHED)
+				 _TIF_NEED_RESCHED | _TIF_RESTOREALL)
+#define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR|_TIF_SAVE_NVGPRS)
 
 #endif /* __KERNEL__ */
 


-- 
dwmw2
