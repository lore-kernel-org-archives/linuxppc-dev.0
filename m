Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3XWn5jPTzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:30:45 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a188so9103646pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 00:30:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH] powerpc/64s: SMP hardlockup watchdog
Date: Thu, 13 Apr 2017 17:30:33 +1000
Message-Id: <20170413073033.4756-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a new SMP based watchdog rather than use the perf based
hardlockup detector. The new watchdog uses all SMP threads to watch
each other for lockups, by pinging a shared cpumask.

This has nothing really to do with NMIs at the moment, but it looks
into a couple of kernel options and APIs that have NMI in the name.

In the interests of size and simplicity, I have avoided grabbing the
pseudo-NMI from underneath the soft IRQ masking code. One issue there
is I want to avoid reusing process stacks when Linux irqs are disabled.

This will become most useful with NMI IPIs to crash stuck CPUs with.
Probably needs some small build fixes on other archs which do their
own watchdogs like sparc, but it works on powerpc.
---
 arch/powerpc/Kconfig           |   1 +
 arch/powerpc/include/asm/nmi.h |   2 +
 arch/powerpc/kernel/Makefile   |   1 +
 arch/powerpc/kernel/kvm.c      |   6 +
 arch/powerpc/kernel/setup_64.c |  18 ---
 arch/powerpc/kernel/watchdog.c | 282 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nmi.h            |   2 +-
 kernel/sysctl.c                |   2 +-
 kernel/watchdog.c              |  50 +++++++-
 lib/Kconfig.debug              |   4 +-
 10 files changed, 340 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/kernel/watchdog.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c4804cd65b9a..66f23c700233 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,6 +148,7 @@ config PPC
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS
+	select HAVE_NMI_WATCHDOG		if PPC64 && PPC_BOOK3S && SMP
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES			if PPC64
 	select HAVE_PERF_EVENTS
diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index ff1ccb375e60..df8e058d94d4 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -1,4 +1,6 @@
 #ifndef _ASM_NMI_H
 #define _ASM_NMI_H
 
+void touch_nmi_watchdog(void);
+
 #endif /* _ASM_NMI_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9b264ebe6ac1..691a5713cc3a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
+obj-$(CONFIG_HAVE_NMI_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f827a97..dee51a1373e9 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -718,6 +718,12 @@ static __init void kvm_free_tmp(void)
 
 static int __init kvm_guest_init(void)
 {
+	/*
+	 * The hardlockup detector is likely to get false positives in
+	 * KVM guests, so disable it by default.
+	 */
+	hardlockup_detector_disable();
+
 	if (!kvm_para_available())
 		goto free_tmp;
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f3e65de63ce8..5a8c57396947 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -729,21 +729,3 @@ struct ppc_pci_io ppc_pci_io;
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
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
new file mode 100644
index 000000000000..d730dc1c222b
--- /dev/null
+++ b/arch/powerpc/kernel/watchdog.c
@@ -0,0 +1,282 @@
+/*
+ * Watchdog support on powerpc systems.
+ *
+ * Copyright 2017, IBM Corporation.
+ *
+ * This uses code from arch/sparc/kernel/nmi.c and kernel/watchdog.c
+ */
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/nmi.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/kprobes.h>
+#include <linux/hardirq.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/kdebug.h>
+#include <linux/sched/debug.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+
+#include <asm/paca.h>
+
+unsigned int __read_mostly hardlockup_panic;
+
+/*
+ * The watchdog has a simple timer that runs on each CPU, once per timer
+ * period. This is the heartbeat.
+ *
+ * Then there are checks to see if the heartbeat has not triggered on a CPU
+ * for the panic timeout period. Currently the watchdog only supports an
+ * SMP check, so the heartbeat only turns on when we have 2 or more CPUs.
+ *
+ * This is not an NMI watchdog, but Linux uses that name for a generic
+ * watchdog in some cases, so NMI gets used in some places.
+ */
+
+static cpumask_t wd_cpus_enabled __read_mostly;
+
+static int wd_panic_timeout __read_mostly = 30000; /* min msec until panic */
+static u64 wd_panic_timeout_tb __read_mostly;      /* in timebase ticks */
+
+static int wd_timer_period __read_mostly = 10000;  /* msec between checks */
+static u64 wd_timer_period_tb __read_mostly;       /* in timebase ticks */
+
+static DEFINE_PER_CPU(struct timer_list, wd_timer);
+
+/*
+ * These are for the SMP checker. CPUs clear their pending bit in their
+ * heartbeat. If the bitmask becomes empty, the time is noted and the
+ * bitmask is refilled.
+ *
+ * All CPUs clear their bit in the pending mask every timer period.
+ * Once all have cleared, the time is noted and the bits are reset.
+ * If the time since all clear was greater than the panic timeout,
+ * we can panic with the list of stuck CPUs.
+ *
+ * This will work best with NMI IPIs for crash code so the stuck CPUs
+ * can be pulled out to get their backtraces.
+ */
+static unsigned long __wd_smp_lock = 0;
+static int wd_smp_enabled __read_mostly = 0;
+static cpumask_t wd_smp_cpus_pending;
+static u64 wd_smp_last_reset_tb;
+
+static inline void wd_smp_lock(unsigned long *flags)
+{
+	/*
+	 * Avoid locking layers if possible.
+	 * This may be called from low level interrupt handlers at some
+	 * point in future.
+	 */
+	local_irq_save(*flags);
+	while (unlikely(test_and_set_bit_lock(0, &__wd_smp_lock)))
+		cpu_relax();
+}
+
+static inline void wd_smp_unlock(unsigned long *flags)
+{
+	clear_bit_unlock(0, &__wd_smp_lock);
+	local_irq_restore(*flags);
+}
+
+static void watchdog_smp_panic(void)
+{
+	unsigned long flags;
+
+	wd_smp_lock(&flags);
+
+	pr_emerg("Watchdog CPU:%d detected hard LOCKUP other CPUS:%*pbl\n",
+			smp_processor_id(),
+			cpumask_pr_args(&wd_smp_cpus_pending));
+
+	if (hardlockup_panic)
+		nmi_panic(get_irq_regs(), "Hard LOCKUP");
+
+	wd_smp_unlock(&flags);
+}
+
+static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
+{
+	if (!cpumask_test_cpu(cpu, &wd_smp_cpus_pending))
+		return;
+
+	cpumask_clear_cpu(cpu, &wd_smp_cpus_pending);
+	if (cpumask_empty(&wd_smp_cpus_pending)) {
+		unsigned long flags;
+
+		wd_smp_lock(&flags);
+		if (cpumask_empty(&wd_smp_cpus_pending)) {
+			wd_smp_last_reset_tb = tb;
+			cpumask_copy(&wd_smp_cpus_pending,
+						&wd_cpus_enabled);
+		}
+		wd_smp_unlock(&flags);
+	}
+}
+
+static void watchdog_timer_interrupt(int cpu)
+{
+	u64 tb;
+
+	if (wd_smp_enabled) {
+		smp_rmb();
+
+		tb = get_tb();
+
+		wd_smp_clear_cpu_pending(cpu, tb);
+
+		if (tb - wd_smp_last_reset_tb >= wd_panic_timeout_tb)
+			watchdog_smp_panic();
+	}
+}
+
+static void wd_timer_reset(unsigned int cpu, struct timer_list *t)
+{
+	t->expires = jiffies + msecs_to_jiffies(wd_timer_period);
+	if (wd_timer_period > 1000)
+		t->expires = round_jiffies(t->expires);
+	add_timer_on(t, cpu);
+}
+
+static void wd_timer_fn(unsigned long data)
+{
+	struct timer_list *t = this_cpu_ptr(&wd_timer);
+	int cpu = smp_processor_id();
+
+	watchdog_timer_interrupt(cpu);
+
+	wd_timer_reset(cpu, t);
+}
+
+void touch_nmi_watchdog(void)
+{
+	int cpu = smp_processor_id();
+
+	watchdog_timer_interrupt(cpu);
+
+	touch_softlockup_watchdog();
+}
+EXPORT_SYMBOL(touch_nmi_watchdog);
+
+static void start_watchdog_timer_on(unsigned int cpu)
+{
+	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
+
+	setup_pinned_timer(t, wd_timer_fn, 0);
+	wd_timer_reset(cpu, t);
+}
+
+static void stop_watchdog_timer_on(unsigned int cpu)
+{
+	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
+
+	del_timer_sync(t);
+}
+
+static int start_wd_on_cpu(unsigned int cpu)
+{
+	if (cpumask_test_cpu(cpu, &wd_cpus_enabled)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	if (cpumask_weight(&wd_cpus_enabled) > 0) {
+		start_watchdog_timer_on(cpu);
+
+		if (cpumask_weight(&wd_cpus_enabled) == 1)
+			start_watchdog_timer_on(cpumask_first(&wd_cpus_enabled));
+	}
+
+	cpumask_set_cpu(cpu, &wd_cpus_enabled);
+
+	if (cpumask_weight(&wd_cpus_enabled) == 1) {
+		cpumask_copy(&wd_smp_cpus_pending, &wd_cpus_enabled);
+		wd_smp_last_reset_tb = get_tb();
+		smp_wmb();
+		wd_smp_enabled = 1;
+
+		pr_info("Watchdog starting cross-CPU SMP watchdog\n");
+	}
+
+	return 0;
+}
+
+static int stop_wd_on_cpu(unsigned int cpu)
+{
+	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	/* In case of == 1, the timer won't have started yet */
+	if (cpumask_weight(&wd_cpus_enabled) > 1)
+		stop_watchdog_timer_on(cpu);
+
+	cpumask_clear_cpu(cpu, &wd_cpus_enabled);
+
+
+	if (wd_smp_enabled) {
+		smp_wmb();
+		wd_smp_clear_cpu_pending(cpu, get_tb());
+
+		if (cpumask_weight(&wd_cpus_enabled) == 1) {
+			stop_watchdog_timer_on(cpumask_first(&wd_cpus_enabled));
+
+			pr_info("Watchdog stopping cross-CPU SMP watchdog\n");
+			wd_smp_last_reset_tb = get_tb();
+			cpumask_copy(&wd_smp_cpus_pending, &wd_cpus_enabled);
+			smp_wmb();
+			wd_smp_enabled = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int __init powerpc_watchdog_init(void)
+{
+	int err;
+
+	if (!wd_panic_timeout)
+		return 0;
+
+	wd_panic_timeout_tb = wd_panic_timeout * ppc_tb_freq / 1000;
+	wd_timer_period_tb = wd_timer_period * ppc_tb_freq / 1000;
+
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/watchdog:online",
+				start_wd_on_cpu, stop_wd_on_cpu);
+	if (err < 0)
+		pr_warning("Watchdog could not be initialized");
+
+	return 0;
+}
+arch_initcall(powerpc_watchdog_init);
+
+void hardlockup_detector_disable(void)
+{
+	wd_panic_timeout = 0;
+}
+
+static int __init wd_setup(char *str)
+{
+	if (!strncmp(str, "panic", 5))
+		hardlockup_panic = 1;
+	else if (!strncmp(str, "nopanic", 7))
+		hardlockup_panic = 0;
+	else if (!strncmp(str, "0", 1))
+		wd_panic_timeout = 0;
+	return 1;
+}
+__setup("nmi_watchdog=", wd_setup);
+
+static int __init nowatchdog_setup(char *str)
+{
+	wd_panic_timeout = 0;
+	return 1;
+}
+__setup("nowatchdog", nowatchdog_setup);
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index aa3cd0878270..793d05d29140 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -78,7 +78,7 @@ static inline void touch_nmi_watchdog(void)
 }
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR)
+#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
 #else
 static inline void hardlockup_detector_disable(void) {}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8c8714fcb53c..dae648322bb9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -904,7 +904,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
 	{
 		.procname	= "hardlockup_panic",
 		.data		= &hardlockup_panic,
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 03e0b69bb5bf..f03d93cef35f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -87,16 +87,40 @@ static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
-unsigned int __read_mostly softlockup_panic =
-			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
-
-static int __init softlockup_panic_setup(char *str)
+/* boot commands */
+/*
+ * Should we panic when a soft-lockup or hard-lockup occurs:
+ */
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+unsigned int __read_mostly hardlockup_panic =
+			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
+static unsigned long hardlockup_allcpu_dumped;
+/*
+ * We may not want to enable hard lockup detection by default in all cases,
+ * for example when running the kernel as a guest on a hypervisor. In these
+ * cases this function can be called to disable hard lockup detection. This
+ * function should only be executed once by the boot processor before the
+ * kernel command line parameters are parsed, because otherwise it is not
+ * possible to override this in hardlockup_panic_setup().
+ */
+void hardlockup_detector_disable(void)
 {
-	softlockup_panic = simple_strtoul(str, NULL, 0);
+	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
+}
 
+static int __init hardlockup_panic_setup(char *str)
+{
+	if (!strncmp(str, "panic", 5))
+		hardlockup_panic = 1;
+	else if (!strncmp(str, "nopanic", 7))
+		hardlockup_panic = 0;
+	else if (!strncmp(str, "0", 1))
+		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
+	else if (!strncmp(str, "1", 1))
+		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
 	return 1;
 }
-__setup("softlockup_panic=", softlockup_panic_setup);
+__setup("nmi_watchdog=", hardlockup_panic_setup);
 
 static int __init nowatchdog_setup(char *str)
 {
@@ -104,6 +128,18 @@ static int __init nowatchdog_setup(char *str)
 	return 1;
 }
 __setup("nowatchdog", nowatchdog_setup);
+#endif
+
+unsigned int __read_mostly softlockup_panic =
+			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
+
+static int __init softlockup_panic_setup(char *str)
+{
+	softlockup_panic = simple_strtoul(str, NULL, 0);
+
+	return 1;
+}
+__setup("softlockup_panic=", softlockup_panic_setup);
 
 static int __init nosoftlockup_setup(char *str)
 {
@@ -120,6 +156,7 @@ static int __init softlockup_all_cpu_backtrace_setup(char *str)
 	return 1;
 }
 __setup("softlockup_all_cpu_backtrace=", softlockup_all_cpu_backtrace_setup);
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 {
 	sysctl_hardlockup_all_cpu_backtrace =
@@ -128,6 +165,7 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 }
 __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
 #endif
+#endif
 
 /*
  * Hard-lockup warnings should be triggered after just a few seconds. Soft-
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 97d62c2da6c2..bc10e69a3a8a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -807,7 +807,7 @@ config HARDLOCKUP_DETECTOR
 
 config BOOTPARAM_HARDLOCKUP_PANIC
 	bool "Panic (Reboot) On Hard Lockups"
-	depends on HARDLOCKUP_DETECTOR
+	depends on HARDLOCKUP_DETECTOR || HAVE_NMI_WATCHDOG
 	help
 	  Say Y here to enable the kernel to panic on "hard lockups",
 	  which are bugs that cause the kernel to loop in kernel
@@ -818,7 +818,7 @@ config BOOTPARAM_HARDLOCKUP_PANIC
 
 config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
 	int
-	depends on HARDLOCKUP_DETECTOR
+	depends on HARDLOCKUP_DETECTOR || HAVE_NMI_WATCHDOG
 	range 0 1
 	default 0 if !BOOTPARAM_HARDLOCKUP_PANIC
 	default 1 if BOOTPARAM_HARDLOCKUP_PANIC
-- 
2.11.0
