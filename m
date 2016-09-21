Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWg6KqgzDshC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:46:07 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hi10so1945238pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:46:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 41/41] powerpc/64s: remove unused exception code,
 small cleanups
Date: Wed, 21 Sep 2016 17:44:07 +1000
Message-Id: <20160921074407.4885-42-npiggin@gmail.com>
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

This was not done before the big patches because I only noticed
them afterwards. It has become much easier to see which handlers
are branched to from which exception vectors now, and to see
exactly what vector space is being used for what.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 71d508a..429d31c 100644
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
+VECTOR_HANDLER_VIRT_NONE(0x4000, 0x4100)
+
 VECTOR_HANDLER_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
@@ -903,9 +910,7 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
 VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
+VECTOR_HANDLER_VIRT_NONE(0x4e00, 0x4e20)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -919,13 +924,10 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
 	bl      unknown_exception
 	b       ret_from_except
 COMMON_HANDLER_END(h_data_storage_common)
-COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 
 
 VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
+VECTOR_HANDLER_VIRT_NONE(0x4e20, 0x4e40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
@@ -936,11 +938,14 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
+/*
+ * hmi_exception trampoline is a special case. It jumps to hmi_exception_early
+ * first, and then eventaully from there to the trampoline to get into virtual
+ * mode.
+ */
 __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
 __TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
+VECTOR_HANDLER_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 COMMON_HANDLER_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
@@ -1118,6 +1123,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
 COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
+VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 #endif
 
 
@@ -1126,6 +1132,8 @@ VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
 COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 
+VECTOR_HANDLER_REAL_NONE(0x1400, 0x1500)
+VECTOR_HANDLER_VIRT_NONE(0x5400, 0x5500)
 
 VECTOR_HANDLER_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
@@ -1229,6 +1237,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
 COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
+VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
 #endif
 
 
@@ -1249,6 +1258,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
+VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 #endif
 
 
-- 
2.9.3
