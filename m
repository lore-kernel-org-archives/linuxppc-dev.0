Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2K2LY6zDrPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 25/42] powerpc/64s: Consolidate Directed Hypervisor
 Doorbell 0xe80 interrupt
Date: Wed,  5 Oct 2016 11:22:47 +1100
Message-Id: <1475626984-18770-26-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 01950615d8d3..3e347c72a941 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1003,6 +1003,16 @@ EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
 __EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
+__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+__EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
+__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
+#ifdef CONFIG_PPC_DOORBELL
+EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
+#else
+EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
+#endif
+
 
 __EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
 
@@ -1144,9 +1154,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xe00 */
-__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
-
 __TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 
@@ -1286,11 +1293,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_PPC_DOORBELL
-EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
-#else
-EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
-#endif
 EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
@@ -1317,8 +1319,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
-
 __EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
 
 EXC_VIRT_NONE(0x4ec0, 0x4f00)
@@ -1422,7 +1422,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 __TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
 __TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
-- 
2.7.4
