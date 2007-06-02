Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B909BDDF4A
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 20:25:14 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l52APAo6022040
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Jun 2007 12:25:10 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l52APAYV022038
	for linuxppc-dev@ozlabs.org; Sat, 2 Jun 2007 12:25:10 +0200
Date: Sat, 2 Jun 2007 12:25:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] consolidate restore_sigmask
Message-ID: <20070602102510.GB22008@lst.de>
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

restore_sigmask is exactly the same on 32 and 64bit, so move it to
common code. Also move _BLOCKABLE to signal.h to avoid defining it
multiple times.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.c	2007-06-01 22:33:06.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal.c	2007-06-01 22:34:37.000000000 +0200
@@ -10,6 +10,21 @@
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 
+#include "signal.h"
+
+
+/*
+ * Restore the user process's signal mask
+ */
+void restore_sigmask(sigset_t *set)
+{
+	sigdelsetmask(set, ~_BLOCKABLE);
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = *set;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+}
+
 void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 		int has_handler)
 {
Index: linux-2.6/arch/powerpc/kernel/signal.h
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.h	2007-06-01 22:33:06.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal.h	2007-06-01 22:34:14.000000000 +0200
@@ -1,3 +1,6 @@
 
+#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
+void restore_sigmask(sigset_t *set);
 void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 		int has_handler);
Index: linux-2.6/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_32.c	2007-06-01 22:33:06.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_32.c	2007-06-01 22:34:11.000000000 +0200
@@ -55,8 +55,6 @@
 
 #undef DEBUG_SIG
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #ifdef CONFIG_PPC64
 #define do_signal	do_signal32
 #define sys_sigsuspend	compat_sys_sigsuspend
@@ -697,23 +695,6 @@ int compat_sys_sigaltstack(u32 __new, u3
 }
 #endif /* CONFIG_PPC64 */
 
-
-/*
- * Restore the user process's signal mask
- */
-#ifdef CONFIG_PPC64
-extern void restore_sigmask(sigset_t *set);
-#else /* CONFIG_PPC64 */
-static void restore_sigmask(sigset_t *set)
-{
-	sigdelsetmask(set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = *set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-}
-#endif
-
 /*
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
Index: linux-2.6/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_64.c	2007-06-01 22:33:06.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_64.c	2007-06-01 22:34:18.000000000 +0200
@@ -38,8 +38,6 @@
 
 #define DEBUG_SIG 0
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 #define FP_REGS_SIZE	sizeof(elf_fpregset_t)
 
@@ -243,19 +241,6 @@ static long setup_trampoline(unsigned in
 }
 
 /*
- * Restore the user process's signal mask (also used by signal32.c)
- */
-void restore_sigmask(sigset_t *set)
-{
-	sigdelsetmask(set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = *set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-}
-
-
-/*
  * Handle {get,set,swap}_context operations
  */
 int sys_swapcontext(struct ucontext __user *old_ctx,
