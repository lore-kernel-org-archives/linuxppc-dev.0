Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2M34YNzDrMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 31/42] powerpc/64s: Consolidate Facility Unavailable 0xf60
 interrupt
Date: Wed,  5 Oct 2016 11:22:53 +1100
Message-Id: <1475626984-18770-32-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f8015d22657f..2e89d4bfc7e6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1112,6 +1112,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 
 
 __EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
+__TRAMP_REAL_REAL_OOL(facility_unavailable, 0xf60)
+__EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
+__TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
+TRAMP_KVM(PACA_EXGEN, 0xf60)
+EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
+
 
 __EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
 
@@ -1241,9 +1247,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xf00 */
-__TRAMP_REAL_REAL_OOL(facility_unavailable, 0xf60)
-TRAMP_KVM(PACA_EXGEN, 0xf60)
-
 __TRAMP_REAL_REAL_OOL_HV(h_facility_unavailable, 0xf80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
 
@@ -1391,8 +1394,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
-
 __EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
 
 EXC_VIRT_NONE(0x4fa0, 0x5200)
@@ -1419,7 +1420,6 @@ EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
 USE_FIXED_SECTION(virt_trampolines)
@@ -1435,7 +1435,6 @@ USE_FIXED_SECTION(virt_trampolines)
 __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
-EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 #ifdef CONFIG_CBE_RAS
-- 
2.7.4
