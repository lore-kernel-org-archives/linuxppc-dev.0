Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVz4qWQzDsgj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:31 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id my20so1945651pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/41] powerpc/64s: consolidate Hypervisor Virtualization
 0xea0 interrupt
Date: Wed, 21 Sep 2016 17:43:51 +1000
Message-Id: <20160921074407.4885-26-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f0493e5..7b76b79 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1012,6 +1012,12 @@ COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 
 
 __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
+__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
+COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
+
 
 VECTOR_HANDLER_REAL_NONE(0xec0, 0xf00)
 
@@ -1152,10 +1158,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 TRAMP_HANDLER_END(denorm_assist)
 
-	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
-TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
-
 	/* moved from 0xf00 */
 __TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
@@ -1294,7 +1296,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
@@ -1325,7 +1326,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
 
 VECTOR_HANDLER_VIRT_NONE(0x4ec0, 0x4f00)
 
@@ -1431,7 +1431,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 COMMON_HANDLER_END(vsx_unavailable_common)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 __TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
 __TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
 __TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
-- 
2.9.3
