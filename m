Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84A0DDE52D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 02:35:44 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n53GZbOR005209
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 22:05:37 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n53GZbPj2224186
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 22:05:37 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n53GZaXj027495
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Jun 2009 02:35:37 +1000
Date: Wed, 3 Jun 2009 22:05:34 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090603163534.GE5197@in.ibm.com>
References: <20090603162741.197115376@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify process handling code to recognise hardware debug registers during copy
and flush operations. Introduce a new TIF_DEBUG task flag to indicate a
process's use of debug register. Load the debug register values into a
new CPU during initialisation.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/thread_info.h |    2 ++
 arch/powerpc/kernel/process.c          |   15 +++++++++++++++
 arch/powerpc/kernel/smp.c              |    2 ++
 3 files changed, 19 insertions(+)

Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/thread_info.h
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/include/asm/thread_info.h
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/thread_info.h
@@ -114,6 +114,7 @@ static inline struct thread_info *curren
 #define TIF_FREEZE		14	/* Freezing for suspend */
 #define TIF_RUNLATCH		15	/* Is the runlatch enabled? */
 #define TIF_ABI_PENDING		16	/* 32/64 bit switch needed */
+#define TIF_DEBUG		17	/* uses debug registers */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -132,6 +133,7 @@ static inline struct thread_info *curren
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
 #define _TIF_RUNLATCH		(1<<TIF_RUNLATCH)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
@@ -50,6 +50,7 @@
 #include <asm/syscalls.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
+#include <asm/hw_breakpoint.h>
 #endif
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
 
+#ifndef CONFIG_PPC64
 	if (debugger_dabr_match(regs))
 		return;
+#endif
 
 	/* Clear the DAC and struct entries.  One shot trigger */
 #if defined(CONFIG_BOOKE)
@@ -372,8 +375,13 @@ struct task_struct *__switch_to(struct t
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC64
+		if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
+			arch_install_thread_hw_breakpoint(new);
+#else
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
+#endif /* CONFIG_PPC64 */
 
 #if defined(CONFIG_BOOKE)
 	/* If new thread DAC (HW breakpoint) is the same then leave it */
@@ -550,6 +558,10 @@ void show_regs(struct pt_regs * regs)
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
+#ifdef CONFIG_PPC64
+	if (unlikely(test_tsk_thread_flag(current, TIF_DEBUG)))
+		flush_thread_hw_breakpoint(current);
+#endif /* CONFIG_PPC64 */
 }
 
 void flush_thread(void)
@@ -672,6 +684,9 @@ int copy_thread(unsigned long clone_flag
 	 * function.
  	 */
 	kregs->nip = *((unsigned long *)ret_from_fork);
+
+	if (unlikely(test_tsk_thread_flag(current, TIF_DEBUG)))
+		copy_thread_hw_breakpoint(current, p, clone_flags);
 #else
 	kregs->nip = (unsigned long)ret_from_fork;
 #endif
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/smp.c
@@ -48,6 +48,7 @@
 #include <asm/vdso_datapage.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/hw_breakpoint.h>
 #endif
 
 #ifdef DEBUG
@@ -536,6 +537,7 @@ int __devinit start_secondary(void *unus
 
 	local_irq_enable();
 
+	load_debug_registers();
 	cpu_idle();
 	return 0;
 }
