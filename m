Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 90360B77DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 19:08:32 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BC51DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:31 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5A98IHb030477
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 14:38:18 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A988kw3047590
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 14:38:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5A98723023254
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:07 +1000
Date: Wed, 10 Jun 2009 14:38:06 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint interfaces
Message-ID: <20090610090806.GC14478@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
 arch/powerpc/kernel/hw_breakpoint.c |  298 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c        |    4 
 4 files changed, 304 insertions(+), 1 deletion(-)

Index: linux-2.6-tip.hbkpt/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/Kconfig
+++ linux-2.6-tip.hbkpt/arch/powerpc/Kconfig
@@ -125,6 +125,7 @@ config PPC
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
 	select HAVE_SYSCALL_WRAPPERS if PPC64
+	select HAVE_HW_BREAKPOINT if PPC64
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_p
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
 				   cpu_setup_pa6t.o \
-				   firmware.o nvram_64.o
+				   firmware.o nvram_64.o hw_breakpoint.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- /dev/null
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
@@ -0,0 +1,298 @@
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers.
+ */
+
+/*
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
+ * Copyright © 2009 IBM Corporation
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
+
+void arch_update_kernel_hw_breakpoint(void *unused)
+{
+	struct hw_breakpoint *bp;
+
+	/* Check if there is nothing to update */
+	if (hbp_kernel_pos == HBP_NUM)
+		return;
+
+	per_cpu(this_hbp_kernel[hbp_kernel_pos], get_cpu()) = bp =
+						hbp_kernel[hbp_kernel_pos];
+	if (bp == NULL)
+		kdabr = 0;
+	else
+		kdabr = (bp->info.address & ~HW_BREAKPOINT_ALIGN) |
+			bp->info.type | DABR_TRANSLATION;
+	set_dabr(kdabr);
+	put_cpu_no_resched();
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
+	/* Symbol names from user-space are rejected */
+	if (tsk) {
+		if (bp->info.name)
+			return -EINVAL;
+		else
+			return 0;
+	}
+	/*
+	 * User-space requests will always have the address field populated
+	 * For kernel-addresses, either the address or symbol name can be
+	 * specified.
+	 */
+	if (bp->info.name)
+		bp->info.address = (unsigned long)
+					kallsyms_lookup_name(bp->info.name);
+	if (bp->info.address)
+		if (kallsyms_lookup_size_offset(bp->info.address,
+						&(bp->info.symbolsize), NULL))
+			return 0;
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
+	if (bp->triggered)
+		ret = arch_store_info(bp, tsk);
+
+	is_kernel = is_kernel_addr(bp->info.address);
+	if ((tsk && is_kernel) || (!tsk && !is_kernel))
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
+	int cpu, is_one_shot, stepped = 1;
+
+	/* Disable breakpoints during exception handling */
+	set_dabr(0);
+
+	cpu = get_cpu();
+	/* Determine whether kernel- or user-space address is the trigger */
+	bp = (hbp_kernel_pos == HBP_NUM) ? current->thread.hbp[0] :
+					per_cpu(this_hbp_kernel[0], cpu);
+	/*
+	 * bp can be NULL due to lazy debug register switching
+	 * or due to the delay between updates of hbp_kernel_pos
+	 * and this_hbp_kernel.
+	 */
+	if (!bp)
+		goto out;
+
+	is_one_shot = (bp->triggered == ptrace_triggered) ? 1 : 0;
+	per_cpu(dabr_data, cpu) = (hbp_kernel_pos == HBP_NUM) ?
+						current->thread.dabr : kdabr;
+
+	/* Verify if dar lies within the address range occupied by the symbol
+	 * being watched. Since we cannot get the symbol size for
+	 * user-space requests we skip this check in that case
+	 */
+	if ((hbp_kernel_pos == 0) &&
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
+	(bp->triggered)(bp, regs);
+	/*
+	 * Ptrace expects the HW Breakpoints to be one-shot. We will return
+	 * NOTIFY_DONE without restoring DABR with the breakpoint address. The
+	 * downstream code will generate SIGTRAP to the process
+	 */
+	if (is_one_shot) {
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
+		goto out;
+	}
+	set_dabr(per_cpu(dabr_data, cpu));
+
+out:
+	/* Enable pre-emption only if single-stepping is finished */
+	if (stepped) {
+		per_cpu(dabr_data, cpu) = 0;
+		put_cpu_no_resched();
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
+
+	/*
+	 * Check if we are single-stepping as a result of a
+	 * previous HW Breakpoint exception
+	 */
+	if (this_dabr_data == 0)
+		goto out;
+
+	regs->msr &= ~MSR_SE;
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
+	put_cpu_no_resched();
+
+out:
+	/*
+	 * A put_cpu_no_resched() call is required to complement the get_cpu()
+	 * call used initially
+	 */
+	put_cpu_no_resched();
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
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
@@ -735,6 +735,10 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
+{
+}
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
