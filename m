Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBW35zmczDsh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:35 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id s3so576392pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/41] powerpc/64s: consolidate Performance Monitor 0xf00
 interrupt
Date: Wed, 21 Sep 2016 17:43:53 +1000
Message-Id: <20160921074407.4885-28-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f052fee..480c28c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1024,6 +1024,12 @@ VECTOR_HANDLER_VIRT_NONE(0x4ec0, 0x4f00)
 
 
 __VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
+__TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
+__VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
+__TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
+TRAMP_KVM(PACA_EXGEN, 0xf00)
+COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
+
 
 __VECTOR_HANDLER_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
 
@@ -1161,9 +1167,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xf00 */
-__TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
-TRAMP_KVM(PACA_EXGEN, 0xf00)
-
 __TRAMP_HANDLER_REAL_OOL(altivec_unavailable, 0xf20)
 TRAMP_KVM(PACA_EXGEN, 0xf20)
 
@@ -1298,7 +1301,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
@@ -1330,7 +1332,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-__VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
 
 __VECTOR_HANDLER_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
 
@@ -1432,7 +1433,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 COMMON_HANDLER_END(vsx_unavailable_common)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
 __TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
 __TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
-- 
2.9.3
