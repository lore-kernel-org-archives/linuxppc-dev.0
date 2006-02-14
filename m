Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 01CC667B5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 06:07:03 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 14 Feb 2006 12:07:00 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
Message-ID: <20060214190700.GB17822@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

On PPC Book E processsors, we currently handle debug
exceptions on the critical exception stack (debug stack
for E200).  This causes problems with the kgdb single
step handler, which calls smp_processor_id() and spin_lock(),
which reference current_thread_info(), which only works when
we are on the kernel stack.

We address this by switching to the kernel stack early while
handling debug exceptions.  Note that the entry values of r10
and r11 are still saved on the critical exception (or debug) stack.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---

This is low level code and needs careful review.
I've only tested it on mpc8548cds.

I didn't find the corresponding code in arch/powerpc,
so I assume Book E support hasn't been merged yet.

 arch/ppc/kernel/head_booke.h |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
index f3d274c..a5eec51 100644
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -92,7 +92,8 @@
  * registers as the normal prolog above. Instead we use a portion of the
  * critical/machine check exception stack at low physical addresses.
  */
-#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
+#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0,		     \
+				   exc_level_srr1, kernel_sp_reg)	     \
 	mtspr	exc_level##_SPRG,r8;					     \
 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
 	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
@@ -100,7 +101,7 @@
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	mr	r11,r8;							     \
+	mr	r11,kernel_sp_reg;					     \
 	mfspr	r8,exc_level##_SPRG;					     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
@@ -128,11 +129,13 @@
 	SAVE_2GPRS(7, r11)
 
 #define CRITICAL_EXCEPTION_PROLOG \
-		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
+		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1, r8)
+#define CRITICAL_EXCEPTION_ON_KERNEL_STACK_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1, r1)
 #define DEBUG_EXCEPTION_PROLOG \
-		EXC_LEVEL_EXCEPTION_PROLOG(DEBUG, SPRN_DSRR0, SPRN_DSRR1)
+		EXC_LEVEL_EXCEPTION_PROLOG(DEBUG, SPRN_DSRR0, SPRN_DSRR1, r1)
 #define MCHECK_EXCEPTION_PROLOG \
-		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1)
+		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1, r8)
 
 /*
  * Exception vectors.
@@ -268,7 +271,7 @@ label:
 #else
 #define DEBUG_EXCEPTION							      \
 	START_EXCEPTION(Debug);						      \
-	CRITICAL_EXCEPTION_PROLOG;					      \
+	CRITICAL_EXCEPTION_ON_KERNEL_STACK_PROLOG;			      \
 									      \
 	/*								      \
 	 * If there is a single step or branch-taken exception in an	      \
