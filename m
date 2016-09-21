Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVS26nlzDshB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:04 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id n24so2028131pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/41] powerpc/64s: consolidate FP Unavailable 0x800 interrupt
Date: Wed, 21 Sep 2016 17:43:39 +1000
Message-Id: <20160921074407.4885-14-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 63 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index de192dc..e81bcd4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -800,8 +800,38 @@ COMMON_HANDLER_END(program_check_common)
 
 
 VECTOR_HANDLER_REAL(fp_unavailable, 0x800, 0x900)
-
+VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 TRAMP_KVM(PACA_EXGEN, 0x800)
+COMMON_HANDLER_BEGIN(fp_unavailable_common)
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
+COMMON_HANDLER_END(fp_unavailable_common)
+
 
 VECTOR_HANDLER_REAL_MASKABLE(decrementer, 0x900, 0x980)
 
@@ -1208,7 +1238,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
 VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
 VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
@@ -1293,36 +1322,6 @@ COMMON_HANDLER_END(h_data_storage_common)
 
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
-COMMON_HANDLER_BEGIN(fp_unavailable_common)
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
-COMMON_HANDLER_END(fp_unavailable_common)
-
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
-- 
2.9.3
