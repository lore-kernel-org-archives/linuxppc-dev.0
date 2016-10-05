Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc286yC3zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 05/42] powerpc/64s: Consolidate System Reset 0x100 interrupt
Date: Wed,  5 Oct 2016 11:22:27 +1100
Message-Id: <1475626984-18770-6-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6ea330a3c51a..b163e7a62289 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -183,6 +183,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
 EXC_REAL_END(system_reset, 0x100, 0x200)
+EXC_VIRT_NONE(0x4100, 0x4200)
+EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
+
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * Vectors for the FWNMI option.  Share common code.
+ */
+TRAMP_REAL_BEGIN(system_reset_fwnmi)
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 NOTEST, 0x100)
+#endif /* CONFIG_PPC_PSERIES */
+
 
 EXC_REAL_BEGIN(machine_check, 0x200, 0x300)
 	/* This is moved out of line as it can be patched by FW, but
@@ -699,17 +712,6 @@ FTR_SECTION_ELSE
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	blr
 
-#ifdef CONFIG_PPC_PSERIES
-/*
- * Vectors for the FWNMI option.  Share common code.
- */
-TRAMP_REAL_BEGIN(system_reset_fwnmi)
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
-				 NOTEST, 0x100)
-
-#endif /* CONFIG_PPC_PSERIES */
-
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	/*
@@ -745,7 +747,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
@@ -790,7 +791,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * only has extra guff for STAB-based processors -- which never
 	 * come here.
 	 */
-EXC_VIRT_NONE(0x4100, 0x4200)
 EXC_VIRT_NONE(0x4200, 0x4300)
 
 EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
-- 
2.7.4
