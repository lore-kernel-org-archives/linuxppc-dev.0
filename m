Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWX6vzZzDshV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:46:00 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 21so2039146pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:46:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 38/41] powerpc/64s: consolidate CBE Thermal 0x1800 interrupt
Date: Wed, 21 Sep 2016 17:44:04 +1000
Message-Id: <20160921074407.4885-39-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 60e7e7e..9f96ec2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1263,18 +1263,14 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 #ifdef CONFIG_CBE_RAS
 VECTOR_HANDLER_REAL_HV(cbe_thermal, 0x1800, 0x1900)
-
+VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
-
+COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 #endif
 
 
-/*** Out of line interrupts support ***/
-
-	/* moved from 0x200 */
-
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
  * - If it was a decrementer interrupt, we bump the dec to max and and return.
@@ -1413,8 +1409,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 	 * come here.
 	 */
 
-VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
-
 TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
@@ -1433,11 +1427,6 @@ USE_FIXED_SECTION(virt_trampolines)
 __end_interrupts:
 UNUSE_FIXED_SECTION(virt_trampolines)
 
-#ifdef CONFIG_CBE_RAS
-COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
-
-
 #ifdef CONFIG_PPC_970_NAP
 TRAMP_HANDLER_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
-- 
2.9.3
