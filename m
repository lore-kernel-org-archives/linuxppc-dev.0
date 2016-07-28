Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0YHt6R43zDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 23:54:18 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id q2so3608054pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 06:54:18 -0700 (PDT)
Date: Thu, 28 Jul 2016 23:54:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/9] Add #defs for paca->soft_enabled flags
Message-ID: <20160728235408.5d914676@roar.ozlabs.ibm.com>
In-Reply-To: <1ee595c7-2c1e-82f4-4d1b-33fa9074c545@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726152706.43bffd08@roar.ozlabs.ibm.com>
 <1ee595c7-2c1e-82f4-4d1b-33fa9074c545@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2016 11:35:16 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Tuesday 26 July 2016 10:57 AM, Nicholas Piggin wrote:
> > On Mon, 25 Jul 2016 20:22:14 +0530
> > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> >  
> >> Two #defs LAZY_INTERRUPT_ENABLED and
> >> LAZY_INTERRUPT_DISABLED are added to be used
> >> when updating paca->soft_enabled.  
> > This is a very nice patchset, but can this not be a new name?  
> 
> Thanks, but idea is from ben :)
> Regarding the name, I looked at the initial patchset posted by
> paul and took the name from it :).


I did this quick hack for doing nmi watchdog using masked
decrementer interrupts instead of perf.

I think it should allow us to trip on hangs in
local_irq_and_pmu_disable() regions where the existing
one would not. Of course local atomics will not be usable
in the watchdog code, but that's more tractable than PMU
interrupts (or we just do our own private NMI watchdog
like other arch's do so we control everything -- sparc's
implementation is only 270 lines).

Let me know if you find it useful.

Thanks,
Nick


diff --git a/arch/Kconfig b/arch/Kconfig
index d794384..a307407 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -35,7 +35,7 @@ config HAVE_OPROFILE
 
 config OPROFILE_NMI_TIMER
 	def_bool y
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
+	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 
 config KPROBES
 	bool "Kprobes"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 01f7464..87a0816 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -130,6 +130,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_CBPF_JIT
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_NMI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select GENERIC_SMP_IDLE_THREAD
@@ -154,8 +155,6 @@ config PPC
 	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
 	select NO_BOOTMEM
 	select HAVE_GENERIC_RCU_GUP
-	select HAVE_PERF_EVENTS_NMI if PPC64
-	select HAVE_NMI if PERF_EVENTS
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index ff1ccb3..90ab2bb 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -1,4 +1,8 @@
 #ifndef _ASM_NMI_H
 #define _ASM_NMI_H
 
+extern int nmi_enable(u64 period);
+extern void nmi_disable(void);
+extern void nmi_interrupt(struct pt_regs *regs);
+
 #endif /* _ASM_NMI_H */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 546540b..6b3b041 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -153,6 +153,9 @@ struct paca_struct {
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 soft_enabled;		/* irq soft-enable flag */
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+	u8 nmi_enabled;			/* generate nmis when soft-disabled */
+#endif
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ea0955..4bf327d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -190,6 +190,9 @@ int main(void)
 	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+	DEFINE(PACANMIENABLED, offsetof(struct paca_struct, nmi_enabled));
+#endif
 	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
 #ifdef CONFIG_PPC_BOOK3S
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, mm_ctx_id));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..972f368 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -634,6 +634,8 @@ masked_##_H##interrupt:					\
 	lis	r10,0x7fff;				\
 	ori	r10,r10,0xffff;				\
 	mtspr	SPRN_DEC,r10;				\
+	/* XXX: test nmi enabled and depend CONFIG_HARDLOCKUP_DETECTOR */ \
+	b	masked_decrementer_##_H##interrupt;	\
 	b	2f;					\
 1:	cmpwi	r10,PACA_IRQ_DBELL;			\
 	beq	2f;					\
@@ -650,9 +652,21 @@ masked_##_H##interrupt:					\
 	GET_SCRATCH0(r13);				\
 	##_H##rfid;					\
 	b	.
-	
+
+#define MASKED_NMI(_H)					\
+masked_decrementer_##_H##interrupt:			\
+	std	r12,PACA_EXGEN+EX_R12(r13);		\
+	GET_SCRATCH0(r10);				\
+	std	r10,PACA_EXGEN+EX_R13(r13);		\
+	EXCEPTION_PROLOG_PSERIES_1(nmi_common, _H)
+
 	MASKED_INTERRUPT()
+	MASKED_NMI()
 	MASKED_INTERRUPT(H)
+	MASKED_NMI(H)
+
+
+STD_EXCEPTION_COMMON_ASYNC(0x900, nmi, nmi_interrupt)
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f8..bedc975 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -25,6 +25,7 @@
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/nmi.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -718,6 +719,8 @@ static __init void kvm_free_tmp(void)
 
 static int __init kvm_guest_init(void)
 {
+	hardlockup_detector_disable();
+
 	if (!kvm_para_available())
 		goto free_tmp;
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 96d4a2b..cfa03db 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -808,21 +808,3 @@ struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-u64 hw_nmi_get_sample_period(int watchdog_thresh)
-{
-	return ppc_proc_freq * watchdog_thresh;
-}
-
-/*
- * The hardlockup detector breaks PMU event based branches and is likely
- * to get false positives in KVM guests, so disable it by default.
- */
-static int __init disable_hardlockup_detector(void)
-{
-	hardlockup_detector_disable();
-
-	return 0;
-}
-early_initcall(disable_hardlockup_detector);
-#endif
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3ed9a5a..633fdca 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -52,6 +52,7 @@
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
@@ -65,6 +66,7 @@
 #include <asm/machdep.h>
 #include <asm/uaccess.h>
 #include <asm/time.h>
+#include <asm/nmi.h>
 #include <asm/prom.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
@@ -523,11 +525,78 @@ static void __timer_interrupt(void)
 	trace_timer_interrupt_exit(regs);
 }
 
+int watchdog_nmi_enable(unsigned int cpu, int period)
+{
+	/* Migration should be disabled and running on same CPU as local */
+	if (cpu != smp_processor_id()) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	return nmi_enable(ppc_tb_freq * period);
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	if (cpu != smp_processor_id()) {
+		WARN_ON(1);
+		return;
+	}
+
+	nmi_disable();
+}
+
+static DEFINE_PER_CPU(u64, nmi_period);
+static DEFINE_PER_CPU(u64, nmi_last_tb);
+
+/*
+ * nmi interrupts only occur when linux irqs are disabled (but
+ * powerpc hardware irqs are enabled), so they can not be relied
+ * upon to be timely or delivered at all. Their only real use is
+ * the nmi watchdog.
+ */
+int nmi_enable(u64 period)
+{
+	if (__this_cpu_read(nmi_period))
+		return -EINVAL;
+
+	__this_cpu_write(nmi_period, period);
+	__this_cpu_write(nmi_last_tb, get_tb());
+	barrier();
+	get_paca()->nmi_enabled = 1;
+
+	return 0;
+}
+
+void nmi_disable(void)
+{
+	get_paca()->nmi_enabled = 0;
+	barrier();
+	__this_cpu_write(nmi_period, 0);
+}
+
+void nmi_interrupt(struct pt_regs *regs)
+{
+	u64 tb;
+
+	if (!__this_cpu_read(nmi_period))
+		return;
+
+	tb = get_tb();
+	if (tb - __this_cpu_read(nmi_last_tb) < __this_cpu_read(nmi_period))
+		return;
+	__this_cpu_write(nmi_last_tb, tb);
+
+	nmi_enter();
+	watchdog_nmi_interrupt(regs);
+	nmi_exit();
+}
+
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
  */
-void timer_interrupt(struct pt_regs * regs)
+void timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4630eea..5d6bdca 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -6,6 +6,9 @@
 
 #include <linux/sched.h>
 #include <asm/irq.h>
+#ifdef CONFIG_HAVE_NMI
+#include <asm/nmi.h>
+#endif
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
@@ -15,7 +18,7 @@
  * disables interrupts for a long time. This call is stateless.
  */
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
-#include <asm/nmi.h>
+extern void watchdog_nmi_interrupt(struct pt_regs *regs);
 extern void touch_nmi_watchdog(void);
 #else
 static inline void touch_nmi_watchdog(void)
@@ -26,6 +29,15 @@ static inline void touch_nmi_watchdog(void)
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+u64 hw_nmi_get_sample_period(int watchdog_thresh);
+#else
+extern int watchdog_nmi_enable(unsigned int cpu, int thresh);
+extern void watchdog_nmi_disable(unsigned int cpu);
+extern void watchdog_nmi_interrupt(struct pt_regs *regs);
+#endif
+
 #else
 static inline void hardlockup_detector_disable(void) {}
 #endif
@@ -65,7 +77,6 @@ static inline bool trigger_allbutself_cpu_backtrace(void)
 #endif
 
 #ifdef CONFIG_LOCKUP_DETECTOR
-u64 hw_nmi_get_sample_period(int watchdog_thresh);
 extern int nmi_watchdog_enabled;
 extern int soft_watchdog_enabled;
 extern int watchdog_user_enabled;
@@ -97,8 +108,4 @@ static inline void lockup_detector_resume(void)
 }
 #endif
 
-#ifdef CONFIG_HAVE_ACPI_APEI_NMI
-#include <asm/nmi.h>
-#endif
-
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e42ada..f397d0b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -395,6 +395,7 @@ extern int proc_dowatchdog_thresh(struct ctl_table *table, int write,
 				  size_t *lenp, loff_t *ppos);
 extern unsigned int  softlockup_panic;
 extern unsigned int  hardlockup_panic;
+void lockup_detector_init_early(void);
 void lockup_detector_init(void);
 #else
 static inline void touch_softlockup_watchdog_sched(void)
@@ -409,6 +410,9 @@ static inline void touch_softlockup_watchdog_sync(void)
 static inline void touch_all_softlockup_watchdogs(void)
 {
 }
+static inline void lockup_detector_init_early(void)
+{
+}
 static inline void lockup_detector_init(void)
 {
 }
diff --git a/init/main.c b/init/main.c
index 4c17fda..7b6671d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -570,6 +570,7 @@ asmlinkage __visible void __init start_kernel(void)
 	time_init();
 	sched_clock_postinit();
 	printk_nmi_init();
+	lockup_detector_init_early();
 	perf_event_init();
 	profile_init();
 	call_function_init();
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..a06376d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 
 #include <asm/irq_regs.h>
+#include <asm/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/perf_event.h>
 #include <linux/kthread.h>
@@ -104,8 +105,10 @@ static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
 #endif
+#endif
 static unsigned long soft_lockup_nmi_warn;
 
 /* boot commands */
@@ -314,23 +317,8 @@ static int is_softlockup(unsigned long touch_ts)
 }
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
-
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-		 struct perf_sample_data *data,
-		 struct pt_regs *regs)
+void watchdog_nmi_interrupt(struct pt_regs *regs)
 {
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
@@ -374,18 +362,40 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	}
 
 	__this_cpu_write(hard_watchdog_warn, false);
-	return;
 }
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+static struct perf_event_attr wd_hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
+/* Callback function for perf event subsystem */
+static void watchdog_overflow_callback(struct perf_event *event,
+		 struct perf_sample_data *data,
+		 struct pt_regs *regs)
+{
+	/* Ensure the watchdog never gets throttled */
+	event->hw.interrupts = 0;
+
+	watchdog_nmi_interrupt(regs);
+
+	return;
+}
+static int watchdog_nmi_enable(unsigned int cpu, int period);
+static void watchdog_nmi_disable(unsigned int cpu);
+
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
+
 static void watchdog_interrupt_count(void)
 {
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
-static int watchdog_nmi_enable(unsigned int cpu);
-static void watchdog_nmi_disable(unsigned int cpu);
-
 static int watchdog_enable_all_cpus(void);
 static void watchdog_disable_all_cpus(void);
 
@@ -514,8 +524,8 @@ static void watchdog_enable(unsigned int cpu)
 	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer->function = watchdog_timer_fn;
 
-	/* Enable the perf event */
-	watchdog_nmi_enable(cpu);
+	/* Enable the nmi */
+	watchdog_nmi_enable(cpu, watchdog_thresh);
 
 	/* done here because hrtimer_start can only pin to smp_processor_id() */
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
@@ -532,7 +542,7 @@ static void watchdog_disable(unsigned int cpu)
 
 	watchdog_set_prio(SCHED_NORMAL, 0);
 	hrtimer_cancel(hrtimer);
-	/* disable the perf event */
+	/* disable the nmi */
 	watchdog_nmi_disable(cpu);
 }
 
@@ -565,7 +575,7 @@ static void watchdog(unsigned int cpu)
 	 * watchdog_nmi_enable() clears the NMI_WATCHDOG_ENABLED bit in the
 	 * failure path. Check for failures that can occur asynchronously -
 	 * for example, when CPUs are on-lined - and shut down the hardware
-	 * perf event on each CPU accordingly.
+	 * nmi mechanism on each CPU accordingly.
 	 *
 	 * The only non-obvious place this bit can be cleared is through
 	 * watchdog_nmi_enable(), so a pr_info() is placed there.  Placing a
@@ -578,6 +588,7 @@ static void watchdog(unsigned int cpu)
 }
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 /*
  * People like the simple clean cpu node info on boot.
  * Reduce the watchdog noise by only printing messages
@@ -585,7 +596,7 @@ static void watchdog(unsigned int cpu)
  */
 static unsigned long cpu0_err;
 
-static int watchdog_nmi_enable(unsigned int cpu)
+static int watchdog_nmi_enable(unsigned int cpu, int period)
 {
 	struct perf_event_attr *wd_attr;
 	struct perf_event *event = per_cpu(watchdog_ev, cpu);
@@ -603,7 +614,7 @@ static int watchdog_nmi_enable(unsigned int cpu)
 		goto out_enable;
 
 	wd_attr = &wd_hw_attr;
-	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
+	wd_attr->sample_period = hw_nmi_get_sample_period(period);
 
 	/* Try to register using hardware perf events */
 	event = perf_event_create_kernel_counter(wd_attr, cpu, NULL, watchdog_overflow_callback, NULL);
@@ -674,9 +685,9 @@ static void watchdog_nmi_disable(unsigned int cpu)
 		cpu0_err = 0;
 	}
 }
-
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
 #else
-static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
+static int watchdog_nmi_enable(unsigned int cpu, int period) { return 0; }
 static void watchdog_nmi_disable(unsigned int cpu) { return; }
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
@@ -1000,6 +1011,7 @@ int proc_watchdog_thresh(struct ctl_table *table, int write,
 		watchdog_thresh = old;
 		set_sample_period();
 	}
+
 out:
 	mutex_unlock(&watchdog_proc_mutex);
 	put_online_cpus();
@@ -1051,9 +1063,15 @@ out:
 
 #endif /* CONFIG_SYSCTL */
 
-void __init lockup_detector_init(void)
+void __init lockup_detector_init_early(void)
 {
 	set_sample_period();
+	watchdog_nmi_enable(raw_smp_processor_id(), watchdog_thresh);
+}
+
+void __init lockup_detector_init(void)
+{
+	watchdog_nmi_disable(raw_smp_processor_id());
 
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_enabled()) {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b9cfdbf..ea35036 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -755,8 +755,11 @@ config LOCKUP_DETECTOR
 
 config HARDLOCKUP_DETECTOR
 	def_bool y
-	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	depends on LOCKUP_DETECTOR
+
+config HARDLOCKUP_DETECTOR_PERF
+	def_bool y
+	depends on HARDLOCKUP_DETECTOR && PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 
 config BOOTPARAM_HARDLOCKUP_PANIC
 	bool "Panic (Reboot) On Hard Lockups"
