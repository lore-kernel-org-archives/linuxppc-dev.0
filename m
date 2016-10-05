Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2940LpzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 06/42] powerpc/64s: Consolidate Machine Check 0x200
 interrupt
Date: Wed,  5 Oct 2016 11:22:28 +1100
Message-Id: <1475626984-18770-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 659 +++++++++++++++++------------------
 1 file changed, 329 insertions(+), 330 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b163e7a62289..afdb2043b1f3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -218,6 +218,301 @@ FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_REAL_END(machine_check, 0x200, 0x300)
+EXC_VIRT_NONE(0x4200, 0x4300)
+TRAMP_REAL_BEGIN(machine_check_powernv_early)
+BEGIN_FTR_SECTION
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	/*
+	 * Register contents:
+	 * R13		= PACA
+	 * R9		= CR
+	 * Original R9 to R13 is saved on PACA_EXMC
+	 *
+	 * Switch to mc_emergency stack and handle re-entrancy (we limit
+	 * the nested MCE upto level 4 to avoid stack overflow).
+	 * Save MCE registers srr1, srr0, dar and dsisr and then set ME=1
+	 *
+	 * We use paca->in_mce to check whether this is the first entry or
+	 * nested machine check. We increment paca->in_mce to track nested
+	 * machine checks.
+	 *
+	 * If this is the first entry then set stack pointer to
+	 * paca->mc_emergency_sp, otherwise r1 is already pointing to
+	 * stack frame on mc_emergency stack.
+	 *
+	 * NOTE: We are here with MSR_ME=0 (off), which means we risk a
+	 * checkstop if we get another machine check exception before we do
+	 * rfid with MSR_ME=1.
+	 */
+	mr	r11,r1			/* Save r1 */
+	lhz	r10,PACA_IN_MCE(r13)
+	cmpwi	r10,0			/* Are we in nested machine check */
+	bne	0f			/* Yes, we are. */
+	/* First machine check entry */
+	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
+0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
+	addi	r10,r10,1		/* increment paca->in_mce */
+	sth	r10,PACA_IN_MCE(r13)
+	/* Limit nested MCE to level 4 to avoid stack overflow */
+	cmpwi	r10,4
+	bgt	2f			/* Check if we hit limit of 4 */
+	std	r11,GPR1(r1)		/* Save r1 on the stack. */
+	std	r11,0(r1)		/* make stack chain pointer */
+	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
+	std	r11,_NIP(r1)
+	mfspr	r11,SPRN_SRR1		/* Save SRR1 */
+	std	r11,_MSR(r1)
+	mfspr	r11,SPRN_DAR		/* Save DAR */
+	std	r11,_DAR(r1)
+	mfspr	r11,SPRN_DSISR		/* Save DSISR */
+	std	r11,_DSISR(r1)
+	std	r9,_CCR(r1)		/* Save CR in stackframe */
+	/* Save r9 through r13 from EXMC save area to stack frame. */
+	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
+	mfmsr	r11			/* get MSR value */
+	ori	r11,r11,MSR_ME		/* turn on ME bit */
+	ori	r11,r11,MSR_RI		/* turn on RI bit */
+	LOAD_HANDLER(r12, machine_check_handle_early)
+1:	mtspr	SPRN_SRR0,r12
+	mtspr	SPRN_SRR1,r11
+	rfid
+	b	.	/* prevent speculative execution */
+2:
+	/* Stack overflow. Stay on emergency stack and panic.
+	 * Keep the ME bit off while panic-ing, so that if we hit
+	 * another machine check we checkstop.
+	 */
+	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
+	ld	r11,PACAKMSR(r13)
+	LOAD_HANDLER(r12, unrecover_mce)
+	li	r10,MSR_ME
+	andc	r11,r11,r10		/* Turn off MSR_ME */
+	b	1b
+	b	.	/* prevent speculative execution */
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
+TRAMP_REAL_BEGIN(machine_check_pSeries)
+	.globl machine_check_fwnmi
+machine_check_fwnmi:
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+machine_check_pSeries_0:
+	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
+	/*
+	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
+	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
+	 * used, so nested machine check corrupts it. machine_check_common
+	 * enables MSR_RI.
+	 */
+	ld	r10,PACAKMSR(r13)
+	xori	r10,r10,MSR_RI
+	mfspr	r11,SPRN_SRR0
+	LOAD_HANDLER(r12, machine_check_common)
+	mtspr	SPRN_SRR0,r12
+	mfspr	r12,SPRN_SRR1
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.	/* prevent speculative execution */
+
+TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
+
+EXC_COMMON_BEGIN(machine_check_common)
+	/*
+	 * Machine check is different because we use a different
+	 * save area: PACA_EXMC instead of PACA_EXGEN.
+	 */
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXMC+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXMC+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
+	FINISH_NAP
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r3,PACA_EXMC+EX_DAR(r13)
+	lwz	r4,PACA_EXMC+EX_DSISR(r13)
+	/* Enable MSR_RI when finished with PACA_EXMC */
+	li	r10,MSR_RI
+	mtmsrd 	r10,1
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	b	ret_from_except
+
+#define MACHINE_CHECK_HANDLER_WINDUP			\
+	/* Clear MSR_RI before setting SRR0 and SRR1. */\
+	li	r0,MSR_RI;				\
+	mfmsr	r9;		/* get MSR value */	\
+	andc	r9,r9,r0;				\
+	mtmsrd	r9,1;		/* Clear MSR_RI */	\
+	/* Move original SRR0 and SRR1 into the respective regs */	\
+	ld	r9,_MSR(r1);				\
+	mtspr	SPRN_SRR1,r9;				\
+	ld	r3,_NIP(r1);				\
+	mtspr	SPRN_SRR0,r3;				\
+	ld	r9,_CTR(r1);				\
+	mtctr	r9;					\
+	ld	r9,_XER(r1);				\
+	mtxer	r9;					\
+	ld	r9,_LINK(r1);				\
+	mtlr	r9;					\
+	REST_GPR(0, r1);				\
+	REST_8GPRS(2, r1);				\
+	REST_GPR(10, r1);				\
+	ld	r11,_CCR(r1);				\
+	mtcr	r11;					\
+	/* Decrement paca->in_mce. */			\
+	lhz	r12,PACA_IN_MCE(r13);			\
+	subi	r12,r12,1;				\
+	sth	r12,PACA_IN_MCE(r13);			\
+	REST_GPR(11, r1);				\
+	REST_2GPRS(12, r1);				\
+	/* restore original r1. */			\
+	ld	r1,GPR1(r1)
+
+	/*
+	 * Handle machine check early in real mode. We come here with
+	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
+	 */
+EXC_COMMON_BEGIN(machine_check_handle_early)
+	std	r0,GPR0(r1)	/* Save r0 */
+	EXCEPTION_PROLOG_COMMON_3(0x200)
+	bl	save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_early
+	std	r3,RESULT(r1)	/* Save result */
+	ld	r12,_MSR(r1)
+#ifdef	CONFIG_PPC_P7_NAP
+	/*
+	 * Check if thread was in power saving mode. We come here when any
+	 * of the following is true:
+	 * a. thread wasn't in power saving mode
+	 * b. thread was in power saving mode with no state loss,
+	 *    supervisor state loss or hypervisor state loss.
+	 *
+	 * Go back to nap/sleep/winkle mode again if (b) is true.
+	 */
+	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
+	beq	4f			/* No, it wasn;t */
+	/* Thread was in power saving mode. Go back to nap again. */
+	cmpwi	r11,2
+	blt	3f
+	/* Supervisor/Hypervisor state loss */
+	li	r0,1
+	stb	r0,PACA_NAPSTATELOST(r13)
+3:	bl	machine_check_queue_event
+	MACHINE_CHECK_HANDLER_WINDUP
+	GET_PACA(r13)
+	ld	r1,PACAR1(r13)
+	/*
+	 * Check what idle state this CPU was in and go back to same mode
+	 * again.
+	 */
+	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi	r3,PNV_THREAD_NAP
+	bgt	10f
+	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	/* No return */
+10:
+	cmpwi	r3,PNV_THREAD_SLEEP
+	bgt	2f
+	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	/* No return */
+
+2:
+	/*
+	 * Go back to winkle. Please note that this thread was woken up in
+	 * machine check from winkle and have not restored the per-subcore
+	 * state. Hence before going back to winkle, set last bit of HSPGR0
+	 * to 1. This will make sure that if this thread gets woken up
+	 * again at reset vector 0x100 then it will get chance to restore
+	 * the subcore state.
+	 */
+	ori	r13,r13,1
+	SET_PACA(r13)
+	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	/* No return */
+4:
+#endif
+	/*
+	 * Check if we are coming from hypervisor userspace. If yes then we
+	 * continue in host kernel in V mode to deliver the MC event.
+	 */
+	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
+	beq	5f
+	andi.	r11,r12,MSR_PR		/* See if coming from user. */
+	bne	9f			/* continue in V mode if we are. */
+
+5:
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	/*
+	 * We are coming from kernel context. Check if we are coming from
+	 * guest. if yes, then we can continue. We will fall through
+	 * do_kvm_200->kvmppc_interrupt to deliver the MC event to guest.
+	 */
+	lbz	r11,HSTATE_IN_GUEST(r13)
+	cmpwi	r11,0			/* Check if coming from guest */
+	bne	9f			/* continue if we are. */
+#endif
+	/*
+	 * At this point we are not sure about what context we come from.
+	 * Queue up the MCE event and return from the interrupt.
+	 * But before that, check if this is an un-recoverable exception.
+	 * If yes, then stay on emergency stack and panic.
+	 */
+	andi.	r11,r12,MSR_RI
+	bne	2f
+1:	mfspr	r11,SPRN_SRR0
+	LOAD_HANDLER(r10,unrecover_mce)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	/*
+	 * We are going down. But there are chances that we might get hit by
+	 * another MCE during panic path and we may run into unstable state
+	 * with no way out. Hence, turn ME bit off while going down, so that
+	 * when another MCE is hit during panic path, system will checkstop
+	 * and hypervisor will get restarted cleanly by SP.
+	 */
+	li	r3,MSR_ME
+	andc	r10,r10,r3		/* Turn off MSR_ME */
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+2:
+	/*
+	 * Check if we have successfully handled/recovered from error, if not
+	 * then stay on emergency stack and panic.
+	 */
+	ld	r3,RESULT(r1)	/* Load result */
+	cmpdi	r3,0		/* see if we handled MCE successfully */
+
+	beq	1b		/* if !handled then panic */
+	/*
+	 * Return from MC interrupt.
+	 * Queue up the MCE event so that we can log it later, while
+	 * returning from kernel or opal call.
+	 */
+	bl	machine_check_queue_event
+	MACHINE_CHECK_HANDLER_WINDUP
+	rfid
+9:
+	/* Deliver the machine check to host kernel in V mode. */
+	MACHINE_CHECK_HANDLER_WINDUP
+	b	machine_check_pSeries
+
+EXC_COMMON_BEGIN(unrecover_mce)
+	/* Invoke machine_check_exception to print MCE event and panic. */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	/*
+	 * We will not reach here. Even if we did, there is no way out. Call
+	 * unrecoverable_exception and die.
+	 */
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	unrecoverable_exception
+	b	1b
+
 
 EXC_REAL(data_access, 0x300, 0x380)
 
@@ -388,140 +683,43 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
 	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
-	addi	r11,r11,-4		/* HSRR0 is next instruction */
-	bne+	denorm_assist
-#endif
-
-	KVMTEST_PR(0x1500)
-	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
-EXC_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
-
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
-
-#ifdef CONFIG_CBE_RAS
-EXC_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
-
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
-
-#else /* CONFIG_CBE_RAS */
-EXC_REAL_NONE(0x1600, 0x1700)
-#endif
-
-EXC_REAL(altivec_assist, 0x1700, 0x1800)
-
-TRAMP_KVM(PACA_EXGEN, 0x1700)
-
-#ifdef CONFIG_CBE_RAS
-EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
-
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
-
-#else /* CONFIG_CBE_RAS */
-EXC_REAL_NONE(0x1800, 0x1900)
-#endif
-
-
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
-TRAMP_REAL_BEGIN(machine_check_powernv_early)
-BEGIN_FTR_SECTION
-	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
-	/*
-	 * Register contents:
-	 * R13		= PACA
-	 * R9		= CR
-	 * Original R9 to R13 is saved on PACA_EXMC
-	 *
-	 * Switch to mc_emergency stack and handle re-entrancy (we limit
-	 * the nested MCE upto level 4 to avoid stack overflow).
-	 * Save MCE registers srr1, srr0, dar and dsisr and then set ME=1
-	 *
-	 * We use paca->in_mce to check whether this is the first entry or
-	 * nested machine check. We increment paca->in_mce to track nested
-	 * machine checks.
-	 *
-	 * If this is the first entry then set stack pointer to
-	 * paca->mc_emergency_sp, otherwise r1 is already pointing to
-	 * stack frame on mc_emergency stack.
-	 *
-	 * NOTE: We are here with MSR_ME=0 (off), which means we risk a
-	 * checkstop if we get another machine check exception before we do
-	 * rfid with MSR_ME=1.
-	 */
-	mr	r11,r1			/* Save r1 */
-	lhz	r10,PACA_IN_MCE(r13)
-	cmpwi	r10,0			/* Are we in nested machine check */
-	bne	0f			/* Yes, we are. */
-	/* First machine check entry */
-	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
-0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
-	addi	r10,r10,1		/* increment paca->in_mce */
-	sth	r10,PACA_IN_MCE(r13)
-	/* Limit nested MCE to level 4 to avoid stack overflow */
-	cmpwi	r10,4
-	bgt	2f			/* Check if we hit limit of 4 */
-	std	r11,GPR1(r1)		/* Save r1 on the stack. */
-	std	r11,0(r1)		/* make stack chain pointer */
-	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
-	std	r11,_NIP(r1)
-	mfspr	r11,SPRN_SRR1		/* Save SRR1 */
-	std	r11,_MSR(r1)
-	mfspr	r11,SPRN_DAR		/* Save DAR */
-	std	r11,_DAR(r1)
-	mfspr	r11,SPRN_DSISR		/* Save DSISR */
-	std	r11,_DSISR(r1)
-	std	r9,_CCR(r1)		/* Save CR in stackframe */
-	/* Save r9 through r13 from EXMC save area to stack frame. */
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
-	mfmsr	r11			/* get MSR value */
-	ori	r11,r11,MSR_ME		/* turn on ME bit */
-	ori	r11,r11,MSR_RI		/* turn on RI bit */
-	LOAD_HANDLER(r12, machine_check_handle_early)
-1:	mtspr	SPRN_SRR0,r12
-	mtspr	SPRN_SRR1,r11
-	rfid
-	b	.	/* prevent speculative execution */
-2:
-	/* Stack overflow. Stay on emergency stack and panic.
-	 * Keep the ME bit off while panic-ing, so that if we hit
-	 * another machine check we checkstop.
-	 */
-	addi	r1,r1,INT_FRAME_SIZE	/* go back to previous stack frame */
-	ld	r11,PACAKMSR(r13)
-	LOAD_HANDLER(r12, unrecover_mce)
-	li	r10,MSR_ME
-	andc	r11,r11,r10		/* Turn off MSR_ME */
-	b	1b
-	b	.	/* prevent speculative execution */
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
+	addi	r11,r11,-4		/* HSRR0 is next instruction */
+	bne+	denorm_assist
+#endif
 
-TRAMP_REAL_BEGIN(machine_check_pSeries)
-	.globl machine_check_fwnmi
-machine_check_fwnmi:
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
-machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
-	/*
-	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
-	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
-	 * used, so nested machine check corrupts it. machine_check_common
-	 * enables MSR_RI.
-	 */
-	ld	r10,PACAKMSR(r13)
-	xori	r10,r10,MSR_RI
-	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r12, machine_check_common)
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.	/* prevent speculative execution */
+	KVMTEST_PR(0x1500)
+	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
+EXC_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
 
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
 
-TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
+#ifdef CONFIG_CBE_RAS
+EXC_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
+
+#else /* CONFIG_CBE_RAS */
+EXC_REAL_NONE(0x1600, 0x1700)
+#endif
+
+EXC_REAL(altivec_assist, 0x1700, 0x1800)
+
+TRAMP_KVM(PACA_EXGEN, 0x1700)
+
+#ifdef CONFIG_CBE_RAS
+EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
+
+#else /* CONFIG_CBE_RAS */
+EXC_REAL_NONE(0x1800, 0x1900)
+#endif
+
+
+/*** Out of line interrupts support ***/
+
+	/* moved from 0x200 */
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 TRAMP_KVM(PACA_EXGEN, 0x400)
@@ -791,7 +989,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * only has extra guff for STAB-based processors -- which never
 	 * come here.
 	 */
-EXC_VIRT_NONE(0x4200, 0x4300)
 
 EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
 
@@ -971,30 +1168,6 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
-	/*
-	 * Machine check is different because we use a different
-	 * save area: PACA_EXMC instead of PACA_EXGEN.
-	 */
-EXC_COMMON_BEGIN(machine_check_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXMC+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXMC+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
-	FINISH_NAP
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3,PACA_EXMC+EX_DAR(r13)
-	lwz	r4,PACA_EXMC+EX_DSISR(r13)
-	/* Enable MSR_RI when finished with PACA_EXMC */
-	li	r10,MSR_RI
-	mtmsrd 	r10,1
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
-	b	ret_from_except
-
 EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -1195,180 +1368,6 @@ hmi_exception_after_realmode:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	tramp_real_hmi_exception
 
-
-#define MACHINE_CHECK_HANDLER_WINDUP			\
-	/* Clear MSR_RI before setting SRR0 and SRR1. */\
-	li	r0,MSR_RI;				\
-	mfmsr	r9;		/* get MSR value */	\
-	andc	r9,r9,r0;				\
-	mtmsrd	r9,1;		/* Clear MSR_RI */	\
-	/* Move original SRR0 and SRR1 into the respective regs */	\
-	ld	r9,_MSR(r1);				\
-	mtspr	SPRN_SRR1,r9;				\
-	ld	r3,_NIP(r1);				\
-	mtspr	SPRN_SRR0,r3;				\
-	ld	r9,_CTR(r1);				\
-	mtctr	r9;					\
-	ld	r9,_XER(r1);				\
-	mtxer	r9;					\
-	ld	r9,_LINK(r1);				\
-	mtlr	r9;					\
-	REST_GPR(0, r1);				\
-	REST_8GPRS(2, r1);				\
-	REST_GPR(10, r1);				\
-	ld	r11,_CCR(r1);				\
-	mtcr	r11;					\
-	/* Decrement paca->in_mce. */			\
-	lhz	r12,PACA_IN_MCE(r13);			\
-	subi	r12,r12,1;				\
-	sth	r12,PACA_IN_MCE(r13);			\
-	REST_GPR(11, r1);				\
-	REST_2GPRS(12, r1);				\
-	/* restore original r1. */			\
-	ld	r1,GPR1(r1)
-
-	/*
-	 * Handle machine check early in real mode. We come here with
-	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
-	 */
-EXC_COMMON_BEGIN(machine_check_handle_early)
-	std	r0,GPR0(r1)	/* Save r0 */
-	EXCEPTION_PROLOG_COMMON_3(0x200)
-	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_early
-	std	r3,RESULT(r1)	/* Save result */
-	ld	r12,_MSR(r1)
-#ifdef	CONFIG_PPC_P7_NAP
-	/*
-	 * Check if thread was in power saving mode. We come here when any
-	 * of the following is true:
-	 * a. thread wasn't in power saving mode
-	 * b. thread was in power saving mode with no state loss,
-	 *    supervisor state loss or hypervisor state loss.
-	 *
-	 * Go back to nap/sleep/winkle mode again if (b) is true.
-	 */
-	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
-	beq	4f			/* No, it wasn;t */
-	/* Thread was in power saving mode. Go back to nap again. */
-	cmpwi	r11,2
-	blt	3f
-	/* Supervisor/Hypervisor state loss */
-	li	r0,1
-	stb	r0,PACA_NAPSTATELOST(r13)
-3:	bl	machine_check_queue_event
-	MACHINE_CHECK_HANDLER_WINDUP
-	GET_PACA(r13)
-	ld	r1,PACAR1(r13)
-	/*
-	 * Check what idle state this CPU was in and go back to same mode
-	 * again.
-	 */
-	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi	r3,PNV_THREAD_NAP
-	bgt	10f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
-	/* No return */
-10:
-	cmpwi	r3,PNV_THREAD_SLEEP
-	bgt	2f
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
-	/* No return */
-
-2:
-	/*
-	 * Go back to winkle. Please note that this thread was woken up in
-	 * machine check from winkle and have not restored the per-subcore
-	 * state. Hence before going back to winkle, set last bit of HSPGR0
-	 * to 1. This will make sure that if this thread gets woken up
-	 * again at reset vector 0x100 then it will get chance to restore
-	 * the subcore state.
-	 */
-	ori	r13,r13,1
-	SET_PACA(r13)
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
-	/* No return */
-4:
-#endif
-	/*
-	 * Check if we are coming from hypervisor userspace. If yes then we
-	 * continue in host kernel in V mode to deliver the MC event.
-	 */
-	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
-	beq	5f
-	andi.	r11,r12,MSR_PR		/* See if coming from user. */
-	bne	9f			/* continue in V mode if we are. */
-
-5:
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-	/*
-	 * We are coming from kernel context. Check if we are coming from
-	 * guest. if yes, then we can continue. We will fall through
-	 * do_kvm_200->kvmppc_interrupt to deliver the MC event to guest.
-	 */
-	lbz	r11,HSTATE_IN_GUEST(r13)
-	cmpwi	r11,0			/* Check if coming from guest */
-	bne	9f			/* continue if we are. */
-#endif
-	/*
-	 * At this point we are not sure about what context we come from.
-	 * Queue up the MCE event and return from the interrupt.
-	 * But before that, check if this is an un-recoverable exception.
-	 * If yes, then stay on emergency stack and panic.
-	 */
-	andi.	r11,r12,MSR_RI
-	bne	2f
-1:	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r10,unrecover_mce)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	/*
-	 * We are going down. But there are chances that we might get hit by
-	 * another MCE during panic path and we may run into unstable state
-	 * with no way out. Hence, turn ME bit off while going down, so that
-	 * when another MCE is hit during panic path, system will checkstop
-	 * and hypervisor will get restarted cleanly by SP.
-	 */
-	li	r3,MSR_ME
-	andc	r10,r10,r3		/* Turn off MSR_ME */
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.
-2:
-	/*
-	 * Check if we have successfully handled/recovered from error, if not
-	 * then stay on emergency stack and panic.
-	 */
-	ld	r3,RESULT(r1)	/* Load result */
-	cmpdi	r3,0		/* see if we handled MCE successfully */
-
-	beq	1b		/* if !handled then panic */
-	/*
-	 * Return from MC interrupt.
-	 * Queue up the MCE event so that we can log it later, while
-	 * returning from kernel or opal call.
-	 */
-	bl	machine_check_queue_event
-	MACHINE_CHECK_HANDLER_WINDUP
-	rfid
-9:
-	/* Deliver the machine check to host kernel in V mode. */
-	MACHINE_CHECK_HANDLER_WINDUP
-	b	machine_check_pSeries
-
-EXC_COMMON_BEGIN(unrecover_mce)
-	/* Invoke machine_check_exception to print MCE event and panic. */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
-	/*
-	 * We will not reach here. Even if we did, there is no way out. Call
-	 * unrecoverable_exception and die.
-	 */
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-
 /*
  * r13 points to the PACA, r9 contains the saved CR,
  * r12 contain the saved SRR1, SRR0 is still ready for return
-- 
2.7.4
