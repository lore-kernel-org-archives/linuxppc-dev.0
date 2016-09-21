Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVQ0X7wzDsh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:02 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so2028073pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/41] powerpc/64s: consolidate Program 0x700 interrupt
Date: Wed, 21 Sep 2016 17:43:38 +1000
Message-Id: <20160921074407.4885-13-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5e7f9ed..de192dc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -787,8 +787,17 @@ COMMON_HANDLER_END(alignment_common)
 
 
 VECTOR_HANDLER_REAL(program_check, 0x700, 0x800)
-
+VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
 TRAMP_KVM(PACA_EXGEN, 0x700)
+COMMON_HANDLER_BEGIN(program_check_common)
+	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	program_check_exception
+	b	ret_from_except
+COMMON_HANDLER_END(program_check_common)
+
 
 VECTOR_HANDLER_REAL(fp_unavailable, 0x800, 0x900)
 
@@ -1199,7 +1208,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
 VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 VECTOR_HANDLER_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
 VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
@@ -1285,15 +1293,6 @@ COMMON_HANDLER_END(h_data_storage_common)
 
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
-COMMON_HANDLER_BEGIN(program_check_common)
-	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	program_check_exception
-	b	ret_from_except
-COMMON_HANDLER_END(program_check_common)
-
 COMMON_HANDLER_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
-- 
2.9.3
