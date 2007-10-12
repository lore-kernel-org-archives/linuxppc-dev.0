Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 064C0DDFB6
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 10:14:42 +1000 (EST)
Date: Thu, 11 Oct 2007 19:20:07 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH v3] powerpc: Implement logging of unhandled signals
Message-ID: <20071012002007.GA18188@lixom.net>
References: <20071001203242.GA14091@lixom.net>
	<20071002053512.GA21414@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002053512.GA21414@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement show_unhandled_signals sysctl + support to print when a process
is killed due to unhandled signals just as i386 and x86_64 does.

Default to having it off, unlike x86 that defaults on.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6.23/arch/powerpc/kernel/traps.c
===================================================================
--- 2.6.23.orig/arch/powerpc/kernel/traps.c
+++ 2.6.23/arch/powerpc/kernel/traps.c
@@ -172,11 +172,21 @@ int die(const char *str, struct pt_regs 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
+	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+			"at %08lx nip %08lx lr %08lx code %x\n";
+	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+			"at %016lx nip %016lx lr %016lx code %x\n";
 
 	if (!user_mode(regs)) {
 		if (die("Exception in kernel mode", regs, signr))
 			return;
-	}
+	} else if (show_unhandled_signals &&
+		    unhandled_signal(current, signr) &&
+		    printk_ratelimit()) {
+			printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+				current->comm, current->pid, signr,
+				addr, regs->nip, regs->link, code);
+		}
 
 	memset(&info, 0, sizeof(info));
 	info.si_signo = signr;
Index: 2.6.23/arch/powerpc/kernel/signal_64.c
===================================================================
--- 2.6.23.orig/arch/powerpc/kernel/signal_64.c
+++ 2.6.23/arch/powerpc/kernel/signal_64.c
@@ -64,6 +64,11 @@ struct rt_sigframe {
 	char abigap[288];
 } __attribute__ ((aligned (16)));
 
+static const char fmt32[] = KERN_INFO \
+	"%s[%d]: bad frame in %s: %08lx nip %08lx lr %08lx\n";
+static const char fmt64[] = KERN_INFO \
+	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
+
 /*
  * Set up the sigcontext for the signal frame.
  */
@@ -315,6 +320,11 @@ badframe:
 	printk("badframe in sys_rt_sigreturn, regs=%p uc=%p &uc->uc_mcontext=%p\n",
 	       regs, uc, &uc->uc_mcontext);
 #endif
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+			current->comm, current->pid, "rt_sigreturn",
+			(long)uc, regs->nip, regs->link);
+
 	force_sig(SIGSEGV, current);
 	return 0;
 }
@@ -398,6 +408,11 @@ badframe:
 	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(regs->msr & MSR_SF ? fmt64 : fmt32,
+			current->comm, current->pid, "setup_rt_frame",
+			(long)frame, regs->nip, regs->link);
+
 	force_sigsegv(signr, current);
 	return 0;
 }
Index: 2.6.23/kernel/sysctl.c
===================================================================
--- 2.6.23.orig/kernel/sysctl.c
+++ 2.6.23/kernel/sysctl.c
@@ -1221,7 +1221,7 @@ static ctl_table fs_table[] = {
 };
 
 static ctl_table debug_table[] = {
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_PPC)
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "exception-trace",
Index: 2.6.23/arch/powerpc/kernel/signal_32.c
===================================================================
--- 2.6.23.orig/arch/powerpc/kernel/signal_32.c
+++ 2.6.23/arch/powerpc/kernel/signal_32.c
@@ -705,11 +705,13 @@ int handle_rt_signal32(unsigned long sig
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
+	void __user *addr;
 	unsigned long newsp = 0;
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ka, regs, sizeof(*rt_sf));
+	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
 
@@ -728,6 +730,7 @@ int handle_rt_signal32(unsigned long sig
 
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
+	addr = frame;
 	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
 		if (save_user_regs(regs, frame, 0))
 			goto badframe;
@@ -742,6 +745,7 @@ int handle_rt_signal32(unsigned long sig
 
 	/* create a stack frame for the caller of the handler */
 	newsp = ((unsigned long)rt_sf) - (__SIGNAL_FRAMESIZE + 16);
+	addr = (void __user *)regs->gpr[1];
 	if (put_user(regs->gpr[1], (u32 __user *)newsp))
 		goto badframe;
 
@@ -762,6 +766,12 @@ badframe:
 	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(KERN_INFO "%s[%d]: bad frame in handle_rt_signal32: "
+			"%p nip %08lx lr %08lx\n",
+			current->comm, current->pid,
+			addr, regs->nip, regs->link);
+
 	force_sigsegv(sig, current);
 	return 0;
 }
@@ -886,6 +896,12 @@ long sys_rt_sigreturn(int r3, int r4, in
 	return 0;
 
  bad:
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(KERN_INFO "%s[%d]: bad frame in sys_rt_sigreturn: "
+			"%p nip %08lx lr %08lx\n",
+			current->comm, current->pid,
+			rt_sf, regs->nip, regs->link);
+
 	force_sig(SIGSEGV, current);
 	return 0;
 }
@@ -967,6 +983,13 @@ int sys_debug_setcontext(struct ucontext
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 	if (do_setcontext(ctx, regs, 1)) {
+		if (show_unhandled_signals && printk_ratelimit())
+			printk(KERN_INFO "%s[%d]: bad frame in "
+				"sys_debug_setcontext: %p nip %08lx "
+				"lr %08lx\n",
+				current->comm, current->pid,
+				ctx, regs->nip, regs->link);
+
 		force_sig(SIGSEGV, current);
 		goto out;
 	}
@@ -1048,6 +1071,12 @@ badframe:
 	printk("badframe in handle_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(KERN_INFO "%s[%d]: bad frame in handle_signal32: "
+			"%p nip %08lx lr %08lx\n",
+			current->comm, current->pid,
+			frame, regs->nip, regs->link);
+
 	force_sigsegv(sig, current);
 	return 0;
 }
@@ -1061,12 +1090,14 @@ long sys_sigreturn(int r3, int r4, int r
 	struct sigcontext __user *sc;
 	struct sigcontext sigctx;
 	struct mcontext __user *sr;
+	void __user *addr;
 	sigset_t set;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	sc = (struct sigcontext __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	addr = sc;
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
 
@@ -1083,6 +1114,7 @@ long sys_sigreturn(int r3, int r4, int r
 	restore_sigmask(&set);
 
 	sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
+	addr = sr;
 	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
 	    || restore_user_regs(regs, sr, 1))
 		goto badframe;
@@ -1091,6 +1123,12 @@ long sys_sigreturn(int r3, int r4, int r
 	return 0;
 
 badframe:
+	if (show_unhandled_signals && printk_ratelimit())
+		printk(KERN_INFO "%s[%d]: bad frame in sys_sigreturn: "
+			"%p nip %08lx lr %08lx\n",
+			current->comm, current->pid,
+			addr, regs->nip, regs->link);
+
 	force_sig(SIGSEGV, current);
 	return 0;
 }
Index: 2.6.23/arch/powerpc/kernel/signal.c
===================================================================
--- 2.6.23.orig/arch/powerpc/kernel/signal.c
+++ 2.6.23/arch/powerpc/kernel/signal.c
@@ -16,6 +16,12 @@
 
 #include "signal.h"
 
+/* Log an error when sending an unhandled signal to a process. Controlled
+ * through debug.exception-trace sysctl.
+ */
+
+int show_unhandled_signals = 0;
+
 /*
  * Allocate space for the signal frame
  */
