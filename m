Message-ID: <410726E9.9050804@acm.org>
Date: Tue, 27 Jul 2004 23:09:13 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch for debug setcontext
Content-Type: multipart/mixed;
 boundary="------------060301070305000100050802"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060301070305000100050802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds the ability to do a setcontext and set up debug
information in the kernel.  It lets you set a context and turn on
single-stepping and branch tracing.

I am using this to enable an in-application debugger.  Basically, you
can insert traps and cause a signal (or cause a signal via other
means).  From the signal handler you can single step or branch trace
using this patch.  The single-stepping is important so that an
instruction may be emulated in a different location so the trap doesn't
have to be replaced.  It is also used to step threads out of critical
areas in some cases.

In the future, even cooler things could be added to this framework like
support for setting up hardware breakpoints.  I have done this in the
past in another job and it can be quite handy.

I have tested this on 440GP and 750.  The patch is relative to stock 2.6.7.

The most problematic part of this patch is probably the 4xx part using
the values in the dbcr0 register to figure out if it needs to be
loaded.  I did it this way because it seems the easiest way to do it
since you can't just use PT_PTRACE to know if the register needs to be
loaded.  I didn't see any problems but I don't know if there are any
races that might cause problems with this method.

Signed-off-by: Corey Minyard <minyard@acm.org>

--------------060301070305000100050802
Content-Type: text/plain;
 name="ppc_debug_setcontext.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_debug_setcontext.diff"

Index: linux-ipmi/arch/ppc/kernel/entry.S
===================================================================
--- linux-ipmi.orig/arch/ppc/kernel/entry.S	2004-06-22 13:31:41.000000000 -0500
+++ linux-ipmi/arch/ppc/kernel/entry.S	2004-07-27 21:14:55.000000000 -0500
@@ -111,8 +111,10 @@
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	lwz	r12,PTRACE-THREAD(r12)
-	andi.	r12,r12,PT_PTRACED
+	/* Check to see if the dbcr0 register is set up to debug.  Use the
+	   single-step bit to do this. */
+	lwz	r12,THREAD_DBCR0(r12)
+	andis.	r12,r12,DBCR0_IC@h
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -242,9 +244,10 @@
 	bne-	syscall_exit_work
 syscall_exit_cont:
 #ifdef CONFIG_4xx
-	/* If the process has its own DBCR0 value, load it up */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* If the process has its own DBCR0 value, load it up.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_4xx_dbcr0
 #endif
 	stwcx.	r0,0,r1			/* to clear the reservation */
@@ -590,9 +593,10 @@

 restore_user:
 #ifdef CONFIG_4xx
-	/* Check whether this process has its own DBCR0 value */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* Check whether this process has its own DBCR0 value.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_4xx_dbcr0
 #endif

@@ -867,14 +871,13 @@
  * having first saved away the global DBCR0.
  */
 load_4xx_dbcr0:
-	mfmsr	r0		/* first disable debug exceptions */
-	rlwinm	r0,r0,0,~MSR_DE
-	mtmsr	r0
+	mfmsr	r10		/* first disable debug exceptions */
+	rlwinm	r10,r10,0,~MSR_DE
+	mtmsr	r10
 	isync
 	mfspr	r10,SPRN_DBCR0
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
-	lwz	r0,THREAD+THREAD_DBCR0(r2)
 	stw	r10,0(r11)
 	mtspr	SPRN_DBCR0,r0
 	lwz	r10,4(r11)
Index: linux-ipmi/arch/ppc/kernel/misc.S
===================================================================
--- linux-ipmi.orig/arch/ppc/kernel/misc.S	2004-06-22 13:31:41.000000000 -0500
+++ linux-ipmi/arch/ppc/kernel/misc.S	2004-07-27 15:14:06.000000000 -0500
@@ -1385,7 +1385,7 @@
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall		/* 255 - rtas (used on ppc64) */
-	.long sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.long sys_debug_setcontext
 	.long sys_ni_syscall		/* 257 reserved for vserver */
 	.long sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
 	.long sys_ni_syscall		/* 259 reserved for new sys_mbind */
Index: linux-ipmi/arch/ppc/kernel/signal.c
===================================================================
--- linux-ipmi.orig/arch/ppc/kernel/signal.c	2004-06-22 13:28:05.000000000 -0500
+++ linux-ipmi/arch/ppc/kernel/signal.c	2004-07-27 21:12:25.000000000 -0500
@@ -462,6 +462,96 @@
 	return 0;
 }

+int sys_debug_setcontext(struct ucontext __user *ctx,
+			 int ndbg, struct sig_dbg_op *dbg,
+			 int r6, int r7, int r8,
+			 struct pt_regs *regs)
+{
+	struct sig_dbg_op op;
+	int i;
+	unsigned long new_msr = regs->msr;
+#if defined(CONFIG_4xx)
+	unsigned long new_dbcr0 = current->thread.dbcr0;
+#endif
+
+	for (i=0; i<ndbg; i++) {
+		if (__copy_from_user(&op, dbg, sizeof(op)))
+			return -EFAULT;
+		switch (op.dbg_type) {
+		case SIG_DBG_SINGLE_STEPPING:
+#if defined(CONFIG_4xx)
+			if (op.dbg_value) {
+				new_msr |= MSR_DE;
+				new_dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+			} else {
+				new_msr &= ~MSR_DE;
+				new_dbcr0 &= ~(DBCR0_IDM | DBCR0_IC);
+			}
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_SE;
+			else
+				new_msr &= ~MSR_SE;
+#endif
+			break;
+		case SIG_DBG_BRANCH_TRACING:
+#if defined(CONFIG_4xx)
+			return -EINVAL;
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_BE;
+			else
+				new_msr &= ~MSR_BE;
+#endif
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* We wait until here to actually install the values in the
+	   registers so if we fail in the above loop, it will not
+	   affect the contents of these registers.  After this point,
+	   failure is a problem, anyway, and it's very unlikely unless
+	   the user is really doing something wrong. */
+	regs->msr = new_msr;
+#if defined(CONFIG_4xx)
+	current->thread.dbcr0 = new_dbcr0;
+#endif
+
+	/*
+	 * If we get a fault copying the context into the kernel's
+	 * image of the user's registers, we can't just return -EFAULT
+	 * because the user's registers will be corrupted.  For instance
+	 * the NIP value may have been updated but not some of the
+	 * other registers.  Given that we have done the verify_area
+	 * and successfully read the first and last bytes of the region
+	 * above, this should only happen in an out-of-memory situation
+	 * or if another thread unmaps the region containing the context.
+	 * We kill the task with a SIGSEGV in this situation.
+	 */
+	if (do_setcontext(ctx, regs, 1)) {
+		force_sig(SIGSEGV, current);
+		goto out;
+	}
+
+	/*
+	 * It's not clear whether or why it is desirable to save the
+	 * sigaltstack setting on signal delivery and restore it on
+	 * signal return.  But other architectures do this and we have
+	 * always done it up until now so it is probably better not to
+	 * change it.  -- paulus
+	 */
+	do_sigaltstack(&ctx->uc_stack, NULL, regs->gpr[1]);
+
+	sigreturn_exit(regs);
+	/* doesn't actually return back to here */
+
+ out:
+	return 0;
+}
+
 /*
  * OK, we're invoking a handler
  */
Index: linux-ipmi/arch/ppc/kernel/traps.c
===================================================================
--- linux-ipmi.orig/arch/ppc/kernel/traps.c	2004-06-22 13:31:41.000000000 -0500
+++ linux-ipmi/arch/ppc/kernel/traps.c	2004-07-27 15:55:49.000000000 -0500
@@ -516,7 +516,7 @@
 void
 SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
Index: linux-ipmi/include/asm-ppc/signal.h
===================================================================
--- linux-ipmi.orig/include/asm-ppc/signal.h	2003-12-17 20:58:08.000000000 -0600
+++ linux-ipmi/include/asm-ppc/signal.h	2004-07-27 15:06:55.000000000 -0500
@@ -153,4 +153,23 @@
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 #endif /* __KERNEL__ */

+/*
+ * These are parameters to dbg_sigreturn syscall.  They enable or
+ * disable certain debugging things that can be done from signal
+ * handlers.  The dbg_sigreturn syscall *must* be called from a
+ * SA_SIGINFO signal so the ucontext can be passed to it.  It takes an
+ * array of struct sig_dbg_op, which has the debug operations to
+ * perform before returning from the signal.
+ */
+struct sig_dbg_op {
+	int dbg_type;
+	unsigned long dbg_value;
+};
+
+/* Enable or disable single-stepping.  The value sets the state. */
+#define SIG_DBG_SINGLE_STEPPING		1
+
+/* Enable or disable branch tracing.  The value sets the state. */
+#define SIG_DBG_BRANCH_TRACING		2
+
 #endif
Index: linux-ipmi/include/asm-ppc/unistd.h
===================================================================
--- linux-ipmi.orig/include/asm-ppc/unistd.h	2004-06-22 13:32:19.000000000 -0500
+++ linux-ipmi/include/asm-ppc/unistd.h	2004-07-27 15:04:30.000000000 -0500
@@ -260,7 +260,7 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
-/* Number 256 is reserved for sys_debug_setcontext */
+#define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
 /* Number 258 is reserved for new sys_remap_file_pages */
 /* Number 259 is reserved for new sys_mbind */

--------------060301070305000100050802--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
