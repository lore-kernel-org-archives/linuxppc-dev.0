Return-Path: <benh@kernel.crashing.org>
Subject: PATCH 19/21] powerpc: Merge creation of signal frame (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070604051559.3E8C1DDF43@ozlabs.org>
References: <20070604051559.3E8C1DDF43@ozlabs.org>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 17:22:48 +1000
Message-Id: <1180941768.31677.50.camel@localhost.localdomain>
Mime-Version: 1.0
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

powerpc: Merge creation of signal frame

The code for creating signal frames was still duplicated and split
in strange ways between 32 and 64 bits, including the SA_ONSTACK
handling being in do_signal on 32 bits but inside handle_rt_signal
on 64 bits etc...

This moves the 64 bits get_sigframe() to the generic signal.c,
cleans it a bit, moves the access_ok() call done by all callers to
it as well, and adapts/cleanups the 3 different signal handling cases
to use that common function.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This one actually works :-)

Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 16:58:04.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 17:06:29.000000000 +1000
@@ -11,6 +11,7 @@
 
 #include <linux/ptrace.h>
 #include <linux/signal.h>
+#include <asm/uaccess.h>
 
 #include "signal.h"
 
@@ -27,6 +28,32 @@ static inline int is_32bit_task(void)
 }
 #endif
 
+/*
+ * Allocate space for the signal frame
+ */
+void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+			   size_t frame_size)
+{
+        unsigned long oldsp, newsp;
+
+        /* Default to using normal stack */
+        oldsp = regs->gpr[1];
+
+	/* Check for alt stack */
+	if ((ka->sa.sa_flags & SA_ONSTACK) &&
+	    current->sas_ss_size && !on_sig_stack(oldsp))
+		oldsp = (current->sas_ss_sp + current->sas_ss_size);
+
+	/* Get aligned frame */
+	newsp = (oldsp - frame_size) & ~0xFUL;
+
+	/* Check access */
+	if (!access_ok(VERIFY_WRITE, (void __user *)newsp, oldsp - newsp))
+		return NULL;
+
+        return (void __user *)newsp;
+}
+
 
 /*
  * Restore the user process's signal mask
@@ -129,20 +156,12 @@ int do_signal(sigset_t *oldset, struct p
 #endif
 
 	if (is32) {
-		unsigned int newsp;
-
-		if ((ka.sa.sa_flags & SA_ONSTACK) &&
-		    current->sas_ss_size && !on_sig_stack(regs->gpr[1]))
-			newsp = current->sas_ss_sp + current->sas_ss_size;
-		else
-			newsp = regs->gpr[1];
-
         	if (ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(signr, &ka, &info, oldset,
-					regs, newsp);
+					regs);
 		else
 			ret = handle_signal32(signr, &ka, &info, oldset,
-					regs, newsp);
+					regs);
 #ifdef CONFIG_PPC64
 	} else {
 		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
Index: linux-cell/arch/powerpc/kernel/signal.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.h	2007-06-04 16:58:04.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.h	2007-06-04 17:03:20.000000000 +1000
@@ -12,15 +12,17 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+extern void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+				  size_t frame_size);
 extern void restore_sigmask(sigset_t *set);
 
 extern int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 			   siginfo_t *info, sigset_t *oldset,
-			   struct pt_regs *regs, unsigned long newsp);
+			   struct pt_regs *regs);
 
 extern int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 			      siginfo_t *info, sigset_t *oldset,
-			      struct pt_regs *regs, unsigned long newsp);
+			      struct pt_regs *regs);
 
 extern int handle_rt_signal64(int signr, struct k_sigaction *ka,
 			      siginfo_t *info, sigset_t *set,
Index: linux-cell/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_32.c	2007-06-04 16:58:04.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_32.c	2007-06-04 17:14:20.000000000 +1000
@@ -282,14 +282,17 @@ long sys_sigaction(int sig, struct old_s
 /*
  * When we have signals to deliver, we set up on the
  * user stack, going down from the original stack pointer:
- *	a sigregs struct
+ *	an ABI gap of 56 words
+ *	an mcontext struct
  *	a sigcontext struct
  *	a gap of __SIGNAL_FRAMESIZE bytes
  *
- * Each of these things must be a multiple of 16 bytes in size.
+ * Each of these things must be a multiple of 16 bytes in size. The following
+ * structure represent all of this except the __SIGNAL_FRAMESIZE gap
  *
  */
-struct sigregs {
+struct sigframe {
+	struct sigcontext sctx;		/* the sigcontext */
 	struct mcontext	mctx;		/* all the register values */
 	/*
 	 * Programs using the rs6000/xcoff abi can save up to 19 gp
@@ -698,21 +701,16 @@ int compat_sys_sigaltstack(u32 __new, u3
  */
 int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 		siginfo_t *info, sigset_t *oldset,
-		struct pt_regs *regs, unsigned long newsp)
+		struct pt_regs *regs)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
-	unsigned long origsp = newsp;
+	unsigned long newsp = 0;
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	newsp -= sizeof(*rt_sf);
-	rt_sf = (struct rt_sigframe __user *)newsp;
-
-	/* create a stack frame for the caller of the handler */
-	newsp -= __SIGNAL_FRAMESIZE + 16;
-
-	if (!access_ok(VERIFY_WRITE, (void __user *)newsp, origsp - newsp))
+	rt_sf = get_sigframe(ka, regs, sizeof(*rt_sf));
+	if (unlikely(rt_sf == NULL))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
@@ -742,8 +740,12 @@ int handle_rt_signal32(unsigned long sig
 
 	current->thread.fpscr.val = 0;	/* turn off all fp exceptions */
 
+	/* create a stack frame for the caller of the handler */
+	newsp = ((unsigned long)rt_sf) - (__SIGNAL_FRAMESIZE + 16);
 	if (put_user(regs->gpr[1], (u32 __user *)newsp))
 		goto badframe;
+
+	/* Fill registers for signal handler */
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
@@ -988,26 +990,17 @@ int sys_debug_setcontext(struct ucontext
  * OK, we're invoking a handler
  */
 int handle_signal32(unsigned long sig, struct k_sigaction *ka,
-		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs,
-		unsigned long newsp)
+		    siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
 	struct sigcontext __user *sc;
-	struct sigregs __user *frame;
-	unsigned long origsp = newsp;
+	struct sigframe __user *frame;
+	unsigned long newsp = 0;
 
 	/* Set up Signal Frame */
-	newsp -= sizeof(struct sigregs);
-	frame = (struct sigregs __user *) newsp;
-
-	/* Put a sigcontext on the stack */
-	newsp -= sizeof(*sc);
-	sc = (struct sigcontext __user *) newsp;
-
-	/* create a stack frame for the caller of the handler */
-	newsp -= __SIGNAL_FRAMESIZE;
-
-	if (!access_ok(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
+	frame = get_sigframe(ka, regs, sizeof(*frame));
+	if (unlikely(frame == NULL))
 		goto badframe;
+	sc = (struct sigcontext __user *) &frame->sctx;
 
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
@@ -1019,7 +1012,7 @@ int handle_signal32(unsigned long sig, s
 #else
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 #endif
-	    || __put_user(to_user_ptr(frame), &sc->regs)
+	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
 	    || __put_user(sig, &sc->signal))
 		goto badframe;
 
@@ -1035,8 +1028,11 @@ int handle_signal32(unsigned long sig, s
 
 	current->thread.fpscr.val = 0;	/* turn off all fp exceptions */
 
+	/* create a stack frame for the caller of the handler */
+	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
 	if (put_user(regs->gpr[1], (u32 __user *)newsp))
 		goto badframe;
+
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
Index: linux-cell/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_64.c	2007-06-04 16:58:04.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_64.c	2007-06-04 17:22:10.000000000 +1000
@@ -196,25 +196,6 @@ static long restore_sigcontext(struct pt
 }
 
 /*
- * Allocate space for the signal frame
- */
-static inline void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-				  size_t frame_size)
-{
-        unsigned long newsp;
-
-        /* Default to using normal stack */
-        newsp = regs->gpr[1];
-
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size) {
-		if (! on_sig_stack(regs->gpr[1]))
-			newsp = (current->sas_ss_sp + current->sas_ss_size);
-	}
-
-        return (void __user *)((newsp - frame_size) & -16ul);
-}
-
-/*
  * Setup the trampoline code on the stack
  */
 static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
@@ -348,8 +329,7 @@ int handle_rt_signal64(int signr, struct
 	long err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
-
-	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+	if (unlikely(frame == NULL))
 		goto badframe;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
@@ -386,7 +366,7 @@ int handle_rt_signal64(int signr, struct
 	funct_desc_ptr = (func_descr_t __user *) ka->sa.sa_handler;
 
 	/* Allocate a dummy caller frame for the signal handler. */
-	newsp = (unsigned long)frame - __SIGNAL_FRAMESIZE;
+	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
 	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
 
 	/* Set up "regs" so we "return" to the signal handler. */
