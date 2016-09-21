Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWQ1BljzDshS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:54 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 21so2039022pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 35/41] powerpc/64s: consolidate Softpatch 0x1500 interrupt
Date: Wed, 21 Sep 2016 17:44:01 +1000
Message-Id: <20160921074407.4885-36-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3e5f566..3172724 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1163,34 +1163,15 @@ VECTOR_HANDLER_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
 VECTOR_HANDLER_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
 
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
+#ifdef CONFIG_PPC_DENORMALISATION
+VECTOR_HANDLER_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
+	b	exc_0x1500_denorm_exception_hv
+VECTOR_HANDLER_VIRT_END(denorm_exception, 0x5500, 0x5600)
+#else
+VECTOR_HANDLER_VIRT_NONE(0x5500, 0x5600)
 #endif
 
-
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 TRAMP_HANDLER_BEGIN(denorm_assist)
@@ -1257,6 +1238,36 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 TRAMP_HANDLER_END(denorm_assist)
 
+COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
+
+
+#ifdef CONFIG_CBE_RAS
+VECTOR_HANDLER_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
+
+#else /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
+#endif
+
+VECTOR_HANDLER_REAL(altivec_assist, 0x1700, 0x1800)
+
+TRAMP_KVM(PACA_EXGEN, 0x1700)
+
+#ifdef CONFIG_CBE_RAS
+VECTOR_HANDLER_REAL_HV(cbe_thermal, 0x1800, 0x1900)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
+
+#else /* CONFIG_CBE_RAS */
+VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
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
@@ -1379,7 +1390,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
 COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
 #else
@@ -1403,14 +1413,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 */
 
 
-#ifdef CONFIG_PPC_DENORMALISATION
-VECTOR_HANDLER_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
-	b	exc_0x1500_denorm_exception_hv
-VECTOR_HANDLER_VIRT_END(denorm_exception, 0x5500, 0x5600)
-#else
-VECTOR_HANDLER_VIRT_NONE(0x5500, 0x5600)
-#endif
-
 VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
 
 VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
-- 
2.9.3
