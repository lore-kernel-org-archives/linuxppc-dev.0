Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 May 2007 18:05:16 +1000
Subject: [RFC/PATCH 4/4] powerpc: Make syscall restart code more common
Message-Id: <20070530080527.6AA6CDDFD0@ozlabs.org>
Cc: ulrich.weigand@de.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the code in signal_32.c and signal_64.c for handling
syscall restart into a common signal-common.h file and converge around
a single implementation that is based on the 32 bits one, using trap, ccr
and r3 rather than the special "result" field for deciding what to do.

The "result" field is now pretty much deprecated. We still set it for
the sake of whatever might rely on it in userland but we no longer use
it's content.

This, along with a previous patch that enables ptracers to write to
"trap" and "orig_r3" should allow gdb to properly handle syscall
restarting.

There is only one common function for now and it's small enough so
having it inline is fine. However, there is probably room for more
merging of _32.c and _64.c in which case we'll probably want to
have a common .c file and avoid inlines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal-common.h |   66 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c     |   28 ++-------------
 arch/powerpc/kernel/signal_64.c     |   59 +++-----------------------------
 3 files changed, 77 insertions(+), 76 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal-common.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/kernel/signal-common.h	2007-05-30 16:47:12.000000000 +1000
@@ -0,0 +1,66 @@
+/*
+ *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
+ *    Extracted from signal_32.c and signal_64.c
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file README.legal in the main directory of
+ * this archive for more details.
+ */
+
+#ifndef _POWERPC_SIGNAL_COMMON_H
+#define _POWERPC_SIGNAL_COMMON_H
+
+static inline void check_syscall_restart(struct pt_regs *regs,
+					 struct k_sigaction *ka,
+					 int has_handler)
+{
+	unsigned long ret = regs->gpr[3];
+	int restart = 1;
+
+	/* syscall ? */
+	if (TRAP(regs) != 0x0C00)
+		return;
+
+	/* error signalled ? */
+	if (!(regs->ccr & 0x10000000))
+		return;
+
+	switch (ret) {
+	case ERESTART_RESTARTBLOCK:
+	case ERESTARTNOHAND:
+		/* ERESTARTNOHAND means that the syscall should only be
+		 * restarted if there was no handler for the signal, and since
+		 * we only get here if there is a handler, we dont restart.
+		 */
+		restart = !has_handler;
+		break;
+	case ERESTARTSYS:
+		/* ERESTARTSYS means to restart the syscall if there is no
+		 * handler or the handler was registered with SA_RESTART
+		 */
+		restart = !has_handler || (ka->sa.sa_flags & SA_RESTART) != 0;
+		break;
+	case ERESTARTNOINTR:
+		/* ERESTARTNOINTR means that the syscall should be
+		 * called again after the signal handler returns.
+		 */
+		break;
+	default:
+		return;
+	}
+	if (restart) {
+		if (ret == ERESTART_RESTARTBLOCK)
+			regs->gpr[0] = __NR_restart_syscall;
+		else
+			regs->gpr[3] = regs->orig_gpr3;
+		regs->nip -= 4;
+		regs->result = 0;
+	} else {
+		regs->result = -EINTR;
+		regs->gpr[3] = EINTR;
+		regs->ccr |= 0x10000000;
+	}
+}
+
+
+#endif /* _POWERPC_SIGNAL_COMMON_H */
Index: linux-cell/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_32.c	2007-05-30 16:45:57.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_32.c	2007-05-30 16:47:16.000000000 +1000
@@ -51,6 +51,8 @@
 #include <asm/pgtable.h>
 #endif
 
+#include "signal-common.h"
+
 #undef DEBUG_SIG
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
@@ -1156,30 +1158,8 @@ int do_signal(sigset_t *oldset, struct p
 #ifdef CONFIG_PPC32
 no_signal:
 #endif
-	if (TRAP(regs) == 0x0C00		/* System Call! */
-	    && regs->ccr & 0x10000000		/* error signalled */
-	    && ((ret = regs->gpr[3]) == ERESTARTSYS
-		|| ret == ERESTARTNOHAND || ret == ERESTARTNOINTR
-		|| ret == ERESTART_RESTARTBLOCK)) {
-
-		if (signr > 0
-		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
-			|| (ret == ERESTARTSYS
-			    && !(ka.sa.sa_flags & SA_RESTART)))) {
-			/* make the system call return an EINTR error */
-			regs->result = -EINTR;
-			regs->gpr[3] = EINTR;
-			/* note that the cr0.SO bit is already set */
-		} else {
-			regs->nip -= 4;	/* Back up & retry system call */
-			regs->result = 0;
-			regs->trap = 0;
-			if (ret == ERESTART_RESTARTBLOCK)
-				regs->gpr[0] = __NR_restart_syscall;
-			else
-				regs->gpr[3] = regs->orig_gpr3;
-		}
-	}
+	/* Is there any syscall restart business here ? */
+	check_syscall_restart(regs, &ka, signr > 0);
 
 	if (signr == 0) {
 		/* No signal to deliver -- put the saved sigmask back */
Index: linux-cell/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_64.c	2007-05-30 16:45:57.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_64.c	2007-05-30 16:47:12.000000000 +1000
@@ -34,6 +34,8 @@
 #include <asm/syscalls.h>
 #include <asm/vdso.h>
 
+#include "signal-common.h"
+
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
@@ -463,41 +465,6 @@ static int handle_signal(unsigned long s
 	return ret;
 }
 
-static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
-{
-	switch ((int)regs->result) {
-	case -ERESTART_RESTARTBLOCK:
-	case -ERESTARTNOHAND:
-		/* ERESTARTNOHAND means that the syscall should only be
-		 * restarted if there was no handler for the signal, and since
-		 * we only get here if there is a handler, we dont restart.
-		 */
-		regs->result = -EINTR;
-		regs->gpr[3] = EINTR;
-		regs->ccr |= 0x10000000;
-		break;
-	case -ERESTARTSYS:
-		/* ERESTARTSYS means to restart the syscall if there is no
-		 * handler or the handler was registered with SA_RESTART
-		 */
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
-			regs->result = -EINTR;
-			regs->gpr[3] = EINTR;
-			regs->ccr |= 0x10000000;
-			break;
-		}
-		/* fallthrough */
-	case -ERESTARTNOINTR:
-		/* ERESTARTNOINTR means that the syscall should be
-		 * called again after the signal handler returns.
-		 */
-		regs->gpr[3] = regs->orig_gpr3;
-		regs->nip -= 4;
-		regs->result = 0;
-		break;
-	}
-}
-
 /*
  * Note that 'init' is a special process: it doesn't get signals it doesn't
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
@@ -522,13 +489,13 @@ int do_signal(sigset_t *oldset, struct p
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+
+	/* Is there any syscall restart business here ? */
+	check_syscall_restart(regs, &ka, signr > 0);
+
 	if (signr > 0) {
 		int ret;
 
-		/* Whee!  Actually deliver the signal.  */
-		if (TRAP(regs) == 0x0C00)
-			syscall_restart(regs, &ka);
-
 		/*
 		 * Reenable the DABR before delivering the signal to
 		 * user space. The DABR will have been cleared if it
@@ -537,6 +504,7 @@ int do_signal(sigset_t *oldset, struct p
 		if (current->thread.dabr)
 			set_dabr(current->thread.dabr);
 
+		/* Whee!  Actually deliver the signal.  */
 		ret = handle_signal(signr, &ka, &info, oldset, regs);
 
 		/* If a signal was successfully delivered, the saved sigmask is in
@@ -547,19 +515,6 @@ int do_signal(sigset_t *oldset, struct p
 		return ret;
 	}
 
-	if (TRAP(regs) == 0x0C00) {	/* System Call! */
-		if ((int)regs->result == -ERESTARTNOHAND ||
-		    (int)regs->result == -ERESTARTSYS ||
-		    (int)regs->result == -ERESTARTNOINTR) {
-			regs->gpr[3] = regs->orig_gpr3;
-			regs->nip -= 4; /* Back up & retry system call */
-			regs->result = 0;
-		} else if ((int)regs->result == -ERESTART_RESTARTBLOCK) {
-			regs->gpr[0] = __NR_restart_syscall;
-			regs->nip -= 4;
-			regs->result = 0;
-		}
-	}
 	/* No signal to deliver -- put the saved sigmask back */
 	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
 		clear_thread_flag(TIF_RESTORE_SIGMASK);
