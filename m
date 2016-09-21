Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBV36fxhzDshH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:43 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id s3so575389pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/41] powerpc/64s: consolidate System Reset 0x100 interrupt
Date: Wed, 21 Sep 2016 17:43:30 +1000
Message-Id: <20160921074407.4885-5-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 11a7b28..a562285 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -185,6 +185,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
 VECTOR_HANDLER_REAL_END(system_reset, 0x100, 0x200)
+VECTOR_HANDLER_VIRT_NONE(0x4100, 0x4200)
+COMMON_HANDLER(system_reset_common, 0x100, system_reset_exception)
+
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * Vectors for the FWNMI option.  Share common code.
+ */
+TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 NOTEST, 0x100)
+TRAMP_HANDLER_END(system_reset_fwnmi)
+#endif /* CONFIG_PPC_PSERIES */
+
 
 VECTOR_HANDLER_REAL_BEGIN(machine_check, 0x200, 0x300)
 	/* This is moved out of line as it can be patched by FW, but
@@ -708,18 +722,6 @@ FTR_SECTION_ELSE
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	blr
 
-#ifdef CONFIG_PPC_PSERIES
-/*
- * Vectors for the FWNMI option.  Share common code.
- */
-TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
-				 NOTEST, 0x100)
-TRAMP_HANDLER_END(system_reset_fwnmi)
-
-#endif /* CONFIG_PPC_PSERIES */
-
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_HANDLER_BEGIN(kvmppc_skip_interrupt)
 	/*
@@ -757,7 +759,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-COMMON_HANDLER(system_reset_common, 0x100, system_reset_exception)
 COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
 COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
@@ -802,7 +803,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * only has extra guff for STAB-based processors -- which never
 	 * come here.
 	 */
-VECTOR_HANDLER_VIRT_NONE(0x4100, 0x4200)
 VECTOR_HANDLER_VIRT_NONE(0x4200, 0x4300)
 
 VECTOR_HANDLER_VIRT(data_access, 0x4300, 0x4380, 0x300)
-- 
2.9.3
