Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 20 Jun 2008 14:13:52 +1000
Subject: [PATCH 4/9] powerpc: Make load_up_fpu and load_up_altivec callable
In-Reply-To: <1213935232.194904.168421502953.qpush@coopers>
Message-Id: <20080620041352.4FF8C70295@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make load_up_fpu and load_up_altivec callable so they can be reused by
the VSX code.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/fpu.S        |    2 +-
 arch/powerpc/kernel/head_32.S    |    6 ++++--
 arch/powerpc/kernel/head_64.S    |    8 +++++---
 arch/powerpc/kernel/head_booke.h |    6 ++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/fpu.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
@@ -85,7 +85,7 @@ _GLOBAL(load_up_fpu)
 #endif /* CONFIG_SMP */
 	/* restore registers and return */
 	/* we haven't used ctr or xer or lr */
-	b	fast_exception_return
+	blr
 
 /*
  * giveup_fpu(tsk)
Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_32.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_32.S
@@ -421,8 +421,10 @@ BEGIN_FTR_SECTION
 	b 	ProgramCheck
 END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
 	EXCEPTION_PROLOG
-	bne	load_up_fpu		/* if from user, just load it up */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+	beq	1f
+	bl	load_up_fpu		/* if from user, just load it up */
+	b	fast_exception_return
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
 /* Decrementer */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
@@ -741,7 +741,8 @@ fp_unavailable_common:
 	ENABLE_INTS
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
-1:	b	.load_up_fpu
+1:	bl	.load_up_fpu
+	b	fast_exception_return
 
 	.align	7
 	.globl altivec_unavailable_common
@@ -749,7 +750,8 @@ altivec_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
-	bne	.load_up_altivec	/* if from user, just load it up */
+	bnel	.load_up_altivec
+	b	fast_exception_return
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	.save_nvgprs
@@ -829,7 +831,7 @@ _STATIC(load_up_altivec)
 	std	r4,0(r3)
 #endif /* CONFIG_SMP */
 	/* restore registers and return */
-	b	fast_exception_return
+	blr
 #endif /* CONFIG_ALTIVEC */
 
 /*
Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_booke.h
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_booke.h
@@ -363,8 +363,10 @@ label:
 #define FP_UNAVAILABLE_EXCEPTION					      \
 	START_EXCEPTION(FloatingPointUnavailable)			      \
 	NORMAL_EXCEPTION_PROLOG;					      \
-	bne	load_up_fpu;		/* if from user, just load it up */   \
-	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	beq	1f;							      \
+	bl	load_up_fpu;		/* if from user, just load it up */   \
+	b	fast_exception_return;					      \
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
 #endif /* __HEAD_BOOKE_H__ */
