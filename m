Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2D16vjzDrMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 13/42] powerpc/64s: Consolidate Program 0x700 interrupt
Date: Wed,  5 Oct 2016 11:22:35 +1100
Message-Id: <1475626984-18770-14-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index debd02436ed6..1df0283a5b3e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -792,8 +792,16 @@ EXC_COMMON_BEGIN(alignment_common)
 
 
 EXC_REAL(program_check, 0x700, 0x800)
-
+EXC_VIRT(program_check, 0x4700, 0x4800, 0x700)
 TRAMP_KVM(PACA_EXGEN, 0x700)
+EXC_COMMON_BEGIN(program_check_common)
+	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	program_check_exception
+	b	ret_from_except
+
 
 EXC_REAL(fp_unavailable, 0x800, 0x900)
 
@@ -1197,7 +1205,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(program_check, 0x4700, 0x4800, 0x700)
 EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
 EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
 EXC_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
@@ -1281,14 +1288,6 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
-EXC_COMMON_BEGIN(program_check_common)
-	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
-	bl	save_nvgprs
-	RECONCILE_IRQ_STATE(r10, r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	program_check_exception
-	b	ret_from_except
-
 EXC_COMMON_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
-- 
2.7.4
