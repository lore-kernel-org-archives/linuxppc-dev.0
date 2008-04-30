Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A0FDDDF27
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 19:31:21 +1000 (EST)
Date: Wed, 30 Apr 2008 04:27:07 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Message-ID: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
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
  just GPR(r8)
* simplify {lvl}_transfer_to_handler code by moving the copying of the
  temp registers we use if we come from user space into the PROLOG
* If the exception came from kernel mode copy thread_info flags,
  preempt, and task pointer from the process thread_info.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

I'm not sure if the copying of TI_FLAGS, TI_PREEMPT, and TI_TASK
are really needed.  I'm a bit concerned what to do if we get a
CriticalInput while in kernel mode and the handler causes a reschedule.

 arch/powerpc/kernel/entry_32.S   |   13 ----------
 arch/powerpc/kernel/head_booke.h |   47 ++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0c8614d..816dd54 100644
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
index d647e05..78baec5 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -78,12 +78,12 @@
 	slwi	r8,r8,2;				\
 	addis	r8,r8,level##_STACK_TOP@ha;		\
 	lwz	r8,level##_STACK_TOP@l(r8);		\
-	addi	r8,r8,THREAD_SIZE;
+	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
 #else
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	lis	r8,level##_STACK_TOP@ha;		\
 	lwz	r8,level##_STACK_TOP@l(r8);		\
-	addi	r8,r8,THREAD_SIZE;
+	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
 #endif

 /*
@@ -97,22 +97,35 @@
 #define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
 	mtspr	exc_level##_SPRG,r8;					     \
 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
-	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
-	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
+	stw	r9,GPR9(r8);		/* save various registers	   */\
+	stw	r10,GPR10(r8);						     \
+	stw	r11,GPR11(r8);						     \
+	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
+	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc exception frm */\
 	mfcr	r10;			/* save CR in r10 for now	   */\
-	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
-	andi.	r11,r11,MSR_PR;						     \
-	mr	r11,r8;							     \
-	mfspr	r8,exc_level##_SPRG;					     \
+	mfspr	r9,exc_level_srr1;	/* check whether user or kernel    */\
+	andi.	r9,r9,MSR_PR;						     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
-	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,THREAD_SIZE;					     \
-1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
+	lwz	r9,GPR9(r8);		/* copy regs from exception stack  */\
+	stw	r9,GPR9(r11);						     \
+	lwz	r9,GPR10(r8);						     \
+	stw	r9,GPR10(r11);						     \
+	lwz	r9,GPR11(r8);						     \
+	stw	r9,GPR11(r11);						     \
+	b	2f;							     \
+	/* COMING FROM PRIV MODE */					     \
+1:	lwz	r9,TI_FLAGS-THREAD_SIZE(r11);				     \
+	stw	r9,TI_FLAGS-THREAD_SIZE(r8);				     \
+	lwz	r9,TI_PREEMPT-THREAD_SIZE(r11);				     \
+	stw	r9,TI_PREEMPT-THREAD_SIZE(r8);				     \
+	lwz	r9,TI_TASK-THREAD_SIZE(r11);				     \
+	stw	r9,TI_TASK-THREAD_SIZE(r8);				     \
+	mr	r11,r8;							     \
+2:	mfspr	r8,exc_level##_SPRG;					     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
-	stw	r9,GPR9(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
 	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
@@ -255,8 +268,8 @@ label:
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
@@ -308,8 +321,8 @@ label:
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
1.5.4.1
