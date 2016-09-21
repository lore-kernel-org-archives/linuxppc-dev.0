Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVt5Tt5zDshB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q2so2030481pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/41] powerpc/64s: consolidate Hypervisor Maintenance 0xe60
 interrupt
Date: Wed, 21 Sep 2016 17:43:49 +1000
Message-Id: <20160921074407.4885-24-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 114 +++++++++++++++++------------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7ff0f11..ec3e6dc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -942,6 +942,62 @@ COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
 __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
+COMMON_HANDLER_BEGIN(hmi_exception_early)
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
+COMMON_HANDLER_END(hmi_exception_early)
+COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
+
 
 __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
 
@@ -1087,9 +1143,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
-
 __TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 
@@ -1234,7 +1287,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
 #else
@@ -1270,10 +1322,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
-
 __VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
 
 __VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
@@ -1413,56 +1461,6 @@ COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 
-COMMON_HANDLER_BEGIN(hmi_exception_early)
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
-COMMON_HANDLER_END(hmi_exception_early)
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_HANDLER_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.9.3
