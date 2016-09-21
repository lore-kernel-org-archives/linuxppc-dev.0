Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVM4gTszDsgn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:59 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id my20so1945014pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/41] powerpc/64s: consolidate Alignment 0x600 interrupt
Date: Wed, 21 Sep 2016 17:43:37 +1000
Message-Id: <20160921074407.4885-12-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index fc5ad5c..5e7f9ed 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -766,8 +766,25 @@ COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
 
 VECTOR_HANDLER_REAL(alignment, 0x600, 0x700)
-
+VECTOR_HANDLER_VIRT(alignment, 0x4600, 0x4700, 0x600)
 TRAMP_KVM(PACA_EXGEN, 0x600)
+COMMON_HANDLER_BEGIN(alignment_common)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	alignment_exception
+	b	ret_from_except
+COMMON_HANDLER_END(alignment_common)
+
 
 VECTOR_HANDLER_REAL(program_check, 0x700, 0x800)
 
@@ -1182,7 +1199,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(alignment, 0x4600, 0x4700, 0x600)
 VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
 VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
@@ -1269,23 +1285,6 @@ COMMON_HANDLER_END(h_data_storage_common)
 
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
-COMMON_HANDLER_BEGIN(alignment_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	alignment_exception
-	b	ret_from_except
-COMMON_HANDLER_END(alignment_common)
-
 COMMON_HANDLER_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
-- 
2.9.3
