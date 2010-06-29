Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47002B6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:53:04 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5TGr0aF025073
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:53:00 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5TGr3WR1548334
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:53:03 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5TGr334016983
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:53:03 +1000
Received: from in.ibm.com ([9.124.213.87])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o5TGqvTA016948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 02:53:00 +1000
Date: Tue, 29 Jun 2010 22:22:57 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 1/1] Implement hardware breakpoint interfaces for PowerPC
	BookE processors
Message-ID: <20100629165257.GB8586@in.ibm.com>
References: <20100628135631.332818538@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce support for generic hw-breakpoint interfaces for PowerPC
BookIII E processors.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                           |    2 
 arch/powerpc/include/asm/cputable.h            |    4 
 arch/powerpc/include/asm/hw_breakpoint_booke.h |   46 ++
 arch/powerpc/kernel/Makefile                   |    4 
 arch/powerpc/kernel/hw_breakpoint_booke.c      |  429 +++++++++++++++++++++++++
 arch/powerpc/kernel/process.c                  |    3 
 arch/powerpc/kernel/ptrace.c                   |   51 ++
 arch/powerpc/kernel/traps.c                    |    9 
 include/linux/perf_event.h                     |    4 
 kernel/trace/trace_ksym.c                      |    4 
 10 files changed, 554 insertions(+), 2 deletions(-)

Index: linux-2.6.bookE/arch/powerpc/include/asm/hw_breakpoint_booke.h
===================================================================
--- /dev/null
+++ linux-2.6.bookE/arch/powerpc/include/asm/hw_breakpoint_booke.h
@@ -0,0 +1,46 @@
+#ifndef	_I386_HW_BREAKPOINT_H
+#define	_I386_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+
+struct arch_hw_breakpoint {
+	unsigned int	len;
+	unsigned long	address;
+	unsigned long	type;
+};
+
+#include <linux/kdebug.h>
+#include <linux/percpu.h>
+#include <linux/list.h>
+
+/* Breakpoint length beyond which we should use 'range' breakpoints */
+#define DAC_LEN 8
+#define HW_BREAKPOINT_ALIGN 0x3
+
+static inline int hw_breakpoint_slots(int type)
+{
+	return HBP_NUM;
+}
+
+struct perf_event;
+struct perf_sample_data;
+struct pmu;
+
+extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+						unsigned long val, void *data);
+extern void hw_breakpoint_handler(struct pt_regs *regs,
+				unsigned long debug_status);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+extern void ptrace_triggered(struct perf_event *bp, int nmi,
+			struct perf_sample_data *data, struct pt_regs *regs);
+
+extern struct pmu perf_ops_bp;
+
+#endif	/* __KERNEL__ */
+#endif	/* _I386_HW_BREAKPOINT_H */
+
Index: linux-2.6.bookE/arch/powerpc/kernel/hw_breakpoint_booke.c
===================================================================
--- /dev/null
+++ linux-2.6.bookE/arch/powerpc/kernel/hw_breakpoint_booke.c
@@ -0,0 +1,429 @@
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers for PowerPC BookIII E. Derived from
+ * "arch/powerpc/kernel/hw_breakpoint.c"
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
+ * Copyright 2010 IBM Corporation
+ * Author: K.Prasad <prasad@linux.vnet.ibm.com>
+ *
+ */
+
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/kprobes.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/hw_breakpoint_booke.h>
+#include <asm/reg_booke.h>
+#include <asm/uaccess.h>
+#include <asm/sstep.h>
+#include <asm/reg.h>
+
+/*
+ * Stores the breakpoints currently in use on each debug register for each CPU
+ * register for each cpus
+ */
+static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
+
+int hw_breakpoint_weight(struct perf_event *bp)
+{
+	return (bp->attr.bp_len > DAC_LEN) ? 2 : 1;
+}
+
+/*
+ * Install a perf counter breakpoint.
+ *
+ * We seek a free debug address register and use it for this
+ * breakpoint. Eventually we enable it in the debug control register.
+ *
+ * Atomic: we hold the counter->ctx->lock and we only handle variables
+ * and registers local to this cpu.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	int i;
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long dbcr0 = mfspr(SPRN_DBCR0);
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = &__get_cpu_var(bp_per_reg[i]);
+
+		if (*slot)
+			continue;
+		*slot = bp;
+		mtspr(SPRN_DAC1, info->address);
+		/* Clean the 'type' fields from DBCR0 to erase old values */
+		dbcr0 &= ~(DBCR0_DAC1W | DBCR0_DAC1R | DBCR0_DAC2W | DBCR0_DAC2R);
+
+		mtspr(SPRN_DBCR0, dbcr0 |
+				(info->type > i) | DBCR0_IDM);
+		/*
+		 * Use DAC2 register in 'range' mode if the length of the
+		 * breakpoint request is 'large'
+		 */
+		if (unlikely(info->len > DAC_LEN)) {
+			/* Check if there's a free debug register */
+			if (i > (HBP_NUM - hw_breakpoint_weight(bp))) {
+				*slot = NULL;
+				mtspr(SPRN_DBCR0, dbcr0);
+				return -EBUSY;
+			}
+			slot++;
+			i++;
+			/*
+			 * In 'range' mode use two debug registers, but copy
+			 * same breakpoint structure in both slots
+			 */
+			*slot = bp;
+			mtspr(SPRN_DAC2, info->address + info->len);
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) |
+				(info->type >> i) | DBCR0_IDM);
+			/* We support only 'inclusive' range for now */
+			mtspr(SPRN_DBCR2, DBCR2_DAC12M);
+		}
+		break;
+	}
+
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
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	int i;
+	unsigned long dbcr0 = mfspr(SPRN_DBCR0);
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = &__get_cpu_var(bp_per_reg[i]);
+
+		if (*slot != bp)
+			continue;
+		*slot = NULL;
+		dbcr0 &= ~((DBCR0_DAC1W | DBCR0_DAC1R) >> i);
+		mtspr(SPRN_DBCR0, dbcr0);
+		if (info->len > DAC_LEN) {
+			slot++;
+			i++;
+			*slot = NULL;
+			dbcr0 &= ~((DBCR0_DAC1W | DBCR0_DAC1R) >> i);
+			mtspr(SPRN_DBCR0, dbcr0);
+		}
+		break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
+		return;
+}
+
+/*
+ * Perform cleanup of arch-specific counters during unregistration
+ * of the perf-event
+ */
+void arch_unregister_hw_breakpoint(struct perf_event *bp)
+{
+	/*
+ 	 * If the breakpoint is unregistered between a hw_breakpoint_handler()
+ 	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
+ 	 * restoration variables to prevent dangling pointers.
+ 	 */
+	if (bp->ctx->task)
+		bp->ctx->task->thread.last_hit_ubp = NULL;
+}
+
+/*
+ * Check for virtual address in kernel space.
+ */
+int arch_check_bp_in_kernelspace(struct perf_event *bp)
+{
+	unsigned long va;
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	va = info->address;
+	return (va >= TASK_SIZE) && ((va + info->len - 1) >= TASK_SIZE);
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	switch (bp->attr.bp_type) {
+	case HW_BREAKPOINT_R:
+		info->type = DBCR0_DAC1R;
+		break;
+	case HW_BREAKPOINT_W:
+		info->type = DBCR0_DAC1W;
+		break;
+	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+		info->type = (DBCR0_DAC1W | DBCR0_DAC1R);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Verify if breakpoint length is less than 2^32 bytes */
+	if (bp->attr.bp_len == (unsigned int)bp->attr.bp_len)
+		info->len = bp->attr.bp_len;
+	else
+		return -EINVAL;
+	info->address = bp->attr.bp_addr;
+	return 0;
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
+
+/*
+ * Invoke this function to populate DAC register with values corresponding
+ * to the registered breakpoints. The list of breakpoints is learnt from the
+ * per-CPU 'bp_per_reg' structure.
+ */
+static void restore_breakpoint_dac(struct perf_event *bp)
+{
+	unsigned int i;
+	unsigned long dbcr0 = mfspr(SPRN_DBCR0);
+	struct arch_hw_breakpoint *bp_info = counter_arch_bp(bp);
+
+	/*
+	 * Loop through the slots to identify the appropriate DAC register
+	 * and restore the breakpoint values
+	 */
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = &__get_cpu_var(bp_per_reg[i]);
+
+		if (*slot != bp)
+			continue;
+
+		/* Restore the breakpoint */
+		dbcr0 |= DBCR0_IDM | (bp_info->type >> i);
+		i++;
+		if (unlikely((bp_info->len > DAC_LEN) && (i != HBP_NUM)))
+			dbcr0 |= (bp_info->type >> i);
+		mtspr(SPRN_DBCR0, dbcr0);
+		break;
+	}
+}
+
+/*
+ * Restores the breakpoint on the debug registers.
+ * Invoke this function if it is known that the execution context is about to
+ * change to cause loss of MSR_SE settings.
+ */
+void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
+{
+	struct perf_event *bp = NULL;
+
+	if (likely(!tsk->thread.last_hit_ubp))
+		return;
+
+	restore_breakpoint_dac(bp);
+	tsk->thread.last_hit_ubp = NULL;
+}
+
+static void ptrace_deliver_signal(int regnum)
+{
+	siginfo_t sig_info;
+
+	sig_info.si_signo = SIGTRAP;
+	sig_info.si_errno = TRAP_HWBKPT;
+
+	switch(regnum) {
+	/* DAC1 */
+	case 0:
+		/* si_code values are as seen in handle_debug() function */
+		sig_info.si_code = 5;
+		sig_info.si_addr = (void __user *)mfspr(SPRN_DAC1);
+		break;
+	/* DAC2 */
+	case 1:
+		sig_info.si_code = 6;
+		sig_info.si_addr = (void __user *)mfspr(SPRN_DAC2);
+		break;
+	}
+	force_sig_info(SIGTRAP, &sig_info, current);
+}
+
+void __kprobes hw_breakpoint_handler(struct pt_regs *regs,
+					unsigned long debug_status)
+{
+	int i, stepped = 0;
+	struct perf_event *bp = NULL;
+	struct arch_hw_breakpoint *bp_info;
+	unsigned int instr = 0;
+	unsigned long dbcr0;
+
+	/*
+	 * Disable breakpoints during exception handling. Disable both MSR_DE
+	 * and DBCR0_IDM to prevent pending exceptions.
+	 */
+	mtmsr(mfmsr() & ~MSR_DE);
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IDM);
+	dbcr0 = mfspr(SPRN_DBCR0);
+
+	/* Handle all the breakpoints that were triggered */
+	for (i = 0; i < HBP_NUM; ++i) {
+		if ((debug_status & ((DBSR_DAC1R | DBSR_DAC1W) >> i)) == 0)
+			continue;
+		/* Clear the debug status register by writing onto it */
+		mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W) >> i);
+		/* Clear DBSR for DAC2 if operating in 'range' mode */
+		if (mfspr(SPRN_DBCR2) & DBCR2_DAC12M)
+			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W) >> (i + 1));
+
+		/*
+		 * The counter may be concurrently released but that can only
+		 * occur from a call_rcu() path. We can then safely fetch
+		 * the breakpoint, use its callback, touch its counter
+		 * while we are in an rcu_read_lock() path.
+		 */
+		rcu_read_lock();
+		bp = __get_cpu_var(bp_per_reg[i]);
+		/*
+		 * bp can be NULL due to lazy debug register switching
+		 * or due to concurrent perf counter removing.
+		 */
+		if (!bp)
+			goto out;
+	}
+	bp_info = counter_arch_bp(bp);
+
+	/*
+	 * Return early after invoking user-callback function without restoring
+	 * breakpoints if it originated from ptrace which always operates in
+	 * one-shot mode.
+	 */
+	if (bp->overflow_handler == ptrace_triggered) {
+		perf_bp_event(bp, regs);
+		ptrace_deliver_signal(i);
+		goto out;
+	}
+
+	/* Do not emulate user-mode instructions, instead, single-step them */
+	if (user_mode(regs)) {
+		bp->ctx->task->thread.last_hit_ubp = bp;
+		/*
+		 * Clear the breakpoint register and single-step the
+		 * causative instruction
+		 */
+		dbcr0 &= ~((DBCR0_DAC1W | DBCR0_DAC1R) >> i);
+		/*
+		 * Block-step and single-stepping (IC) is not supported
+		 * simultaneously for now
+		 */
+		dbcr0 &= ~DBCR0_BT;
+		mtspr(SPRN_DBCR0, dbcr0 | DBCR0_IC);
+		mtmsr(mfmsr() | MSR_DE);
+		goto out;
+	}
+	/*
+	 * Attempt to emulate the causative instruction. If successful, then
+	 * invoke the perf-callback and restore the breakpoint.
+	 */
+	if (!__get_user_inatomic(instr, (unsigned int *) regs->nip))
+		stepped = emulate_step(regs, instr);
+	/*
+	 * emulate_step() could not execute it. We've failed in reliably
+	 * handling the hw-breakpoint. Unregister it and throw a warning
+	 * message to let the user know about it.
+	 */
+	if (!stepped) {
+		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at "
+			"0x%lx will be disabled.", bp_info->address);
+		perf_event_disable(bp);
+		goto out;
+	}
+	perf_bp_event(bp, regs);
+	restore_breakpoint_dac(bp);
+	mtmsr(mfmsr() | MSR_DE);
+out:
+	rcu_read_unlock();
+}
+
+/*
+ * Handle single-step exceptions following a DAC hit
+ */
+int __kprobes single_step_dac_instruction(struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bp_info;
+	struct perf_event *bp = NULL;
+
+	/* Disable single-stepping */
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+	mtmsr(mfmsr() & ~MSR_DE);
+
+	bp = current->thread.last_hit_ubp;
+	/*
+	 * Check if we are single-stepping as a result of a
+	 * previous HW Breakpoint exception
+	 */
+	if (!bp)
+		return NOTIFY_DONE;
+	bp_info = counter_arch_bp(bp);
+	/*
+	 * We shall invoke the user-defined callback function in the single
+	 * stepping handler to confirm to 'trigger-after-execute' semantics
+	 */
+	perf_bp_event(bp, regs);
+	restore_breakpoint_dac(bp);
+	mtmsr(mfmsr() | MSR_DE);
+
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
+	if (val == DIE_SSTEP)
+		ret = single_step_dac_instruction(data);
+	return ret;
+}
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
Index: linux-2.6.bookE/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6.bookE/arch/powerpc/kernel/traps.c
@@ -57,6 +57,9 @@
 #ifdef CONFIG_FSL_BOOKE
 #include <asm/dbell.h>
 #endif
+#ifdef CONFIG_BOOKE
+#include <asm/hw_breakpoint_booke.h>
+#endif
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -1193,7 +1196,11 @@ void __kprobes DebugException(struct pt_
 
 		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 	} else
-		handle_debug(regs, debug_status);
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+		hw_breakpoint_handler(regs, debug_status);
+		return;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+			handle_debug(regs, debug_status);
 }
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
Index: linux-2.6.bookE/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/Kconfig
+++ linux-2.6.bookE/arch/powerpc/Kconfig
@@ -141,7 +141,7 @@ config PPC
 	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (PPC_BOOK3S_64 || BOOKE))
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6.bookE/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6.bookE/arch/powerpc/kernel/Makefile
@@ -34,7 +34,11 @@ obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
+ifeq ($(CONFIG_BOOKE),y)
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint_booke.o
+else
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
+endif
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
Index: linux-2.6.bookE/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6.bookE/arch/powerpc/kernel/ptrace.c
@@ -964,6 +964,56 @@ int ptrace_set_debugreg(struct task_stru
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
 #else /* CONFIG_PPC_ADV_DEBUG_REGS */
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/*
+	 * For compatibility with existing ptrace design which uses only one
+	 * breakpoint slot, we will use only one DAC register.
+	 */
+	bp = thread->ptrace_bps[0];
+	if (!data) {
+		if (bp) {
+			unregister_hw_breakpoint(bp);
+			thread->ptrace_bps[0] = NULL;
+			thread->dac1 = 0;
+		}
+		return 0;
+	}
+	if (bp) {
+		attr = bp->attr;
+		attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
+		/*
+		 * Check for write and read flags and set DBCR0
+		 * accordingly
+		 */
+		dbcr_dac(task) &= ~(DBCR_DAC1R|DBCR_DAC1W);
+		if (data & 0x1UL)
+			attr.bp_type |= HW_BREAKPOINT_R;
+		if (data & 0x2UL)
+			attr.bp_type |= HW_BREAKPOINT_R;
+		ret =  modify_user_hw_breakpoint(bp, &attr);
+		if (ret)
+			return ret;
+		thread->ptrace_bps[0] = bp;
+		thread->dac1 = data;
+		return 0;
+	}
+
+	/* Create a new breakpoint request if one doesn't exist already */
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
+	if (data & 0x1UL)
+		attr.bp_type |= HW_BREAKPOINT_R;
+	if (data & 0x2UL)
+		attr.bp_type |= HW_BREAKPOINT_R;
+	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
+							ptrace_triggered, task);
+	if (IS_ERR(bp)) {
+		thread->ptrace_bps[0] = NULL;
+		return PTR_ERR(bp);
+	}
+	thread->dac1 = data;
+
+#else /* CONFIG_HAVE_HW_BREAKPOINT */
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
 	 *  as to not cause alignment restrictions for DAC-based processors.
@@ -999,6 +1049,7 @@ int ptrace_set_debugreg(struct task_stru
 	if (data & 0x2UL)
 		dbcr_dac(task) |= DBCR_DAC1W;
 	task->thread.regs->msr |= MSR_DE;
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 	return 0;
 }
Index: linux-2.6.bookE/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/include/asm/cputable.h
+++ linux-2.6.bookE/arch/powerpc/include/asm/cputable.h
@@ -517,7 +517,11 @@ static inline int cpu_has_feature(unsign
 }
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#ifdef CONFIG_BOOKE
+#define HBP_NUM 2
+#else
 #define HBP_NUM 1
+#endif /* CONFIG_BOOKE */
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6.bookE/include/linux/perf_event.h
===================================================================
--- linux-2.6.bookE.orig/include/linux/perf_event.h
+++ linux-2.6.bookE/include/linux/perf_event.h
@@ -470,7 +470,11 @@ struct perf_guest_info_callbacks {
 };
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#ifdef CONFIG_BOOKE
+#include <asm/hw_breakpoint_booke.h>
+#else
 #include <asm/hw_breakpoint.h>
+#endif /* CONFIG_BOOKE */
 #endif
 
 #include <linux/list.h>
Index: linux-2.6.bookE/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/kernel/process.c
+++ linux-2.6.bookE/arch/powerpc/kernel/process.c
@@ -329,6 +329,7 @@ static void prime_debug_regs(struct thre
 	mtspr(SPRN_IAC3, thread->iac3);
 	mtspr(SPRN_IAC4, thread->iac4);
 #endif
+#ifndef CONFIG_HAVE_HW_BREAKPOINT
 	mtspr(SPRN_DAC1, thread->dac1);
 	mtspr(SPRN_DAC2, thread->dac2);
 #if CONFIG_PPC_ADV_DEBUG_DVCS > 0
@@ -340,7 +341,9 @@ static void prime_debug_regs(struct thre
 #ifdef CONFIG_BOOKE
 	mtspr(SPRN_DBCR2, thread->dbcr2);
 #endif
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
+
 /*
  * Unless neither the old or new thread are making use of the
  * debug registers, set the debug registers from the values
Index: linux-2.6.bookE/kernel/trace/trace_ksym.c
===================================================================
--- linux-2.6.bookE.orig/kernel/trace/trace_ksym.c
+++ linux-2.6.bookE/kernel/trace/trace_ksym.c
@@ -30,7 +30,11 @@
 #include "trace.h"
 
 #include <linux/hw_breakpoint.h>
+#ifdef CONFIG_BOOKE
+#include <asm/hw_breakpoint_booke.h>
+#else /* CONFIG_BOOKE */
 #include <asm/hw_breakpoint.h>
+#endif /* CONFIG_BOOKE */
 
 #include <asm/atomic.h>
 
