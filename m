Message-ID: <3F4FB0F3.9090906@acm.org>
Date: Fri, 29 Aug 2003 15:00:51 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Change to allow signal handlers to set SE and BE bits.
Content-Type: multipart/mixed;
 boundary="------------040800060406010009020508"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040800060406010009020508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a debugger that runs in an application that requires access to
the SE and BE bits.  The following patch adds that capability to
2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
out of signal handlers, and it seems to work for 4xx.  Does this look ok?

Thanks

-Corey

--------------040800060406010009020508
Content-Type: text/plain;
 name="ppc-dbgr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc-dbgr.diff"

--- arch/ppc/kernel/signal.c.old	2003-08-28 15:30:37.000000000 -0500
+++ arch/ppc/kernel/signal.c	2003-08-28 18:23:25.000000000 -0500
@@ -284,12 +284,12 @@

 /*
  * Restore the current user register values from the user stack,
- * (except for MSR).
+ * (except for MSR, which is partially restored for 6xx).
  */
 static int
 restore_user_regs(struct pt_regs *regs, struct mcontext *sr, int mctxsize)
 {
-#ifdef CONFIG_ALTIVEC
+#if defined(CONFIG_ALTIVEC) || defined(CONFIG_6xx)
 	unsigned long msr;
 #endif

@@ -299,6 +299,31 @@
 	/* copy up to but not including MSR */
 	if (__copy_from_user(regs, &sr->mc_gregs, PT_MSR * sizeof(elf_greg_t)))
 		return 1;
+	/* Special handling for the msr. */
+	if (__copy_from_user(&msr, &sr->mc_gregs[PT_MSR], sizeof(elf_greg_t)))
+		return 1;
+#if defined(CONFIG_4xx)
+	/*
+	 * If the signal handlers sets the MSR_SE bit in the MSR, then
+	 * we use that to tell us to turn on single-stepping.  Also set
+	 * it if single stepping is enabled.
+	 */
+	if ((msr & MSR_SE) || (current->thread.single_stepping)) {
+		regs->msr |= MSR_DE;
+		task->thread.dbcr0 |=  (DBCR0_IDM | DBCR0_IC);
+	}
+#else
+	/*
+	 * Take certain bits from the MSR.
+	 * Allow a signal handler to set these bits in the MSR, it is
+	 * neccesary for some debuggers to work.
+	 */
+#define MSR_USERALLOWED		(MSR_BE | MSR_SE)
+	regs->msr &= ~MSR_USERALLOWED;
+	regs->msr |= msr & MSR_USERALLOWED;
+	if (current->thread.single_stepping)
+		regs->msr |= MSR_SE;
+#endif
 	/* copy from orig_r3 (the word after the MSR) up to the end */
 	if (__copy_from_user(&regs->orig_gpr3, &sr->mc_gregs[PT_ORIG_R3],
 			     GP_REGS_SIZE - PT_ORIG_R3 * sizeof(elf_greg_t)))
--- arch/ppc/kernel/traps.c.old	2003-08-28 15:42:26.000000000 -0500
+++ arch/ppc/kernel/traps.c	2003-08-29 10:04:02.000000000 -0500
@@ -396,7 +396,8 @@
 void
 SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
+	current->thread.single_stepping = 0;
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
@@ -491,6 +492,7 @@

 		mtspr(SPRN_DBSR, DBSR_IC);
 		current->thread.dbcr0 &=  ~DBCR0_IC;
+		current->thread.single_stepping = 0;

 		if (!user_mode(regs) && debugger_sstep(regs))
 			return;
--- arch/ppc/kernel/ptrace.c.old	2003-08-28 18:03:53.000000000 -0500
+++ arch/ppc/kernel/ptrace.c	2003-08-28 18:05:05.000000000 -0500
@@ -140,7 +140,7 @@
 	if (regs != NULL)
 		regs->msr |= MSR_SE;
 #endif
-
+	task->thread.single_stepping = 1;
 }

 static inline void
@@ -154,6 +154,7 @@
 	if (regs != NULL)
 		regs->msr &= ~MSR_SE;
 #endif
+	task->thread.single_stepping = 0;
 }

 /*
--- include/asm-ppc/processor.h.old	2003-08-28 18:08:09.000000000 -0500
+++ include/asm-ppc/processor.h	2003-08-28 18:09:02.000000000 -0500
@@ -722,6 +722,8 @@
 	/* Saved 4xx debug registers */
 	unsigned long dbcr0;
 #endif
+	int           single_stepping;  /* Set by ptrace if the thread is
+					   single-stepping. */
 };

 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
@@ -731,6 +733,7 @@
 	.fs = KERNEL_DS, \
 	.pgdir = swapper_pg_dir, \
 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
+	.single_stepping = 0, \
 }

 /*

--------------040800060406010009020508--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
