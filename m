Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEAFADE58E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:13 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4L7ICk6008124
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4L7IC9Q442374
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:12 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4L7ICJp011631
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:12 +1000
Date: Thu, 21 May 2009 12:48:03 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090521071803.GE693@in.ibm.com>
References: <20090521070751.156865078@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
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
 arch/powerpc/kernel/process.c          |   18 ++++++++++++++++++
 arch/powerpc/kernel/smp.c              |    2 ++
 3 files changed, 22 insertions(+)

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
@@ -605,6 +617,9 @@ int copy_thread(unsigned long clone_flag
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
+#ifdef CONFIG_PPC64
+	struct task_struct *tsk = current;
+#endif
 
 	CHECK_FULL_REGS(regs);
 	/* Copy registers */
@@ -672,6 +687,9 @@ int copy_thread(unsigned long clone_flag
 	 * function.
  	 */
 	kregs->nip = *((unsigned long *)ret_from_fork);
+
+	if (unlikely(test_tsk_thread_flag(tsk, TIF_DEBUG)))
+		copy_thread_hw_breakpoint(tsk, p, clone_flags);
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
