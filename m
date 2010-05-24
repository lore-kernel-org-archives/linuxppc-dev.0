Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2A9DB7D1D
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 23:47:22 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4ODjCZX012000
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 19:17:07 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4OAYo333559518
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 16:04:58 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4OAYnNw027642
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 20:34:49 +1000
Date: Mon, 24 May 2010 16:04:19 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 4/4] PPC64-HWBKPT: Enable hw-breakpoints while handling
	intervening signals
Message-ID: <20100524103419.GE8131@in.ibm.com>
References: <20100524102614.040177456@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A signal delivered between a hw_breakpoint_handler() and the
single_step_dabr_instruction() will not have the breakpoint active during
signal handling (since breakpoint will not be restored through single-stepping
due to absence of MSR_SE bit on the signal frame). Enable breakpoints before
signal delivery and clear them during sigreturn() syscall.

Limitation: Nested hw-breakpoint exceptions (where second exception is raised
inside signal context) will cause a 'double-hit' i.e. the first breakpoint
exception will be taken twice.

Restore hw-breakpoints if the user-context is altered in the signal handler
(causing loss of MSR_SE). Side-effect: 'Double-hit' of breakpoint if the
instruction pointer is unaltered in the new context.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |    3 +++
 arch/powerpc/kernel/hw_breakpoint.c      |   28 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/signal.c             |    8 ++++++++
 arch/powerpc/kernel/signal_32.c          |   10 ++++++++++
 arch/powerpc/kernel/signal_64.c          |    7 +++++++
 5 files changed, 56 insertions(+)

Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/hw_breakpoint.h
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
@@ -43,6 +43,9 @@ static inline void hw_breakpoint_disable
 {
 	set_dabr(0);
 }
+extern void sighandler_install_bp(struct task_struct *tsk);
+extern void sigreturn_uninstall_bp(struct task_struct *tsk);
+extern void thread_change_pc(struct task_struct *tsk, unsigned long msr);
 
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* __KERNEL__ */
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/hw_breakpoint.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
@@ -175,6 +175,34 @@ int arch_validate_hwbkpt_settings(struct
 	return 0;
 }
 
+void sighandler_install_bp(struct task_struct *tsk)
+{
+	struct arch_hw_breakpoint *info;
+
+	if (likely(!tsk->thread.last_hit_ubp))
+		return;
+
+	info = counter_arch_bp(tsk->thread.last_hit_ubp);
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
+}
+
+void sigreturn_uninstall_bp(struct task_struct *tsk)
+{
+	if (unlikely(tsk->thread.last_hit_ubp))
+		set_dabr(0);
+}
+
+void thread_change_pc(struct task_struct *tsk, unsigned long new_msr)
+{
+	/*
+	 * Do not bother to restore breakpoints if single-stepping is not
+	 * cleared. single_step_dabr_instruction() will handle it if MSR_SE
+	 * is set.
+	 */
+	if (!(new_msr & MSR_SE))
+		sighandler_install_bp(tsk);
+}
+
 /*
  * Handle debug exception notifications.
  */
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/signal.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/signal.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/signal.c
@@ -11,6 +11,7 @@
 
 #include <linux/tracehook.h>
 #include <linux/signal.h>
+#include <asm/hw_breakpoint.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
@@ -149,6 +150,13 @@ static int do_signal_pending(sigset_t *o
 	if (current->thread.dabr)
 		set_dabr(current->thread.dabr);
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/*
+	 * Re-enable the breakpoints (if it was previously cleared in
+	 * hw_breakpoint_handler()) for the signal stack.
+	 */
+	sighandler_install_bp(current);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	if (is32) {
         	if (ka.sa.sa_flags & SA_SIGINFO)
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/signal_64.c
@@ -33,6 +33,7 @@
 #include <asm/cacheflush.h>
 #include <asm/syscalls.h>
 #include <asm/vdso.h>
+#include <asm/hw_breakpoint.h>
 
 #include "signal.h"
 
@@ -312,6 +313,9 @@ int sys_swapcontext(struct ucontext __us
 		    || __copy_to_user(&old_ctx->uc_sigmask,
 				      &current->blocked, sizeof(sigset_t)))
 			return -EFAULT;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+		thread_change_pc(current, new_msr);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	}
 	if (new_ctx == NULL)
 		return 0;
@@ -364,6 +368,9 @@ int sys_rt_sigreturn(unsigned long r3, u
 	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
 		goto badframe;
 	restore_sigmask(&set);
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	sigreturn_uninstall_bp(current);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
 		goto badframe;
 
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/signal_32.c
@@ -42,6 +42,7 @@
 #include <asm/syscalls.h>
 #include <asm/sigcontext.h>
 #include <asm/vdso.h>
+#include <asm/hw_breakpoint.h>
 #ifdef CONFIG_PPC64
 #include "ppc32.h"
 #include <asm/unistd.h>
@@ -996,6 +997,9 @@ long sys_swapcontext(struct ucontext __u
 		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
 		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
 			return -EFAULT;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+		thread_change_pc(current, new_msr);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	}
 	if (new_ctx == NULL)
 		return 0;
@@ -1034,6 +1038,9 @@ long sys_rt_sigreturn(int r3, int r4, in
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
 	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
 		goto bad;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	sigreturn_uninstall_bp(current);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	if (do_setcontext(&rt_sf->uc, regs, 1))
 		goto bad;
 
@@ -1279,6 +1286,9 @@ long sys_sigreturn(int r3, int r4, int r
 #endif
 	restore_sigmask(&set);
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	sigreturn_uninstall_bp(current);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
 	addr = sr;
 	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
