Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVr3ts2zDsgt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:24 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id oz2so1949223pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/41] powerpc/64s: consolidate Hypervisor Emulation
 Assistance 0xe40 interrupt
Date: Wed, 21 Sep 2016 17:43:48 +1000
Message-Id: <20160921074407.4885-23-npiggin@gmail.com>
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
index 75dcc08..7ff0f11 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -934,6 +934,12 @@ COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
 
 __VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
+__TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
+__VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
+__TRAMP_HANDLER_VIRT_OOL_HV(emulation_assist, 0xe40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
+COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
+
 
 __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
 
@@ -1081,9 +1087,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
-
 __TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 
@@ -1231,7 +1234,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1268,8 +1270,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-__VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
-
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
@@ -1382,7 +1382,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 COMMON_HANDLER_END(vsx_unavailable_common)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_HANDLER_VIRT_OOL_HV(emulation_assist, 0xe40)
 __TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 __TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 __TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
-- 
2.9.3
