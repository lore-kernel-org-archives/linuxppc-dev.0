Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY8m70jNYzDsTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:09:27 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ph5so2474370pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:09:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/8] powerpc/pseries: remove unused exception code,
 small cleanups
Date: Tue, 13 Sep 2016 13:08:46 +1000
Message-Id: <20160913030846.29790-9-npiggin@gmail.com>
In-Reply-To: <20160913030846.29790-1-npiggin@gmail.com>
References: <20160913030846.29790-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a647779..4d06af3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -89,6 +89,9 @@ USE_FIXED_SECTION(real_vectors)
 	.globl __start_interrupts
 __start_interrupts:
 
+/* No virt vectors corresponding with 0x0..0x100 */
+VECTOR_HANDLER_VIRT_NONE(0x4000, 0x4100)
+
 VECTOR_HANDLER_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
@@ -902,9 +905,7 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
 VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
+VECTOR_HANDLER_VIRT_NONE(0x4e00, 0x4e20)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -918,13 +919,10 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
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
 
@@ -935,11 +933,14 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
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
@@ -1117,6 +1118,7 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
 COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
+VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 #endif
 
 
@@ -1231,6 +1233,7 @@ COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
+VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
 #endif
 
 
@@ -1252,8 +1255,11 @@ COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
+VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 #endif
 
+/* Real vector area ends at 0x18ff */
+VECTOR_HANDLER_VIRT_NONE(0x5900, 0x6000)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
-- 
2.9.3
