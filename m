Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2C1WhGzDrM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 10/42] powerpc/64s: Consolidate Instruction Segment 0x480
 interrupt
Date: Wed,  5 Oct 2016 11:22:32 +1100
Message-Id: <1475626984-18770-11-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 224 ++++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 13eb8c7bc051..d084b0efd287 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -629,6 +629,119 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 #endif
 EXC_REAL_END(instruction_access_slb, 0x480, 0x500)
 
+EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
+	mfspr	r12,SPRN_SRR1
+	crclr	4*cr6+eq
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
+	mfctr	r11
+	LOAD_HANDLER(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+EXC_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
+TRAMP_KVM(PACA_EXSLB, 0x480)
+
+
+/* This handler is used by both 0x380 and 0x480 slb miss interrupts */
+EXC_COMMON_BEGIN(slb_miss_realmode)
+	/*
+	 * r13 points to the PACA, r9 contains the saved CR,
+	 * r12 contain the saved SRR1, SRR0 is still ready for return
+	 * r3 has the faulting address
+	 * r9 - r13 are saved in paca->exslb.
+	 * r3 is saved in paca->slb_r3
+ 	 * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
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
+	std	r3,PACA_EXSLB+EX_DAR(r13)
+
+	crset	4*cr0+eq
+#ifdef CONFIG_PPC_STD_MMU_64
+BEGIN_MMU_FTR_SECTION
+	bl	slb_allocate_realmode
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
+#endif
+
+	ld	r10,PACA_EXSLB+EX_LR(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
+	mtlr	r10
+
+	beq	8f		/* if bad address, make full stack frame */
+
+	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+	beq-	2f
+
+	/* All done -- return from exception. */
+
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x02,r9		/* I/D indication is in cr6 */
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
+	LOAD_HANDLER(r10,unrecov_slb)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+
+8:	mfspr	r11,SPRN_SRR0
+	LOAD_HANDLER(r10,bad_addr_slb)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+
+EXC_COMMON_BEGIN(unrecov_slb)
+	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	bl	save_nvgprs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	unrecoverable_exception
+	b	1b
+
+EXC_COMMON_BEGIN(bad_addr_slb)
+	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r3, PACA_EXSLB+EX_DAR(r13)
+	std	r3, _DAR(r1)
+	beq	cr6, 2f
+	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	std	r10, _TRAP(r1)
+2:	bl	save_nvgprs
+	addi	r3, r1, STACK_FRAME_OVERHEAD
+	bl	slb_miss_bad_addr
+	b	ret_from_except
+
 EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -790,7 +903,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 
@@ -1057,24 +1169,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
-	crclr	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	mfctr	r11
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-EXC_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
-
 EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
@@ -1370,98 +1464,6 @@ hmi_exception_after_realmode:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	tramp_real_hmi_exception
 
-/*
- * r13 points to the PACA, r9 contains the saved CR,
- * r12 contain the saved SRR1, SRR0 is still ready for return
- * r3 has the faulting address
- * r9 - r13 are saved in paca->exslb.
- * r3 is saved in paca->slb_r3
- * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
- * We assume we aren't going to take any exceptions during this procedure.
- */
-EXC_COMMON_BEGIN(slb_miss_realmode)
-	mflr	r10
-#ifdef CONFIG_RELOCATABLE
-	mtctr	r11
-#endif
-
-	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
-	std	r3,PACA_EXSLB+EX_DAR(r13)
-
-	crset	4*cr0+eq
-#ifdef CONFIG_PPC_STD_MMU_64
-BEGIN_MMU_FTR_SECTION
-	bl	slb_allocate_realmode
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
-#endif
-
-	ld	r10,PACA_EXSLB+EX_LR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
-	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-	mtlr	r10
-
-	beq	8f		/* if bad address, make full stack frame */
-
-	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-	beq-	2f
-
-	/* All done -- return from exception. */
-
-.machine	push
-.machine	"power4"
-	mtcrf	0x80,r9
-	mtcrf	0x02,r9		/* I/D indication is in cr6 */
-	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-.machine	pop
-
-	RESTORE_PPR_PACA(PACA_EXSLB, r9)
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	ld	r11,PACA_EXSLB+EX_R11(r13)
-	ld	r12,PACA_EXSLB+EX_R12(r13)
-	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
-	b	.	/* prevent speculative execution */
-
-2:	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r10,unrecov_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.
-
-8:	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r10,bad_addr_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.
-
-EXC_COMMON_BEGIN(unrecov_slb)
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
-	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-
-
-EXC_COMMON_BEGIN(bad_addr_slb)
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3, PACA_EXSLB+EX_DAR(r13)
-	std	r3, _DAR(r1)
-	beq	cr6, 2f
-	li	r10, 0x480		/* fix trap number for I-SLB miss */
-	std	r10, _TRAP(r1)
-2:	bl	save_nvgprs
-	addi	r3, r1, STACK_FRAME_OVERHEAD
-	bl	slb_miss_bad_addr
-	b	ret_from_except
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_REAL_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.7.4
