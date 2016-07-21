Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw4651rKLzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:17 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so4672700pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:17 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 10/14] powerpc/pseries: move related exception code together
Date: Thu, 21 Jul 2016 16:44:09 +1000
Message-Id: <1469083453-9279-11-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is mostly juggling. Generated code should remain the same,
except for placement and offsets. We can do this now that code
gets moved into the correct section according to its type.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2005 ++++++++++++++++------------------
 1 file changed, 967 insertions(+), 1038 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9093521..7893af7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -64,6 +64,13 @@ OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x6000)
 OPEN_FIXED_SECTION(virt_trampolines,    0x6000, 0x7000)
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 OPEN_FIXED_SECTION(fwnmi_page,          0x7000, 0x8000)
+/*
+ * Data area reserved for FWNMI option.
+ * This address (0x7000) is fixed by the RPA.
+ * pseries and powernv need to keep the whole page from
+ * 0x7000 to 0x8000 free for use by the firmware
+ */
+FIXED_SECTION_ENTRY_ZERO(fwnmi_page, 0x7000, 0x8000)
 OPEN_TEXT_SECTION(0x8000)
 #else
 OPEN_TEXT_SECTION(0x7000)
@@ -72,60 +79,6 @@ OPEN_TEXT_SECTION(0x7000)
 USE_FIXED_SECTION(real_vectors)
 
 
-	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
-#define SYSCALL_PSERIES_1 					\
-BEGIN_FTR_SECTION						\
-	cmpdi	r0,0x1ebe ; 					\
-	beq-	1f ;						\
-END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
-	mr	r9,r13 ;					\
-	GET_PACA(r13) ;						\
-	mfspr	r11,SPRN_SRR0 ;					\
-0:
-
-#define SYSCALL_PSERIES_2_RFID 					\
-	mfspr	r12,SPRN_SRR1 ;					\
-	ld	r10,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER_4G(r10, system_call_common) ; 		\
-	mtspr	SPRN_SRR0,r10 ; 				\
-	ld	r10,PACAKMSR(r13) ;				\
-	mtspr	SPRN_SRR1,r10 ; 				\
-	rfid ; 							\
-	b	. ;	/* prevent speculative execution */
-
-#define SYSCALL_PSERIES_3					\
-	/* Fast LE/BE switch system call */			\
-1:	mfspr	r12,SPRN_SRR1 ;					\
-	xori	r12,r12,MSR_LE ;				\
-	mtspr	SPRN_SRR1,r12 ;					\
-	rfid ;		/* return to userspace */		\
-	b	. ;	/* prevent speculative execution */
-
-#if defined(CONFIG_RELOCATABLE)
-	/*
-	 * We can't branch directly so we do it via the CTR which
-	 * is volatile across system calls.
-	 */
-#define SYSCALL_PSERIES_2_DIRECT				\
-	mflr	r10 ;						\
-	ld	r12,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER_4G(r12, system_call_common) ;		\
-	mtctr	r12 ;						\
-	mfspr	r12,SPRN_SRR1 ;					\
-	/* Re-use of r13... No spare regs to do this */	\
-	li	r13,MSR_RI ;					\
-	mtmsrd 	r13,1 ;						\
-	GET_PACA(r13) ;	/* get r13 back */			\
-	bctr ;
-#else
-	/* We can branch directly */
-#define SYSCALL_PSERIES_2_DIRECT				\
-	mfspr	r12,SPRN_SRR1 ;					\
-	li	r10,MSR_RI ;					\
-	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
-	b	system_call_common ;
-#endif
-
 /*
  * This is the start of the interrupt handlers for pSeries
  * This code runs with relocation off.
@@ -199,6 +152,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
 VECTOR_HANDLER_REAL_END(system_reset, 0x100, 0x200)
+VECTOR_HANDLER_VIRT_NONE(0x4100, 0x4200)
+COMMON_HANDLER(system_reset_common, 0x100, system_reset_exception)
+
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * Vectors for the FWNMI option.  Share common code.
+ */
+TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 NOTEST, 0x100)
+TRAMP_HANDLER_END(system_reset_fwnmi)
+#endif /* CONFIG_PPC_PSERIES */
+
 
 VECTOR_HANDLER_REAL_BEGIN(machine_check, 0x200, 0x300)
 	/* This is moved out of line as it can be patched by FW, but
@@ -236,588 +203,320 @@ FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 VECTOR_HANDLER_REAL_END(machine_check, 0x200, 0x300)
+VECTOR_HANDLER_VIRT_NONE(0x4200, 0x4300)
 
-VECTOR_HANDLER_REAL(data_access, 0x300, 0x380)
-
-VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
+TRAMP_HANDLER_BEGIN(machine_check_powernv_early)
+BEGIN_FTR_SECTION
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
 	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
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
 	 */
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_REAL_END(data_access_slb, 0x380, 0x400)
-
-VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
-
-VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
-
-VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
-	.globl hardware_interrupt_hv;
-hardware_interrupt_hv:
-	BEGIN_FTR_SECTION
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
-					    EXC_HV, SOFTEN_TEST_HV)
-	FTR_SECTION_ELSE
-		_MASKABLE_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common),
-					    EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-VECTOR_HANDLER_REAL_END(hardware_interrupt, 0x500, 0x600)
-
-/*
- * Relon code jumps to these KVM handlers too so can't put them
- * in the feature sections.
- */
-TRAMP_KVM_HV(PACA_EXGEN, 0x500)
-TRAMP_KVM(PACA_EXGEN, 0x500)
-
-VECTOR_HANDLER_REAL(alignment, 0x600, 0x700)
-
-TRAMP_KVM(PACA_EXGEN, 0x600)
-
-VECTOR_HANDLER_REAL(program_check, 0x700, 0x800)
-
-TRAMP_KVM(PACA_EXGEN, 0x700)
-
-VECTOR_HANDLER_REAL(fp_unavailable, 0x800, 0x900)
-
-TRAMP_KVM(PACA_EXGEN, 0x800)
-
-__VECTOR_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900, 0x980)
-
-VECTOR_HANDLER_REAL_HV(hdecrementer, 0x980, 0xa00)
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
+	ld	r12,PACAKBASE(r13)	/* get high part of &label */
+	LOAD_HANDLER_4G(r12, machine_check_handle_early)
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
+	ld	r12,PACAKBASE(r13)
+	LOAD_HANDLER_4G(r12, unrecover_mce)
+	li	r10,MSR_ME
+	andc	r11,r11,r10		/* Turn off MSR_ME */
+	b	1b
+	b	.	/* prevent speculative execution */
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+TRAMP_HANDLER_END(machine_check_powernv_early)
 
-VECTOR_HANDLER_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
+TRAMP_HANDLER_BEGIN(machine_check_pSeries)
+	.globl machine_check_fwnmi
+machine_check_fwnmi:
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+machine_check_pSeries_0:
+	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
+	EXCEPTION_PROLOG_PSERIES_1(machine_check_common, EXC_STD)
+TRAMP_HANDLER_END(machine_check_pSeries)
 
-TRAMP_KVM(PACA_EXGEN, 0xa00)
+TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
-VECTOR_HANDLER_REAL(trap_0b, 0xb00, 0xc00)
+COMMON_HANDLER_BEGIN(machine_check_common)
+	/*
+	 * Machine check is different because we use a different
+	 * save area: PACA_EXMC instead of PACA_EXGEN.
+	 */
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
+	FINISH_NAP
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	b	ret_from_except
+COMMON_HANDLER_END(machine_check_common)
 
-TRAMP_KVM(PACA_EXGEN, 0xb00)
-
-VECTOR_HANDLER_REAL_BEGIN(system_call, 0xc00, 0xd00)
-	 /*
-	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
-	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
-	  * code to save that value into the guest state (it is the guest's PPR
-	  * value). Otherwise just change to HMT_MEDIUM as userspace has
-	  * already saved the PPR.
-	  */
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-	SET_SCRATCH0(r13)
-	GET_PACA(r13)
-	std	r9,PACA_EXGEN+EX_R9(r13)
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);
-	HMT_MEDIUM;
-	std	r10,PACA_EXGEN+EX_R10(r13)
-	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
-	mfcr	r9
-	KVMTEST_PR(0xc00)
-	GET_SCRATCH0(r13)
-#else
-	HMT_MEDIUM;
-#endif
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_RFID
-	SYSCALL_PSERIES_3
-VECTOR_HANDLER_REAL_END(system_call, 0xc00, 0xd00)
-
-TRAMP_KVM(PACA_EXGEN, 0xc00)
-
-VECTOR_HANDLER_REAL(single_step, 0xd00, 0xe00)
-
-TRAMP_KVM(PACA_EXGEN, 0xd00)
-
-
-	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
-	 * out of line to handle them
-	 */
-__VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-
-__VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-
-__VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
-
-__VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
-
-__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
-
-VECTOR_HANDLER_REAL_NONE(0xea0, 0xf00)
-
-__VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
-
-__VECTOR_HANDLER_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
-
-__VECTOR_HANDLER_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
-
-__VECTOR_HANDLER_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
-
-__VECTOR_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
-
-VECTOR_HANDLER_REAL_NONE(0xfa0, 0x1200)
-
-	
-
-#ifdef CONFIG_CBE_RAS
-VECTOR_HANDLER_REAL_HV(cbe_system_error, 0x1200, 0x1300)
-
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
-
-#else /* CONFIG_CBE_RAS */
-VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
-#endif
-
-VECTOR_HANDLER_REAL(instruction_breakpoint, 0x1300, 0x1400)
-
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
-
-VECTOR_HANDLER_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
-	mtspr	SPRN_SPRG_HSCRATCH0,r13
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
-
-#ifdef CONFIG_PPC_DENORMALISATION
-	mfspr	r10,SPRN_HSRR1
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
-	addi	r11,r11,-4		/* HSRR0 is next instruction */
-	bne+	denorm_assist
-#endif
-
-	KVMTEST_PR(0x1500)
-	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
-VECTOR_HANDLER_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
-
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
-
-#ifdef CONFIG_CBE_RAS
-VECTOR_HANDLER_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
-
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
-
-#else /* CONFIG_CBE_RAS */
-VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
-#endif
-
-VECTOR_HANDLER_REAL(altivec_assist, 0x1700, 0x1800)
-
-TRAMP_KVM(PACA_EXGEN, 0x1700)
-
-#ifdef CONFIG_CBE_RAS
-VECTOR_HANDLER_REAL_HV(cbe_thermal, 0x1800, 0x1900)
-
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
-
-#else /* CONFIG_CBE_RAS */
-VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
-#endif
-
-
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
-TRAMP_HANDLER_BEGIN(machine_check_powernv_early)
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
-	ld	r12,PACAKBASE(r13)	/* get high part of &label */
-	LOAD_HANDLER_4G(r12, machine_check_handle_early)
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
-	ld	r12,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r12, unrecover_mce)
-	li	r10,MSR_ME
-	andc	r11,r11,r10		/* Turn off MSR_ME */
-	b	1b
-	b	.	/* prevent speculative execution */
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-TRAMP_HANDLER_END(machine_check_powernv_early)
-
-TRAMP_HANDLER_BEGIN(machine_check_pSeries)
-	.globl machine_check_fwnmi
-machine_check_fwnmi:
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
-machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
-	EXCEPTION_PROLOG_PSERIES_1(machine_check_common, EXC_STD)
-TRAMP_HANDLER_END(machine_check_pSeries)
-
-TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
-TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
-TRAMP_KVM(PACA_EXGEN, 0x400)
-TRAMP_KVM(PACA_EXSLB, 0x480)
-TRAMP_KVM(PACA_EXGEN, 0x900)
-TRAMP_KVM_HV(PACA_EXGEN, 0x980)
-
-#ifdef CONFIG_PPC_DENORMALISATION
-COMMON_HANDLER_BEGIN(denorm_assist)
-BEGIN_FTR_SECTION
-/*
- * To denormalise we need to move a copy of the register to itself.
- * For POWER6 do that here for all FP regs.
- */
-	mfmsr	r10
-	ori	r10,r10,(MSR_FP|MSR_FE0|MSR_FE1)
-	xori	r10,r10,(MSR_FE0|MSR_FE1)
-	mtmsrd	r10
-	sync
-
-#define FMR2(n)  fmr (n), (n) ; fmr n+1, n+1
-#define FMR4(n)  FMR2(n) ; FMR2(n+2)
-#define FMR8(n)  FMR4(n) ; FMR4(n+4)
-#define FMR16(n) FMR8(n) ; FMR8(n+8)
-#define FMR32(n) FMR16(n) ; FMR16(n+16)
-	FMR32(0)
-
-FTR_SECTION_ELSE
-/*
- * To denormalise we need to move a copy of the register to itself.
- * For POWER7 do that here for the first 32 VSX registers only.
- */
-	mfmsr	r10
-	oris	r10,r10,MSR_VSX@h
-	mtmsrd	r10
-	sync
-
-#define XVCPSGNDP2(n) XVCPSGNDP(n,n,n) ; XVCPSGNDP(n+1,n+1,n+1)
-#define XVCPSGNDP4(n) XVCPSGNDP2(n) ; XVCPSGNDP2(n+2)
-#define XVCPSGNDP8(n) XVCPSGNDP4(n) ; XVCPSGNDP4(n+4)
-#define XVCPSGNDP16(n) XVCPSGNDP8(n) ; XVCPSGNDP8(n+8)
-#define XVCPSGNDP32(n) XVCPSGNDP16(n) ; XVCPSGNDP16(n+16)
-	XVCPSGNDP32(0)
-
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
-
-BEGIN_FTR_SECTION
-	b	denorm_done
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
-/*
- * To denormalise we need to move a copy of the register to itself.
- * For POWER8 we need to do that for all 64 VSX registers
- */
-	XVCPSGNDP32(32)
-denorm_done:
-	mtspr	SPRN_HSRR0,r11
-	mtcrf	0x80,r9
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	RESTORE_PPR_PACA(PACA_EXGEN, r10)
-BEGIN_FTR_SECTION
-	ld	r10,PACA_EXGEN+EX_CFAR(r13)
-	mtspr	SPRN_CFAR,r10
-END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	ld	r11,PACA_EXGEN+EX_R11(r13)
-	ld	r12,PACA_EXGEN+EX_R12(r13)
-	ld	r13,PACA_EXGEN+EX_R13(r13)
-	HRFID
-	b	.
-#endif
-COMMON_HANDLER_END(denorm_assist)
-
-	/* moved from 0x900 */
-__TRAMP_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900)
-
-	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
-
-__TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
-
-__TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
-
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
-
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
-
-	/* moved from 0xf00 */
-__TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
-TRAMP_KVM(PACA_EXGEN, 0xf00)
-
-__TRAMP_HANDLER_REAL_OOL(altivec_unavailable, 0xf20)
-TRAMP_KVM(PACA_EXGEN, 0xf20)
-
-__TRAMP_HANDLER_REAL_OOL(vsx_unavailable, 0xf40)
-TRAMP_KVM(PACA_EXGEN, 0xf40)
-
-__TRAMP_HANDLER_REAL_OOL(facility_unavailable, 0xf60)
-TRAMP_KVM(PACA_EXGEN, 0xf60)
-
-__TRAMP_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
-
-/*
- * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
- * - If it was a decrementer interrupt, we bump the dec to max and and return.
- * - If it was a doorbell we return immediately since doorbells are edge
- *   triggered and won't automatically refire.
- * - If it was a HMI we return immediately since we handled it in realmode
- *   and it won't refire.
- * - else we hard disable and return.
- * This is called with r10 containing the value to OR to the paca field.
- */
-#define MASKED_INTERRUPT(_H)				\
-masked_##_H##interrupt:					\
-	std	r11,PACA_EXGEN+EX_R11(r13);		\
-	lbz	r11,PACAIRQHAPPENED(r13);		\
-	or	r11,r11,r10;				\
-	stb	r11,PACAIRQHAPPENED(r13);		\
-	cmpwi	r10,PACA_IRQ_DEC;			\
-	bne	1f;					\
-	lis	r10,0x7fff;				\
-	ori	r10,r10,0xffff;				\
-	mtspr	SPRN_DEC,r10;				\
-	b	2f;					\
-1:	cmpwi	r10,PACA_IRQ_DBELL;			\
-	beq	2f;					\
-	cmpwi	r10,PACA_IRQ_HMI;			\
-	beq	2f;					\
-	mfspr	r10,SPRN_##_H##SRR1;			\
-	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
-	rotldi	r10,r10,16;				\
-	mtspr	SPRN_##_H##SRR1,r10;			\
-2:	mtcrf	0x80,r9;				\
-	ld	r9,PACA_EXGEN+EX_R9(r13);		\
-	ld	r10,PACA_EXGEN+EX_R10(r13);		\
-	ld	r11,PACA_EXGEN+EX_R11(r13);		\
-	GET_SCRATCH0(r13);				\
-	##_H##rfid;					\
-	b	.
-
-USE_FIXED_SECTION(real_trampolines)
-	MASKED_INTERRUPT()
-	MASKED_INTERRUPT(H)
-UNUSE_FIXED_SECTION(real_trampolines)
-
-/*
- * Called from arch_local_irq_enable when an interrupt needs
- * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
- * which kind of interrupt. MSR:EE is already off. We generate a
- * stackframe like if a real interrupt had happened.
- *
- * Note: While MSR:EE is off, we need to make sure that _MSR
- * in the generated frame has EE set to 1 or the exception
- * handler will not properly re-enable them.
- */
-COMMON_HANDLER_BEGIN(__replay_interrupt)
-	/* We are going to jump to the exception common code which
-	 * will retrieve various register values from the PACA which
-	 * we don't give a damn about, so we don't bother storing them.
-	 */
-	mfmsr	r12
-	mflr	r11
-	mfcr	r9
-	ori	r12,r12,MSR_EE
-	cmpwi	r3,0x900
-	beq	decrementer_common
-	cmpwi	r3,0x500
-	beq	hardware_interrupt_common
-BEGIN_FTR_SECTION
-	cmpwi	r3,0xe80
-	beq	h_doorbell_common
-FTR_SECTION_ELSE
-	cmpwi	r3,0xa00
-	beq	doorbell_super_common
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-	blr
-COMMON_HANDLER_END(__replay_interrupt)
-
-#ifdef CONFIG_PPC_PSERIES
-/*
- * Vectors for the FWNMI option.  Share common code.
- */
-TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
-				 NOTEST, 0x100)
-TRAMP_HANDLER_END(system_reset_fwnmi)
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
 
-#endif /* CONFIG_PPC_PSERIES */
+	/*
+	 * Handle machine check early in real mode. We come here with
+	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
+	 */
+COMMON_HANDLER_BEGIN(machine_check_handle_early)
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
+	 * b. thread was in power saving mode with no state loss or
+	 *    supervisor state loss
+	 *
+	 * Go back to nap again if (b) is true.
+	 */
+	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
+	beq	4f			/* No, it wasn;t */
+	/* Thread was in power saving mode. Go back to nap again. */
+	cmpwi	r11,2
+	bne	3f
+	/* Supervisor state loss */
+	li	r0,1
+	stb	r0,PACA_NAPSTATELOST(r13)
+3:	bl	machine_check_queue_event
+	MACHINE_CHECK_HANDLER_WINDUP
+	GET_PACA(r13)
+	ld	r1,PACAR1(r13)
+	li	r3,PNV_THREAD_NAP
+	b	power7_enter_nap_mode
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
 
+5:
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-TRAMP_HANDLER_BEGIN(kvmppc_skip_interrupt)
 	/*
-	 * Here all GPRs are unchanged from when the interrupt happened
-	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 * We are coming from kernel context. Check if we are coming from
+	 * guest. if yes, then we can continue. We will fall through
+	 * do_kvm_200->kvmppc_interrupt to deliver the MC event to guest.
 	 */
-	mfspr	r13, SPRN_SRR0
-	addi	r13, r13, 4
-	mtspr	SPRN_SRR0, r13
-	GET_SCRATCH0(r13)
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
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER_4G(r10,unrecover_mce)
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
 	rfid
 	b	.
-TRAMP_HANDLER_END(kvmppc_skip_interrupt)
-
-TRAMP_HANDLER_BEGIN(kvmppc_skip_Hinterrupt)
+2:
 	/*
-	 * Here all GPRs are unchanged from when the interrupt happened
-	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 * Check if we have successfully handled/recovered from error, if not
+	 * then stay on emergency stack and panic.
 	 */
-	mfspr	r13, SPRN_HSRR0
-	addi	r13, r13, 4
-	mtspr	SPRN_HSRR0, r13
-	GET_SCRATCH0(r13)
-	hrfid
-	b	.
-TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
-#endif
+	ld	r3,RESULT(r1)	/* Load result */
+	cmpdi	r3,0		/* see if we handled MCE successfully */
 
-/*
- * Ensure that any handlers that get invoked from the exception prologs
- * above are below the first 64KB (0x10000) of the kernel image because
- * the prologs assemble the addresses of these handlers using the
- * LOAD_HANDLER_4G macro, which uses an ori instruction. Care must also
- * be taken because relative branches can only address 32K in each direction.
- */
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
+COMMON_HANDLER_END(machine_check_handle_early)
 
-/*** Common interrupt handlers ***/
+COMMON_HANDLER_BEGIN(unrecover_mce)
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
+COMMON_HANDLER_END(unrecover_mce)
 
-COMMON_HANDLER(system_reset_common, 0x100, system_reset_exception)
-COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
-COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
-COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
-#ifdef CONFIG_PPC_DOORBELL
-COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
-#else
-COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
-#endif
-COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
-COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
-COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
-COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
-COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
-#ifdef CONFIG_PPC_DOORBELL
-COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
-#else
-COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
-#endif
-COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
-COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
-COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
-#ifdef CONFIG_ALTIVEC
-COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
-#else
-COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
-#endif
-#ifdef CONFIG_CBE_RAS
-COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
-COMMON_HANDLER(cbe_maintenance, 0x1600, cbe_maintenance_exception)
-COMMON_HANDLER(cbe_thermal, 0x1800, cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL(data_access, 0x300, 0x380)
+VECTOR_HANDLER_VIRT(data_access, 0x4300, 0x4380, 0x300)
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 
+COMMON_HANDLER_BEGIN(data_access_common)
 	/*
-	 * Relocation-on interrupts: A subset of the interrupts can be delivered
-	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
-	 * it.  Addresses are the same as the original interrupt addresses, but
-	 * offset by 0xc000000000004000.
-	 * It's impossible to receive interrupts below 0x300 via this mechanism.
-	 * KVM: None of these traps are from the guest ; anything that escalated
-	 * to HV=1 from HV=0 is delivered via real mode handlers.
+	 * Here r13 points to the paca, r9 contains the saved CR,
+	 * SRR0 and SRR1 are saved in r11 and r12,
+	 * r9 - r13 are saved in paca->exgen.
 	 */
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r12,_MSR(r1)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	li	r5,0x300
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
+	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+COMMON_HANDLER_END(data_access_common)
 
+
+VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_DAR
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
 	/*
-	 * This uses the standard macro, since the original 0x300 vector
-	 * only has extra guff for STAB-based processors -- which never
-	 * come here.
+	 * We can't just use a direct branch to slb_miss_realmode
+	 * because the distance from here to there depends on where
+	 * the kernel ends up being put.
 	 */
-VECTOR_HANDLER_VIRT_NONE(0x4100, 0x4200)
-VECTOR_HANDLER_VIRT_NONE(0x4200, 0x4300)
-
-VECTOR_HANDLER_VIRT(data_access, 0x4300, 0x4380, 0x300)
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+VECTOR_HANDLER_REAL_END(data_access_slb, 0x380, 0x400)
 
 VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	SET_SCRATCH0(r13)
@@ -841,9 +540,46 @@ VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	bctr
 #endif
 VECTOR_HANDLER_VIRT_END(data_access_slb, 0x4380, 0x4400)
+TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
+
+VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
 VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+TRAMP_KVM(PACA_EXGEN, 0x400)
+COMMON_HANDLER_BEGIN(instruction_access_common)
+	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r12,_MSR(r1)
+	ld	r3,_NIP(r1)
+	andis.	r4,r12,0x5820
+	li	r5,0x400
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
+	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+COMMON_HANDLER_END(instruction_access_common)
 
+
+VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER_4G(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
 VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
@@ -861,6 +597,91 @@ VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	bctr
 #endif
 VECTOR_HANDLER_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
+TRAMP_KVM(PACA_EXSLB, 0x480)
+
+
+TRAMP_HANDLER_BEGIN(slb_miss_realmode)
+	/*
+	 * r13 points to the PACA, r9 contains the saved CR,
+	 * r12 contain the saved SRR1, SRR0 is still ready for return
+	 * r3 has the faulting address
+	 * r9 - r13 are saved in paca->exslb.
+	 * r3 is saved in paca->slb_r3
+	 * We assume we aren't going to take any exceptions during this
+	 * procedure.
+	 */
+	mflr	r10
+#ifdef CONFIG_RELOCATABLE
+	mtctr	r11
+#endif
+
+	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
+	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
+
+#ifdef CONFIG_PPC_STD_MMU_64
+BEGIN_MMU_FTR_SECTION
+	bl	slb_allocate_realmode
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+#endif
+	/* All done -- return from exception. */
+
+	ld	r10,PACA_EXSLB+EX_LR(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
+
+	mtlr	r10
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
+	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+	beq-	2f
+
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
+
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	rfid
+	b	.	/* prevent speculative execution */
+
+2:	mfspr	r11,SPRN_SRR0
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER_4G(r10,unrecov_slb)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+TRAMP_HANDLER_END(slb_miss_realmode)
+
+COMMON_HANDLER_BEGIN(unrecov_slb)
+	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	bl	save_nvgprs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	unrecoverable_exception
+	b	1b
+COMMON_HANDLER_END(unrecov_slb)
+
+
+VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
+	.globl hardware_interrupt_hv;
+hardware_interrupt_hv:
+	BEGIN_FTR_SECTION
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+					    EXC_HV, SOFTEN_TEST_HV)
+	FTR_SECTION_ELSE
+		_MASKABLE_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common),
+					    EXC_STD, SOFTEN_TEST_PR)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+VECTOR_HANDLER_REAL_END(hardware_interrupt, 0x500, 0x600)
 
 VECTOR_HANDLER_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
 	.globl hardware_interrupt_relon_hv;
@@ -872,101 +693,210 @@ hardware_interrupt_relon_hv:
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 VECTOR_HANDLER_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
 
+TRAMP_KVM_HV(PACA_EXGEN, 0x500)
+TRAMP_KVM(PACA_EXGEN, 0x500)
+COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
+
+
+VECTOR_HANDLER_REAL(alignment, 0x600, 0x700)
 VECTOR_HANDLER_VIRT(alignment, 0x4600, 0x4700, 0x600)
-VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
-VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
-VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
-VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
-VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
-VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
+TRAMP_KVM(PACA_EXGEN, 0x600)
+COMMON_HANDLER_BEGIN(alignment_common)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	alignment_exception
+	b	ret_from_except
+COMMON_HANDLER_END(alignment_common)
 
-VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-	HMT_MEDIUM
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_DIRECT
-	SYSCALL_PSERIES_3
-VECTOR_HANDLER_VIRT_END(system_call, 0x4c00, 0x4d00)
 
-VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
+VECTOR_HANDLER_REAL(program_check, 0x700, 0x800)
+VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
+TRAMP_KVM(PACA_EXGEN, 0x700)
+COMMON_HANDLER_BEGIN(program_check_common)
+	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	program_check_exception
+	b	ret_from_except
+COMMON_HANDLER_END(program_check_common)
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
+VECTOR_HANDLER_REAL(fp_unavailable, 0x800, 0x900)
+VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
+TRAMP_KVM(PACA_EXGEN, 0x800)
+COMMON_HANDLER_BEGIN(fp_unavailable_common)
+	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
+	bne	1f			/* if from user, just load it up */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	kernel_fp_unavailable_exception
+	BUG_OPCODE
+1:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
+	 * transaction), go do TM stuff
+	 */
+	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
+	bne-	2f
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
+#endif
+	bl	load_up_fpu
+	b	fast_exception_return
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	fp_unavailable_tm
+	b	ret_from_except
+#endif
+COMMON_HANDLER_END(fp_unavailable_common)
 
-__VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
+__VECTOR_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900, 0x980)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900)
+VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
+TRAMP_KVM(PACA_EXGEN, 0x900)
+COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
 
-__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
 
-VECTOR_HANDLER_VIRT_NONE(0x4ea0, 0x4f00)
+VECTOR_HANDLER_REAL_HV(hdecrementer, 0x980, 0xa00)
+VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
+TRAMP_KVM_HV(PACA_EXGEN, 0x980)
+COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
-__VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
 
-__VECTOR_HANDLER_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
+VECTOR_HANDLER_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
+VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
+TRAMP_KVM(PACA_EXGEN, 0xa00)
+#ifdef CONFIG_PPC_DOORBELL
+COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
+#else
+COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
+#endif
 
-__VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
 
-__VECTOR_HANDLER_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
+VECTOR_HANDLER_REAL(trap_0b, 0xb00, 0xc00)
+VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
+COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
+TRAMP_KVM(PACA_EXGEN, 0xb00)
 
-__VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
 
-VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
+/* Syscall routine is used twice, in reloc-off and reloc-on paths */
+#define SYSCALL_PSERIES_1 					\
+BEGIN_FTR_SECTION						\
+	cmpdi	r0,0x1ebe ; 					\
+	beq-	1f ;						\
+END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
+	mr	r9,r13 ;					\
+	GET_PACA(r13) ;						\
+	mfspr	r11,SPRN_SRR0 ;					\
+0:
 
-VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
+#define SYSCALL_PSERIES_2_RFID 					\
+	mfspr	r12,SPRN_SRR1 ;					\
+	ld	r10,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER_4G(r10, system_call_common) ; 		\
+	mtspr	SPRN_SRR0,r10 ; 				\
+	ld	r10,PACAKMSR(r13) ;				\
+	mtspr	SPRN_SRR1,r10 ; 				\
+	rfid ; 							\
+	b	. ;	/* prevent speculative execution */
 
-VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
+#define SYSCALL_PSERIES_3					\
+	/* Fast LE/BE switch system call */			\
+1:	mfspr	r12,SPRN_SRR1 ;					\
+	xori	r12,r12,MSR_LE ;				\
+	mtspr	SPRN_SRR1,r12 ;					\
+	rfid ;		/* return to userspace */		\
+	b	. ;	/* prevent speculative execution */
 
-#ifdef CONFIG_PPC_DENORMALISATION
-VECTOR_HANDLER_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
-	b	exc_0x1500_denorm_exception_hv
-VECTOR_HANDLER_VIRT_END(denorm_exception, 0x5500, 0x5600)
+#if defined(CONFIG_RELOCATABLE)
+	/*
+	 * We can't branch directly so we do it via the CTR which
+	 * is volatile across system calls.
+	 */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mflr	r10 ;						\
+	ld	r12,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER_4G(r12, system_call_common) ;		\
+	mtctr	r12 ;						\
+	mfspr	r12,SPRN_SRR1 ;					\
+	/* Re-use of r13... No spare regs to do this */	\
+	li	r13,MSR_RI ;					\
+	mtmsrd 	r13,1 ;						\
+	GET_PACA(r13) ;	/* get r13 back */			\
+	bctr ;
+#else
+	/* We can branch directly */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mfspr	r12,SPRN_SRR1 ;					\
+	li	r10,MSR_RI ;					\
+	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
+	b	system_call_common ;
+#endif
+
+VECTOR_HANDLER_REAL_BEGIN(system_call, 0xc00, 0xd00)
+	 /*
+	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
+	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
+	  * code to save that value into the guest state (it is the guest's PPR
+	  * value). Otherwise just change to HMT_MEDIUM as userspace has
+	  * already saved the PPR.
+	  */
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	SET_SCRATCH0(r13)
+	GET_PACA(r13)
+	std	r9,PACA_EXGEN+EX_R9(r13)
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);
+	HMT_MEDIUM;
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
+	mfcr	r9
+	KVMTEST_PR(0xc00)
+	GET_SCRATCH0(r13)
 #else
-VECTOR_HANDLER_VIRT_NONE(0x5500, 0x5600)
+	HMT_MEDIUM;
 #endif
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_RFID
+	SYSCALL_PSERIES_3
+VECTOR_HANDLER_REAL_END(system_call, 0xc00, 0xd00)
 
-VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
-
-VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
-
-VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
+VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
+	HMT_MEDIUM
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_DIRECT
+	SYSCALL_PSERIES_3
+VECTOR_HANDLER_VIRT_END(system_call, 0x4c00, 0x4d00)
 
+TRAMP_KVM(PACA_EXGEN, 0xc00)
 
-TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
-	b	__ppc64_runlatch_on
-TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-/*
- * Here r13 points to the paca, r9 contains the saved CR,
- * SRR0 and SRR1 are saved in r11 and r12,
- * r9 - r13 are saved in paca->exgen.
- */
-COMMON_HANDLER_BEGIN(data_access_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	li	r5,0x300
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-BEGIN_MMU_FTR_SECTION
-	b	do_hash_page		/* Try to handle as hpte fault */
-MMU_FTR_SECTION_ELSE
-	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
-COMMON_HANDLER_END(data_access_common)
+VECTOR_HANDLER_REAL(single_step, 0xd00, 0xe00)
+VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
+TRAMP_KVM(PACA_EXGEN, 0xd00)
+COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
+__VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
+__TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
@@ -979,103 +909,113 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
 	bl      unknown_exception
 	b       ret_from_except
 COMMON_HANDLER_END(h_data_storage_common)
+COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 
-COMMON_HANDLER_BEGIN(instruction_access_common)
-	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,_NIP(r1)
-	andis.	r4,r12,0x5820
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-BEGIN_MMU_FTR_SECTION
-	b	do_hash_page		/* Try to handle as hpte fault */
-MMU_FTR_SECTION_ELSE
-	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
-COMMON_HANDLER_END(instruction_access_common)
 
+__VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
+__TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
-	/*
-	 * Machine check is different because we use a different
-	 * save area: PACA_EXMC instead of PACA_EXGEN.
-	 */
-COMMON_HANDLER_BEGIN(machine_check_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
-	FINISH_NAP
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	machine_check_exception
-	b	ret_from_except
-COMMON_HANDLER_END(machine_check_common)
 
-COMMON_HANDLER_BEGIN(alignment_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	alignment_exception
-	b	ret_from_except
-COMMON_HANDLER_END(alignment_common)
+__VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
+__TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
+__VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
+__TRAMP_HANDLER_VIRT_OOL_HV(emulation_assist, 0xe40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
+COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
-COMMON_HANDLER_BEGIN(program_check_common)
-	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	program_check_exception
-	b	ret_from_except
-COMMON_HANDLER_END(program_check_common)
 
-COMMON_HANDLER_BEGIN(fp_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
-	bne	1f			/* if from user, just load it up */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
+__VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
+COMMON_HANDLER_BEGIN(hmi_exception_early)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
+	mr	r10,r1			/* Save r1			*/
+	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
+	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
+	std	r9,_CCR(r1)		/* save CR in stackframe	*/
+	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
+	std	r11,_NIP(r1)		/* save HSRR0 in stackframe	*/
+	mfspr	r12,SPRN_HSRR1		/* Save SRR1 */
+	std	r12,_MSR(r1)		/* save SRR1 in stackframe	*/
+	std	r10,0(r1)		/* make stack chain pointer	*/
+	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
+	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
+	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
+	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	kernel_fp_unavailable_exception
-	BUG_OPCODE
-1:
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-BEGIN_FTR_SECTION
-	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
-	 * transaction), go do TM stuff
+	bl	hmi_exception_realmode
+	/* Windup the stack. */
+	/* Move original HSRR0 and HSRR1 into the respective regs */
+	ld	r9,_MSR(r1)
+	mtspr	SPRN_HSRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_HSRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+
+	/*
+	 * Go to virtual mode and pull the HMI event information from
+	 * firmware.
 	 */
-	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
-	bne-	2f
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
-#endif
-	bl	load_up_fpu
-	b	fast_exception_return
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-2:	/* User process was in a transaction */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	fp_unavailable_tm
-	b	ret_from_except
+	.globl hmi_exception_after_realmode
+hmi_exception_after_realmode:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	tramp_real_hmi_exception
+COMMON_HANDLER_END(hmi_exception_early)
+COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
+
+
+__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
+__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
+#ifdef CONFIG_PPC_DOORBELL
+COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
+#else
+COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
-COMMON_HANDLER_END(fp_unavailable_common)
 
+
+VECTOR_HANDLER_REAL_NONE(0xea0, 0xf00)
+VECTOR_HANDLER_VIRT_NONE(0x4ea0, 0x4f00)
+
+
+__VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
+__TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
+__VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
+__TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
+TRAMP_KVM(PACA_EXGEN, 0xf00)
+COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
+
+
+__VECTOR_HANDLER_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
+__TRAMP_HANDLER_REAL_OOL(altivec_unavailable, 0xf20)
+__VECTOR_HANDLER_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
+__TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
+TRAMP_KVM(PACA_EXGEN, 0xf20)
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
@@ -1110,6 +1050,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 COMMON_HANDLER_END(altivec_unavailable_common)
 
+
+
+__VECTOR_HANDLER_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+__TRAMP_HANDLER_REAL_OOL(vsx_unavailable, 0xf40)
+__VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
+__TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
+TRAMP_KVM(PACA_EXGEN, 0xf40)
 COMMON_HANDLER_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
@@ -1143,309 +1090,291 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 COMMON_HANDLER_END(vsx_unavailable_common)
 
-COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
-COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL_HV(emulation_assist, 0xe40)
-__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-__TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
-__TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
-__TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
+__VECTOR_HANDLER_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
+__TRAMP_HANDLER_REAL_OOL(facility_unavailable, 0xf60)
+__VECTOR_HANDLER_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
 __TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
+TRAMP_KVM(PACA_EXGEN, 0xf60)
+COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
+
+
+__VECTOR_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+__TRAMP_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80)
+__VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
 __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
+COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
-USE_FIXED_SECTION(virt_trampolines)
-	/*
-	 * The __end_interrupts marker must be past the out-of-line (OOL)
-	 * handlers, so that they are copied to real address 0x100 when running
-	 * a relocatable kernel. This ensures they can be reached from the short
-	 * trampoline handlers (like 0x4f00, 0x4f20, etc.) which branch
-	 * directly, without using LOAD_HANDLER_4G().
-	 */
-	.align	7
-	.globl	__end_interrupts
-__end_interrupts:
-UNUSE_FIXED_SECTION(virt_trampolines)
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
-/*
- * Data area reserved for FWNMI option.
- * This address (0x7000) is fixed by the RPA.
- * pseries and powernv need to keep the whole page from
- * 0x7000 to 0x8000 free for use by the firmware
- */
-FIXED_SECTION_ENTRY_ZERO(fwnmi_page, 0x7000, 0x8000)
-#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+VECTOR_HANDLER_REAL_NONE(0xfa0, 0x1200)
+VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
 
-COMMON_HANDLER_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
-	mr	r10,r1			/* Save r1			*/
-	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
-	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
-	std	r9,_CCR(r1)		/* save CR in stackframe	*/
-	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	std	r11,_NIP(r1)		/* save HSRR0 in stackframe	*/
-	mfspr	r12,SPRN_HSRR1		/* Save SRR1 */
-	std	r12,_MSR(r1)		/* save SRR1 in stackframe	*/
-	std	r10,0(r1)		/* make stack chain pointer	*/
-	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
-	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
-	EXCEPTION_PROLOG_COMMON_3(0xe60)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	hmi_exception_realmode
-	/* Windup the stack. */
-	/* Move original HSRR0 and HSRR1 into the respective regs */
-	ld	r9,_MSR(r1)
-	mtspr	SPRN_HSRR1,r9
-	ld	r3,_NIP(r1)
-	mtspr	SPRN_HSRR0,r3
-	ld	r9,_CTR(r1)
-	mtctr	r9
-	ld	r9,_XER(r1)
-	mtxer	r9
-	ld	r9,_LINK(r1)
-	mtlr	r9
-	REST_GPR(0, r1)
-	REST_8GPRS(2, r1)
-	REST_GPR(10, r1)
-	ld	r11,_CCR(r1)
-	mtcr	r11
-	REST_GPR(11, r1)
-	REST_2GPRS(12, r1)
-	/* restore original r1. */
-	ld	r1,GPR1(r1)
+	
+#ifdef CONFIG_CBE_RAS
+VECTOR_HANDLER_REAL_HV(cbe_system_error, 0x1200, 0x1300)
+VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
+COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 
-	/*
-	 * Go to virtual mode and pull the HMI event information from
-	 * firmware.
-	 */
-	.globl hmi_exception_after_realmode
-hmi_exception_after_realmode:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	tramp_real_hmi_exception
-COMMON_HANDLER_END(hmi_exception_early)
+#else /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
+#endif
 
 
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
+VECTOR_HANDLER_REAL(instruction_breakpoint, 0x1300, 0x1400)
+VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
+COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 
-	/*
-	 * Handle machine check early in real mode. We come here with
-	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
-	 */
-COMMON_HANDLER_BEGIN(machine_check_handle_early)
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
-	 * b. thread was in power saving mode with no state loss or
-	 *    supervisor state loss
-	 *
-	 * Go back to nap again if (b) is true.
-	 */
-	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
-	beq	4f			/* No, it wasn;t */
-	/* Thread was in power saving mode. Go back to nap again. */
-	cmpwi	r11,2
-	bne	3f
-	/* Supervisor state loss */
-	li	r0,1
-	stb	r0,PACA_NAPSTATELOST(r13)
-3:	bl	machine_check_queue_event
-	MACHINE_CHECK_HANDLER_WINDUP
-	GET_PACA(r13)
-	ld	r1,PACAR1(r13)
-	li	r3,PNV_THREAD_NAP
-	b	power7_enter_nap_mode
-4:
+
+VECTOR_HANDLER_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
+	mtspr	SPRN_SPRG_HSCRATCH0,r13
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
+
+#ifdef CONFIG_PPC_DENORMALISATION
+	mfspr	r10,SPRN_HSRR1
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
+	addi	r11,r11,-4		/* HSRR0 is next instruction */
+	bne+	denorm_assist
 #endif
-	/*
-	 * Check if we are coming from hypervisor userspace. If yes then we
-	 * continue in host kernel in V mode to deliver the MC event.
-	 */
-	rldicl.	r11,r12,4,63		/* See if MC hit while in HV mode. */
-	beq	5f
-	andi.	r11,r12,MSR_PR		/* See if coming from user. */
-	bne	9f			/* continue in V mode if we are. */
 
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
+	KVMTEST_PR(0x1500)
+	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
+VECTOR_HANDLER_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
+
+#ifdef CONFIG_PPC_DENORMALISATION
+VECTOR_HANDLER_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
+	b	exc_0x1500_denorm_exception_hv
+VECTOR_HANDLER_VIRT_END(denorm_exception, 0x5500, 0x5600)
+#else
+VECTOR_HANDLER_VIRT_NONE(0x5500, 0x5600)
 #endif
-	/*
-	 * At this point we are not sure about what context we come from.
-	 * Queue up the MCE event and return from the interrupt.
-	 * But before that, check if this is an un-recoverable exception.
-	 * If yes, then stay on emergency stack and panic.
-	 */
-	andi.	r11,r12,MSR_RI
-	bne	2f
-1:	mfspr	r11,SPRN_SRR0
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10,unrecover_mce)
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
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
+
+#ifdef CONFIG_PPC_DENORMALISATION
+TRAMP_HANDLER_BEGIN(denorm_assist)
+BEGIN_FTR_SECTION
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER6 do that here for all FP regs.
+ */
+	mfmsr	r10
+	ori	r10,r10,(MSR_FP|MSR_FE0|MSR_FE1)
+	xori	r10,r10,(MSR_FE0|MSR_FE1)
+	mtmsrd	r10
+	sync
+
+#define FMR2(n)  fmr (n), (n) ; fmr n+1, n+1
+#define FMR4(n)  FMR2(n) ; FMR2(n+2)
+#define FMR8(n)  FMR4(n) ; FMR4(n+4)
+#define FMR16(n) FMR8(n) ; FMR8(n+8)
+#define FMR32(n) FMR16(n) ; FMR16(n+16)
+	FMR32(0)
+
+FTR_SECTION_ELSE
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER7 do that here for the first 32 VSX registers only.
+ */
+	mfmsr	r10
+	oris	r10,r10,MSR_VSX@h
+	mtmsrd	r10
+	sync
 
-unrecover_mce:
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
-COMMON_HANDLER_END(machine_check_handle_early)
+#define XVCPSGNDP2(n) XVCPSGNDP(n,n,n) ; XVCPSGNDP(n+1,n+1,n+1)
+#define XVCPSGNDP4(n) XVCPSGNDP2(n) ; XVCPSGNDP2(n+2)
+#define XVCPSGNDP8(n) XVCPSGNDP4(n) ; XVCPSGNDP4(n+4)
+#define XVCPSGNDP16(n) XVCPSGNDP8(n) ; XVCPSGNDP8(n+8)
+#define XVCPSGNDP32(n) XVCPSGNDP16(n) ; XVCPSGNDP16(n+16)
+	XVCPSGNDP32(0)
+
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 
+BEGIN_FTR_SECTION
+	b	denorm_done
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 /*
- * r13 points to the PACA, r9 contains the saved CR,
- * r12 contain the saved SRR1, SRR0 is still ready for return
- * r3 has the faulting address
- * r9 - r13 are saved in paca->exslb.
- * r3 is saved in paca->slb_r3
- * We assume we aren't going to take any exceptions during this procedure.
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER8 we need to do that for all 64 VSX registers
  */
-COMMON_HANDLER_BEGIN(slb_miss_realmode)
-	mflr	r10
-#ifdef CONFIG_RELOCATABLE
-	mtctr	r11
+	XVCPSGNDP32(32)
+denorm_done:
+	mtspr	SPRN_HSRR0,r11
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	RESTORE_PPR_PACA(PACA_EXGEN, r10)
+BEGIN_FTR_SECTION
+	ld	r10,PACA_EXGEN+EX_CFAR(r13)
+	mtspr	SPRN_CFAR,r10
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r13,PACA_EXGEN+EX_R13(r13)
+	HRFID
+	b	.
 #endif
+TRAMP_HANDLER_END(denorm_assist)
 
-	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
+COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
 
-#ifdef CONFIG_PPC_STD_MMU_64
-BEGIN_MMU_FTR_SECTION
-	bl	slb_allocate_realmode
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+
+#ifdef CONFIG_CBE_RAS
+VECTOR_HANDLER_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
+VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
+COMMON_HANDLER(cbe_maintenance, 0x1600, cbe_maintenance_exception)
+
+#else /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
 #endif
-	/* All done -- return from exception. */
 
-	ld	r10,PACA_EXSLB+EX_LR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
-	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 
-	mtlr	r10
-BEGIN_MMU_FTR_SECTION
-	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
-	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-	beq-	2f
+VECTOR_HANDLER_REAL(altivec_assist, 0x1700, 0x1800)
+VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
+TRAMP_KVM(PACA_EXGEN, 0x1700)
+#ifdef CONFIG_ALTIVEC
+COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
+#else
+COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
+#endif
 
-.machine	push
-.machine	"power4"
-	mtcrf	0x80,r9
-	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-.machine	pop
 
-	RESTORE_PPR_PACA(PACA_EXSLB, r9)
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	ld	r11,PACA_EXSLB+EX_R11(r13)
-	ld	r12,PACA_EXSLB+EX_R12(r13)
-	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
-	b	.	/* prevent speculative execution */
+#ifdef CONFIG_CBE_RAS
+VECTOR_HANDLER_REAL_HV(cbe_thermal, 0x1800, 0x1900)
+VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
+COMMON_HANDLER(cbe_thermal, 0x1800, cbe_thermal_exception)
 
-2:	mfspr	r11,SPRN_SRR0
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10,unrecov_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
+#else /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
+#endif
+
+
+/*
+ * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
+ * - If it was a decrementer interrupt, we bump the dec to max and and return.
+ * - If it was a doorbell we return immediately since doorbells are edge
+ *   triggered and won't automatically refire.
+ * - If it was a HMI we return immediately since we handled it in realmode
+ *   and it won't refire.
+ * - else we hard disable and return.
+ * This is called with r10 containing the value to OR to the paca field.
+ */
+#define MASKED_INTERRUPT(_H)				\
+masked_##_H##interrupt:					\
+	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	lbz	r11,PACAIRQHAPPENED(r13);		\
+	or	r11,r11,r10;				\
+	stb	r11,PACAIRQHAPPENED(r13);		\
+	cmpwi	r10,PACA_IRQ_DEC;			\
+	bne	1f;					\
+	lis	r10,0x7fff;				\
+	ori	r10,r10,0xffff;				\
+	mtspr	SPRN_DEC,r10;				\
+	b	2f;					\
+1:	cmpwi	r10,PACA_IRQ_DBELL;			\
+	beq	2f;					\
+	cmpwi	r10,PACA_IRQ_HMI;			\
+	beq	2f;					\
+	mfspr	r10,SPRN_##_H##SRR1;			\
+	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
+	rotldi	r10,r10,16;				\
+	mtspr	SPRN_##_H##SRR1,r10;			\
+2:	mtcrf	0x80,r9;				\
+	ld	r9,PACA_EXGEN+EX_R9(r13);		\
+	ld	r10,PACA_EXGEN+EX_R10(r13);		\
+	ld	r11,PACA_EXGEN+EX_R11(r13);		\
+	GET_SCRATCH0(r13);				\
+	##_H##rfid;					\
+	b	.
+
+USE_FIXED_SECTION(real_trampolines)
+	MASKED_INTERRUPT()
+	MASKED_INTERRUPT(H)
+UNUSE_FIXED_SECTION(real_trampolines)
+
+/*
+ * Called from arch_local_irq_enable when an interrupt needs
+ * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
+ * which kind of interrupt. MSR:EE is already off. We generate a
+ * stackframe like if a real interrupt had happened.
+ *
+ * Note: While MSR:EE is off, we need to make sure that _MSR
+ * in the generated frame has EE set to 1 or the exception
+ * handler will not properly re-enable them.
+ */
+COMMON_HANDLER_BEGIN(__replay_interrupt)
+	/* We are going to jump to the exception common code which
+	 * will retrieve various register values from the PACA which
+	 * we don't give a damn about, so we don't bother storing them.
+	 */
+	mfmsr	r12
+	mflr	r11
+	mfcr	r9
+	ori	r12,r12,MSR_EE
+	cmpwi	r3,0x900
+	beq	decrementer_common
+	cmpwi	r3,0x500
+	beq	hardware_interrupt_common
+BEGIN_FTR_SECTION
+	cmpwi	r3,0xe80
+	beq	h_doorbell_common
+FTR_SECTION_ELSE
+	cmpwi	r3,0xa00
+	beq	doorbell_super_common
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	blr
+COMMON_HANDLER_END(__replay_interrupt)
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+TRAMP_HANDLER_BEGIN(kvmppc_skip_interrupt)
+	/*
+	 * Here all GPRs are unchanged from when the interrupt happened
+	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 */
+	mfspr	r13, SPRN_SRR0
+	addi	r13, r13, 4
+	mtspr	SPRN_SRR0, r13
+	GET_SCRATCH0(r13)
 	rfid
 	b	.
+TRAMP_HANDLER_END(kvmppc_skip_interrupt)
 
-unrecov_slb:
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
-	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-COMMON_HANDLER_END(slb_miss_realmode)
+TRAMP_HANDLER_BEGIN(kvmppc_skip_Hinterrupt)
+	/*
+	 * Here all GPRs are unchanged from when the interrupt happened
+	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 */
+	mfspr	r13, SPRN_HSRR0
+	addi	r13, r13, 4
+	mtspr	SPRN_HSRR0, r13
+	GET_SCRATCH0(r13)
+	hrfid
+	b	.
+TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
+#endif
 
+TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
+	b	__ppc64_runlatch_on
+TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
+
+USE_FIXED_SECTION(virt_trampolines)
+	/*
+	 * The __end_interrupts marker must be past the out-of-line (OOL)
+	 * handlers, so that they are copied to real address 0x100 when running
+	 * a relocatable kernel. This ensures they can be reached from the short
+	 * trampoline handlers (like 0x4f00, 0x4f20, etc.) which branch
+	 * directly, without using LOAD_HANDLER_4G().
+	 */
+	.align	7
+	.globl	__end_interrupts
+__end_interrupts:
+UNUSE_FIXED_SECTION(virt_trampolines)
 
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_HANDLER_BEGIN(power4_fixup_nap)
-- 
2.8.1
