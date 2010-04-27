Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2879BB7DE1
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:40:57 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3RFmdMN019654
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 21:18:39 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3RGerHn3543172
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 22:10:53 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3RGerxP009085
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:40:53 +1000
Date: Tue, 27 Apr 2010 22:10:47 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [RFC Patch 1/1] Implement hw-breakpoint interfaces for BookE
	processors
Message-ID: <20100427164047.GB8303@in.ibm.com>
References: <20100427163508.631888092@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement hardware breakpoint interfaces for PowerPC BookE processors

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                           |    2 
 arch/powerpc/include/asm/cputable.h            |    4 
 arch/powerpc/include/asm/hw_breakpoint_booke.h |   42 +++
 arch/powerpc/kernel/Makefile                   |    4 
 arch/powerpc/kernel/hw_breakpoint_booke.c      |  326 +++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c                   |    8 
 arch/powerpc/kernel/traps.c                    |   11 
 include/linux/perf_event.h                     |    4 
 8 files changed, 398 insertions(+), 3 deletions(-)

Index: linux-2.6.bookE/arch/powerpc/include/asm/hw_breakpoint_booke.h
===================================================================
--- /dev/null
+++ linux-2.6.bookE/arch/powerpc/include/asm/hw_breakpoint_booke.h
@@ -0,0 +1,42 @@
+#ifndef	_I386_HW_BREAKPOINT_H
+#define	_I386_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+
+struct arch_hw_breakpoint {
+	u8		len;
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
+
+static inline int hw_breakpoint_slots(int type)
+{
+	return HBP_NUM;
+}
+
+struct perf_event;
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
@@ -0,0 +1,326 @@
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
+#include <asm/reg.h>
+
+/*
+ * Store the 'bp' that caused the hw-breakpoint exception just before we
+ * single-step. Use it to distinguish a single-step exception (due to a
+ * previous hw-breakpoint exception) from a normal one
+ */
+static DEFINE_PER_CPU(struct perf_event *, last_hit_bp);
+
+/*
+ * Save the debug registers to restore them after single-stepping the
+ * instruction that caused the debug exception
+ */
+static DEFINE_PER_CPU(unsigned long, last_hit_dac[2]);
+static DEFINE_PER_CPU(unsigned long, last_hit_dbcr0);
+
+/*
+ * Stores the breakpoints currently in use on each breakpoint address
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
+	bool range_bp;
+	int i;
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long dbcr0 = mfspr(SPRN_DBCR0);
+
+	range_bp = (info->len > DAC_LEN) ? true : false;
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = &__get_cpu_var(bp_per_reg[i]);
+
+		if (*slot)
+			continue;
+		*slot = bp;
+		mtspr(SPRN_DAC1, info->address);
+		/* Clean the 'type' fields to erase past values */
+		dbcr0 &= ~(DBCR0_DAC2W | DBCR0_DAC2R);
+
+		mtspr(SPRN_DBCR0, dbcr0 |
+				(info->type << (HBP_NUM - i)) | DBCR0_IDM);
+		/*
+		 * Use DAC2 register in 'range' mode if the length of the
+		 * breakpoint request is 'large'
+		 */
+		if (unlikely(range_bp)) {
+			if (i > (HBP_NUM - hw_breakpoint_weight(bp))) {
+				*slot = NULL;
+				mtspr(SPRN_DBCR0, dbcr0);
+				return -EBUSY;
+			}
+			(*slot)++;
+			i++;
+			/*
+			 * In 'range' mode use two debug registers, but copy
+			 * same breakpoint structure in both slots
+			 */
+			*slot = bp;
+			mtspr(SPRN_DAC2, info->address + info->len);
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) |
+				(info->type << (HBP_NUM - i)) | DBCR0_IDM);
+			/* We support only 'inclusive' range for now */
+			mtspr(SPRN_DBCR2, DBCR2_DAC12M);
+		}
+		break;
+	}
+
+/* TODO: Support DVC settings - atleast for user-space breakpoint requests */
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
+		dbcr0 &= ~((DBCR0_DAC2W | DBCR0_DAC2R) << i);
+		mtspr(SPRN_DBCR0, dbcr0);
+		if (info->len > DAC_LEN) {
+			(*slot)++;
+			i++;
+			*slot = NULL;
+			dbcr0 &= ~((DBCR0_DAC2W | DBCR0_DAC2R) << i);
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
+static int arch_build_bp_info(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	/* Type */
+	switch (bp->attr.bp_type) {
+	case HW_BREAKPOINT_R:
+		info->type = DBCR0_DAC2R;
+		break;
+	case HW_BREAKPOINT_W:
+		info->type = DBCR0_DAC2W;
+		break;
+	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+		info->type = (DBCR0_DAC2W | DBCR0_DAC2R);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp)
+{
+	int ret;
+
+	ret = arch_build_bp_info(bp);
+	if (ret)
+		return ret;
+	/* TODO: Remove this check when user-space breakpoints are supported */
+	ret = arch_check_bp_in_kernelspace(bp);
+
+	return ret;
+}
+
+/*
+ * Release the user breakpoints used by ptrace
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	/* Placeholder for now...required for compilation */
+}
+
+void __kprobes hw_breakpoint_handler(struct pt_regs *regs,
+					unsigned long debug_status)
+{
+	int i, cpu;
+	struct perf_event *bp = NULL;
+	struct arch_hw_breakpoint *bp_info;
+	unsigned long dbcr0;
+
+	/* Disable breakpoints during exception handling */
+	mtmsr(mfmsr() & ~MSR_DE);
+	cpu = smp_processor_id();
+
+	/* Handle all the breakpoints that were triggered */
+	for (i = 0; i < HBP_NUM; ++i) {
+		if ((debug_status & ((DBSR_DAC2R | DBSR_DAC2W) << i)) == 0)
+			continue;
+		/* Clear the debug status register */
+		mtspr(SPRN_DBSR, (DBSR_DAC2R | DBSR_DAC2W) << (HBP_NUM - i));
+
+		/*
+		 * The counter may be concurrently released but that can only
+		 * occur from a call_rcu() path. We can then safely fetch
+		 * the breakpoint, use its callback, touch its counter
+		 * while we are in an rcu_read_lock() path.
+		 */
+		rcu_read_lock();
+		bp = per_cpu(bp_per_reg[i], cpu);
+		/*
+		 * bp can be NULL due to lazy debug register switching
+		 * or due to concurrent perf counter removing.
+		 */
+		if (!bp) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+
+	bp_info = counter_arch_bp(bp);
+
+	/*
+	 * Clear the breakpoint register and single-step the
+	 * causative instruction
+	 */
+	dbcr0 = per_cpu(last_hit_dbcr0, cpu) = mfspr(SPRN_DBCR0);
+	dbcr0 &= ~((DBCR0_DAC2W | DBCR0_DAC2R) << i);
+
+	/*
+	 * Save the debug registers in corresponding per-cpu variables, only to
+	 * be restored in the single-step exception handler.
+	 */
+	per_cpu(last_hit_dac[0], cpu) = mfspr(SPRN_DAC1);
+	if (unlikely(bp_info->len > DAC_LEN)) {
+		dbcr0 &= ~((DBCR0_DAC2W | DBCR0_DAC2R) << i);
+		per_cpu(last_hit_dac[1], cpu) = mfspr(SPRN_DAC1);
+	}
+	rcu_read_unlock();
+
+	/*
+	 * Block-step and single-stepping is not supported
+	 * simultaneously for now
+	 */
+	dbcr0 &= ~DBCR0_BT;
+	mtspr(SPRN_DBCR0, dbcr0 | DBCR0_IDM | DBCR0_IC);
+	mtmsr(mfmsr() | MSR_DE);
+}
+
+/*
+ * Handle single-step exceptions following a DAC hit
+ */
+int __kprobes single_step_dac_instruction(struct pt_regs *regs)
+{
+	int i, cpu = smp_processor_id();
+	struct arch_hw_breakpoint *bp_info;
+	struct perf_event *bp = per_cpu(last_hit_bp, cpu);
+	unsigned long dbcr0 = mfspr(SPRN_DBCR0);
+
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
+
+	/*
+	 * Loop through the 'slot's to identify the appropriate DAC register
+	 * and restore the breakpoint values
+	 */
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = &__get_cpu_var(bp_per_reg[i]);
+
+		if (*slot != bp)
+			continue;
+		mtspr(SPRN_DAC1, bp_info->address);
+		dbcr0 &= ~(DBCR0_DAC2W | DBCR0_DAC2R);
+		mtspr(SPRN_DBCR0, dbcr0 |
+				(bp_info->type << (HBP_NUM - i)) | DBCR0_IDM);
+		if (unlikely(bp_info->len > DAC_LEN)) {
+			i++;
+			mtspr(SPRN_DAC2, bp_info->address + bp_info->len);
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) |
+				(bp_info->type << (HBP_NUM - i)) | DBCR0_IDM);
+			mtspr(SPRN_DBCR2, DBCR2_DAC12M);
+		}
+		break;
+	}
+	mtspr(SPRN_DBCR0, dbcr0 | DBCR0_IDM | DBCR0_IC);
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
@@ -1151,8 +1154,12 @@ void __kprobes DebugException(struct pt_
 		}
 
 		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-	} else
-		handle_debug(regs, debug_status);
+	} else {
+		if (is_kernel_addr(regs->dar))
+			hw_breakpoint_handler(regs, debug_status);
+		else
+			handle_debug(regs, debug_status);
+	}
 }
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
Index: linux-2.6.bookE/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/Kconfig
+++ linux-2.6.bookE/arch/powerpc/Kconfig
@@ -140,7 +140,7 @@ config PPC
 	select HAVE_SYSCALL_WRAPPERS if PPC64
 	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_EVENTS
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && PPC_BOOK3S_64) || BOOKE
 
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
@@ -787,10 +787,12 @@ int ptrace_set_debugreg(struct task_stru
 			       unsigned long data)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#ifndef CONFIG_BOOKE
 	int ret;
 	struct thread_struct *thread = &(task->thread);
 	struct perf_event *bp;
 	struct perf_event_attr attr;
+#endif /* CONFIG_BOOKE */
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
@@ -821,6 +823,11 @@ int ptrace_set_debugreg(struct task_stru
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+/*
+ * Temporarily disable use of breakpoint interfaces through ptrace until
+ * user-space breakpoint support is enabled.
+ */
+#ifndef CONFIG_BOOKE
 	bp = thread->ptrace_bps[0];
 	if (data == 0) {
 		if (bp) {
@@ -873,6 +880,7 @@ int ptrace_set_debugreg(struct task_stru
 		return PTR_ERR(bp);
 	}
 
+#endif /* CONFIG_BOOKE */
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	/* Move contents to the DABR register */
Index: linux-2.6.bookE/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-2.6.bookE.orig/arch/powerpc/include/asm/cputable.h
+++ linux-2.6.bookE/arch/powerpc/include/asm/cputable.h
@@ -512,7 +512,11 @@ static inline int cpu_has_feature(unsign
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
@@ -440,7 +440,11 @@ enum perf_callchain_context {
 #endif
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#ifdef CONFIG_BOOKE
+#include <asm/hw_breakpoint_booke.h>
+#else
 #include <asm/hw_breakpoint.h>
+#endif /* CONFIG_BOOKE */
 #endif
 
 #include <linux/list.h>
