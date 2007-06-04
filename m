Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:51 +1000
Subject: [PATCH 16/21] powerpc: consolidate restore_sigmask
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051556.3F278DDF75@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

restore_sigmask is exactly the same on 32 and 64bit, so move it to
common code. Also move _BLOCKABLE to signal.h to avoid defining it
multiple times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal.c    |   15 +++++++++++++++
 arch/powerpc/kernel/signal.h    |    3 +++
 arch/powerpc/kernel/signal_32.c |   19 -------------------
 arch/powerpc/kernel/signal_64.c |   15 ---------------
 4 files changed, 18 insertions(+), 34 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 11:45:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 11:45:58.000000000 +1000
@@ -12,6 +12,21 @@
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
Index: linux-cell/arch/powerpc/kernel/signal.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.h	2007-06-04 11:45:41.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.h	2007-06-04 11:45:58.000000000 +1000
@@ -10,6 +10,9 @@
 #ifndef _POWERPC_ARCH_SIGNAL_H
 #define _POWERPC_ARCH_SIGNAL_H
 
+#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
+extern void restore_sigmask(sigset_t *set);
 extern void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 				  int has_handler);
 
Index: linux-cell/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_32.c	2007-06-04 11:45:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_32.c	2007-06-04 11:45:58.000000000 +1000
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
Index: linux-cell/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_64.c	2007-06-04 11:45:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_64.c	2007-06-04 11:45:58.000000000 +1000
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
