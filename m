Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2Q5dSPzDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 41/42] powerpc/64s: Use a single macro for both parts of
 OOL exception
Date: Wed,  5 Oct 2016 11:23:03 +1100
Message-Id: <1475626984-18770-42-git-send-email-mpe@ellerman.id.au>
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

Simple substitution. This is possible now that both parts of the OOL
initial handler get linked into their correct location.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 55 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9b26b7b6f74a..1e17f8d4365a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -906,9 +906,7 @@ EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 TRAMP_KVM(PACA_EXGEN, 0xd00)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
-
-__EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-__TRAMP_REAL_REAL_OOL_HV(h_data_storage, 0xe00)
+EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
 EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 EXC_VIRT_END(unused, 0x4e00, 0x4e20)
@@ -927,8 +925,7 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 
 
-__EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-__TRAMP_REAL_REAL_OOL_HV(h_instr_storage, 0xe20)
+EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 EXC_VIRT_END(unused, 0x4e20, 0x4e40)
@@ -936,10 +933,8 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 
-__EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
-__TRAMP_REAL_REAL_OOL_HV(emulation_assist, 0xe40)
-__EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
-__TRAMP_REAL_VIRT_OOL_HV(emulation_assist, 0xe40)
+EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
+EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60, 0xe40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
@@ -1002,10 +997,8 @@ hmi_exception_after_realmode:
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
-__EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
-__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
-__EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
-__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
+EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0, 0xe80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1014,10 +1007,8 @@ EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
 
 
-__EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
-__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
-__EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
-__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
+EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0, 0xea0)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
@@ -1026,18 +1017,14 @@ EXC_REAL_NONE(0xec0, 0xf00)
 EXC_VIRT_NONE(0x4ec0, 0x4f00)
 
 
-__EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
-__TRAMP_REAL_REAL_OOL(performance_monitor, 0xf00)
-__EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
-__TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
+EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
+EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20, 0xf00)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
 
-__EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
-__TRAMP_REAL_REAL_OOL(altivec_unavailable, 0xf20)
-__EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
-__TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
+EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
+EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40, 0xf20)
 TRAMP_KVM(PACA_EXGEN, 0xf20)
 EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
@@ -1073,10 +1060,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 
 
-__EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
-__TRAMP_REAL_REAL_OOL(vsx_unavailable, 0xf40)
-__EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
-__TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
+EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60, 0xf40)
 TRAMP_KVM(PACA_EXGEN, 0xf40)
 EXC_COMMON_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
@@ -1111,18 +1096,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 
-__EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
-__TRAMP_REAL_REAL_OOL(facility_unavailable, 0xf60)
-__EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
-__TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
+EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
+EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80, 0xf60)
 TRAMP_KVM(PACA_EXGEN, 0xf60)
 EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 
 
-__EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
-__TRAMP_REAL_REAL_OOL_HV(h_facility_unavailable, 0xf80)
-__EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
-__TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
+EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0, 0xf80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
 EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
-- 
2.7.4
