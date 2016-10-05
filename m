Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2D54cZzDrMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 14/42] powerpc/64s: Consolidate FP Unavailable 0x800
 interrupt
Date: Wed,  5 Oct 2016 11:22:36 +1100
Message-Id: <1475626984-18770-15-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 61 ++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1df0283a5b3e..ac727633cbb1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -804,8 +804,37 @@ EXC_COMMON_BEGIN(program_check_common)
 
 
 EXC_REAL(fp_unavailable, 0x800, 0x900)
-
+EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 TRAMP_KVM(PACA_EXGEN, 0x800)
+EXC_COMMON_BEGIN(fp_unavailable_common)
+	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
+	bne	1f			/* if from user, just load it up */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	kernel_fp_unavailable_exception
+	BUG_OPCODE
+1:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
+	 * transaction), go do TM stuff
+	 */
+	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
+	bne-	2f
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
+#endif
+	bl	load_up_fpu
+	b	fast_exception_return
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	fp_unavailable_tm
+	b	ret_from_except
+#endif
+
 
 EXC_REAL_MASKABLE(decrementer, 0x900, 0x980)
 
@@ -1205,7 +1234,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
 EXC_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
 EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
@@ -1288,35 +1316,6 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
-EXC_COMMON_BEGIN(fp_unavailable_common)
-	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
-	bne	1f			/* if from user, just load it up */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	kernel_fp_unavailable_exception
-	BUG_OPCODE
-1:
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-BEGIN_FTR_SECTION
-	/* Test if 2 TM state bits are zero.  If non-zero (ie. userspace was in
-	 * transaction), go do TM stuff
-	 */
-	rldicl.	r0, r12, (64-MSR_TS_LG), (64-2)
-	bne-	2f
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
-#endif
-	bl	load_up_fpu
-	b	fast_exception_return
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-2:	/* User process was in a transaction */
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	fp_unavailable_tm
-	b	ret_from_except
-#endif
-
 EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
-- 
2.7.4
