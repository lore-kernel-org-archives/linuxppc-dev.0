Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2J71DGzDrPF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 24/42] powerpc/64s: Consolidate Hypervisor Maintenance
 0xe60 interrupt
Date: Wed,  5 Oct 2016 11:22:46 +1100
Message-Id: <1475626984-18770-25-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 113 +++++++++++++++++------------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 128b21b42f8b..01950615d8d3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -945,6 +945,62 @@ EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
 __EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
+__TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e60, 0x4e80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
+TRAMP_REAL_BEGIN(hmi_exception_early)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
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
+	addi	r3,r1,STACK_FRAME_OVERHEAD
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
+	 */
+	.globl hmi_exception_after_realmode
+hmi_exception_after_realmode:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	tramp_real_hmi_exception
+
+EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
+
 
 __EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
 
@@ -1088,9 +1144,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xe00 */
-__TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
-
 __TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 
@@ -1233,7 +1286,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
 #else
@@ -1265,10 +1317,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e60, 0x4e80)
-
 __EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
 
 __EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
@@ -1405,55 +1453,6 @@ EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 
-TRAMP_REAL_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
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
-
-	/*
-	 * Go to virtual mode and pull the HMI event information from
-	 * firmware.
-	 */
-	.globl hmi_exception_after_realmode
-hmi_exception_after_realmode:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	tramp_real_hmi_exception
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_REAL_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.7.4
