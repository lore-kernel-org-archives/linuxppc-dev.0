Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWF0gsHzDsh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:45 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q2so2030842pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/41] powerpc/64s: consolidate Hypervisor Facility
 Unavailable 0xf80 interrupt
Date: Wed, 21 Sep 2016 17:43:57 +1000
Message-Id: <20160921074407.4885-32-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index dfc1ced..5a3db33 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1119,6 +1119,12 @@ COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exceptio
 
 
 __VECTOR_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+__TRAMP_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80)
+__VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
+__TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
+COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
+
 
 VECTOR_HANDLER_REAL_NONE(0xfa0, 0x1200)
 
@@ -1247,10 +1253,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 TRAMP_HANDLER_END(denorm_assist)
 
-	/* moved from 0xf00 */
-__TRAMP_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
-
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
  * - If it was a decrementer interrupt, we bump the dec to max and and return.
@@ -1397,8 +1399,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
-
 VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
 
 VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
@@ -1424,8 +1424,6 @@ TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
-
 USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
@@ -1439,8 +1437,6 @@ USE_FIXED_SECTION(virt_trampolines)
 __end_interrupts:
 UNUSE_FIXED_SECTION(virt_trampolines)
 
-COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
-
 #ifdef CONFIG_CBE_RAS
 COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
-- 
2.9.3
