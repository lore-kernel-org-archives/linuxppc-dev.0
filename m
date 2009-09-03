Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F29FDB7B81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 04:40:25 +1000 (EST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 380A1DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 04:40:25 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n83IeNXn023116
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:40:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n83IeNFu1167536
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:40:23 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n83IeMPh018460
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:40:23 +1000
Date: Fri, 4 Sep 2009 00:10:13 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 2/6] PPC64-HWBKPT: Introduce PPC64 specific Hardware
	Breakpoint interfaces
Message-ID: <20090903184013.GC4590@in.ibm.com>
References: <20090903183306.875398457@xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
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

Introduce PPC64 implementation for the generic hardware breakpoint interfaces
defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
Makefile.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                |    1 
 arch/powerpc/kernel/Makefile        |    2 
 arch/powerpc/kernel/hw_breakpoint.c |  342 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c        |    4 
 4 files changed, 348 insertions(+), 1 deletion(-)

Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/Kconfig
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/Kconfig
@@ -126,6 +126,7 @@ config PPC
 	select HAVE_SYSCALL_WRAPPERS if PPC64
 	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_COUNTERS
+	select HAVE_HW_BREAKPOINT if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_p
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
 				   cpu_setup_pa6t.o \
-				   firmware.o nvram_64.o
+				   firmware.o nvram_64.o hw_breakpoint.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- /dev/null
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/hw_breakpoint.c
@@ -0,0 +1,342 @@
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers.
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
+ */
+
+#include <linux/notifier.h>
+#include <linux/kallsyms.h>
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
+/* Store the kernel-space breakpoint address value */
+static unsigned long kdabr;
+
+/*
+ * Temporarily stores address for DABR before it is written by the
+ * single-step handler routine
+ */
+static DEFINE_PER_CPU(unsigned long, dabr_data);
+static DEFINE_PER_CPU(struct hw_breakpoint*, last_hit_bp);
+
+/* Disable breakpoints on the physical debug register */
+void arch_disable_hw_breakpoint(void)
+{
+	set_dabr(0);
+}
+
+void arch_update_kernel_hw_breakpoint(void *unused)
+{
+	struct hw_breakpoint *bp;
+
+	/* Check if there is nothing to update */
+	if (hbp_kernel_pos == HBP_NUM)
+		return;
+
+	bp = per_cpu(this_hbp_kernel[hbp_kernel_pos], get_cpu());
+	if (bp == NULL)
+		kdabr = 0;
+	else
+		kdabr = (bp->info.address & ~HW_BREAKPOINT_ALIGN) |
+			bp->info.type | DABR_TRANSLATION;
+	set_dabr(kdabr);
+	put_cpu();
+}
+
+/*
+ * Install the thread breakpoints in their debug registers.
+ */
+void arch_install_thread_hw_breakpoint(struct task_struct *tsk)
+{
+	set_dabr(tsk->thread.dabr);
+}
+
+/*
+ * Clear the DABR which contains the thread-specific breakpoint address
+ */
+void arch_uninstall_thread_hw_breakpoint()
+{
+	set_dabr(0);
+}
+
+/*
+ * Store a breakpoint's encoded address, length, and type.
+ */
+int arch_store_info(struct hw_breakpoint *bp, struct task_struct *tsk)
+{
+	unsigned long sym_addr;
+
+	/* Symbol names from user-space are rejected */
+	if (tsk) {
+		if (bp->info.name)
+			return -EINVAL;
+		return 0;
+	}
+	/*
+	 * User-space requests will always have the address field populated
+	 * For kernel-addresses, either the address or symbol name can be
+	 * specified.
+	 */
+	if (bp->info.name) {
+		sym_addr = (unsigned long)kallsyms_lookup_name(bp->info.name);
+		if (bp->info.address) {
+			if (bp->info.address != sym_addr)
+				return -EINVAL;
+		} else
+			bp->info.address = sym_addr;
+	}
+	if (!bp->info.address)
+		return -EINVAL;
+	/*
+	 * Determine the symbolsize if not already specified.
+	 * Reject the breakpoint request if symbolsize is found
+	 * to be greater than HW_BREAKPOINT_LEN
+	 */
+	if (!bp->info.symbolsize) {
+		if(!kallsyms_lookup_size_offset(bp->info.address,
+					&(bp->info.symbolsize), NULL))
+			return -EINVAL;
+	}
+	if (bp->info.symbolsize <= HW_BREAKPOINT_LEN)
+		return 0;
+	return -EINVAL;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
+						struct task_struct *tsk)
+{
+	int is_kernel, ret = -EINVAL;
+
+	/* User-space breakpoints cannot be restricted to a subset of CPUs */
+	if (tsk && bp->cpumask)
+		return ret;
+
+	if (!bp)
+		return ret;
+
+	switch (bp->info.type) {
+	case HW_BREAKPOINT_READ:
+	case HW_BREAKPOINT_WRITE:
+	case HW_BREAKPOINT_RW:
+		break;
+	default:
+		return ret;
+	}
+
+	if (!bp->triggered)
+		return -EINVAL;
+
+	ret = arch_store_info(bp, tsk);
+	is_kernel = is_kernel_addr(bp->info.address);
+	if ((tsk && is_kernel) || (!tsk && !is_kernel))
+		return -EINVAL;
+
+	/*
+	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
+	 * and breakpoint addresses are aligned to nearest double-word
+	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
+	 * 'symbolsize' should satisfy the check below.
+	 */
+	if (bp->info.symbolsize >
+	    (HW_BREAKPOINT_LEN - (bp->info.address & HW_BREAKPOINT_ALIGN)))
+		return -EINVAL;
+
+	return ret;
+}
+
+void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk)
+{
+	struct thread_struct *thread = &(tsk->thread);
+	struct hw_breakpoint *bp = thread->hbp[0];
+
+	if (bp)
+		thread->dabr = (bp->info.address & ~HW_BREAKPOINT_ALIGN) |
+				bp->info.type | DABR_TRANSLATION;
+	else
+		thread->dabr = 0;
+}
+
+void arch_flush_thread_hw_breakpoint(struct task_struct *tsk)
+{
+	struct thread_struct *thread = &(tsk->thread);
+
+	thread->dabr = 0;
+}
+
+/*
+ * Handle debug exception notifications.
+ */
+int __kprobes hw_breakpoint_handler(struct die_args *args)
+{
+	int rc = NOTIFY_STOP;
+	struct hw_breakpoint *bp;
+	struct pt_regs *regs = args->regs;
+	unsigned long dar = regs->dar;
+	int cpu, is_kernel, stepped = 1;
+
+	is_kernel = (hbp_kernel_pos == HBP_NUM) ? 0 : 1;
+
+	/* Disable breakpoints during exception handling */
+	set_dabr(0);
+
+	cpu = get_cpu();
+	/* Determine whether kernel- or user-space address is the trigger */
+	bp = is_kernel ?
+		per_cpu(this_hbp_kernel[0], cpu) : current->thread.hbp[0];
+	/*
+	 * bp can be NULL due to lazy debug register switching
+	 * or due to the delay between updates of hbp_kernel_pos
+	 * and this_hbp_kernel.
+	 */
+	if (!bp)
+		goto out;
+
+	per_cpu(dabr_data, cpu) = is_kernel ? kdabr : current->thread.dabr;
+
+	/* Verify if dar lies within the address range occupied by the symbol
+	 * being watched. Since we cannot get the symbol size for
+	 * user-space requests we skip this check in that case
+	 */
+	if (is_kernel &&
+	    !((bp->info.address <= dar) &&
+	     (dar <= (bp->info.address + bp->info.symbolsize))))
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
+	if (bp->triggered == ptrace_triggered) {
+		(bp->triggered)(bp, regs);
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
+	(bp->triggered)(bp, regs);
+	set_dabr(per_cpu(dabr_data, cpu));
+
+out:
+	/* Enable pre-emption only if single-stepping is finished */
+	if (stepped) {
+		per_cpu(dabr_data, cpu) = 0;
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
+	unsigned long this_dabr_data = per_cpu(dabr_data, cpu);
+	struct hw_breakpoint *bp = per_cpu(last_hit_bp, cpu);
+
+	/*
+	 * Check if we are single-stepping as a result of a
+	 * previous HW Breakpoint exception
+	 */
+	if (this_dabr_data == 0)
+		goto out;
+
+	regs->msr &= ~MSR_SE;
+	/*
+	 * We shall invoke the user-defined callback function in the single
+	 * stepping handler to confirm to 'trigger-after-execute' semantics
+	 */
+	(bp->triggered)(bp, regs);
+
+	/* Deliver signal to user-space */
+	if (this_dabr_data < TASK_SIZE) {
+		info.si_signo = SIGTRAP;
+		info.si_errno = 0;
+		info.si_code = TRAP_HWBKPT;
+		info.si_addr = (void __user *)(per_cpu(dabr_data, cpu));
+		force_sig_info(SIGTRAP, &info, current);
+	}
+
+	set_dabr(this_dabr_data);
+	per_cpu(dabr_data, cpu) = 0;
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
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/kernel/ptrace.c
@@ -755,6 +755,10 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
+{
+}
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
