Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2N6dvhzDrPF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 36/42] powerpc/64s: Consolidate Softpatch 0x1500 interrupt
Date: Wed,  5 Oct 2016 11:22:58 +1100
Message-Id: <1475626984-18770-37-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0214c97c117d..04d25c76adee 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1163,34 +1163,15 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
 
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
+#ifdef CONFIG_PPC_DENORMALISATION
+EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
+	b	exc_real_0x1500_denorm_exception_hv
+EXC_VIRT_END(denorm_exception, 0x5500, 0x5600)
+#else
+EXC_VIRT_NONE(0x5500, 0x5600)
 #endif
 
-
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 TRAMP_REAL_BEGIN(denorm_assist)
@@ -1256,6 +1237,36 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	b	.
 #endif
 
+EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
+
+
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
+
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
  * - If it was a decrementer interrupt, we bump the dec to max and and return.
@@ -1376,7 +1387,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
 EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
 #else
@@ -1399,14 +1409,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-#ifdef CONFIG_PPC_DENORMALISATION
-EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
-	b	exc_real_0x1500_denorm_exception_hv
-EXC_VIRT_END(denorm_exception, 0x5500, 0x5600)
-#else
-EXC_VIRT_NONE(0x5500, 0x5600)
-#endif
-
 EXC_VIRT_NONE(0x5600, 0x5700)
 
 EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
-- 
2.7.4
