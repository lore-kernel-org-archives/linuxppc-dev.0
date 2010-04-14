Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A7ADB7D54
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 13:48:35 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3E3mWVc028390
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 09:18:32 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3E3mWFo3358722
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 09:18:32 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3E3mWjq016844
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 13:48:32 +1000
Date: Wed, 14 Apr 2010 09:18:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100414034827.GC6571@in.ibm.com>
References: <20100414033555.746326035@pr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, paulus@samba.org,
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

Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
These interfaces help arbitrate requests from various users and schedules
them as appropriate.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                     |    1 
 arch/powerpc/include/asm/cputable.h      |    4 
 arch/powerpc/include/asm/hw_breakpoint.h |   45 ++++
 arch/powerpc/include/asm/processor.h     |    8 
 arch/powerpc/kernel/Makefile             |    1 
 arch/powerpc/kernel/hw_breakpoint.c      |  324 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c   |    3 
 arch/powerpc/kernel/process.c            |    6 
 arch/powerpc/kernel/ptrace.c             |   81 +++++++
 arch/powerpc/lib/Makefile                |    1 
 include/linux/hw_breakpoint.h            |    1 
 11 files changed, 475 insertions(+)

Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- /dev/null
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
@@ -0,0 +1,45 @@
+#ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
+#define _PPC_BOOK3S_64_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+struct arch_hw_breakpoint {
+	u8		len; /* length of the target data symbol */
+	int		type;
+	unsigned long	address;
+};
+
+#include <linux/kdebug.h>
+#include <asm/reg.h>
+#include <asm/system.h>
+
+struct perf_event;
+struct pmu;
+struct perf_sample_data;
+
+#define HW_BREAKPOINT_ALIGN 0x7
+/* Maximum permissible length of any HW Breakpoint */
+#define HW_BREAKPOINT_LEN 0x8
+
+extern int arch_validate_hwbkpt_settings(struct perf_event *bp,
+						struct task_struct *tsk);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+						unsigned long val, void *data);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
+
+extern struct pmu perf_ops_bp;
+extern void ptrace_triggered(struct perf_event *bp, int nmi,
+			struct perf_sample_data *data, struct pt_regs *regs);
+static inline void hw_breakpoint_disable(void)
+{
+	set_dabr(0);
+}
+
+#endif	/* CONFIG_HAVE_HW_BREAKPOINT */
+#endif	/* __KERNEL__ */
+#endif	/* _PPC_BOOK3S_64_HW_BREAKPOINT_H */
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- /dev/null
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
@@ -0,0 +1,324 @@
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers. Derived from
+ * "arch/x86/kernel/hw_breakpoint.c"
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright 2009 IBM Corporation
+ * Author: K.Prasad <prasad@linux.vnet.ibm.com>
+ *
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/notifier.h>
+#include <linux/kprobes.h>
+#include <linux/percpu.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/hw_breakpoint.h>
+#include <asm/processor.h>
+#include <asm/sstep.h>
+
+/*
+ * Store the 'bp' that caused the hw-breakpoint exception just before we
+ * single-step. Use it to distinguish a single-step exception (due to a
+ * previous hw-breakpoint exception) from a normal one
+ */
+static DEFINE_PER_CPU(struct perf_event *, last_hit_bp);
+
+/*
+ * Stores the breakpoints currently in use on each breakpoint address
+ * register for every cpu
+ */
+static DEFINE_PER_CPU(struct perf_event *, bp_per_reg);
+
+/*
+ * Install a perf counter breakpoint.
+ *
+ * We seek a free debug address register and use it for this
+ * breakpoint.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables
+ * and registers local to this cpu.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
+
+	*slot = bp;
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
+	return 0;
+}
+
+/*
+ * Uninstall the breakpoint contained in the given counter.
+ *
+ * First we search the debug address register it uses and then we disable
+ * it.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables
+ * and registers local to this cpu.
+ */
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
+
+	if (*slot != bp) {
+		WARN_ONCE(1, "Can't find the breakpoint");
+		return;
+	}
+
+	*slot = NULL;
+	set_dabr(0);
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp,
+						struct task_struct *tsk)
+{
+	bool is_kernel;
+	int ret = -EINVAL;
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	if (!bp)
+		return ret;
+
+	switch (bp->attr.bp_type) {
+	case HW_BREAKPOINT_R:
+		info->type = DABR_DATA_READ;
+		break;
+	case HW_BREAKPOINT_W:
+		info->type = DABR_DATA_WRITE;
+		break;
+	case HW_BREAKPOINT_R | HW_BREAKPOINT_W:
+		info->type = (DABR_DATA_READ | DABR_DATA_WRITE);
+		break;
+	default:
+		return ret;
+	}
+
+	is_kernel = is_kernel_addr(bp->attr.bp_addr);
+	if ((tsk && is_kernel) || (!tsk && !is_kernel))
+		return -EINVAL;
+
+	info->address = bp->attr.bp_addr;
+	info->len = bp->attr.bp_len;
+
+	/*
+	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
+	 * and breakpoint addresses are aligned to nearest double-word
+	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
+	 * 'symbolsize' should satisfy the check below.
+	 */
+	if (info->len >
+	    (HW_BREAKPOINT_LEN - (info->address & HW_BREAKPOINT_ALIGN)))
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+int __kprobes hw_breakpoint_handler(struct die_args *args)
+{
+	bool is_kernel, is_ptrace_bp = false;
+	int rc = NOTIFY_STOP;
+	struct perf_event *bp;
+	struct pt_regs *regs = args->regs;
+	unsigned long dar = regs->dar;
+	int cpu, stepped = 1;
+	struct arch_hw_breakpoint *info;
+
+	/* Disable breakpoints during exception handling */
+	set_dabr(0);
+	cpu = smp_processor_id();
+	/*
+	 * The counter may be concurrently released but that can only
+	 * occur from a call_rcu() path. We can then safely fetch
+	 * the breakpoint, use its callback, touch its counter
+	 * while we are in an rcu_read_lock() path.
+	 */
+	rcu_read_lock();
+
+	bp = per_cpu(bp_per_reg, cpu);
+	if (!bp)
+		goto out;
+	info = counter_arch_bp(bp);
+	is_kernel = is_kernel_addr(bp->attr.bp_addr);
+	is_ptrace_bp = (bp->overflow_handler == ptrace_triggered) ?
+			true : false;
+
+	/*
+	 * Verify if dar lies within the address range occupied by the symbol
+	 * being watched to filter extraneous exceptions.
+	 */
+	if (!((bp->attr.bp_addr <= dar) &&
+	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))) &&
+	    (is_ptrace_bp == false))
+		/*
+		 * This exception is triggered not because of a memory access on
+		 * the monitored variable but in the double-word address range
+		 * in which it is contained. We will consume this exception,
+		 * considering it as 'noise'.
+		 */
+		goto restore_bp;
+
+	/*
+	 * Return early after invoking user-callback function without restoring
+	 * DABR if the breakpoint is from ptrace which always operates in
+	 * one-shot mode
+	 */
+	if (is_ptrace_bp == true) {
+		perf_bp_event(bp, regs);
+		rc = NOTIFY_DONE;
+		goto out;
+	}
+
+	/*
+	 * Do not emulate user-space instructions from kernel-space,
+	 * instead single-step them.
+	 */
+	if (is_kernel == false) {
+		current->thread.last_hit_ubp = bp;
+		regs->msr |= MSR_SE;
+		goto out;
+	}
+
+	stepped = emulate_step(regs, regs->nip);
+	/* emulate_step() could not execute it, single-step them */
+	if (stepped == 0) {
+		regs->msr |= MSR_SE;
+		per_cpu(last_hit_bp, cpu) = bp;
+		goto out;
+	}
+	/*
+	 * As a policy, the callback is invoked in a 'trigger-after-execute'
+	 * fashion
+	 */
+	perf_bp_event(bp, regs);
+
+restore_bp:
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
+out:
+	rcu_read_unlock();
+	return rc;
+}
+
+/*
+ * Handle single-step exceptions following a DABR hit.
+ */
+int __kprobes single_step_dabr_instruction(struct die_args *args)
+{
+	struct pt_regs *regs = args->regs;
+	int cpu = smp_processor_id();
+	siginfo_t info;
+	struct perf_event *bp = NULL, *kernel_bp, *user_bp;
+	struct arch_hw_breakpoint *bp_info;
+
+	/*
+	 * Identify the cause of single-stepping and find the corresponding
+	 * breakpoint structure
+	 */
+	user_bp = current->thread.last_hit_ubp;
+	kernel_bp = per_cpu(last_hit_bp, cpu);
+	if (user_bp) {
+		bp = user_bp;
+		current->thread.last_hit_ubp = NULL;
+	} else if (kernel_bp) {
+		bp = kernel_bp;
+		per_cpu(last_hit_bp, cpu) = NULL;
+	}
+
+	/*
+	 * Check if we are single-stepping as a result of a
+	 * previous HW Breakpoint exception
+	 */
+	if (!bp)
+		return NOTIFY_DONE;
+
+	bp_info = counter_arch_bp(bp);
+
+	/*
+	 * We shall invoke the user-defined callback function in the single
+	 * stepping handler to confirm to 'trigger-after-execute' semantics
+	 */
+	perf_bp_event(bp, regs);
+
+	/*
+	 * Do not disable MSR_SE if the process was already in
+	 * single-stepping mode. We cannot reliable detect single-step mode
+	 * for kernel-space breakpoints, so this cannot work along with other
+	 * debuggers (like KGDB, xmon) which may be single-stepping kernel code.
+	 */
+	if (!(user_bp && test_thread_flag(TIF_SINGLESTEP)))
+		regs->msr &= ~MSR_SE;
+
+	/* Deliver signal to user-space */
+	if (user_bp) {
+		info.si_signo = SIGTRAP;
+		info.si_errno = 0;
+		info.si_code = TRAP_HWBKPT;
+		info.si_addr = (void __user *)bp_info->address;
+		force_sig_info(SIGTRAP, &info, current);
+	}
+
+	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
+	return NOTIFY_STOP;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+int __kprobes hw_breakpoint_exceptions_notify(
+		struct notifier_block *unused, unsigned long val, void *data)
+{
+	int ret = NOTIFY_DONE;
+
+	switch (val) {
+	case DIE_DABR_MATCH:
+		ret = hw_breakpoint_handler(data);
+		break;
+	case DIE_SSTEP:
+		ret = single_step_dabr_instruction(data);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Release the user breakpoints used by ptrace
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	struct thread_struct *t = &tsk->thread;
+
+	unregister_hw_breakpoint(t->ptrace_bps[0]);
+	t->ptrace_bps[0] = NULL;
+}
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
+
Index: linux-2.6.ppc64_test/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/Kconfig
+++ linux-2.6.ppc64_test/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select HAVE_SYSCALL_WRAPPERS if PPC64
 	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_EVENTS
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
@@ -34,6 +34,7 @@ obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
@@ -209,6 +209,14 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *ptrace_bps[HBP_NUM];
+	/*
+	 * Helps identify source of single-step exception and subsequent
+	 * hw-breakpoint enablement
+	 */
+	struct perf_event *last_hit_ubp;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/ptrace.c
@@ -32,6 +32,8 @@
 #ifdef CONFIG_PPC32
 #include <linux/module.h>
 #endif
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -763,9 +765,34 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+void ptrace_triggered(struct perf_event *bp, int nmi,
+		      struct perf_sample_data *data, struct pt_regs *regs)
+{
+	struct perf_event_attr attr;
+
+	/*
+	 * Disable the breakpoint request here since ptrace has defined a
+	 * one-shot behaviour for breakpoint exceptions in PPC64.
+	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * We don't have to do anything about that here
+	 */
+	attr = bp->attr;
+	attr.disabled = true;
+	modify_user_hw_breakpoint(bp, &attr);
+}
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	int ret;
+	struct thread_struct *thread = &(task->thread);
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
 	 *  For embedded processors we support one DAC and no IAC's at the
 	 *  moment.
@@ -793,6 +820,60 @@ int ptrace_set_debugreg(struct task_stru
 	/* Ensure breakpoint translation bit is set */
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	bp = thread->ptrace_bps[0];
+	if (data == 0) {
+		if (bp) {
+			unregister_hw_breakpoint(bp);
+			thread->ptrace_bps[0] = NULL;
+		}
+		return 0;
+	}
+	if (bp) {
+		attr = bp->attr;
+		attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
+
+		switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
+		case DABR_DATA_READ:
+			attr.bp_type = HW_BREAKPOINT_R;
+			break;
+		case DABR_DATA_WRITE:
+			attr.bp_type = HW_BREAKPOINT_W;
+			break;
+		case (DABR_DATA_WRITE | DABR_DATA_READ):
+			attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
+			break;
+		}
+		ret =  modify_user_hw_breakpoint(bp, &attr);
+		if (ret)
+			return ret;
+		thread->ptrace_bps[0] = bp;
+		thread->dabr = data;
+		return 0;
+	}
+
+	/* Create a new breakpoint request if one doesn't exist already */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
+	switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
+	case DABR_DATA_READ:
+		attr.bp_type = HW_BREAKPOINT_R;
+		break;
+	case DABR_DATA_WRITE:
+		attr.bp_type = HW_BREAKPOINT_W;
+		break;
+	case (DABR_DATA_WRITE | DABR_DATA_READ):
+		attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
+		break;
+	}
+	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
+							ptrace_triggered, task);
+	if (IS_ERR(bp)) {
+		thread->ptrace_bps[0] = NULL;
+		return PTR_ERR(bp);
+	}
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/process.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
@@ -459,8 +459,14 @@ struct task_struct *__switch_to(struct t
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	switch_booke_debug_regs(&new->thread);
 #else
+/*
+ * For PPC_BOOK3S_64, we use the hw-breakpoint interfaces that would
+ * schedule DABR
+ */
+#ifndef CONFIG_HAVE_HW_BREAKPOINT
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
 
Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
@@ -511,6 +511,10 @@ static inline int cpu_has_feature(unsign
 		& feature);
 }
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define HBP_NUM 1
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6.ppc64_test/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/machine_kexec_64.c
@@ -15,6 +15,7 @@
 #include <linux/thread_info.h>
 #include <linux/init_task.h>
 #include <linux/errno.h>
+#include <linux/hw_breakpoint.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -161,6 +162,7 @@ void kexec_copy_flush(struct kimage *ima
  */
 static void kexec_smp_down(void *arg)
 {
+	hw_breakpoint_disable();
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 1);
 
@@ -174,6 +176,7 @@ static void kexec_prepare_cpus(void)
 	int my_cpu, i, notified=-1;
 
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
+	hw_breakpoint_disable();
 	my_cpu = get_cpu();
 
 	/* check the others cpus are now down (via paca hw cpu id == -1) */
Index: linux-2.6.ppc64_test/arch/powerpc/lib/Makefile
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/lib/Makefile
+++ linux-2.6.ppc64_test/arch/powerpc/lib/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PPC64)	+= copypage_64.o cop
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
 obj-$(CONFIG_XMON)	+= sstep.o
 obj-$(CONFIG_KPROBES)	+= sstep.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
Index: linux-2.6.ppc64_test/include/linux/hw_breakpoint.h
===================================================================
--- linux-2.6.ppc64_test.orig/include/linux/hw_breakpoint.h
+++ linux-2.6.ppc64_test/include/linux/hw_breakpoint.h
@@ -120,6 +120,7 @@ static inline struct arch_hw_breakpoint 
 {
 	return NULL;
 }
+static inline void hw_breakpoint_disable(void) { }
 
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif /* __KERNEL__ */
