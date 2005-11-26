Return-Path: <SRS0+8b9f4a6fc0d47fc8ba51+825+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3201687C7
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2005 01:44:55 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sat, 26 Nov 2005 14:44:47 +0000
Message-Id: <1133016287.4044.65.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make ARCH=ppc build again with new syscall path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes ARCH=ppc build in your powerpc tree again, with the new
syscall entry/exit path. 

Still doesn't actually boot on my Pegasos; the last thing I see is
'MMU:exit'. But at least it builds -- I'll look at why it doesn't boot
later, so that I can see if the mv643xx_eth actually works with ARCH=ppc
(it doesn't with ARCH=powerpc; two in every three packets I receive are
offset by 4 bytes).

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/ppc/kernel/asm-offsets.c b/arch/ppc/kernel/asm-offsets.c
index fe0e767..7964bf6 100644
--- a/arch/ppc/kernel/asm-offsets.c
+++ b/arch/ppc/kernel/asm-offsets.c
@@ -131,7 +131,7 @@ main(void)
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
-	DEFINE(TI_SC_NOERR, offsetof(struct thread_info, syscall_noerror));
+	DEFINE(TI_SIGFRAME, offsetof(struct thread_info, nvgprs_frame));
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index f044edb..a48b950 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -200,8 +200,6 @@ _GLOBAL(DoSyscall)
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
 	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
-	li	r11,0
-	stb	r11,TI_SC_NOERR(r10)
 	lwz	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
@@ -222,25 +220,21 @@ ret_from_syscall:
 	bl	do_show_syscall_exit
 #endif
 	mr	r6,r3
-	li	r11,-_LAST_ERRNO
-	cmplw	0,r3,r11
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
-	blt+	30f
-	lbz	r11,TI_SC_NOERR(r12)
-	cmpwi	r11,0
-	bne	30f
-	neg	r3,r3
-	lwz	r10,_CCR(r1)	/* Set SO bit in CR */
-	oris	r10,r10,0x1000
-	stw	r10,_CCR(r1)
-
 	/* disable interrupts so current_thread_info()->flags can't change */
-30:	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	li	r8,-_LAST_ERRNO
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
 	bne-	syscall_exit_work
+	cmplw	0,r3,r8
+	blt+	syscall_exit_cont
+	lwz	r11,_CCR(r1)			/* Load CR */
+	neg	r3,r3
+	oris	r11,r11,0x1000	/* Set SO bit in CR */
+	stw	r11,_CCR(r1)
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The single
@@ -292,46 +286,113 @@ syscall_dotrace:
 	b	syscall_dotrace_cont
 
 syscall_exit_work:
-	stw	r6,RESULT(r1)	/* Save result */
+	andi.	r0,r9,_TIF_RESTOREALL
+	bne-	2f
+	cmplw	0,r3,r8
+	blt+	1f
+	andi.	r0,r9,_TIF_NOERROR
+	bne-	1f
+	lwz	r11,_CCR(r1)			/* Load CR */
+	neg	r3,r3
+	oris	r11,r11,0x1000	/* Set SO bit in CR */
+	stw	r11,_CCR(r1)
+
+1:	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
-	beq	5f
-	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)		/* re-enable interrupts */
+2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
+	beq	4f
+
+	/* Clear per-syscall TIF flags if any are set, but _leave_
+	_TIF_SAVE_NVGPRS set in r9 since we haven't dealt with that
+	yet.  */
+
+	li	r11,_TIF_PERSYSCALL_MASK
+	addi	r12,r12,TI_FLAGS
+3:	lwarx	r8,0,r12
+	andc	r8,r8,r11
+#ifdef CONFIG_IBM405_ERR77
+	dcbt	0,r12
+#endif
+	stwcx.	r8,0,r12
+	bne-	3b
+	subi	r12,r12,TI_FLAGS
+	
+4:	/* Anything which requires enabling interrupts? */
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SAVE_NVGPRS)
+	beq	7f
+
+	/* Save NVGPRS if they're not saved already */
 	lwz	r4,TRAP(r1)
 	andi.	r4,r4,1
-	beq	4f
+	beq	5f
 	SAVE_NVGPRS(r1)
 	li	r4,0xc00
 	stw	r4,TRAP(r1)
-4:
+
+	/* Re-enable interrupts */
+5:	ori	r10,r10,MSR_EE
+	SYNC
+	MTMSRD(r10)
+
+	andi.	r0,r9,_TIF_SAVE_NVGPRS
+	bne	save_user_nvgprs
+
+save_user_nvgprs_cont:
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	beq	7f
+
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_syscall_trace_leave
 	REST_NVGPRS(r1)
-2:
-	lwz	r3,GPR3(r1)
+
+6:	lwz	r3,GPR3(r1)
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)		/* disable interrupts again */
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	lwz	r9,TI_FLAGS(r12)
-5:
+7:
 	andi.	r0,r9,_TIF_NEED_RESCHED
-	bne	1f
+	bne	8f
 	lwz	r5,_MSR(r1)
 	andi.	r5,r5,MSR_PR
-	beq	syscall_exit_cont
+	beq	ret_from_except
 	andi.	r0,r9,_TIF_SIGPENDING
-	beq	syscall_exit_cont
+	beq	ret_from_except
 	b	do_user_signal
-1:
+8:
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* re-enable interrupts */
 	bl	schedule
-	b	2b
+	b	6b
+
+save_user_nvgprs:
+	lwz	r8,TI_SIGFRAME(r12)
+
+.macro savewords start, end
+  1:	stw \start,4*(\start)(r8)
+	.section __ex_table,"a"
+	.align	2
+	.long	1b,save_user_nvgprs_fault
+	.previous
+	.if \end - \start
+	savewords "(\start+1)",\end
+	.endif
+.endm	
+	savewords 14,31
+	b	save_user_nvgprs_cont
+
+	
+save_user_nvgprs_fault:
+	li	r3,11		/* SIGSEGV */
+	lwz	r4,TI_TASK(r12)
+	bl	force_sigsegv
 
+	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	lwz	r9,TI_FLAGS(r12)
+	b	save_user_nvgprs_cont
+	
 #ifdef SHOW_SYSCALLS
 do_show_syscall:
 #ifdef SHOW_SYSCALLS_TASK
@@ -401,28 +462,10 @@ show_syscalls_task:
 #endif /* SHOW_SYSCALLS */
 
 /*
- * The sigsuspend and rt_sigsuspend system calls can call do_signal
- * and thus put the process into the stopped state where we might
- * want to examine its user state with ptrace.  Therefore we need
- * to save all the nonvolatile registers (r13 - r31) before calling
- * the C code.
+ * The fork/clone functions need to copy the full register set into
+ * the child process. Therefore we need to save all the nonvolatile
+ * registers (r13 - r31) before calling the C code.
  */
-	.globl	ppc_sigsuspend
-ppc_sigsuspend:
-	SAVE_NVGPRS(r1)
-	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,TRAP(r1)		/* register set saved */
-	b	sys_sigsuspend
-
-	.globl	ppc_rt_sigsuspend
-ppc_rt_sigsuspend:
-	SAVE_NVGPRS(r1)
-	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30
-	stw	r0,TRAP(r1)
-	b	sys_rt_sigsuspend
-
 	.globl	ppc_fork
 ppc_fork:
 	SAVE_NVGPRS(r1)
@@ -447,14 +490,6 @@ ppc_clone:
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_clone
 
-	.globl	ppc_swapcontext
-ppc_swapcontext:
-	SAVE_NVGPRS(r1)
-	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,TRAP(r1)		/* register set saved */
-	b	sys_swapcontext
-
 /*
  * Top-level page fault handling.
  * This is in assembler because if do_page_fault tells us that
@@ -626,16 +661,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	.long	ret_from_except
 #endif
 
-	.globl	sigreturn_exit
-sigreturn_exit:
-	subi	r1,r3,STACK_FRAME_OVERHEAD
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
-	beq+	ret_from_except_full
-	bl	do_syscall_trace_leave
-	/* fall through */
-
 	.globl	ret_from_except_full
 ret_from_except_full:
 	REST_NVGPRS(r1)
@@ -658,7 +683,7 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,18
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
 	bne	do_work
 
 restore_user:
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 5e61124..fb5658b 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -1197,7 +1197,7 @@ _GLOBAL(sys_call_table)
 	.long sys_ssetmask
 	.long sys_setreuid	/* 70 */
 	.long sys_setregid
-	.long ppc_sigsuspend
+	.long sys_sigsuspend
 	.long sys_sigpending
 	.long sys_sethostname
 	.long sys_setrlimit	/* 75 */
@@ -1303,7 +1303,7 @@ _GLOBAL(sys_call_table)
 	.long sys_rt_sigpending	/* 175 */
 	.long sys_rt_sigtimedwait
 	.long sys_rt_sigqueueinfo
-	.long ppc_rt_sigsuspend
+	.long sys_rt_sigsuspend
 	.long sys_pread64
 	.long sys_pwrite64	/* 180 */
 	.long sys_chown
@@ -1374,7 +1374,7 @@ _GLOBAL(sys_call_table)
 	.long sys_clock_gettime
 	.long sys_clock_getres
 	.long sys_clock_nanosleep
-	.long ppc_swapcontext
+	.long sys_swapcontext
 	.long sys_tgkill	/* 250 */
 	.long sys_utimes
 	.long sys_statfs64

-- 
dwmw2
