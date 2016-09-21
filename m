Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBW92hZvzDsgn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:41 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id my20so1945866pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 29/41] powerpc/64s: consolidate VSX Unavailable 0xf40 interrupt
Date: Wed, 21 Sep 2016 17:43:55 +1000
Message-Id: <20160921074407.4885-30-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 75 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f517744..7df5c63 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1072,6 +1072,43 @@ COMMON_HANDLER_END(altivec_unavailable_common)
 
 
 __VECTOR_HANDLER_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+__TRAMP_HANDLER_REAL_OOL(vsx_unavailable, 0xf40)
+__VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
+__TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
+TRAMP_KVM(PACA_EXGEN, 0xf40)
+COMMON_HANDLER_BEGIN(vsx_unavailable_common)
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
+COMMON_HANDLER_END(vsx_unavailable_common)
+
 
 __VECTOR_HANDLER_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
 
@@ -1205,9 +1242,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xf00 */
-__TRAMP_HANDLER_REAL_OOL(vsx_unavailable, 0xf40)
-TRAMP_KVM(PACA_EXGEN, 0xf40)
-
 __TRAMP_HANDLER_REAL_OOL(facility_unavailable, 0xf60)
 TRAMP_KVM(PACA_EXGEN, 0xf60)
 
@@ -1369,7 +1403,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-__VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
 
 __VECTOR_HANDLER_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
 
@@ -1399,41 +1432,7 @@ TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-COMMON_HANDLER_BEGIN(vsx_unavailable_common)
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
-COMMON_HANDLER_END(vsx_unavailable_common)
-
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
-- 
2.9.3
