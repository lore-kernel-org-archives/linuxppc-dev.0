Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2L5gYWzDrPS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 30/42] powerpc/64s: Consolidate VSX Unavailable 0xf40
 interrupt
Date: Wed,  5 Oct 2016 11:22:52 +1100
Message-Id: <1475626984-18770-31-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 74 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5b81ecf7c1a7..f8015d22657f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1074,6 +1074,42 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 
 __EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+__TRAMP_REAL_REAL_OOL(vsx_unavailable, 0xf40)
+__EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
+__TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
+TRAMP_KVM(PACA_EXGEN, 0xf40)
+EXC_COMMON_BEGIN(vsx_unavailable_common)
+	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
+#ifdef CONFIG_VSX
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
+	b	load_up_vsx
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	vsx_unavailable_tm
+	b	ret_from_except
+#endif
+1:
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	vsx_unavailable_exception
+	b	ret_from_except
+
 
 __EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
 
@@ -1205,9 +1241,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xf00 */
-__TRAMP_REAL_REAL_OOL(vsx_unavailable, 0xf40)
-TRAMP_KVM(PACA_EXGEN, 0xf40)
-
 __TRAMP_REAL_REAL_OOL(facility_unavailable, 0xf60)
 TRAMP_KVM(PACA_EXGEN, 0xf60)
 
@@ -1358,8 +1391,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
-
 __EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
 
 __EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
@@ -1387,40 +1418,7 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-EXC_COMMON_BEGIN(vsx_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
-#ifdef CONFIG_VSX
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
-	b	load_up_vsx
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-2:	/* User process was in a transaction */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	vsx_unavailable_tm
-	b	ret_from_except
-#endif
-1:
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	vsx_unavailable_exception
-	b	ret_from_except
-
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
-- 
2.7.4
