Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWd5ff5zDsh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:46:05 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id s3so576936pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:46:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 40/41] powerpc/64s: use single macro for both parts of OOL
 exception
Date: Wed, 21 Sep 2016 17:44:06 +1000
Message-Id: <20160921074407.4885-41-npiggin@gmail.com>
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

Simple substitution. This is possible now that both parts of the OOL
initial handler get linked into their correct location.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 55 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 69a2379..71d508a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -902,9 +902,7 @@ VECTOR_HANDLER_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 TRAMP_KVM(PACA_EXGEN, 0xd00)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
-
-__VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-__TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
+VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
@@ -924,8 +922,7 @@ COMMON_HANDLER_END(h_data_storage_common)
 COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 
 
-__VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-__TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
+VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
@@ -933,10 +930,8 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
 
-__VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
-__TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
-__VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
-__TRAMP_HANDLER_VIRT_OOL_HV(emulation_assist, 0xe40)
+VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
+VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60, 0xe40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
@@ -999,10 +994,8 @@ COMMON_HANDLER_END(hmi_exception_early)
 COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
-__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
-__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
+VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0, 0xe80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1011,10 +1004,8 @@ COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
 
 
-__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
-__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
-__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
-__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
+VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0, 0xea0)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
@@ -1023,18 +1014,14 @@ VECTOR_HANDLER_REAL_NONE(0xec0, 0xf00)
 VECTOR_HANDLER_VIRT_NONE(0x4ec0, 0x4f00)
 
 
-__VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
-__TRAMP_HANDLER_REAL_OOL(performance_monitor, 0xf00)
-__VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
-__TRAMP_HANDLER_VIRT_OOL(performance_monitor, 0xf00)
+VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
+VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20, 0xf00)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
 
-__VECTOR_HANDLER_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
-__TRAMP_HANDLER_REAL_OOL(altivec_unavailable, 0xf20)
-__VECTOR_HANDLER_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
-__TRAMP_HANDLER_VIRT_OOL(altivec_unavailable, 0xf20)
+VECTOR_HANDLER_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
+VECTOR_HANDLER_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40, 0xf20)
 TRAMP_KVM(PACA_EXGEN, 0xf20)
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
@@ -1071,10 +1058,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 COMMON_HANDLER_END(altivec_unavailable_common)
 
 
-__VECTOR_HANDLER_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
-__TRAMP_HANDLER_REAL_OOL(vsx_unavailable, 0xf40)
-__VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
-__TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
+VECTOR_HANDLER_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+VECTOR_HANDLER_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60, 0xf40)
 TRAMP_KVM(PACA_EXGEN, 0xf40)
 COMMON_HANDLER_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
@@ -1110,18 +1095,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 COMMON_HANDLER_END(vsx_unavailable_common)
 
 
-__VECTOR_HANDLER_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
-__TRAMP_HANDLER_REAL_OOL(facility_unavailable, 0xf60)
-__VECTOR_HANDLER_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
-__TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
+VECTOR_HANDLER_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
+VECTOR_HANDLER_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80, 0xf60)
 TRAMP_KVM(PACA_EXGEN, 0xf60)
 COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 
 
-__VECTOR_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
-__TRAMP_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80)
-__VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
-__TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
+VECTOR_HANDLER_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+VECTOR_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0, 0xf80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
 COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
-- 
2.9.3
