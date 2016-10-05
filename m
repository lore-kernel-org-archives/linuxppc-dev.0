Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2P6X2YzDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 39/42] powerpc/64s: Consolidate CBE Thermal 0x1800 interrupt
Date: Wed,  5 Oct 2016 11:23:01 +1100
Message-Id: <1475626984-18770-40-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 389032a8e744..307e117b95d3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1262,18 +1262,14 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
-
+EXC_VIRT_NONE(0x5800, 0x5900)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
-
+EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1800, 0x1900)
 #endif
 
 
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
-
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
  * - If it was a decrementer interrupt, we bump the dec to max and and return.
@@ -1410,8 +1406,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 	 * come here.
 	 */
 
-EXC_VIRT_NONE(0x5800, 0x5900)
-
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
@@ -1429,11 +1423,6 @@ USE_FIXED_SECTION(virt_trampolines)
 __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
-#ifdef CONFIG_CBE_RAS
-EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
-
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_REAL_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.7.4
