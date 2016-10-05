Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2H5JdQzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 21/42] powerpc/64s: Consolidate Hypervisor Data Storage
 0xe00 interrupt
Date: Wed,  5 Oct 2016 11:22:43 +1100
Message-Id: <1475626984-18770-22-git-send-email-mpe@ellerman.id.au>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 42 ++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f47c36d605d6..10cf57eb2e77 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -907,10 +907,25 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
 
-	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
-	 * out of line to handle them
-	 */
 __EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
+__TRAMP_REAL_REAL_OOL_HV(h_data_storage, 0xe00)
+EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e00, 0x4e20)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
+EXC_COMMON_BEGIN(h_data_storage_common)
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
+EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
+
 
 __EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 
@@ -1060,9 +1075,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xe00 */
-__TRAMP_REAL_REAL_OOL_HV(h_data_storage, 0xe00)
-TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
-
 __TRAMP_REAL_REAL_OOL_HV(h_instr_storage, 0xe20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 
@@ -1214,7 +1226,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
@@ -1248,10 +1259,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e00, 0x4e20)
-
 EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 EXC_VIRT_END(unused, 0x4e20, 0x4e40)
@@ -1301,19 +1308,6 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-EXC_COMMON_BEGIN(h_data_storage_common)
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
-
-
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 EXC_COMMON_BEGIN(altivec_unavailable_common)
-- 
2.7.4
