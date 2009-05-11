Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E442DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 06:04:08 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4BK47sx011163
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 06:04:07 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4BK47na1356018
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 06:04:07 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4BK47tP007130
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 06:04:07 +1000
Date: Tue, 12 May 2009 01:33:55 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090511200355.GA17988@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi PPC Dev folks,
	Please find a patch below that implements the proposed Hardware
Breakpoint interfaces for PPC64 architecture.

As a brief introduction, the proposed Hardware Breakpoint
infrastructure provides generic in-kernel interfaces to which users
from kernel- and user-space can request for breakpoint registers. An
ftrace plugin that can trace accesses to data variables is also part
of the generic HW Breakpoint interface patchset. The latest submission
for this patchset along with an x86 implementation can be found here:
http://lkml.org/lkml/2009/5/11/159.

The following are the salient features of the PPC64 patch.

- Arch-specific definitions for kernel and user-space requests are
  defined in arch/powerpc/kernel/hw_breakpoint.c
- Ptrace is converted to use the HW Breakpoint interfaces
- The ftrace plugin called ksym_tracer is tested to work fine. For
  instance when tracing pid_max kernel variable, the following was
  obtained as output

# cat trace
# tracer: ksym_tracer
#
#       TASK-PID      CPU#      Symbol         Type    Function         
#          |           |          |              |         |            
bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0x78/0x10c
bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0xa0/0x10c
bash            4502  3   pid_max               RW  .alloc_pid+0x8c/0x4a4

There are however a few limitations/caveats of the patch as identified
below:

- The patch is currently implemented only for PPC64 architecture. Other
  architectures (especially Book-E implementations are expected to
  happen in due course).

- HW Breakpoints over data addresses through Xmon (using "bd" command)
  and the proposed HW Breakpoint interfaces can now operate in a
  mutually exclusive manner. Xmon's integration is pending and is
  dependant on successful triggering of breakpoints through "bd<ops>".
  (Note: On a Power5 machine running 2.6.29, Xmon could not trigger HW
  Breakpoints when tested).

Kindly let me know your comments.

Thanks,
K.Prasad


Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                     |    1 
 arch/powerpc/include/asm/hw_breakpoint.h |   52 +++++
 arch/powerpc/include/asm/processor.h     |    1 
 arch/powerpc/include/asm/reg.h           |    2 
 arch/powerpc/include/asm/thread_info.h   |    2 
 arch/powerpc/kernel/Makefile             |    2 
 arch/powerpc/kernel/hw_breakpoint.c      |  271 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/process.c            |   18 ++
 arch/powerpc/kernel/ptrace.c             |   48 +++++
 arch/powerpc/mm/fault.c                  |   14 -
 samples/hw_breakpoint/data_breakpoint.c  |    4 
 12 files changed, 423 insertions(+), 9 deletions(-)

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
@@ -0,0 +1,271 @@
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
+ * Copyright (C) 2009 IBM Corporation
+ */
+
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers.
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
+	if (hbp_kernel_pos == HB_NUM)
+		return;
+	bp = hbp_kernel[hbp_kernel_pos];
+	if (bp == NULL)
+		kdabr = 0;
+	else
+		kdabr = bp->info.address | bp->info.type | DABR_TRANSLATION;
+	set_dabr(kdabr);
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
+ * Install the debug register values for just the kernel, no thread.
+ */
+void arch_uninstall_thread_hw_breakpoint()
+{
+	set_dabr(0);
+}
+
+/*
+ * Check for virtual address in user space.
+ */
+int arch_check_va_in_userspace(unsigned long va, u8 hbp_len)
+{
+	return (va <= TASK_SIZE - HW_BREAKPOINT_LEN);
+}
+
+/*
+ * Check for virtual address in kernel space.
+ */
+int arch_check_va_in_kernelspace(unsigned long va, u8 hbp_len)
+{
+	return (va >= TASK_SIZE) && ((va + HW_BREAKPOINT_LEN - 1) >= TASK_SIZE);
+}
+
+/*
+ * Store a breakpoint's encoded address, length, and type.
+ */
+int arch_store_info(struct hw_breakpoint *bp)
+{
+	/*
+	 * User-space requests will always have the address field populated
+	 * For kernel-addresses, either the address or symbol name can be
+	 * specified.
+	 */
+	if (bp->info.name)
+		bp->info.address = (unsigned long)
+					kallsyms_lookup_name(bp->info.name);
+	if (bp->info.address)
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
+	int ret = -EINVAL;
+
+	if (!bp)
+		return ret;
+
+	switch (bp->info.type) {
+	case DABR_DATA_READ:
+		break;
+	case DABR_DATA_WRITE:
+		break;
+	case DABR_DATA_RW:
+		break;
+	default:
+		return ret;
+	}
+
+	if (bp->triggered)
+		ret = arch_store_info(bp);
+
+	/* Check for double word alignment - 8 bytes */
+	if (bp->info.address & HW_BREAKPOINT_ALIGN)
+		return -EINVAL;
+	return ret;
+}
+
+void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk)
+{
+	struct thread_struct *thread = &(tsk->thread);
+	struct hw_breakpoint *bp = thread->hbp[0];
+
+	if (bp)
+		thread->dabr = bp->info.address	| bp->info.type |
+				DABR_TRANSLATION;
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
+	unsigned long dar;
+	int cpu, stepped, is_kernel;
+
+	/* Disable breakpoints during exception handling */
+	set_dabr(0);
+
+	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
+	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
+
+	if (is_kernel)
+		bp = hbp_kernel[0];
+	else {
+		bp = current->thread.hbp[0];
+		/* Lazy debug register switching */
+		if (!bp)
+			return rc;
+		rc = NOTIFY_DONE;
+	}
+
+	(bp->triggered)(bp, regs);
+
+	cpu = get_cpu();
+	if (is_kernel)
+		per_cpu(dabr_data, cpu) = kdabr;
+	else
+		per_cpu(dabr_data, cpu) = current->thread.dabr;
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
+
+	set_dabr(per_cpu(dabr_data, cpu));
+out:
+	/* Enable pre-emption only if single-stepping is finished */
+	if (stepped)
+		put_cpu_no_resched();
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
+	put_cpu_no_resched();
+
+out:
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
Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- /dev/null
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
@@ -0,0 +1,52 @@
+#ifndef	_PPC64_HW_BREAKPOINT_H
+#define	_PPC64_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+
+struct arch_hw_breakpoint {
+	char		*name; /* Contains name of the symbol to set bkpt */
+	unsigned long	address;
+	u8		type;
+};
+
+#include <linux/kdebug.h>
+#include <asm/reg.h>
+#include <asm-generic/hw_breakpoint.h>
+
+#define HW_BREAKPOINT_READ DABR_DATA_READ
+#define HW_BREAKPOINT_WRITE DABR_DATA_WRITE
+#define HW_BREAKPOINT_RW DABR_DATA_RW
+
+#define HW_BREAKPOINT_ALIGN 0x7
+#define HW_BREAKPOINT_LEN 4
+
+extern struct hw_breakpoint *hbp_kernel[HB_NUM];
+extern unsigned int hbp_user_refcount[HB_NUM];
+
+/*
+ * Ptrace support: breakpoint trigger routine.
+ */
+extern int __modify_user_hw_breakpoint(int pos, struct task_struct *tsk,
+			struct hw_breakpoint *bp);
+
+extern void arch_install_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_uninstall_thread_hw_breakpoint(void);
+extern int arch_check_va_in_userspace(unsigned long va, u8 hbp_len);
+extern int arch_check_va_in_kernelspace(unsigned long va, u8 hbp_len);
+extern int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
+						struct task_struct *tsk);
+extern void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk);
+extern void arch_flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_update_kernel_hw_breakpoint(void *);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				     unsigned long val, void *data);
+
+extern void flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern int copy_thread_hw_breakpoint(struct task_struct *tsk,
+		struct task_struct *child, unsigned long clone_flags);
+extern void switch_to_thread_hw_breakpoint(struct task_struct *tsk);
+
+#endif	/* __KERNEL__ */
+#endif	/* _PPC64_HW_BREAKPOINT_H */
+
Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/processor.h
@@ -177,6 +177,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	struct hw_breakpoint *hbp[HB_NUM];
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
@@ -37,6 +37,9 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#ifdef CONFIG_PPC64
+#include <asm/hw_breakpoint.h>
+#endif
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -735,9 +738,22 @@ void user_disable_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+static void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
+{
+	/*
+	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * We don't have to do anything here
+	 */
+}
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
+#ifdef CONFIG_PPC64
+	struct thread_struct *thread = &(task->thread);
+	struct hw_breakpoint *bp;
+	int ret;
+#endif
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
 	 *  For embedded processors we support one DAC and no IAC's at the
 	 *  moment.
@@ -767,6 +783,38 @@ int ptrace_set_debugreg(struct task_stru
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 
+#ifdef CONFIG_PPC64
+	bp = thread->hbp[0];
+	if ((data & ~0x7UL) == 0) {
+		if (bp) {
+			unregister_user_hw_breakpoint(task, bp);
+			kfree(bp);
+			thread->hbp[0] = NULL;
+		}
+		return 0;
+	}
+
+	if (bp) {
+		bp->info.type = data & 0x3UL;
+		task->thread.dabr = bp->info.address =
+						(data & ~HW_BREAKPOINT_ALIGN);
+		return __modify_user_hw_breakpoint(0, task, bp);
+	}
+	bp = kzalloc(sizeof(struct hw_breakpoint), GFP_KERNEL);
+	if (!bp)
+		return -ENOMEM;
+
+	/* Store the type of breakpoint */
+	bp->info.type = data & 0x3UL;
+	bp->triggered = ptrace_triggered;
+	task->thread.dabr = bp->info.address = (data & ~HW_BREAKPOINT_ALIGN);
+
+	ret = register_user_hw_breakpoint(task, bp);
+	if (ret)
+		return ret;
+	set_tsk_thread_flag(task, TIF_DEBUG);
+#endif /* CONFIG_PPC64 */
+
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
 
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
+			switch_to_thread_hw_breakpoint(new);
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
Index: linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/samples/hw_breakpoint/data_breakpoint.c
+++ linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
@@ -54,6 +54,10 @@ static int __init hw_break_module_init(v
 	sample_hbp.info.type = HW_BREAKPOINT_WRITE;
 	sample_hbp.info.len = HW_BREAKPOINT_LEN_4;
 #endif /* CONFIG_X86 */
+#ifdef CONFIG_PPC64
+	sample_hbp.info.name = ksym_name;
+	sample_hbp.info.type = DABR_DATA_WRITE;
+#endif /* CONFIG_PPC64 */
 
 	sample_hbp.triggered = (void *)sample_hbp_handler;
 
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
Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/include/asm/reg.h
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/reg.h
@@ -184,9 +184,11 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
+#define   HB_NUM	1	/* Number of physical HW breakpoint registers */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define   DABR_DATA_WRITE	(1UL << 1)
 #define   DABR_DATA_READ	(1UL << 0)
+#define   DABR_DATA_RW		(3UL << 0)
 #define SPRN_DABR2	0x13D	/* e300 */
 #define SPRN_DABRX	0x3F7	/* Data Address Breakpoint Register Extension */
 #define   DABRX_USER	(1UL << 0)
Index: linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/mm/fault.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
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
