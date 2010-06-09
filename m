Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B04A0101680
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:25:52 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id o59APoe5022745
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 15:55:50 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59APoPO3264650
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 15:55:50 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o59APnKi032298
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 20:25:50 +1000
Date: Wed, 9 Jun 2010 15:55:48 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 4/5] PPC64-HWBKPT: Enable hw-breakpoints while handling
	intervening signals
Message-ID: <20100609102548.GE20332@in.ibm.com>
References: <20100609101417.644628763@linux.vnet.ibm.com>
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
signal delivery.

Restore hw-breakpoints if the user-context is altered in the signal handler.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |    3 +++
 arch/powerpc/kernel/hw_breakpoint.c      |   18 ++++++++++++++++++
 arch/powerpc/kernel/signal.c             |    3 +++
 3 files changed, 24 insertions(+)

Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/hw_breakpoint.h
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
@@ -65,9 +65,12 @@ static inline void hw_breakpoint_disable
 {
 	set_dabr(0);
 }
+extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 
 #else	/* CONFIG_HAVE_HW_BREAKPOINT */
 static inline void hw_breakpoint_disable(void) { }
+static inline void thread_change_pc(struct task_struct *tsk,
+					struct pt_regs *regs) { }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* __KERNEL__ */
 #endif	/* _PPC_BOOK3S_64_HW_BREAKPOINT_H */
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/hw_breakpoint.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
@@ -174,6 +174,24 @@ int arch_validate_hwbkpt_settings(struct
 }
 
 /*
+ * Restores the breakpoint on the debug registers.
+ * Invoke this function if it is known that the execution context is about to
+ * change to cause loss of MSR_SE settings.
+ */
+void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *info;
+
+	if (likely(!tsk->thread.last_hit_ubp))
+		return;
+
+	info = counter_arch_bp(tsk->thread.last_hit_ubp);
+	regs->msr &= ~MSR_SE;
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
+	tsk->thread.last_hit_ubp = NULL;
+}
+
+/*
  * Handle debug exception notifications.
  */
 int __kprobes hw_breakpoint_handler(struct die_args *args)
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
 
@@ -149,6 +150,8 @@ static int do_signal_pending(sigset_t *o
 	if (current->thread.dabr)
 		set_dabr(current->thread.dabr);
 #endif
+	/* Re-enable the breakpoints for the signal stack */
+	thread_change_pc(current, regs);
 
 	if (is32) {
         	if (ka.sa.sa_flags & SA_SIGINFO)
