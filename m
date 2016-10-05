Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2M3xjfzDrPS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 32/42] powerpc/64s: Consolidate Hypervisor Facility
 Unavailable 0xf80 interrupt
Date: Wed,  5 Oct 2016 11:22:54 +1100
Message-Id: <1475626984-18770-33-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2e89d4bfc7e6..d88024384bc6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1120,6 +1120,12 @@ EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 
 
 __EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+__TRAMP_REAL_REAL_OOL_HV(h_facility_unavailable, 0xf80)
+__EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
+__TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
+EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
+
 
 EXC_REAL_NONE(0xfa0, 0x1200)
 
@@ -1246,10 +1252,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	b	.
 #endif
 
-	/* moved from 0xf00 */
-__TRAMP_REAL_REAL_OOL_HV(h_facility_unavailable, 0xf80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
-
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
  * - If it was a decrementer interrupt, we bump the dec to max and and return.
@@ -1394,8 +1396,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
-
 EXC_VIRT_NONE(0x4fa0, 0x5200)
 
 EXC_VIRT_NONE(0x5200, 0x5300)
@@ -1420,8 +1420,6 @@ EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
-
 USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
@@ -1435,8 +1433,6 @@ USE_FIXED_SECTION(virt_trampolines)
 __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
-EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
-
 #ifdef CONFIG_CBE_RAS
 EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
-- 
2.7.4
