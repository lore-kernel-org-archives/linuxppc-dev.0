Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A320DDEDE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 20:21:48 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l52ALho6021909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Jun 2007 12:21:43 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l52ALhLI021907
	for linuxppc-dev@ozlabs.org; Sat, 2 Jun 2007 12:21:43 +0200
Date: Sat, 2 Jun 2007 12:21:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] consolidate do_signal
Message-ID: <20070602102143.GA21707@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

do_signal has exactly the same behaviour on 32bit and 64bit and 32bit
compat on 64bit for handling 32bit signals.  Consolidate all these
into one common function in signal.c.  The oly odd left over is
the try_to_free in the 32bit version that no other architecture has
in mainline (only in i386 for some odd SuSE release).  We should
probably get rid of it in a separate patch.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.c	2007-06-02 11:15:15.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal.c	2007-06-02 11:16:02.000000000 +0200
@@ -7,12 +7,26 @@
  * this archive for more details.
  */
 
+#include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 
 #include "signal.h"
 
 
+#ifdef CONFIG_PPC64
+static inline int is_32bit_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+#else
+static inline int is_32bit_task(void)
+{
+	return 1;
+}
+#endif
+
+
 /*
  * Restore the user process's signal mask
  */
@@ -25,7 +39,7 @@ void restore_sigmask(sigset_t *set)
 	spin_unlock_irq(&current->sighand->siglock);
 }
 
-void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
+static void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 		int has_handler)
 {
 	unsigned long ret = regs->gpr[3];
@@ -76,6 +90,95 @@ void check_syscall_restart(struct pt_reg
 	}
 }
 
+int do_signal(sigset_t *oldset, struct pt_regs *regs)
+{
+	siginfo_t info;
+	int signr;
+	struct k_sigaction ka;
+	int ret;
+	int is32 = is_32bit_task();
+
+#ifdef CONFIG_PPC32
+	if (try_to_freeze()) {
+		signr = 0;
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+#endif
+
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else if (!oldset)
+		oldset = &current->blocked;
+
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+
+#ifdef CONFIG_PPC32
+no_signal:
+#endif
+	/* Is there any syscall restart business here ? */
+	check_syscall_restart(regs, &ka, signr > 0);
+
+	if (signr <= 0) {
+		/* No signal to deliver -- put the saved sigmask back */
+		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		}
+		return 0;               /* no signals delivered */
+	}
+
+#ifdef CONFIG_PPC64
+        /*
+	 * Reenable the DABR before delivering the signal to
+	 * user space. The DABR will have been cleared if it
+	 * triggered inside the kernel.
+	 */
+	if (current->thread.dabr)
+		set_dabr(current->thread.dabr);
+#endif
+
+	if (is32) {
+		unsigned int newsp;
+
+		if ((ka.sa.sa_flags & SA_ONSTACK) &&
+		    current->sas_ss_size && !on_sig_stack(regs->gpr[1]))
+			newsp = current->sas_ss_sp + current->sas_ss_size;
+		else
+			newsp = regs->gpr[1];
+
+        	if (ka.sa.sa_flags & SA_SIGINFO)
+			ret = handle_rt_signal32(signr, &ka, &info, oldset,
+					regs, newsp);
+		else
+			ret = handle_signal32(signr, &ka, &info, oldset,
+					regs, newsp);
+#ifdef CONFIG_PPC64
+	} else {
+		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
+#endif
+	}
+
+	if (ret) {
+		spin_lock_irq(&current->sighand->siglock);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka.sa.sa_mask);
+		if (!(ka.sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked, signr);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+
+		/*
+		 * A signal was successfully delivered; the saved sigmask is in
+		 * its frame, and we can clear the TIF_RESTORE_SIGMASK flag.
+		 */
+		if (test_thread_flag(TIF_RESTORE_SIGMASK))
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+	}
+
+	return ret;
+}
+
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
 		unsigned long r5, unsigned long r6, unsigned long r7,
 		unsigned long r8, struct pt_regs *regs)
Index: linux-2.6/arch/powerpc/kernel/signal.h
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.h	2007-06-02 11:15:15.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal.h	2007-06-02 11:15:19.000000000 +0200
@@ -2,5 +2,11 @@
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 void restore_sigmask(sigset_t *set);
-void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
-		int has_handler);
+int handle_signal32(unsigned long sig, struct k_sigaction *ka,
+		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs,
+		unsigned long newsp);
+int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
+		siginfo_t *info, sigset_t *oldset,
+		struct pt_regs *regs, unsigned long newsp);
+int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
+		sigset_t *set, struct pt_regs *regs);
Index: linux-2.6/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_32.c	2007-06-02 11:15:15.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_32.c	2007-06-02 11:15:19.000000000 +0200
@@ -56,7 +56,6 @@
 #undef DEBUG_SIG
 
 #ifdef CONFIG_PPC64
-#define do_signal	do_signal32
 #define sys_sigsuspend	compat_sys_sigsuspend
 #define sys_rt_sigsuspend	compat_sys_rt_sigsuspend
 #define sys_rt_sigreturn	compat_sys_rt_sigreturn
@@ -231,8 +230,6 @@ static inline int restore_general_regs(s
 
 #endif /* CONFIG_PPC64 */
 
-int do_signal(sigset_t *oldset, struct pt_regs *regs);
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
@@ -699,7 +696,7 @@ int compat_sys_sigaltstack(u32 __new, u3
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
  */
-static int handle_rt_signal(unsigned long sig, struct k_sigaction *ka,
+int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 		siginfo_t *info, sigset_t *oldset,
 		struct pt_regs *regs, unsigned long newsp)
 {
@@ -990,7 +987,7 @@ int sys_debug_setcontext(struct ucontext
 /*
  * OK, we're invoking a handler
  */
-static int handle_signal(unsigned long sig, struct k_sigaction *ka,
+int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs,
 		unsigned long newsp)
 {
@@ -1101,84 +1098,3 @@ badframe:
 	force_sig(SIGSEGV, current);
 	return 0;
 }
-
-/*
- * Note that 'init' is a special process: it doesn't get signals it doesn't
- * want to handle. Thus you cannot kill init even with a SIGKILL even by
- * mistake.
- */
-int do_signal(sigset_t *oldset, struct pt_regs *regs)
-{
-	siginfo_t info;
-	struct k_sigaction ka;
-	unsigned int newsp;
-	int signr, ret;
-
-#ifdef CONFIG_PPC32
-	if (try_to_freeze()) {
-		signr = 0;
-		if (!signal_pending(current))
-			goto no_signal;
-	}
-#endif
-
-	if (test_thread_flag(TIF_RESTORE_SIGMASK))
-		oldset = &current->saved_sigmask;
-	else if (!oldset)
-		oldset = &current->blocked;
-
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-#ifdef CONFIG_PPC32
-no_signal:
-#endif
-	/* Is there any syscall restart business here ? */
-	check_syscall_restart(regs, &ka, signr > 0);
-
-	if (signr == 0) {
-		/* No signal to deliver -- put the saved sigmask back */
-		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
-			clear_thread_flag(TIF_RESTORE_SIGMASK);
-			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
-		}
-		return 0;		/* no signals delivered */
-	}
-
-	if ((ka.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
-	    && !on_sig_stack(regs->gpr[1]))
-		newsp = current->sas_ss_sp + current->sas_ss_size;
-	else
-		newsp = regs->gpr[1];
-	newsp &= ~0xfUL;
-
-#ifdef CONFIG_PPC64
-	/*
-	 * Reenable the DABR before delivering the signal to
-	 * user space. The DABR will have been cleared if it
-	 * triggered inside the kernel.
-	 */
-	if (current->thread.dabr)
-		set_dabr(current->thread.dabr);
-#endif
-
-	/* Whee!  Actually deliver the signal.  */
-	if (ka.sa.sa_flags & SA_SIGINFO)
-		ret = handle_rt_signal(signr, &ka, &info, oldset, regs, newsp);
-	else
-		ret = handle_signal(signr, &ka, &info, oldset, regs, newsp);
-
-	if (ret) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked,
-			  &ka.sa.sa_mask);
-		if (!(ka.sa.sa_flags & SA_NODEFER))
-			sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-		/* A signal was successfully delivered; the saved sigmask is in
-		   its frame, and we can clear the TIF_RESTORE_SIGMASK flag */
-		if (test_thread_flag(TIF_RESTORE_SIGMASK))
-			clear_thread_flag(TIF_RESTORE_SIGMASK);
-	}
-
-	return ret;
-}
Index: linux-2.6/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_64.c	2007-06-02 11:15:15.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_64.c	2007-06-02 11:15:19.000000000 +0200
@@ -334,7 +334,7 @@ badframe:
 	return 0;
 }
 
-static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
+int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 		sigset_t *set, struct pt_regs *regs)
 {
 	/* Handler is *really* a pointer to the function descriptor for
@@ -417,87 +417,3 @@ badframe:
 	force_sigsegv(signr, current);
 	return 0;
 }
-
-
-/*
- * OK, we're invoking a handler
- */
-static int handle_signal(unsigned long sig, struct k_sigaction *ka,
-			 siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
-{
-	int ret;
-
-	/* Set up Signal Frame */
-	ret = setup_rt_frame(sig, ka, info, oldset, regs);
-
-	if (ret) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
-		if (!(ka->sa.sa_flags & SA_NODEFER))
-			sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
-
-	return ret;
-}
-
-/*
- * Note that 'init' is a special process: it doesn't get signals it doesn't
- * want to handle. Thus you cannot kill init even with a SIGKILL even by
- * mistake.
- */
-int do_signal(sigset_t *oldset, struct pt_regs *regs)
-{
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
-
-	/*
-	 * If the current thread is 32 bit - invoke the
-	 * 32 bit signal handling code
-	 */
-	if (test_thread_flag(TIF_32BIT))
-		return do_signal32(oldset, regs);
-
-	if (test_thread_flag(TIF_RESTORE_SIGMASK))
-		oldset = &current->saved_sigmask;
-	else if (!oldset)
-		oldset = &current->blocked;
-
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
-	/* Is there any syscall restart business here ? */
-	check_syscall_restart(regs, &ka, signr > 0);
-
-	if (signr > 0) {
-		int ret;
-
-		/*
-		 * Reenable the DABR before delivering the signal to
-		 * user space. The DABR will have been cleared if it
-		 * triggered inside the kernel.
-		 */
-		if (current->thread.dabr)
-			set_dabr(current->thread.dabr);
-
-		/* Whee!  Actually deliver the signal.  */
-		ret = handle_signal(signr, &ka, &info, oldset, regs);
-
-		/* If a signal was successfully delivered, the saved sigmask is in
-		   its frame, and we can clear the TIF_RESTORE_SIGMASK flag */
-		if (ret && test_thread_flag(TIF_RESTORE_SIGMASK))
-			clear_thread_flag(TIF_RESTORE_SIGMASK);
-
-		return ret;
-	}
-
-	/* No signal to deliver -- put the saved sigmask back */
-	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
-		clear_thread_flag(TIF_RESTORE_SIGMASK);
-		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(do_signal);
