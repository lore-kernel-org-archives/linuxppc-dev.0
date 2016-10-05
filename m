Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2R6RDFzDrMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 42/42] powerpc/64s: Remove unused exception code,
 small cleanups
Date: Wed,  5 Oct 2016 11:23:04 +1100
Message-Id: <1475626984-18770-43-git-send-email-mpe@ellerman.id.au>
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

This was not done before the big patches because I only noticed
them afterwards. It has become much easier to see which handlers
are branched to from which exception vectors now, and to see
exactly what vector space is being used for what.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1e17f8d4365a..08992f8f5036 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -57,6 +57,10 @@
  * 0x7000 - 0x7fff : FWNMI data area
  * 0x8000 -   .... : Common interrupt handlers, remaining early
  *                   setup code, rest of kernel.
+ *
+ * We could reclaim 0x4000-0x42ff for real mode trampolines if the space
+ * is necessary. Until then it's more consistent to explicitly put VIRT_NONE
+ * vectors there.
  */
 OPEN_FIXED_SECTION(real_vectors,        0x0100, 0x1900)
 OPEN_FIXED_SECTION(real_trampolines,    0x1900, 0x4000)
@@ -88,6 +92,9 @@ USE_FIXED_SECTION(real_vectors)
 	.globl __start_interrupts
 __start_interrupts:
 
+/* No virt vectors corresponding with 0x0..0x100 */
+EXC_VIRT_NONE(0x4000, 0x4100)
+
 EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
@@ -907,9 +914,7 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
 EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e00, 0x4e20)
+EXC_VIRT_NONE(0x4e00, 0x4e20)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -922,13 +927,10 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	bl      unknown_exception
 	b       ret_from_except
-EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 
 
 EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e20, 0x4e40)
+EXC_VIRT_NONE(0x4e20, 0x4e40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
@@ -939,11 +941,14 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
+/*
+ * hmi_exception trampoline is a special case. It jumps to hmi_exception_early
+ * first, and then eventaully from there to the trampoline to get into virtual
+ * mode.
+ */
 __EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
 __TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e60, 0x4e80)
+EXC_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
@@ -1118,6 +1123,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
 EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1200, 0x1300)
+EXC_VIRT_NONE(0x5200, 0x5300)
 #endif
 
 
@@ -1126,6 +1132,8 @@ EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
 EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 
+EXC_REAL_NONE(0x1400, 0x1500)
+EXC_VIRT_NONE(0x5400, 0x5500)
 
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
@@ -1228,6 +1236,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
 EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1600, 0x1700)
+EXC_VIRT_NONE(0x5600, 0x5700)
 #endif
 
 
@@ -1248,6 +1257,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1800, 0x1900)
+EXC_VIRT_NONE(0x5800, 0x5900)
 #endif
 
 
-- 
2.7.4
