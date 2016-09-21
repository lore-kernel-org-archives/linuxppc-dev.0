Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVx103WzDsgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:29 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so2028669pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/41] powerpc/64s: consolidate Directed Hypervisor Doorbell
 0xe80 interrupt
Date: Wed, 21 Sep 2016 17:43:50 +1000
Message-Id: <20160921074407.4885-25-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ec3e6dc..f0493e5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1000,6 +1000,16 @@ COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
 __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
+__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
+#ifdef CONFIG_PPC_DOORBELL
+COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
+#else
+COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
+#endif
+
 
 __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
 
@@ -1143,9 +1153,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
-
 __TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 
@@ -1287,11 +1294,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_PPC_DOORBELL
-COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
-#else
-COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
-#endif
 COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
@@ -1322,7 +1324,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
 
 __VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
 
@@ -1430,7 +1431,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 COMMON_HANDLER_END(vsx_unavailable_common)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 __TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 __TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
 __TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
-- 
2.9.3
