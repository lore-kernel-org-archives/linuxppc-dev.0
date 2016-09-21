Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVH1rTLzDshQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:55 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id n24so2027973pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/41] powerpc/64s: consolidate Instruction Segment 0x480
 interrupt
Date: Wed, 21 Sep 2016 17:43:35 +1000
Message-Id: <20160921074407.4885-10-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 183 ++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 90 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5f08388..0320b60 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -643,6 +643,99 @@ VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 #endif
 VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
 
+VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+VECTOR_HANDLER_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
+TRAMP_KVM(PACA_EXSLB, 0x480)
+
+
+/* This handler is used by both 0x380 and 0x480 slb miss interrupts */
+COMMON_HANDLER_BEGIN(slb_miss_realmode)
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
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
+#endif
+	/* All done -- return from exception. */
+
+	ld	r10,PACA_EXSLB+EX_LR(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
+
+	mtlr	r10
+	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+BEGIN_MMU_FTR_SECTION
+	beq-	2f
+FTR_SECTION_ELSE
+	b	2f
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
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
+	LOAD_HANDLER(r10,unrecov_slb)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+COMMON_HANDLER_END(slb_miss_realmode)
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
 VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -805,7 +898,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 
@@ -1078,24 +1170,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
-
 VECTOR_HANDLER_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
@@ -1399,77 +1473,6 @@ hmi_exception_after_realmode:
 	b	tramp_real_hmi_exception
 COMMON_HANDLER_END(hmi_exception_early)
 
-/*
- * r13 points to the PACA, r9 contains the saved CR,
- * r12 contain the saved SRR1, SRR0 is still ready for return
- * r3 has the faulting address
- * r9 - r13 are saved in paca->exslb.
- * r3 is saved in paca->slb_r3
- * We assume we aren't going to take any exceptions during this procedure.
- */
-COMMON_HANDLER_BEGIN(slb_miss_realmode)
-	mflr	r10
-#ifdef CONFIG_RELOCATABLE
-	mtctr	r11
-#endif
-
-	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
-
-#ifdef CONFIG_PPC_STD_MMU_64
-BEGIN_MMU_FTR_SECTION
-	bl	slb_allocate_realmode
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
-#endif
-	/* All done -- return from exception. */
-
-	ld	r10,PACA_EXSLB+EX_LR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
-	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-
-	mtlr	r10
-	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-BEGIN_MMU_FTR_SECTION
-	beq-	2f
-FTR_SECTION_ELSE
-	b	2f
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
-
-.machine	push
-.machine	"power4"
-	mtcrf	0x80,r9
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
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10,unrecov_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.
-COMMON_HANDLER_END(slb_miss_realmode)
-
-COMMON_HANDLER_BEGIN(unrecov_slb)
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
-	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-COMMON_HANDLER_END(unrecov_slb)
-
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_HANDLER_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.9.3
