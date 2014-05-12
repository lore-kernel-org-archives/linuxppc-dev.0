Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CDB014007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 15:57:41 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s4C5vZvX029122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 00:57:36 -0500
Message-ID: <1399874254.17624.85.camel@pasglop>
Subject: [PATCH] powerpc/ppc64: Allow allmodconfig to build (finally !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 12 May 2014 15:57:34 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This shuffles code around in exceptions-64s.S in order to
allow an allmodconfig build to succeed.

The main problems were:

 - We have a fixed hole from 0x7000 to 0x8000 for use by FW,
under some circumstances the code before that would grow too
big and hit the . = 0x7000

 - The various attempts at making space in there would trigger
cases where short conditional branches from assembly would no
longer be able to reach their target. This is especially nasty
when these branches reside in alternate feature sections which
are appended at the end of each .o file

This fixes it by essentially moving all the "second level"
exception handlers to after the hole and moving a couple of
functions near the hole itself so they sit at reachable distance
of both the first level handlers (before the hole) and the alternate
feature sections (end of file).

In the long run, if we start hitting this again, we'll probably
have to split the file in two, probably at the hole location,
to keep the alt sections used by the first level handlers close
to them, and move everything else further away.

But for now, this will do.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3afd391..833a68d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -533,70 +533,6 @@ do_stab_bolted_pSeries:
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x900)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
 
-#ifdef CONFIG_PPC_DENORMALISATION
-denorm_assist:
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
-
 	.align	7
 	/* moved from 0xe00 */
 	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
@@ -623,43 +559,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
 
 /*
- * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
- * - If it was a decrementer interrupt, we bump the dec to max and and return.
- * - If it was a doorbell we return immediately since doorbells are edge
- *   triggered and won't automatically refire.
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
-	MASKED_INTERRUPT()
-	MASKED_INTERRUPT(H)
-
-/*
  * Called from arch_local_irq_enable when an interrupt needs
  * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
  * which kind of interrupt. MSR:EE is already off. We generate a
@@ -759,50 +658,6 @@ kvmppc_skip_Hinterrupt:
 	b	.
 #endif
 
-/*
- * Code from here down to __end_handlers is invoked from the
- * exception prologs above.  Because the prologs assemble the
- * addresses of these handlers using the LOAD_HANDLER macro,
- * which uses an ori instruction, these handlers must be in
- * the first 64k of the kernel image.
- */
-
-/*** Common interrupt handlers ***/
-
-	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
-
-	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
-	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
-	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
-#ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .doorbell_exception)
-#else
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .unknown_exception)
-#endif
-	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
-	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .emulation_assist_interrupt)
-	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
-#ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .doorbell_exception)
-#else
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .unknown_exception)
-#endif
-	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
-	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
-	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
-#ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
-#else
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .unknown_exception)
-#endif
-#ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, .cbe_system_error_exception)
-	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, .cbe_maintenance_exception)
-	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, .cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
-
 	/*
 	 * Relocation-on interrupts: A subset of the interrupts can be delivered
 	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
@@ -949,6 +804,17 @@ hv_facility_unavailable_relon_trampoline:
 #endif
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
+	/* Equivalents to the above handlers for relocation-on interrupt vectors */
+	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
+
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
+	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
+
+
 	/* Other future vectors */
 	.align	7
 	.globl	__end_interrupts
@@ -1028,11 +894,183 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	bl	.kernel_bad_stack
 	b	1b
 
+
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
- * Here r13 points to the paca, r9 contains the saved CR,
- * SRR0 and SRR1 are saved in r11 and r12,
- * r9 - r13 are saved in paca->exgen.
+ * Data area reserved for FWNMI option.
+ * This address (0x7000) is fixed by the RPA.
  */
+	.= 0x7000
+	.globl fwnmi_data_area
+fwnmi_data_area:
+
+	/* pseries and powernv need to keep the whole page from
+	 * 0x7000 to 0x8000 free for use by the firmware
+	 */
+	. = 0x8000
+#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+
+/*
+ * Denorm interrupt assist moved out of line to here, where it remains
+ * close enough to the call site which uses a small conditional branch
+ */
+#ifdef CONFIG_PPC_DENORMALISATION
+denorm_assist:
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
+
+#define XVCPSGNDP2(n) XVCPSGNDP(n,n,n) ; XVCPSGNDP(n+1,n+1,n+1)
+#define XVCPSGNDP4(n) XVCPSGNDP2(n) ; XVCPSGNDP2(n+2)
+#define XVCPSGNDP8(n) XVCPSGNDP4(n) ; XVCPSGNDP4(n+4)
+#define XVCPSGNDP16(n) XVCPSGNDP8(n) ; XVCPSGNDP8(n+8)
+#define XVCPSGNDP32(n) XVCPSGNDP16(n) ; XVCPSGNDP16(n+16)
+	XVCPSGNDP32(0)
+
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
+
+BEGIN_FTR_SECTION
+	b	denorm_done
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER8 we need to do that for all 64 VSX registers
+ */
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
+#endif
+
+/*
+ * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
+ * - If it was a decrementer interrupt, we bump the dec to max and and return.
+ * - If it was a doorbell we return immediately since doorbells are edge
+ *   triggered and won't automatically refire.
+ * - else we hard disable and return.
+ * This is called with r10 containing the value to OR to the paca field.
+ *
+ * Warning: This code is reached using a (small) conditional branch from both
+ * the 1st level exception handlers below 0x8000 and the alternate feature
+ * sections of that file which the linker puts right after the text in here.
+ *
+ * For that to work, we thus need this code to be roughly near the "middle"
+ * so that we can reach it with <32k offsets. Here works... for now.
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
+	MASKED_INTERRUPT()
+	MASKED_INTERRUPT(H)
+
+/*
+ * Code from here down to __end_handlers is invoked from the
+ * exception prologs above.  Because the prologs assemble the
+ * addresses of these handlers using the LOAD_HANDLER macro,
+ * which uses an ori instruction, these handlers must be in
+ * the first 64k of the kernel image.
+ */
+
+/*** Common interrupt handlers ***/
+
+	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
+
+	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
+	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
+	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
+#ifdef CONFIG_PPC_DOORBELL
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .doorbell_exception)
+#else
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .unknown_exception)
+#endif
+	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
+	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .emulation_assist_interrupt)
+	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
+#ifdef CONFIG_PPC_DOORBELL
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .doorbell_exception)
+#else
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .unknown_exception)
+#endif
+	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
+	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
+	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
+#ifdef CONFIG_ALTIVEC
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
+#else
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .unknown_exception)
+#endif
+#ifdef CONFIG_CBE_RAS
+	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, .cbe_system_error_exception)
+	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, .cbe_maintenance_exception)
+	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, .cbe_thermal_exception)
+#endif /* CONFIG_CBE_RAS */
+
+	/*
+	 * Here r13 points to the paca, r9 contains the saved CR,
+	 * SRR0 and SRR1 are saved in r11 and r12,
+	 * r9 - r13 are saved in paca->exgen.
+	 */
 	.align	7
 	.globl data_access_common
 data_access_common:
@@ -1075,69 +1113,6 @@ instruction_access_common:
 
 	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, .unknown_exception)
 
-/*
- * Here is the common SLB miss user that is used when going to virtual
- * mode for SLB misses, that is currently not used
- */
-#ifdef __DISABLED__
-	.align	7
-	.globl	slb_miss_user_common
-slb_miss_user_common:
-	mflr	r10
-	std	r3,PACA_EXGEN+EX_DAR(r13)
-	stw	r9,PACA_EXGEN+EX_CCR(r13)
-	std	r10,PACA_EXGEN+EX_LR(r13)
-	std	r11,PACA_EXGEN+EX_SRR0(r13)
-	bl	.slb_allocate_user
-
-	ld	r10,PACA_EXGEN+EX_LR(r13)
-	ld	r3,PACA_EXGEN+EX_R3(r13)
-	lwz	r9,PACA_EXGEN+EX_CCR(r13)
-	ld	r11,PACA_EXGEN+EX_SRR0(r13)
-	mtlr	r10
-	beq-	slb_miss_fault
-
-	andi.	r10,r12,MSR_RI		/* check for unrecoverable exception */
-	beq-	unrecov_user_slb
-	mfmsr	r10
-
-.machine push
-.machine "power4"
-	mtcrf	0x80,r9
-.machine pop
-
-	clrrdi	r10,r10,2		/* clear RI before setting SRR0/1 */
-	mtmsrd	r10,1
-
-	mtspr	SRR0,r11
-	mtspr	SRR1,r12
-
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	ld	r11,PACA_EXGEN+EX_R11(r13)
-	ld	r12,PACA_EXGEN+EX_R12(r13)
-	ld	r13,PACA_EXGEN+EX_R13(r13)
-	rfid
-	b	.
-
-slb_miss_fault:
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXGEN)
-	ld	r4,PACA_EXGEN+EX_DAR(r13)
-	li	r5,0
-	std	r4,_DAR(r1)
-	std	r5,_DSISR(r1)
-	b	handle_page_fault
-
-unrecov_user_slb:
-	EXCEPTION_PROLOG_COMMON(0x4200, PACA_EXGEN)
-	DISABLE_INTS
-	bl	.save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.unrecoverable_exception
-	b	1b
-
-#endif /* __DISABLED__ */
-
 
 	/*
 	 * Machine check is different because we use a different
@@ -1297,30 +1272,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	.globl	__end_handlers
 __end_handlers:
 
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
-
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
-
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
-/*
- * Data area reserved for FWNMI option.
- * This address (0x7000) is fixed by the RPA.
- */
-	.= 0x7000
-	.globl fwnmi_data_area
-fwnmi_data_area:
-
-	/* pseries and powernv need to keep the whole page from
-	 * 0x7000 to 0x8000 free for use by the firmware
-	 */
-	. = 0x8000
-#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /* Space for CPU0's segment table */
 	.balign 4096
