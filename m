Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CEDFDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 21:37:25 +1000 (EST)
Date: Wed, 9 Apr 2008 06:25:57 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Rework Book-E debug exception handling
Message-ID: <Pine.LNX.4.64.0804090624480.4465@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The architecture allows for "Book-E" style debug interrupts to either go
to critial interrupts of their own debug interrupt level.  To allow for
a dynamic kernel to support machines of either type we want to be able to
compile in the interrupt handling code for both exception levels.

Towards this goal we renamed the debug handling macros to specify the
interrupt level in their name (DEBUG_CRIT_EXCEPTION/DebugCrit and
DEBUG_DEBUG_EXCEPTION/DebugDebug).

Additionally, on the Freescale Book-e parts we expanded the exception
stacks to cover the maximum case of needing three exception stacks (normal,
machine check and debug).

There is some kernel text space optimization to be gained if a kernel is
configured for a specific Freescale implementation but we aren't handling
that now to allow for the single kernel image support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Josh, can you test on 44x.  I don't expect any harm since its just
renaming a few things.

 arch/powerpc/kernel/head_44x.S       |    4 ++--
 arch/powerpc/kernel/head_booke.h     |   33 ++++++++++++++++++++-------------
 arch/powerpc/kernel/head_fsl_booke.S |   10 ++++++++--
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index ad071a1..b84ec6a 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -211,7 +211,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	SET_IVOR(12, WatchdogTimer);
 	SET_IVOR(13, DataTLBError);
 	SET_IVOR(14, InstructionTLBError);
-	SET_IVOR(15, Debug);
+	SET_IVOR(15, DebugCrit);

 	/* Establish the interrupt vector base */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
@@ -578,7 +578,7 @@ interrupt_base:
 	b	InstructionStorage

 	/* Debug Interrupt */
-	DEBUG_EXCEPTION
+	DEBUG_CRIT_EXCEPTION

 /*
  * Local functions
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index ba9393f..aefafc6 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -56,8 +56,17 @@
  * is necessary since the MMU is always on, for Book-E parts, and the stacks
  * are offset from KERNELBASE.
  *
+ * There is some space optimization to be had here if desired.  However
+ * to allow for a common kernel with support for debug exceptions either
+ * going to critical or their own debug level we aren't currently
+ * providing configurations that micro-optimize space usage.
  */
-#define BOOKE_EXCEPTION_STACK_SIZE	(8192)
+#ifdef CONFIG_44x
+#define NUM_EXCEPTION_LVLS	2
+#else
+#define NUM_EXCEPTION_LVLS	3
+#endif
+#define BOOKE_EXCEPTION_STACK_SIZE	(4096 * NUM_EXCEPTION_LVLS)

 /* CRIT_SPRG only used in critical exception handling */
 #define CRIT_SPRG	SPRN_SPRG2
@@ -68,7 +77,7 @@
 #define CRIT_STACK_TOP		(exception_stack_top)

 /* only on e200 for now */
-#define DEBUG_STACK_TOP		(exception_stack_top - 4096)
+#define DEBUG_STACK_TOP		(exception_stack_top - 8192)
 #define DEBUG_SPRG		SPRN_SPRG6W

 #ifdef CONFIG_SMP
@@ -212,9 +221,8 @@ label:
  * save (and later restore) the MSR via SPRN_CSRR1, which will still have
  * the MSR_DE bit set.
  */
-#ifdef CONFIG_E200
-#define DEBUG_EXCEPTION							      \
-	START_EXCEPTION(Debug);						      \
+#define DEBUG_DEBUG_EXCEPTION						      \
+	START_EXCEPTION(DebugDebug);					      \
 	DEBUG_EXCEPTION_PROLOG;						      \
 									      \
 	/*								      \
@@ -234,8 +242,8 @@ label:
 	cmplw	r12,r10;						      \
 	blt+	2f;			/* addr below exception vectors */    \
 									      \
-	lis	r10,Debug@h;						      \
-	ori	r10,r10,Debug@l;					      \
+	lis	r10,DebugDebug@h;					      \
+	ori	r10,r10,DebugDebug@l;					      \
 	cmplw	r12,r10;						      \
 	bgt+	2f;			/* addr above exception vectors */    \
 									      \
@@ -265,9 +273,9 @@ label:
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
-#else
-#define DEBUG_EXCEPTION							      \
-	START_EXCEPTION(Debug);						      \
+
+#define DEBUG_CRIT_EXCEPTION						      \
+	START_EXCEPTION(DebugCrit);					      \
 	CRITICAL_EXCEPTION_PROLOG;					      \
 									      \
 	/*								      \
@@ -287,8 +295,8 @@ label:
 	cmplw	r12,r10;						      \
 	blt+	2f;			/* addr below exception vectors */    \
 									      \
-	lis	r10,Debug@h;						      \
-	ori	r10,r10,Debug@l;					      \
+	lis	r10,DebugCrit@h;						      \
+	ori	r10,r10,DebugCrit@l;					      \
 	cmplw	r12,r10;						      \
 	bgt+	2f;			/* addr above exception vectors */    \
 									      \
@@ -318,7 +326,6 @@ label:
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
-#endif

 #define INSTRUCTION_STORAGE_EXCEPTION					      \
 	START_EXCEPTION(InstructionStorage)				      \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d9cc2c2..92bf2cc 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -283,7 +283,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	SET_IVOR(12, WatchdogTimer);
 	SET_IVOR(13, DataTLBError);
 	SET_IVOR(14, InstructionTLBError);
-	SET_IVOR(15, Debug);
+	SET_IVOR(15, DebugDebug);
+#if defined(CONFIG_E500)
+	SET_IVOR(15, DebugCrit);
+#endif
 	SET_IVOR(32, SPEUnavailable);
 	SET_IVOR(33, SPEFloatingPointData);
 	SET_IVOR(34, SPEFloatingPointRound);
@@ -718,7 +721,10 @@ interrupt_base:


 	/* Debug Interrupt */
-	DEBUG_EXCEPTION
+	DEBUG_DEBUG_EXCEPTION
+#if defined(CONFIG_E500)
+	DEBUG_CRIT_EXCEPTION
+#endif

 /*
  * Local functions
-- 
1.5.4.1
