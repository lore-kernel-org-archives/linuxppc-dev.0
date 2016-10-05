Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2L2d5xzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 28/42] powerpc/64s: Consolidate Performance Monitor 0xf00
 interrupt
Date: Wed,  5 Oct 2016 11:22:50 +1100
Message-Id: <1475626984-18770-29-git-send-email-mpe@ellerman.id.au>
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
index ee9d4959948c..5566f218734a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1027,6 +1027,12 @@ EXC_VIRT_NONE(0x4ec0, 0x4f00)
 
 
 __EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
+__TRAMP_REAL_REAL_OOL(performance_monitor, 0xf00)
+__EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
+__TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
+TRAMP_KVM(PACA_EXGEN, 0xf00)
+EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
+
 
 __EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
 
@@ -1162,9 +1168,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xf00 */
-__TRAMP_REAL_REAL_OOL(performance_monitor, 0xf00)
-TRAMP_KVM(PACA_EXGEN, 0xf00)
-
 __TRAMP_REAL_REAL_OOL(altivec_unavailable, 0xf20)
 TRAMP_KVM(PACA_EXGEN, 0xf20)
 
@@ -1297,7 +1300,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
@@ -1322,8 +1324,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
-
 __EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
 
 __EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
@@ -1421,7 +1421,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
 __TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
 __TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
-- 
2.7.4
