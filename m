Message-ID: <4113FA9F.8070804@mvista.com>
Date: Fri, 06 Aug 2004 16:39:43 -0500
From: Corey Minyard <cminyard@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch for debug setcontext, relative to 2.6.8
References: <41090F9A.8000901@mvista.com> <BA214A7E-E195-11D8-8E6C-000393DBC2E8@freescale.com> <4109B225.8020604@mvista.com> <FCFD4600-E231-11D8-858D-000393DBC2E8@freescale.com>
In-Reply-To: <FCFD4600-E231-11D8-858D-000393DBC2E8@freescale.com>
Content-Type: multipart/mixed;
 boundary="------------080105070908040206010503"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080105070908040206010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks to Kumar, I moved to a new kernel and it makes more sense now.
Patch is attached.

Signed-off-by: Corey Minyard <minyard@acm.org>

--------------080105070908040206010503
Content-Type: text/plain;
 name="ppc_debug_setcontext-2.6.8-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_debug_setcontext-2.6.8-rc2.diff"

--- arch/ppc/kernel/entry.S.sct	2004-08-02 11:34:49.000000000 -0500
+++ arch/ppc/kernel/entry.S	2004-08-02 12:13:52.000000000 -0500
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
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* If the process has its own DBCR0 value, load it up */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* If the process has its own DBCR0 value, load it up.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
 	stwcx.	r0,0,r1			/* to clear the reservation */
@@ -599,9 +602,10 @@

 restore_user:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* Check whether this process has its own DBCR0 value */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* Check whether this process has its own DBCR0 value.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif

@@ -876,17 +880,17 @@

 /*
  * Load the DBCR0 value for a task that is being ptraced,
- * having first saved away the global DBCR0.
+ * having first saved away the global DBCR0.  Note that r0
+ * has the dbcr0 value to set upon entry to this.
  */
 load_dbcr0:
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
--- arch/ppc/kernel/misc.S.sct	2004-08-02 11:36:43.000000000 -0500
+++ arch/ppc/kernel/misc.S	2004-08-06 16:35:08.000000000 -0500
@@ -1437,7 +1437,7 @@
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall		/* 255 - rtas (used on ppc64) */
-	.long sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.long sys_debug_setcontext
 	.long sys_ni_syscall		/* 257 reserved for vserver */
 	.long sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
 	.long sys_ni_syscall		/* 259 reserved for new sys_mbind */
--- arch/ppc/kernel/signal.c.sct	2004-08-02 11:36:43.000000000 -0500
+++ arch/ppc/kernel/signal.c	2004-08-06 16:31:09.000000000 -0500
@@ -501,6 +501,96 @@
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
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+	unsigned long new_dbcr0 = current->thread.dbcr0;
+#endif
+
+	for (i=0; i<ndbg; i++) {
+		if (__copy_from_user(&op, dbg, sizeof(op)))
+			return -EFAULT;
+		switch (op.dbg_type) {
+		case SIG_DBG_SINGLE_STEPPING:
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
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
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
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
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
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
--- arch/ppc/kernel/traps.c.sct	2004-08-02 11:36:43.000000000 -0500
+++ arch/ppc/kernel/traps.c	2004-08-06 16:31:58.000000000 -0500
@@ -543,7 +543,7 @@

 void SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
--- include/asm-ppc/signal.h.sct	2004-08-02 11:37:14.000000000 -0500
+++ include/asm-ppc/signal.h	2004-08-06 16:33:39.000000000 -0500
@@ -157,4 +157,23 @@
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
--- include/asm-ppc/unistd.h.sct	2004-08-02 11:37:14.000000000 -0500
+++ include/asm-ppc/unistd.h	2004-08-06 16:34:08.000000000 -0500
@@ -260,7 +260,7 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
-/* Number 256 is reserved for sys_debug_setcontext */
+#define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
 /* Number 258 is reserved for new sys_remap_file_pages */
 /* Number 259 is reserved for new sys_mbind */

--------------080105070908040206010503--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
