Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVm16dLzDsgh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:20 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 6so2029852pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/41] powerpc/64s: consolidate Hypervisor Data Storage 0xe00
 interrupt
Date: Wed, 21 Sep 2016 17:43:46 +1000
Message-Id: <20160921074407.4885-21-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 44 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1a9618f..8dceb35 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -903,10 +903,26 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 
 
-	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
-	 * out of line to handle them
-	 */
 __VECTOR_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
+__TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
+COMMON_HANDLER_BEGIN(h_data_storage_common)
+	mfspr   r10,SPRN_HDAR
+	std     r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr   r10,SPRN_HDSISR
+	stw     r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
+	bl      save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      unknown_exception
+	b       ret_from_except
+COMMON_HANDLER_END(h_data_storage_common)
+COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
+
 
 __VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 
@@ -1058,9 +1074,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
-
 __TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 
@@ -1214,7 +1227,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
@@ -1252,10 +1264,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e00, 0x4e20)
-
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
@@ -1306,20 +1314,6 @@ TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-COMMON_HANDLER_BEGIN(h_data_storage_common)
-	mfspr   r10,SPRN_HDAR
-	std     r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr   r10,SPRN_HDSISR
-	stw     r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
-	bl      save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	bl      unknown_exception
-	b       ret_from_except
-COMMON_HANDLER_END(h_data_storage_common)
-
-
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
-- 
2.9.3
