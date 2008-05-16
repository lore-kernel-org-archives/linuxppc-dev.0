Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7F00DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:06:38 +1000 (EST)
Date: Fri, 16 May 2008 14:06:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 2/3] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
In-Reply-To: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0805161406100.6286@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Cleanup the code a bit my allocating an INT_FRAME on our exception
  stack there by make references go from GPR11-INT_FRAME_SIZE(r8) to
  just GPR11(r8)
* simplify {lvl}_transfer_to_handler code by moving the copying of the
  temp registers we use if we come from user space into the PROLOG
* If the exception came from kernel mode copy thread_info flags,
  preempt, and task pointer from the process thread_info.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* fix copying of thread_info fields onto proper stack

- k

 arch/powerpc/kernel/entry_32.S   |   13 ---------
 arch/powerpc/kernel/head_booke.h |   54 ++++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3a05e9f..13aea53 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -44,29 +44,16 @@
 #endif

 #ifdef CONFIG_BOOKE
-#include "head_booke.h"
-#define TRANSFER_TO_HANDLER_EXC_LEVEL(exc_level)	\
-	mtspr	exc_level##_SPRG,r8;			\
-	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);		\
-	lwz	r0,GPR10-INT_FRAME_SIZE(r8);		\
-	stw	r0,GPR10(r11);				\
-	lwz	r0,GPR11-INT_FRAME_SIZE(r8);		\
-	stw	r0,GPR11(r11);				\
-	mfspr	r8,exc_level##_SPRG
-
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-	TRANSFER_TO_HANDLER_EXC_LEVEL(MCHECK)
 	b	transfer_to_handler_full

 	.globl	debug_transfer_to_handler
 debug_transfer_to_handler:
-	TRANSFER_TO_HANDLER_EXC_LEVEL(DEBUG)
 	b	transfer_to_handler_full

 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-	TRANSFER_TO_HANDLER_EXC_LEVEL(CRIT)
 	/* fall through */
 #endif

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 9eacf4c..b0874d2 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -72,18 +72,20 @@
 #define DEBUG_STACK_BASE	dbgirq_ctx
 #define DEBUG_SPRG		SPRN_SPRG6W

+#define EXC_LVL_FRAME_OVERHEAD	(THREAD_SIZE - INT_FRAME_SIZE)
+
 #ifdef CONFIG_SMP
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	mfspr	r8,SPRN_PIR;				\
 	slwi	r8,r8,2;				\
 	addis	r8,r8,level##_STACK_BASE@ha;		\
 	lwz	r8,level##_STACK_BASE@l(r8);		\
-	addi	r8,r8,THREAD_SIZE;
+	addi	r8,r8,EXC_LVL_FRAME_OVERHEAD;
 #else
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	lis	r8,level##_STACK_BASE@ha;		\
 	lwz	r8,level##_STACK_BASE@l(r8);		\
-	addi	r8,r8,THREAD_SIZE;
+	addi	r8,r8,EXC_LVL_FRAME_OVERHEAD;
 #endif

 /*
@@ -97,22 +99,36 @@
 #define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
 	mtspr	exc_level##_SPRG,r8;					     \
 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
-	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
-	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
-	mfcr	r10;			/* save CR in r10 for now	   */\
-	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
-	andi.	r11,r11,MSR_PR;						     \
-	mr	r11,r8;							     \
-	mfspr	r8,exc_level##_SPRG;					     \
-	beq	1f;							     \
-	/* COMING FROM USER MODE */					     \
+	stw	r9,GPR9(r8);		/* save various registers	   */\
+	mfcr	r9;			/* save CR in r9 for now	   */\
+	stw	r10,GPR10(r8);						     \
+	stw	r11,GPR11(r8);						     \
+	stw	r9,_CCR(r8);		/* save CR on stack		   */\
+	mfspr	r10,exc_level_srr1;	/* check whether user or kernel    */\
+	andi.	r10,r10,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,THREAD_SIZE;					     \
-1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
-	stw	r10,_CCR(r11);          /* save various registers	   */\
-	stw	r12,GPR12(r11);						     \
+	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
+	beq	1f;							     \
+	/* COMING FROM USER MODE */					     \
+	stw	r9,_CCR(r11);		/* save CR			   */\
+	lwz	r10,GPR10(r8);		/* copy regs from exception stack  */\
+	lwz	r9,GPR9(r8);						     \
+	stw	r10,GPR10(r11);						     \
+	lwz	r10,GPR11(r8);						     \
 	stw	r9,GPR9(r11);						     \
+	stw	r10,GPR11(r11);						     \
+	b	2f;							     \
+	/* COMING FROM PRIV MODE */					     \
+1:	lwz	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r11);		     \
+	lwz	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r11);		     \
+	stw	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r8);			     \
+	stw	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r8);		     \
+	lwz	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r11);			     \
+	stw	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r8);			     \
+	mr	r11,r8;							     \
+2:	mfspr	r8,exc_level##_SPRG;					     \
+	stw	r12,GPR12(r11);		/* save various registers	   */\
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
 	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
@@ -255,8 +271,8 @@ label:
 	lwz	r12,GPR12(r11);						      \
 	mtspr	DEBUG_SPRG,r8;						      \
 	BOOKE_LOAD_EXC_LEVEL_STACK(DEBUG); /* r8 points to the debug stack */ \
-	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
-	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	lwz	r10,GPR10(r8);						      \
+	lwz	r11,GPR11(r8);						      \
 	mfspr	r8,DEBUG_SPRG;						      \
 									      \
 	RFDI;								      \
@@ -308,8 +324,8 @@ label:
 	lwz	r12,GPR12(r11);						      \
 	mtspr	CRIT_SPRG,r8;						      \
 	BOOKE_LOAD_EXC_LEVEL_STACK(CRIT); /* r8 points to the debug stack */  \
-	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
-	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	lwz	r10,GPR10(r8);						      \
+	lwz	r11,GPR11(r8);						      \
 	mfspr	r8,CRIT_SPRG;						      \
 									      \
 	rfci;								      \
-- 
1.5.4.5
