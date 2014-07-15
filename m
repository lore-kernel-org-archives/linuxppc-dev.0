Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DB371A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 20:25:03 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Move bad_stack() below the fwnmi_data_area
Date: Tue, 15 Jul 2014 20:25:02 +1000
Message-Id: <1405419902-6130-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the allmodconfig build is failing because we run out of
space between altivec_assist() at 0x5700 and the fwnmi_data_area at
0x7000.

Fixing it permanently will take some more work, but a quick fix is to
move bad_stack() below the fwnmi_data_area. That gives us just enough
room with everything enabled.

bad_stack() is called from the common exception handlers, but it's a
non-conditional branch, so we have plenty of scope to move it further
way.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 120 +++++++++++++++++------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b859b3665be6..647d6c75ed62 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -953,66 +953,6 @@ ppc64_runlatch_on_trampoline:
 	b	__ppc64_runlatch_on
 
 /*
- * Here we have detected that the kernel stack pointer is bad.
- * R9 contains the saved CR, r13 points to the paca,
- * r10 contains the (bad) kernel stack pointer,
- * r11 and r12 contain the saved SRR0 and SRR1.
- * We switch to using an emergency stack, save the registers there,
- * and call kernel_bad_stack(), which panics.
- */
-bad_stack:
-	ld	r1,PACAEMERGSP(r13)
-	subi	r1,r1,64+INT_FRAME_SIZE
-	std	r9,_CCR(r1)
-	std	r10,GPR1(r1)
-	std	r11,_NIP(r1)
-	std	r12,_MSR(r1)
-	mfspr	r11,SPRN_DAR
-	mfspr	r12,SPRN_DSISR
-	std	r11,_DAR(r1)
-	std	r12,_DSISR(r1)
-	mflr	r10
-	mfctr	r11
-	mfxer	r12
-	std	r10,_LINK(r1)
-	std	r11,_CTR(r1)
-	std	r12,_XER(r1)
-	SAVE_GPR(0,r1)
-	SAVE_GPR(2,r1)
-	ld	r10,EX_R3(r3)
-	std	r10,GPR3(r1)
-	SAVE_GPR(4,r1)
-	SAVE_4GPRS(5,r1)
-	ld	r9,EX_R9(r3)
-	ld	r10,EX_R10(r3)
-	SAVE_2GPRS(9,r1)
-	ld	r9,EX_R11(r3)
-	ld	r10,EX_R12(r3)
-	ld	r11,EX_R13(r3)
-	std	r9,GPR11(r1)
-	std	r10,GPR12(r1)
-	std	r11,GPR13(r1)
-BEGIN_FTR_SECTION
-	ld	r10,EX_CFAR(r3)
-	std	r10,ORIG_GPR3(r1)
-END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
-	SAVE_8GPRS(14,r1)
-	SAVE_10GPRS(22,r1)
-	lhz	r12,PACA_TRAP_SAVE(r13)
-	std	r12,_TRAP(r1)
-	addi	r11,r1,INT_FRAME_SIZE
-	std	r11,0(r1)
-	li	r12,0
-	std	r12,0(r11)
-	ld	r2,PACATOC(r13)
-	ld	r11,exception_marker@toc(r2)
-	std	r12,RESULT(r1)
-	std	r11,STACK_FRAME_OVERHEAD-16(r1)
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	kernel_bad_stack
-	b	1b
-
-/*
  * Here r13 points to the paca, r9 contains the saved CR,
  * SRR0 and SRR1 are saved in r11 and r12,
  * r9 - r13 are saved in paca->exgen.
@@ -1636,3 +1576,63 @@ handle_dabr_fault:
 	li	r5,SIGSEGV
 	bl	bad_page_fault
 	b	ret_from_except
+
+/*
+ * Here we have detected that the kernel stack pointer is bad.
+ * R9 contains the saved CR, r13 points to the paca,
+ * r10 contains the (bad) kernel stack pointer,
+ * r11 and r12 contain the saved SRR0 and SRR1.
+ * We switch to using an emergency stack, save the registers there,
+ * and call kernel_bad_stack(), which panics.
+ */
+bad_stack:
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,64+INT_FRAME_SIZE
+	std	r9,_CCR(r1)
+	std	r10,GPR1(r1)
+	std	r11,_NIP(r1)
+	std	r12,_MSR(r1)
+	mfspr	r11,SPRN_DAR
+	mfspr	r12,SPRN_DSISR
+	std	r11,_DAR(r1)
+	std	r12,_DSISR(r1)
+	mflr	r10
+	mfctr	r11
+	mfxer	r12
+	std	r10,_LINK(r1)
+	std	r11,_CTR(r1)
+	std	r12,_XER(r1)
+	SAVE_GPR(0,r1)
+	SAVE_GPR(2,r1)
+	ld	r10,EX_R3(r3)
+	std	r10,GPR3(r1)
+	SAVE_GPR(4,r1)
+	SAVE_4GPRS(5,r1)
+	ld	r9,EX_R9(r3)
+	ld	r10,EX_R10(r3)
+	SAVE_2GPRS(9,r1)
+	ld	r9,EX_R11(r3)
+	ld	r10,EX_R12(r3)
+	ld	r11,EX_R13(r3)
+	std	r9,GPR11(r1)
+	std	r10,GPR12(r1)
+	std	r11,GPR13(r1)
+BEGIN_FTR_SECTION
+	ld	r10,EX_CFAR(r3)
+	std	r10,ORIG_GPR3(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
+	SAVE_8GPRS(14,r1)
+	SAVE_10GPRS(22,r1)
+	lhz	r12,PACA_TRAP_SAVE(r13)
+	std	r12,_TRAP(r1)
+	addi	r11,r1,INT_FRAME_SIZE
+	std	r11,0(r1)
+	li	r12,0
+	std	r12,0(r11)
+	ld	r2,PACATOC(r13)
+	ld	r11,exception_marker@toc(r2)
+	std	r12,RESULT(r1)
+	std	r11,STACK_FRAME_OVERHEAD-16(r1)
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	kernel_bad_stack
+	b	1b
-- 
1.9.1
