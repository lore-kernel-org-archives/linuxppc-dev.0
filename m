Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw4682rLrzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:20 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so4911514pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:20 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 12/14] powerpc/pseries: remove unused exception code,
 small cleanups
Date: Thu, 21 Jul 2016 16:44:11 +1000
Message-Id: <1469083453-9279-13-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
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

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9832765..b7a8a66 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -90,6 +90,9 @@ USE_FIXED_SECTION(real_vectors)
 	.globl __start_interrupts
 __start_interrupts:
 
+/* No virt vectors corresponding with 0x0..0x100 */
+VECTOR_HANDLER_VIRT_NONE(0x4000, 0x4100)
+
 VECTOR_HANDLER_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
@@ -891,9 +894,7 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
 VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
+VECTOR_HANDLER_VIRT_NONE(0x4e00, 0x4e20)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -907,13 +908,10 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
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
 
@@ -925,9 +923,7 @@ COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
 __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e60, 0x4e80)
+VECTOR_HANDLER_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 COMMON_HANDLER_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
@@ -1100,6 +1096,7 @@ COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
+VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 #endif
 
 
@@ -1212,6 +1209,7 @@ COMMON_HANDLER(cbe_maintenance, 0x1600, cbe_maintenance_exception)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
+VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
 #endif
 
 
@@ -1233,8 +1231,11 @@ COMMON_HANDLER(cbe_thermal, 0x1800, cbe_thermal_exception)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
+VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 #endif
 
+VECTOR_HANDLER_REAL_NONE(0x1900, 0x2000)
+VECTOR_HANDLER_VIRT_NONE(0x5900, 0x6000)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
-- 
2.8.1
