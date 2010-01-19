Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 377CFB7CA1
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:14:38 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o0J9EZtM019272
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 14:44:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0J9EYA32363400
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 14:44:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0J9EYb3026880
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:14:34 +1100
Date: Tue, 19 Jan 2010 14:44:29 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Roland McGrath <roland@redhat.com>
Subject: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100119091429.GB9971@in.ibm.com>
References: <20100119091234.GA9971@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100119091234.GA9971@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
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
 arch/powerpc/include/asm/hw_breakpoint.h |   55 +++++
 arch/powerpc/include/asm/processor.h     |    1 
 arch/powerpc/include/asm/reg.h           |    1 
 arch/powerpc/kernel/Makefile             |    2 
 arch/powerpc/kernel/hw_breakpoint.c      |  332 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/process.c            |    5 
 arch/powerpc/kernel/ptrace.c             |   77 +++++++
 arch/powerpc/mm/fault.c                  |   14 -
 9 files changed, 479 insertions(+), 9 deletions(-)

Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- /dev/null
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/hw_breakpoint.h
@@ -0,0 +1,55 @@
+#ifndef	_PPC64_HW_BREAKPOINT_H
+#define	_PPC64_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+#ifdef CONFIG_PPC64
+
+struct arch_hw_breakpoint {
+	u8		len; /* length of the target symbol */
+	int		type;
+	char		*name; /* Contains name of the symbol to set bkpt */
+	unsigned long	address;
+};
+
+#include <linux/kdebug.h>
+#include <asm/reg.h>
+#include <asm/system.h>
+
+/* Total number of available HW breakpoint registers */
+#define HBP_NUM 1
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
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
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
+#else
+static inline void hw_breakpoint_disable(void)
+{
+	/* Function is defined only on PPC64 for now */
+}
+#endif	/* CONFIG_PPC64 */
+#endif	/* __KERNEL__ */
+#endif	/* _PPC64_HW_BREAKPOINT_H */
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- /dev/null
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/hw_breakpoint.c
@@ -0,0 +1,332 @@
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
+ * single-step. Used to distinguish a single-step exception (due to a previous
+ * hw-breakpoint exception) from a normal one
+ */
+static DEFINE_PER_CPU(struct perf_event *, last_hit_bp);
+
+/*
+ * Stores the breakpoints currently in use on each breakpoint address
+ * register for each cpus
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
+	if (!*slot)
+		*slot = bp;
+	else {
+		WARN_ONCE(1, "Can't find any breakpoint slot");
+		return -EBUSY;
+	}
+
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
+	if (*slot == bp)
+		*slot = NULL;
+	else {
+		WARN_ONCE(1, "Can't find the breakpoint slot");
+		return;
+	}
+	set_dabr(0);
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp,
+						struct task_struct *tsk)
+{
+	int is_kernel, ret = -EINVAL;
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
+	/* TODO: Check for a valid triggered function */
+	/* if (!bp->triggered)
+		return -EINVAL; */
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
+	int rc = NOTIFY_STOP;
+	struct perf_event *bp;
+	struct pt_regs *regs = args->regs;
+	unsigned long dar = regs->dar;
+	int cpu, is_kernel, stepped = 1;
+	struct arch_hw_breakpoint *info;
+
+	/* Disable breakpoints during exception handling */
+	set_dabr(0);
+	cpu = get_cpu();
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
+
+	/* Verify if dar lies within the address range occupied by the symbol
+	 * being watched. Since we cannot get the symbol size for
+	 * user-space requests we skip this check in that case
+	 */
+	if (is_kernel &&
+	    !((bp->attr.bp_addr <= dar) &&
+	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))))
+		/*
+		 * This exception is triggered not because of a memory access on
+		 * the monitored variable but in the double-word address range
+		 * in which it is contained. We will consume this exception,
+		 * considering it as 'noise'.
+		 */
+		goto out;
+
+	/*
+	 * Return early after invoking user-callback function without restoring
+	 * DABR if the breakpoint is from ptrace which always operates in
+	 * one-shot mode
+	 */
+	if (bp->overflow_handler == ptrace_triggered) {
+		(bp->overflow_handler)(bp, 0, NULL, regs);
+		rc = NOTIFY_DONE;
+		goto out;
+	}
+
+	stepped = emulate_step(regs, regs->nip);
+	/*
+	 * Single-step the causative instruction manually if
+	 * emulate_step() could not execute it
+	 */
+	if (stepped == 0) {
+		regs->msr |= MSR_SE;
+		per_cpu(last_hit_bp, cpu) = bp;
+		goto out;
+	}
+	/*
+	 * As a policy, the callback is invoked in a 'trigger-after-execute'
+	 * fashion
+	 */
+	(bp->overflow_handler)(bp, 0, NULL, regs);
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
+
+out:
+	rcu_read_unlock();
+	/*
+	 * Enable pre-emption only if single-stepping is finished i.e.
+	 * Pre-emption is disabled for a small time-window extending from
+	 * the completion of instruction preceding the causative instruction
+	 * and the single-step exception handler that immediately follows the
+	 * completion of the causative instruction. The hardware breakpoint
+	 * exception is sandwiched between the two.
+	 */
+	if (stepped) {
+		per_cpu(last_hit_bp, cpu) = 0;
+		put_cpu();
+	}
+	return rc;
+}
+
+/*
+ * Handle single-step exceptions following a DABR hit.
+ */
+int __kprobes single_step_dabr_instruction(struct die_args *args)
+{
+	struct pt_regs *regs = args->regs;
+	int cpu = get_cpu();
+	int ret = NOTIFY_DONE;
+	siginfo_t info;
+	struct perf_event *bp = per_cpu(last_hit_bp, cpu);
+	struct arch_hw_breakpoint *bp_info;
+
+	/*
+	 * Check if we are single-stepping as a result of a
+	 * previous HW Breakpoint exception
+	 */
+	if (!bp)
+		goto out;
+
+	bp_info = counter_arch_bp(bp);
+	if (!test_thread_flag(TIF_SINGLESTEP))
+		regs->msr &= ~MSR_SE;
+	/*
+	 * We shall invoke the user-defined callback function in the single
+	 * stepping handler to confirm to 'trigger-after-execute' semantics
+	 */
+	(bp->overflow_handler)(bp, 0, NULL, regs);
+
+	/* Deliver signal to user-space */
+	if (!is_kernel_addr(bp->attr.bp_addr)) {
+		info.si_signo = SIGTRAP;
+		info.si_errno = 0;
+		info.si_code = TRAP_HWBKPT;
+		info.si_addr = (void __user *)bp_info->address;
+		force_sig_info(SIGTRAP, &info, current);
+	}
+
+	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
+	per_cpu(last_hit_bp, cpu) = NULL;
+	ret = NOTIFY_STOP;
+	/*
+	 * If single-stepped after hw_breakpoint_handler(), pre-emption is
+	 * already disabled.
+	 */
+	put_cpu();
+
+out:
+	/*
+	 * A put_cpu() call is required to complement the get_cpu()
+	 * call used initially
+	 */
+	put_cpu();
+	return ret;
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
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/Kconfig
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/Kconfig
@@ -130,6 +130,7 @@ config PPC
 	select HAVE_SYSCALL_WRAPPERS if PPC64
 	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_EVENTS
+	select HAVE_HW_BREAKPOINT if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/Makefile
@@ -33,7 +33,7 @@ obj-y				:= cputable.o ptrace.o syscalls
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
-				   paca.o nvram_64.o firmware.o
+				   paca.o nvram_64.o firmware.o hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/include/asm/reg.h
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/reg.h
@@ -180,6 +180,7 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
+#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define   DABR_DATA_WRITE	(1UL << 1)
 #define   DABR_DATA_READ	(1UL << 0)
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/mm/fault.c
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/mm/fault.c
@@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & DSISR_ISSTORE;
+
+	if (error_code & DSISR_DABRMATCH) {
+		/* DABR match */
+		do_dabr(regs, address, error_code);
+		return 0;
+	}
 #else
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
@@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
 	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
 
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
-  	if (error_code & DSISR_DABRMATCH) {
-		/* DABR match */
-		do_dabr(regs, address, error_code);
-		return 0;
-	}
-#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
-
 	if (in_atomic() || mm == NULL) {
 		if (!user_mode(regs))
 			return SIGSEGV;
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/include/asm/processor.h
@@ -177,6 +177,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	struct perf_event *ptrace_bps[HBP_NUM];
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/ptrace.c
@@ -32,6 +32,8 @@
 #ifdef CONFIG_PPC32
 #include <linux/module.h>
 #endif
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -755,9 +757,32 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
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
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
+#ifdef CONFIG_PPC64
+	int ret;
+	struct thread_struct *thread = &(task->thread);
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+#endif /* CONFIG_PPC64 */
+
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
 	 *  For embedded processors we support one DAC and no IAC's at the
 	 *  moment.
@@ -786,6 +811,58 @@ int ptrace_set_debugreg(struct task_stru
 	/* Ensure breakpoint translation bit is set */
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
+#ifdef CONFIG_PPC64
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
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+#endif /* CONFIG_PPC64 */
 
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
Index: linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-tip.new_ppc64_perf.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-tip.new_ppc64_perf/arch/powerpc/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/syscalls.h>
+#include <asm/hw_breakpoint.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #endif
@@ -376,8 +377,11 @@ struct task_struct *__switch_to(struct t
 	if (new->thread.dabr)
 		set_dabr(new->thread.dabr);
 #else
+/* For PPC64, we use the hw-breakpoint interfaces that would schedule DABR */
+#ifndef CONFIG_PPC64
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
+#endif /* CONFIG_PPC64 */
 #endif
 
 
@@ -564,6 +568,7 @@ void flush_thread(void)
 		else
 			set_ti_thread_flag(t, TIF_32BIT);
 	}
+	flush_ptrace_hw_breakpoint(current);
 #endif
 
 	discard_lazy_cpu_state();
