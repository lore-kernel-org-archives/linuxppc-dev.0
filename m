Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w83Th66TBzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 01:59:36 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Avoid risk of unrecoverable TLBmiss inside
 entry_32.S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170420155932.BFC2C6E98F@localhost.localdomain>
Date: Thu, 20 Apr 2017 17:59:32 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, the 8xx pins an ITLB on the first 8M of memory in order
to avoid any ITLB miss on kernel code.
However, with some debug functions like DEBUG_PAGEALLOC and
DEBUG_RODATA, pinning TLBs is contradictory.

In order to avoid any ITLB miss in a critical section without pinning
TLBs, we have to ensure that there is no page boundary crossed between
the setup of a new value in SRR0/SRR1 and the associated RFI.

Today, the functions modifying srr0/srr1 are all located in
setup_32.S. They are spread over almost 4kbytes.

This patch reorganises setup_32.S to regroup those functions at the
beginning of the file. It regroups them within the first 2kbytes.

Then the patch forces an 11 bits (2kbytes) alignment for those
functions. This garanties that the functions remain in a
single 4k page.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 This patch superseeds previous patch named "powerpc/32: Move entry_32
 functions just after HEAD functions.", taking into account suggestion
 from Michael.

 No modification is done to the code, only a move was done.

 arch/powerpc/kernel/entry_32.S | 509 +++++++++++++++++++++--------------------
 1 file changed, 258 insertions(+), 251 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a38600949f3a..b46556571580 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -44,6 +44,13 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif
 
+/*
+ * Align to 2k in order to ensure that all functions modyfing srr0/srr1
+ * fit into one page in order to not encounter a TLB miss between the
+ * modification of srr0/srr1 and the associated rfi.
+ */
+	.align	11
+
 #ifdef CONFIG_BOOKE
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
@@ -441,257 +448,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 66:	li	r3,-ENOSYS
 	b	ret_from_syscall
 
-	.globl	ret_from_fork
-ret_from_fork:
-	REST_NVGPRS(r1)
-	bl	schedule_tail
-	li	r3,0
-	b	ret_from_syscall
-
-	.globl	ret_from_kernel_thread
-ret_from_kernel_thread:
-	REST_NVGPRS(r1)
-	bl	schedule_tail
-	mtlr	r14
-	mr	r3,r15
-	PPC440EP_ERR42
-	blrl
-	li	r3,0
-	b	ret_from_syscall
-
-/* Traced system call support */
-syscall_dotrace:
-	SAVE_NVGPRS(r1)
-	li	r0,0xc00
-	stw	r0,_TRAP(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	do_syscall_trace_enter
-	/*
-	 * Restore argument registers possibly just changed.
-	 * We use the return value of do_syscall_trace_enter
-	 * for call number to look up in the table (r0).
-	 */
-	mr	r0,r3
-	lwz	r3,GPR3(r1)
-	lwz	r4,GPR4(r1)
-	lwz	r5,GPR5(r1)
-	lwz	r6,GPR6(r1)
-	lwz	r7,GPR7(r1)
-	lwz	r8,GPR8(r1)
-	REST_NVGPRS(r1)
-
-	cmplwi	r0,NR_syscalls
-	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
-	bge-	ret_from_syscall
-	b	syscall_dotrace_cont
-
-syscall_exit_work:
-	andi.	r0,r9,_TIF_RESTOREALL
-	beq+	0f
-	REST_NVGPRS(r1)
-	b	2f
-0:	cmplw	0,r3,r8
-	blt+	1f
-	andi.	r0,r9,_TIF_NOERROR
-	bne-	1f
-	lwz	r11,_CCR(r1)			/* Load CR */
-	neg	r3,r3
-	oris	r11,r11,0x1000	/* Set SO bit in CR */
-	stw	r11,_CCR(r1)
-
-1:	stw	r6,RESULT(r1)	/* Save result */
-	stw	r3,GPR3(r1)	/* Update return value */
-2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
-	beq	4f
-
-	/* Clear per-syscall TIF flags if any are set.  */
-
-	li	r11,_TIF_PERSYSCALL_MASK
-	addi	r12,r12,TI_FLAGS
-3:	lwarx	r8,0,r12
-	andc	r8,r8,r11
-#ifdef CONFIG_IBM405_ERR77
-	dcbt	0,r12
-#endif
-	stwcx.	r8,0,r12
-	bne-	3b
-	subi	r12,r12,TI_FLAGS
-	
-4:	/* Anything which requires enabling interrupts? */
-	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
-	beq	ret_from_except
-
-	/* Re-enable interrupts. There is no need to trace that with
-	 * lockdep as we are supposed to have IRQs on at this point
-	 */
-	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)
-
-	/* Save NVGPRS if they're not saved already */
-	lwz	r4,_TRAP(r1)
-	andi.	r4,r4,1
-	beq	5f
-	SAVE_NVGPRS(r1)
-	li	r4,0xc00
-	stw	r4,_TRAP(r1)
-5:
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	do_syscall_trace_leave
-	b	ret_from_except_full
-
-/*
- * The fork/clone functions need to copy the full register set into
- * the child process. Therefore we need to save all the nonvolatile
- * registers (r13 - r31) before calling the C code.
- */
-	.globl	ppc_fork
-ppc_fork:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_fork
-
-	.globl	ppc_vfork
-ppc_vfork:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_vfork
-
-	.globl	ppc_clone
-ppc_clone:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_clone
-
-	.globl	ppc_swapcontext
-ppc_swapcontext:
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
-	stw	r0,_TRAP(r1)		/* register set saved */
-	b	sys_swapcontext
-
-/*
- * Top-level page fault handling.
- * This is in assembler because if do_page_fault tells us that
- * it is a bad kernel page fault, we want to save the non-volatile
- * registers before calling bad_page_fault.
- */
-	.globl	handle_page_fault
-handle_page_fault:
-	stw	r4,_DAR(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	do_page_fault
-	cmpwi	r3,0
-	beq+	ret_from_except
-	SAVE_NVGPRS(r1)
-	lwz	r0,_TRAP(r1)
-	clrrwi	r0,r0,1
-	stw	r0,_TRAP(r1)
-	mr	r5,r3
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	lwz	r4,_DAR(r1)
-	bl	bad_page_fault
-	b	ret_from_except_full
-
-/*
- * This routine switches between two different tasks.  The process
- * state of one is saved on its kernel stack.  Then the state
- * of the other is restored from its kernel stack.  The memory
- * management hardware is updated to the second process's state.
- * Finally, we can return to the second process.
- * On entry, r3 points to the THREAD for the current task, r4
- * points to the THREAD for the new task.
- *
- * This routine is always called with interrupts disabled.
- *
- * Note: there are two ways to get to the "going out" portion
- * of this code; either by coming in via the entry (_switch)
- * or via "fork" which must set up an environment equivalent
- * to the "_switch" path.  If you change this , you'll have to
- * change the fork code also.
- *
- * The code which creates the new task context is in 'copy_thread'
- * in arch/ppc/kernel/process.c
- */
-_GLOBAL(_switch)
-	stwu	r1,-INT_FRAME_SIZE(r1)
-	mflr	r0
-	stw	r0,INT_FRAME_SIZE+4(r1)
-	/* r3-r12 are caller saved -- Cort */
-	SAVE_NVGPRS(r1)
-	stw	r0,_NIP(r1)	/* Return to switch caller */
-	mfmsr	r11
-	li	r0,MSR_FP	/* Disable floating-point */
-#ifdef CONFIG_ALTIVEC
-BEGIN_FTR_SECTION
-	oris	r0,r0,MSR_VEC@h	/* Disable altivec */
-	mfspr	r12,SPRN_VRSAVE	/* save vrsave register value */
-	stw	r12,THREAD+THREAD_VRSAVE(r2)
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-#endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-BEGIN_FTR_SECTION
-	oris	r0,r0,MSR_SPE@h	 /* Disable SPE */
-	mfspr	r12,SPRN_SPEFSCR /* save spefscr register value */
-	stw	r12,THREAD+THREAD_SPEFSCR(r2)
-END_FTR_SECTION_IFSET(CPU_FTR_SPE)
-#endif /* CONFIG_SPE */
-	and.	r0,r0,r11	/* FP or altivec or SPE enabled? */
-	beq+	1f
-	andc	r11,r11,r0
-	MTMSRD(r11)
-	isync
-1:	stw	r11,_MSR(r1)
-	mfcr	r10
-	stw	r10,_CCR(r1)
-	stw	r1,KSP(r3)	/* Set old stack pointer */
-
-#ifdef CONFIG_SMP
-	/* We need a sync somewhere here to make sure that if the
-	 * previous task gets rescheduled on another CPU, it sees all
-	 * stores it has performed on this one.
-	 */
-	sync
-#endif /* CONFIG_SMP */
-
-	tophys(r0,r4)
-	mtspr	SPRN_SPRG_THREAD,r0	/* Update current THREAD phys addr */
-	lwz	r1,KSP(r4)	/* Load new stack pointer */
-
-	/* save the old current 'last' for return value */
-	mr	r3,r2
-	addi	r2,r4,-THREAD	/* Update current */
-
-#ifdef CONFIG_ALTIVEC
-BEGIN_FTR_SECTION
-	lwz	r0,THREAD+THREAD_VRSAVE(r2)
-	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-#endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-BEGIN_FTR_SECTION
-	lwz	r0,THREAD+THREAD_SPEFSCR(r2)
-	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
-END_FTR_SECTION_IFSET(CPU_FTR_SPE)
-#endif /* CONFIG_SPE */
-
-	lwz	r0,_CCR(r1)
-	mtcrf	0xFF,r0
-	/* r3-r12 are destroyed -- Cort */
-	REST_NVGPRS(r1)
-
-	lwz	r4,_NIP(r1)	/* Return to _switch caller in new task */
-	mtlr	r4
-	addi	r1,r1,INT_FRAME_SIZE
-	blr
-
 	.globl	fast_exception_return
 fast_exception_return:
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
@@ -1182,6 +938,257 @@ global_dbcr0:
 	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
 
+	.globl	ret_from_fork
+ret_from_fork:
+	REST_NVGPRS(r1)
+	bl	schedule_tail
+	li	r3,0
+	b	ret_from_syscall
+
+	.globl	ret_from_kernel_thread
+ret_from_kernel_thread:
+	REST_NVGPRS(r1)
+	bl	schedule_tail
+	mtlr	r14
+	mr	r3,r15
+	PPC440EP_ERR42
+	blrl
+	li	r3,0
+	b	ret_from_syscall
+
+/* Traced system call support */
+syscall_dotrace:
+	SAVE_NVGPRS(r1)
+	li	r0,0xc00
+	stw	r0,_TRAP(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_syscall_trace_enter
+	/*
+	 * Restore argument registers possibly just changed.
+	 * We use the return value of do_syscall_trace_enter
+	 * for call number to look up in the table (r0).
+	 */
+	mr	r0,r3
+	lwz	r3,GPR3(r1)
+	lwz	r4,GPR4(r1)
+	lwz	r5,GPR5(r1)
+	lwz	r6,GPR6(r1)
+	lwz	r7,GPR7(r1)
+	lwz	r8,GPR8(r1)
+	REST_NVGPRS(r1)
+
+	cmplwi	r0,NR_syscalls
+	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
+	bge-	ret_from_syscall
+	b	syscall_dotrace_cont
+
+syscall_exit_work:
+	andi.	r0,r9,_TIF_RESTOREALL
+	beq+	0f
+	REST_NVGPRS(r1)
+	b	2f
+0:	cmplw	0,r3,r8
+	blt+	1f
+	andi.	r0,r9,_TIF_NOERROR
+	bne-	1f
+	lwz	r11,_CCR(r1)			/* Load CR */
+	neg	r3,r3
+	oris	r11,r11,0x1000	/* Set SO bit in CR */
+	stw	r11,_CCR(r1)
+
+1:	stw	r6,RESULT(r1)	/* Save result */
+	stw	r3,GPR3(r1)	/* Update return value */
+2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)
+	beq	4f
+
+	/* Clear per-syscall TIF flags if any are set.  */
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
+	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
+	beq	ret_from_except
+
+	/* Re-enable interrupts. There is no need to trace that with
+	 * lockdep as we are supposed to have IRQs on at this point
+	 */
+	ori	r10,r10,MSR_EE
+	SYNC
+	MTMSRD(r10)
+
+	/* Save NVGPRS if they're not saved already */
+	lwz	r4,_TRAP(r1)
+	andi.	r4,r4,1
+	beq	5f
+	SAVE_NVGPRS(r1)
+	li	r4,0xc00
+	stw	r4,_TRAP(r1)
+5:
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_syscall_trace_leave
+	b	ret_from_except_full
+
+/*
+ * The fork/clone functions need to copy the full register set into
+ * the child process. Therefore we need to save all the nonvolatile
+ * registers (r13 - r31) before calling the C code.
+ */
+	.globl	ppc_fork
+ppc_fork:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_fork
+
+	.globl	ppc_vfork
+ppc_vfork:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_vfork
+
+	.globl	ppc_clone
+ppc_clone:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_clone
+
+	.globl	ppc_swapcontext
+ppc_swapcontext:
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,_TRAP(r1)		/* register set saved */
+	b	sys_swapcontext
+
+/*
+ * Top-level page fault handling.
+ * This is in assembler because if do_page_fault tells us that
+ * it is a bad kernel page fault, we want to save the non-volatile
+ * registers before calling bad_page_fault.
+ */
+	.globl	handle_page_fault
+handle_page_fault:
+	stw	r4,_DAR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_page_fault
+	cmpwi	r3,0
+	beq+	ret_from_except
+	SAVE_NVGPRS(r1)
+	lwz	r0,_TRAP(r1)
+	clrrwi	r0,r0,1
+	stw	r0,_TRAP(r1)
+	mr	r5,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	lwz	r4,_DAR(r1)
+	bl	bad_page_fault
+	b	ret_from_except_full
+
+/*
+ * This routine switches between two different tasks.  The process
+ * state of one is saved on its kernel stack.  Then the state
+ * of the other is restored from its kernel stack.  The memory
+ * management hardware is updated to the second process's state.
+ * Finally, we can return to the second process.
+ * On entry, r3 points to the THREAD for the current task, r4
+ * points to the THREAD for the new task.
+ *
+ * This routine is always called with interrupts disabled.
+ *
+ * Note: there are two ways to get to the "going out" portion
+ * of this code; either by coming in via the entry (_switch)
+ * or via "fork" which must set up an environment equivalent
+ * to the "_switch" path.  If you change this , you'll have to
+ * change the fork code also.
+ *
+ * The code which creates the new task context is in 'copy_thread'
+ * in arch/ppc/kernel/process.c
+ */
+_GLOBAL(_switch)
+	stwu	r1,-INT_FRAME_SIZE(r1)
+	mflr	r0
+	stw	r0,INT_FRAME_SIZE+4(r1)
+	/* r3-r12 are caller saved -- Cort */
+	SAVE_NVGPRS(r1)
+	stw	r0,_NIP(r1)	/* Return to switch caller */
+	mfmsr	r11
+	li	r0,MSR_FP	/* Disable floating-point */
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	oris	r0,r0,MSR_VEC@h	/* Disable altivec */
+	mfspr	r12,SPRN_VRSAVE	/* save vrsave register value */
+	stw	r12,THREAD+THREAD_VRSAVE(r2)
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_SPE
+BEGIN_FTR_SECTION
+	oris	r0,r0,MSR_SPE@h	 /* Disable SPE */
+	mfspr	r12,SPRN_SPEFSCR /* save spefscr register value */
+	stw	r12,THREAD+THREAD_SPEFSCR(r2)
+END_FTR_SECTION_IFSET(CPU_FTR_SPE)
+#endif /* CONFIG_SPE */
+	and.	r0,r0,r11	/* FP or altivec or SPE enabled? */
+	beq+	1f
+	andc	r11,r11,r0
+	MTMSRD(r11)
+	isync
+1:	stw	r11,_MSR(r1)
+	mfcr	r10
+	stw	r10,_CCR(r1)
+	stw	r1,KSP(r3)	/* Set old stack pointer */
+
+#ifdef CONFIG_SMP
+	/* We need a sync somewhere here to make sure that if the
+	 * previous task gets rescheduled on another CPU, it sees all
+	 * stores it has performed on this one.
+	 */
+	sync
+#endif /* CONFIG_SMP */
+
+	tophys(r0,r4)
+	mtspr	SPRN_SPRG_THREAD,r0	/* Update current THREAD phys addr */
+	lwz	r1,KSP(r4)	/* Load new stack pointer */
+
+	/* save the old current 'last' for return value */
+	mr	r3,r2
+	addi	r2,r4,-THREAD	/* Update current */
+
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	lwz	r0,THREAD+THREAD_VRSAVE(r2)
+	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_SPE
+BEGIN_FTR_SECTION
+	lwz	r0,THREAD+THREAD_SPEFSCR(r2)
+	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
+END_FTR_SECTION_IFSET(CPU_FTR_SPE)
+#endif /* CONFIG_SPE */
+
+	lwz	r0,_CCR(r1)
+	mtcrf	0xFF,r0
+	/* r3-r12 are destroyed -- Cort */
+	REST_NVGPRS(r1)
+
+	lwz	r4,_NIP(r1)	/* Return to _switch caller in new task */
+	mtlr	r4
+	addi	r1,r1,INT_FRAME_SIZE
+	blr
+
 do_work:			/* r10 contains MSR_KERNEL here */
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	beq	do_user_signal
-- 
2.12.0
