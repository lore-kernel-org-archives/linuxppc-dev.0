Message-ID: <3F5E27D2.3090808@acm.org>
Date: Tue, 09 Sep 2003 14:19:46 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: paulus@samba.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org> <20030829131824.B18608@home.com> <3F574958.4090402@acm.org> <3F58AA89.80803@acm.org>
In-Reply-To: <3F58AA89.80803@acm.org>
Content-Type: multipart/mixed;
 boundary="------------070007070105060500080608"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070007070105060500080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul came up with a much better method for this.  I have added a syscall
that does a "debug" return from the signal handler.  It's much cleaner.

I ahve a patch for this, and I've done a number of things besides just
this.  I seemed bad to me to add yet another kludge to the beginning of
DoSyscall for handling yet another signal return value.  So I turned all
the signal return syscalls into normal syscalls.  This should speed up
normal syscall handling by removing four instructions from the syscall
entry.  Is this ok?

I added some new syscalls for each sigreturn option, but there were
already some more that would obviously not work for this.  Should I
convert the others over to work correctly, or should I leave these like
they are?

I made the interface to the debug sigreturn extensible, it takes an
array of two-member structures, where the first member is a debug type
and the second is a debug value.  This should allow a lot of flexibility
for adding new things (probably a lot more than is required).

I also brought the syscall table in asm/unistd.h up to date.

I've got some code for setting dabr from userland and causing traps.  I
could work it into this if someone is interested.  It involves some
complicated code at exception entry.

-Corey

Corey Minyard wrote:

> Here's an example patch (that I have tested) that shows the use of the
> top 16 bits of the trap field as communication between the signal
> handler and the kernel.
>
> -Corey
>
> Corey Minyard wrote:
>
>>
>> Actually, using the SE bit may not be the best way to handle this to
>> cover all the PPC variants.
>>
>> Would it be better to have a special bit field someplace that is used to
>> communicate between the signal handler and the kernel?  Some
>> possibilities are:
>>
>>    * The top 16 bits of the trap field
>>    * The currently unused mq field (except on APUS?)
>>    * A new field in the signal frame
>>
>> I'm thinking that reserving the top 16 bits of the trap field may be the
>> best.  It would always come in as zero (so existing software won't be
>> broken) and it will be available for all processors and will not be used
>> for anything else by the processor.
>>
>> Any thoughts?
>>
>> -Corey
>

--------------070007070105060500080608
Content-Type: text/plain;
 name="dbg_sig_ppc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbg_sig_ppc.diff"

--- arch/ppc/kernel/signal.c.old	2003-08-28 15:30:37.000000000 -0500
+++ arch/ppc/kernel/signal.c	2003-09-09 14:13:37.000000000 -0500
@@ -383,7 +383,7 @@

 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	if (save_user_regs(regs, frame, 0x6666, 0))
+	if (save_user_regs(regs, frame, __NR_kern_rt_sigreturn, 0))
 		goto badframe;

 	if (put_user(regs->gpr[1], (unsigned long *)newsp))
@@ -461,15 +461,13 @@
 	return 0;
 }

-int sys_rt_sigreturn(struct pt_regs *regs)
+int rt_sigreturn(struct ucontext *uc, struct pt_regs *regs)
 {
-	struct rt_sigframe *rt_sf;
 	stack_t st;

-	rt_sf = (struct rt_sigframe *)(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
-	if (verify_area(VERIFY_READ, rt_sf, sizeof(struct rt_sigframe)))
+	if (verify_area(VERIFY_READ, uc, sizeof(struct ucontext)))
 		goto bad;
-	if (do_setcontext(&rt_sf->uc, regs, 0))
+	if (do_setcontext(uc, regs, 0))
 		goto bad;

 	/*
@@ -479,7 +477,7 @@
 	 * always done it up until now so it is probably better not to
 	 * change it.  -- paulus
 	 */
-	if (__copy_from_user(&st, &rt_sf->uc.uc_stack, sizeof(st)))
+	if (__copy_from_user(&st, &uc->uc_stack, sizeof(st)))
 		goto bad;
 	do_sigaltstack(&st, NULL, regs->gpr[1]);

@@ -489,6 +487,61 @@
 	do_exit(SIGSEGV);
 }

+int sys_rt_sigreturn(struct pt_regs *regs)
+{
+	struct rt_sigframe *rt_sf;
+
+	rt_sf = (struct rt_sigframe *)(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
+	return rt_sigreturn(&rt_sf->uc, regs);
+}
+
+int sys_dbg_sigreturn(struct ucontext *uc, int ndbg, struct sig_dbg_op *dbg,
+		      struct pt_regs *regs)
+{
+  	struct sig_dbg_op op;
+	int i;
+
+	for (i=0; i<ndbg; i++) {
+		if (__copy_from_user(&op, dbg, sizeof(op)))
+			return -EFAULT;
+		switch (op.dbg_type) {
+		case SIG_DBG_SINGLE_STEPPING:
+#if defined(CONFIG_4xx)
+			if (op.dbg_value) {
+				regs->msr |= MSR_DE;
+				current->thread.dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+			} else {
+				regs->msr &= ~MSR_DE;
+				current->thread.dbcr0 &= ~(DBCR0_IDM | DBCR0_IC);
+				regs->msr &= ~MSR_SE;
+			}
+#else
+			if (op.dbg_value)
+				regs->msr |= MSR_SE;
+			else
+				regs->msr &= ~MSR_SE;
+#endif
+			break;
+
+		case SIG_DBG_BRANCH_TRACING:
+#if defined(CONFIG_4xx)
+			return -EINVAL;
+#else
+			if (op.dbg_value)
+				regs->msr |= MSR_BE;
+			else
+				regs->msr &= ~MSR_BE;
+#endif
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return rt_sigreturn(uc, regs);
+}
+
 /*
  * OK, we're invoking a handler
  */
@@ -525,7 +578,7 @@
 	    || __put_user(sig, &sc->signal))
 		goto badframe;

-	if (save_user_regs(regs, &frame->mctx, 0x7777, 0))
+	if (save_user_regs(regs, &frame->mctx, __NR_kern_sigreturn, 0))
 		goto badframe;

 	if (put_user(regs->gpr[1], (unsigned long *)newsp))
--- arch/ppc/kernel/traps.c.old	2003-08-28 15:42:26.000000000 -0500
+++ arch/ppc/kernel/traps.c	2003-09-05 09:15:47.000000000 -0500
@@ -396,7 +396,7 @@
 void
 SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
--- arch/ppc/kernel/entry.S.old	2003-08-31 04:39:10.000000000 -0500
+++ arch/ppc/kernel/entry.S	2003-09-09 09:39:53.000000000 -0500
@@ -80,10 +80,6 @@
 	lwz	r8,GPR8(r1)
 1:
 #endif /* SHOW_SYSCALLS */
-	cmpi	0,r0,0x7777	/* Special case for 'sys_sigreturn' */
-	beq-	10f
-	cmpi    0,r0,0x6666     /* Special case for 'sys_rt_sigreturn' */
-	beq-    16f
 	lwz	r10,TASK_PTRACE(r2)
 	andi.	r10,r10,PT_TRACESYS
 	bne-	50f
@@ -100,7 +96,7 @@
 	blrl			/* Call handler */
 	.globl	ret_from_syscall_1
 ret_from_syscall_1:
-20:	stw	r3,RESULT(r1)	/* Save result */
+	stw	r3,RESULT(r1)	/* Save result */
 #ifdef SHOW_SYSCALLS
 #ifdef SHOW_SYSCALLS_TASK
 	cmp	0,r2,r31
@@ -127,18 +123,6 @@
 	b	ret_from_except
 66:	li	r3,ENOSYS
 	b	22b
-/* sys_sigreturn */
-10:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	sys_sigreturn
-	cmpi    0,r3,0          /* Check for restarted system call */
-	bge     ret_from_except
-	b       20b
-/* sys_rt_sigreturn */
-16:	addi    r3,r1,STACK_FRAME_OVERHEAD
-	bl      sys_rt_sigreturn
-	cmpi	0,r3,0		/* Check for restarted system call */
-	bge	ret_from_except
-	b	20b
 /* Traced system call support */
 50:	bl	syscall_trace
 	lwz	r0,GPR0(r1)	/* Restore original registers */
--- arch/ppc/kernel/misc.S.old	2003-08-31 04:39:09.000000000 -0500
+++ arch/ppc/kernel/misc.S	2003-09-09 10:14:43.000000000 -0500
@@ -1034,6 +1034,37 @@
 _GLOBAL(__main)
 	blr

+_sys_sigreturn:
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	mflr	r30
+	bl      sys_sigreturn
+	cmpi	0,r3,0		/* Check for restarted system call */
+	bge	ret_from_except
+	mtlr	r30
+	blr
+
+_sys_rt_sigreturn:
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	mflr	r30
+	bl      sys_rt_sigreturn
+	cmpi	0,r3,0		/* Check for restarted system call */
+	bge	ret_from_except
+	mtlr	r30
+	blr
+
+/*
+ * This handles the special case of the debug sigreturn call, which needs
+ * the registers in order to do its job.
+ */
+_sys_dbg_sigreturn:
+	addi    r6,r1,STACK_FRAME_OVERHEAD
+	mflr	r30
+	bl      sys_dbg_sigreturn
+	cmpi	0,r3,0		/* Check for restarted system call */
+	bge	ret_from_except
+	mtlr	r30
+	blr
+
 #define SYSCALL(name) \
 _GLOBAL(name) \
 	li	r0,__NR_##name; \
@@ -1314,6 +1345,9 @@
 	.long sys_ni_syscall	/*	reserved for sys_clock_getres */
 	.long sys_ni_syscall	/*	reserved for sys_clock_nanosleep */
 	.long sys_swapcontext
+	.long _sys_sigreturn	/* 250 */
+	.long _sys_rt_sigreturn
+	.long _sys_dbg_sigreturn

 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- include/asm-ppc/signal.h.old	2003-09-09 11:29:59.000000000 -0500
+++ include/asm-ppc/signal.h	2003-09-09 13:29:49.000000000 -0500
@@ -152,4 +152,23 @@
 #include <asm/sigcontext.h>
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
--- include/asm-ppc/unistd.h.old	2003-08-31 04:41:10.000000000 -0500
+++ include/asm-ppc/unistd.h	2003-09-09 13:20:11.000000000 -0500
@@ -237,7 +237,28 @@
 #define __NR_io_getevents	229
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
+#define __NR_set_tid_address	232
+#define __NR_fadvise64		233
+#define __NR_exit_group		234
+#define __NR_lookup_dcookie	235
+#define __NR_epoll_create	236
+#define __NR_epoll_ctl		237
+#define __NR_epoll_wait		238
+#define __NR_remap_file_pages	239
+#define __NR_timer_create	240
+#define __NR_timer_settime	241
+#define __NR_timer_gettime	242
+#define __NR_timer_getoverrun	243
+#define __NR_timer_delete	244
+#define __NR_clock_settime	245
+#define __NR_clock_gettime	246
+#define __NR_clock_getres	247
+#define __NR_clock_nanosleep	248
 #endif
+#define __NR_swapcontext	249
+#define __NR_kern_sigreturn	250
+#define __NR_kern_rt_sigreturn	251
+#define __NR_dbg_sigreturn	252

 #define __NR(n)	#n


--------------070007070105060500080608--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
