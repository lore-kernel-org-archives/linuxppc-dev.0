Message-ID: <3F5E90BE.50300@acm.org>
Date: Tue, 09 Sep 2003 21:47:26 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org>	<20030829131824.B18608@home.com>	<3F574958.4090402@acm.org>	<3F58AA89.80803@acm.org>	<3F5E27D2.3090808@acm.org> <16222.32829.717728.344331@cargo.ozlabs.ibm.com>
In-Reply-To: <16222.32829.717728.344331@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020703060808030909020001"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020703060808030909020001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After your and Ben's comments, I looked at this some more.  Yes, I
should have used the old versions of sigreturn and rt_sigreturn.  I have
looked at gdb and gcc unwinding.  gdb 5.3 only handles the "7777"
(non-rt) signal frames properly.  It does not handle rt frames.  gdb 6.0
pre has handling code for the "6666" (rt), "7777" (non-rt), sigreturn,
and rt_sigreturn versions of the stack frames.  However, the rt versions
are broken, it doesn't account for the different frame format in rt
signal handlers.

gcc unwinding looks ok, it handles the old and new versions of the stack
frame system calls.

I'm being a little persistent on this because I think changing the way
signal handling works would be better if changed.  System calls would be
a little faster with the change (although signal returns would be
slightly slower, but I assume the occur less often).  Plus, strace is
unable to trace signal returns with the way it works now.  I consider
signal returns a pretty important thing for strace to show, and other
arches do this.

I've attached yet another patch.  By default, this patch uses the
"0x6666" and "0x7777" versions of the signal return syscalls.  The
DoSyscall code will translate from the 0x6666 and 0x7777 to the
sys_rt_sigreturn and sys_sigreturn.  You can do "echo '0' >
/proc/sys/ppc/sigtype" to change it to use the syscalls for
sys_sigreturn and sys_rt_sigreturn.  I've tested gdb 5.3, gdb 6.0, and
strace with it in both modes.  (when using sys_sigreturn, strace
actually prints the right thing).

I'm going to test signal unwinding now after I brush up on my C++ skills
:-).  I expect they will work, but I'll send an email.

This is against 2.4.22-ben2, and it has the new code.  The 2.5 code is
quite different, but my changes make 2.4 more like 2.5.  A 2.5 patch
would be pretty easy to do.

I also have a patch against 2.4.20 (I have to do that version for our
product), but with stacked signal frames things get ugly.

-Corey

Paul Mackerras wrote:

>Corey Minyard writes:
>
>
>>I added some new syscalls for each sigreturn option, but there were
>>already some more that would obviously not work for this.  Should I
>>convert the others over to work correctly, or should I leave these like
>>they are?
>>
>>
>
>There already were numbers assigned for the sigreturn and rt_sigreturn
>system calls which weren't being used in 2.4.  In 2.5/2.6 I have
>changed the kernel to use them.  I thought the stack unwinding code in
>glibc (at least) had already been updated to reflect that.
>
>Which tree is your patch against?  Note that there are PPC signal
>changes in 2.4.23-pre3.  I hope your patch is against the new version
>not the old version. :)
>
>Paul.
>
>
>


--------------020703060808030909020001
Content-Type: text/plain;
 name="dbg_sig_ppc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbg_sig_ppc2.diff"

--- arch/ppc/kernel/signal.c.old	2003-08-28 15:30:37.000000000 -0500
+++ arch/ppc/kernel/signal.c	2003-09-09 21:13:38.000000000 -0500
@@ -26,6 +26,8 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/elf.h>
+#include <linux/sysctl.h>
+#include <linux/init.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -40,6 +42,8 @@

 #define GP_REGS_SIZE	MIN(sizeof(elf_gregset_t), sizeof(struct pt_regs))

+int ppc_use_old_sigret = 1;
+
 extern void syscall_direct_return(struct pt_regs *regs);

 int do_signal(sigset_t *oldset, struct pt_regs *regs);
@@ -383,8 +387,15 @@

 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	if (save_user_regs(regs, frame, 0x6666, 0))
-		goto badframe;
+	if (ppc_use_old_sigret) {
+		/* We use 0x6666 for a rt signal frame, the entry code will
+		   map it to __NR_rt_sigreturn. */
+		if (save_user_regs(regs, frame, 0x6666, 0))
+			goto badframe;
+	} else {
+		if (save_user_regs(regs, frame, __NR_rt_sigreturn, 0))
+			goto badframe;
+	}

 	if (put_user(regs->gpr[1], (unsigned long *)newsp))
 		goto badframe;
@@ -461,15 +472,13 @@
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
@@ -479,7 +488,7 @@
 	 * always done it up until now so it is probably better not to
 	 * change it.  -- paulus
 	 */
-	if (__copy_from_user(&st, &rt_sf->uc.uc_stack, sizeof(st)))
+	if (__copy_from_user(&st, &uc->uc_stack, sizeof(st)))
 		goto bad;
 	do_sigaltstack(&st, NULL, regs->gpr[1]);

@@ -489,6 +498,61 @@
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
@@ -525,8 +589,15 @@
 	    || __put_user(sig, &sc->signal))
 		goto badframe;

-	if (save_user_regs(regs, &frame->mctx, 0x7777, 0))
-		goto badframe;
+	if (ppc_use_old_sigret) {
+		/* We use 0x7777 for a normal signal frame, the entry code will
+		   map it to __NR_sigreturn. */
+		if (save_user_regs(regs, &frame->mctx, 0x7777, 0))
+			goto badframe;
+	} else {
+		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn, 0))
+			goto badframe;
+	}

 	if (put_user(regs->gpr[1], (unsigned long *)newsp))
 		goto badframe;
@@ -747,3 +818,23 @@
 	return 1;
 }

+#define PPC_CPU_DEFHANDLER_SIGTYPE 1
+static struct ctl_table ppc_table[] = {
+	{PPC_CPU_DEFHANDLER_SIGTYPE, "sigtype", &ppc_use_old_sigret,
+		sizeof(int), 0644, NULL, &proc_dointvec_minmax},
+	{0}
+};
+
+static struct ctl_table ppc_root_table[] = {
+	{CTL_CPU, "ppc", NULL, 0, 0555, ppc_table},
+	{0}
+};
+
+static int __init
+ppc_register_sysctl(void)
+{
+	register_sysctl_table(ppc_root_table, 1);
+	return 0;
+}
+
+__initcall(ppc_register_sysctl);
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
+++ arch/ppc/kernel/entry.S	2003-09-09 20:21:41.000000000 -0500
@@ -28,6 +28,7 @@
 #include <asm/mmu.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
+#include <asm/unistd.h>
 #include "ppc_defs.h"

 #undef SHOW_SYSCALLS
@@ -80,27 +81,24 @@
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
 	cmpli	0,r0,NR_syscalls
 	bge-	66f
+syscall_1:
 	lis	r10,sys_call_table@h
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	cmpi	0,r10,0
-	beq-	66f
+	beq-	16f
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	blrl			/* Call handler */
 	.globl	ret_from_syscall_1
 ret_from_syscall_1:
-20:	stw	r3,RESULT(r1)	/* Save result */
+	stw	r3,RESULT(r1)	/* Save result */
 #ifdef SHOW_SYSCALLS
 #ifdef SHOW_SYSCALLS_TASK
 	cmp	0,r2,r31
@@ -125,20 +123,17 @@
 	stw	r10,_CCR(r1)
 30:	stw	r3,GPR3(r1)	/* Update return value */
 	b	ret_from_except
-66:	li	r3,ENOSYS
+
+66:	cmpi	0,r0,0x7777	/* Special case for 'sys_sigreturn' */
+	bne-	10f
+	li	r0,__NR_sigreturn
+	b	syscall_1
+10:	cmpi    0,r0,0x6666     /* Special case for 'sys_rt_sigreturn' */
+	bne-    16f
+	li	r0,__NR_rt_sigreturn
+	b	syscall_1
+16:	li	r3,ENOSYS
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
@@ -151,12 +146,13 @@
 	lwz	r9,GPR9(r1)
 	cmpli	0,r0,NR_syscalls
 	bge-	66f
+syscall_2:
 	lis	r10,sys_call_table@h
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	cmpi	0,r10,0
-	beq-	66f
+	beq-	16f
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	blrl			/* Call handler */
@@ -176,7 +172,15 @@
 60:	stw	r3,GPR3(r1)	/* Update return value */
 	bl	syscall_trace
 	b	ret_from_except
-66:	li	r3,ENOSYS
+66:	cmpi	0,r0,0x7777	/* Special case for 'sys_sigreturn' */
+	bne-	10f
+	li	r0,__NR_sigreturn
+	b	syscall_2
+10:	cmpi    0,r0,0x6666     /* Special case for 'sys_rt_sigreturn' */
+	bne-    16f
+	li	r0,__NR_rt_sigreturn
+	b	syscall_2
+16:	li	r3,ENOSYS
 	b	52b
 #ifdef SHOW_SYSCALLS
 7:	.string	"syscall %d(%x, %x, %x, %x, %x, "
--- arch/ppc/kernel/misc.S.old	2003-08-31 04:39:09.000000000 -0500
+++ arch/ppc/kernel/misc.S	2003-09-09 21:41:58.000000000 -0500
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
@@ -1183,7 +1214,7 @@
 	.long sys_sysinfo
 	.long sys_ipc
 	.long sys_fsync
-	.long sys_sigreturn
+	.long _sys_sigreturn
 	.long sys_clone		/* 120 */
 	.long sys_setdomainname
 	.long sys_newuname
@@ -1236,7 +1267,7 @@
 	.long sys_setresgid
 	.long sys_getresgid	/* 170 */
 	.long sys_prctl
-	.long sys_rt_sigreturn
+	.long _sys_rt_sigreturn
 	.long sys_rt_sigaction
 	.long sys_rt_sigprocmask
 	.long sys_rt_sigpending	/* 175 */
@@ -1314,6 +1345,11 @@
 	.long sys_ni_syscall	/*	reserved for sys_clock_getres */
 	.long sys_ni_syscall	/*	reserved for sys_clock_nanosleep */
 	.long sys_swapcontext
+	.long sys_ni_syscall	/* 250  reserved for sys_tgkill */
+	.long sys_ni_syscall	/*      reserved for sys_utimes */
+	.long sys_ni_syscall	/*      reserved for sys_statfs64 */
+	.long sys_ni_syscall	/*      reserved for sys_fstatfs64 */
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
+++ include/asm-ppc/unistd.h	2003-09-09 21:44:04.000000000 -0500
@@ -237,7 +237,33 @@
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
+#if 0
+#define __NR_tgkill		250
+#define __NR__utimes		251
+#define __NR_statfs64		252
+#define __NR_fstatfs64		253
+#endif
+#define __NR_dbg_sigreturn	254
+

 #define __NR(n)	#n


--------------020703060808030909020001--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
