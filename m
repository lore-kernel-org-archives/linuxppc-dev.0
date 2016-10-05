Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2L5f6tzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 29/42] powerpc/64s: Consolidate Vector Unavailable 0xf20
 interrupt
Date: Wed,  5 Oct 2016 11:22:51 +1100
Message-Id: <1475626984-18770-30-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 76 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5566f218734a..5b81ecf7c1a7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1035,6 +1035,43 @@ EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exceptio
 
 
 __EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
+__TRAMP_REAL_REAL_OOL(altivec_unavailable, 0xf20)
+__EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
+__TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
+TRAMP_KVM(PACA_EXGEN, 0xf20)
+EXC_COMMON_BEGIN(altivec_unavailable_common)
+	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	beq	1f
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+  BEGIN_FTR_SECTION_NESTED(69)
+	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
+	 * transaction), go do TM stuff
+	 */
+	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
+	bne-	2f
+  END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
+#endif
+	bl	load_up_altivec
+	b	fast_exception_return
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	altivec_unavailable_tm
+	b	ret_from_except
+#endif
+1:
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	altivec_unavailable_exception
+	b	ret_from_except
+
 
 __EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
 
@@ -1168,9 +1205,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xf00 */
-__TRAMP_REAL_REAL_OOL(altivec_unavailable, 0xf20)
-TRAMP_KVM(PACA_EXGEN, 0xf20)
-
 __TRAMP_REAL_REAL_OOL(vsx_unavailable, 0xf40)
 TRAMP_KVM(PACA_EXGEN, 0xf40)
 
@@ -1324,8 +1358,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
-
 __EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
 
 __EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
@@ -1355,39 +1387,6 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-EXC_COMMON_BEGIN(altivec_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
-#ifdef CONFIG_ALTIVEC
-BEGIN_FTR_SECTION
-	beq	1f
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-  BEGIN_FTR_SECTION_NESTED(69)
-	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
-	 * transaction), go do TM stuff
-	 */
-	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
-	bne-	2f
-  END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
-#endif
-	bl	load_up_altivec
-	b	fast_exception_return
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-2:	/* User process was in a transaction */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	altivec_unavailable_tm
-	b	ret_from_except
-#endif
-1:
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-#endif
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	altivec_unavailable_exception
-	b	ret_from_except
-
 EXC_COMMON_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
@@ -1421,7 +1420,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
 __TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
-- 
2.7.4
