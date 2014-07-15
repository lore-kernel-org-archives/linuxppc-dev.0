Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4407E1A0B92
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 21:15:45 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc: Remove misleading DISABLE_INTS
Date: Tue, 15 Jul 2014 21:15:38 +1000
Message-Id: <1405422938-27608-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1405422938-27608-1-git-send-email-mpe@ellerman.id.au>
References: <1405422938-27608-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DISABLE_INTS has a long and storied history, but for some time now it
has not actually disabled interrupts.

For the open-coded exception handlers, just stop using it, instead call
RECONCILE_IRQ_STATE directly. This has the benefit of removing a level
of indirection, and making it clear that r10 & r11 are used at that
point.

For the addition case we still need a macro, so rename it to clarify
what it actually does.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 11 +++++++----
 arch/powerpc/kernel/exceptions-64s.S     | 28 ++++++++++++++--------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 066c15cd2837..13a63379e496 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -513,8 +513,11 @@ label##_relon_hv:							\
  * runlatch, etc...
  */
 
-/* Exception addition: Hard disable interrupts */
-#define DISABLE_INTS	RECONCILE_IRQ_STATE(r10,r11)
+/*
+ * This addition reconciles our actual IRQ state with the various software
+ * flags that track it. This may call C code.
+ */
+#define ADD_RECONCILE	RECONCILE_IRQ_STATE(r10,r11)
 
 #define ADD_NVGPRS				\
 	bl	save_nvgprs
@@ -540,7 +543,7 @@ label##_common:							\
 
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
 	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except,	\
-			 ADD_NVGPRS;DISABLE_INTS)
+			 ADD_NVGPRS;ADD_RECONCILE)
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
@@ -549,7 +552,7 @@ label##_common:							\
  */
 #define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		  \
 	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except_lite, \
-			 FINISH_NAP;DISABLE_INTS;RUNLATCH_ON)
+			 FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a7d36b19221d..03a54ef03049 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1057,7 +1057,7 @@ data_access_common:
 	mfspr	r10,SPRN_DSISR
 	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
@@ -1073,7 +1073,7 @@ h_data_storage_common:
 	stw     r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
 	bl      save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	bl      unknown_exception
 	b       ret_from_except
@@ -1082,7 +1082,7 @@ h_data_storage_common:
 	.globl instruction_access_common
 instruction_access_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
@@ -1146,7 +1146,7 @@ slb_miss_fault:
 
 unrecov_user_slb:
 	EXCEPTION_PROLOG_COMMON(0x4200, PACA_EXGEN)
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	bl	save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	unrecoverable_exception
@@ -1169,7 +1169,7 @@ machine_check_common:
 	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
 	FINISH_NAP
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
 	std	r3,_DAR(r1)
@@ -1192,7 +1192,7 @@ alignment_common:
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	alignment_exception
 	b	ret_from_except
@@ -1202,7 +1202,7 @@ alignment_common:
 program_check_common:
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	program_check_exception
 	b	ret_from_except
@@ -1213,7 +1213,7 @@ fp_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	kernel_fp_unavailable_exception
 	BUG_OPCODE
@@ -1232,7 +1232,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	fp_unavailable_tm
 	b	ret_from_except
@@ -1258,7 +1258,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_tm
 	b	ret_from_except
@@ -1267,7 +1267,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	altivec_unavailable_exception
 	b	ret_from_except
@@ -1292,7 +1292,7 @@ BEGIN_FTR_SECTION
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_tm
 	b	ret_from_except
@@ -1301,7 +1301,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	bl	save_nvgprs
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	vsx_unavailable_exception
 	b	ret_from_except
@@ -1566,7 +1566,7 @@ slb_miss_realmode:
 
 unrecov_slb:
 	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	DISABLE_INTS
+	RECONCILE_IRQ_STATE(r10, r11)
 	bl	save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	unrecoverable_exception
-- 
1.9.1
