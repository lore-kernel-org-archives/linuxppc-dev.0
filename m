Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:34:06 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 5/7] powerpc: Add timer, performance monitor and machine
	check counts to /proc/interrupts
Message-ID: <20100201063406.GX2996@kryten>
References: <20100201063023.GT2996@kryten> <20100201063251.GU2996@kryten>
	<20100201063318.GV2996@kryten> <20100201063341.GW2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100201063341.GW2996@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


With NO_HZ it is useful to know how often the decrementer is going off. The
patch below adds an entry for it and also adds it into the /proc/stat
summaries.

While here, I added performance monitoring and machine check exceptions.
I found it useful to keep an eye on the PMU exception rate
when using the perf tool. Since it's possible to take a completely
handled machine check on a System p box it also sounds like a good idea to
keep a machine check summary.

The event naming matches x86 to keep gratuitous differences to a minimum.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

If people really don't like the x86 short names, we can think up something
else.

Index: linux-cpumask/arch/powerpc/include/asm/hardirq.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:28:56.990963256 +1100
+++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:29:03.887211643 +1100
@@ -6,6 +6,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+	unsigned int timer_irqs;
+	unsigned int pmu_irqs;
+	unsigned int mce_exceptions;
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
@@ -19,4 +22,10 @@ static inline void ack_bad_irq(unsigned 
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 
+extern u64 arch_irq_stat_cpu(unsigned int cpu);
+#define arch_irq_stat_cpu	arch_irq_stat_cpu
+
+extern u64 arch_irq_stat(void);
+#define arch_irq_stat		arch_irq_stat
+
 #endif /* _ASM_POWERPC_HARDIRQ_H */
Index: linux-cpumask/arch/powerpc/kernel/time.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/time.c	2010-02-01 17:28:56.590961781 +1100
+++ linux-cpumask/arch/powerpc/kernel/time.c	2010-02-01 17:29:03.887211643 +1100
@@ -575,6 +575,8 @@ void timer_interrupt(struct pt_regs * re
 
 	trace_timer_interrupt_entry(regs);
 
+	__get_cpu_var(irq_stat).timer_irqs++;
+
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continuue to take decrementer exceptions */
 	set_dec(DECREMENTER_MAX);
Index: linux-cpumask/arch/powerpc/kernel/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-02-01 17:29:02.007212291 +1100
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-02-01 17:29:03.887211643 +1100
@@ -196,6 +196,21 @@ static int show_other_interrupts(struct 
 	}
 #endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
 
+	seq_printf(p, "%*s: ", prec, "LOC");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs);
+        seq_printf(p, "  Local timer interrupts\n");
+
+	seq_printf(p, "%*s: ", prec, "CNT");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
+	seq_printf(p, "  Performance monitoring interrupts\n");
+
+	seq_printf(p, "%*s: ", prec, "MCE");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
+	seq_printf(p, "  Machine check exceptions\n");
+
 	seq_printf(p, "%*s: %10u\n", prec, "BAD", ppc_spurious_interrupts);
 
 	return 0;
@@ -258,6 +273,26 @@ out:
 	return 0;
 }
 
+/*
+ * /proc/stat helpers
+ */
+u64 arch_irq_stat_cpu(unsigned int cpu)
+{
+	u64 sum = per_cpu(irq_stat, cpu).timer_irqs;
+
+	sum += per_cpu(irq_stat, cpu).pmu_irqs;
+	sum += per_cpu(irq_stat, cpu).mce_exceptions;
+
+	return sum;
+}
+
+u64 arch_irq_stat(void)
+{
+	u64 sum = ppc_spurious_interrupts;
+
+	return sum;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(cpumask_t map)
 {
Index: linux-cpumask/arch/powerpc/kernel/traps.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/traps.c	2010-02-01 17:28:56.570961322 +1100
+++ linux-cpumask/arch/powerpc/kernel/traps.c	2010-02-01 17:29:03.897211396 +1100
@@ -478,6 +478,8 @@ void machine_check_exception(struct pt_r
 {
 	int recover = 0;
 
+	__get_cpu_var(irq_stat).mce_exceptions++;
+
 	/* See if any machine dependent calls. In theory, we would want
 	 * to call the CPU first, and call the ppc_md. one if the CPU
 	 * one returns a positive number. However there is existing code
@@ -960,6 +962,8 @@ void vsx_unavailable_exception(struct pt
 
 void performance_monitor_exception(struct pt_regs *regs)
 {
+	__get_cpu_var(irq_stat).pmu_irqs++;
+
 	perf_irq(regs);
 }
 
