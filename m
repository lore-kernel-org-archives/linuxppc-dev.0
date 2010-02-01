Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:34:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 6/7] powerpc: Convert global "BAD" interrupt to per cpu
	spurious
Message-ID: <20100201063436.GY2996@kryten>
References: <20100201063023.GT2996@kryten> <20100201063251.GU2996@kryten>
	<20100201063318.GV2996@kryten> <20100201063341.GW2996@kryten>
	<20100201063406.GX2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100201063406.GX2996@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I often get asked if BAD interrupts are really bad. On some boxes (eg
IBM machines running a hypervisor) there are valid cases where are
presented with an interrupt that is not for us. These cases are common
enough to show up as thousands of BAD interrupts a day.

Tone them down by calling them spurious. Since they can be a significant cause
of OS jitter, we may as well log them per cpu so we know where they are
occurring.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Again, the short name matches x86 but if people are sufficiently confused by
it ("SPU"), then we can think up something else.

Index: linux-cpumask/arch/powerpc/include/asm/hardirq.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:29:03.887211643 +1100
+++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:29:04.738461552 +1100
@@ -9,6 +9,7 @@ typedef struct {
 	unsigned int timer_irqs;
 	unsigned int pmu_irqs;
 	unsigned int mce_exceptions;
+	unsigned int spurious_irqs;
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
@@ -25,7 +26,4 @@ static inline void ack_bad_irq(unsigned 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
 
-extern u64 arch_irq_stat(void);
-#define arch_irq_stat		arch_irq_stat
-
 #endif /* _ASM_POWERPC_HARDIRQ_H */
Index: linux-cpumask/arch/powerpc/kernel/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-02-01 17:29:03.887211643 +1100
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-02-01 17:29:04.738461552 +1100
@@ -77,7 +77,6 @@ DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpusta
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 int __irq_offset_value;
-static int ppc_spurious_interrupts;
 
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(__irq_offset_value);
@@ -201,6 +200,11 @@ static int show_other_interrupts(struct 
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs);
         seq_printf(p, "  Local timer interrupts\n");
 
+	seq_printf(p, "%*s: ", prec, "SPU");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).spurious_irqs);
+	seq_printf(p, "  Spurious interrupts\n");
+
 	seq_printf(p, "%*s: ", prec, "CNT");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
@@ -211,8 +215,6 @@ static int show_other_interrupts(struct 
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
 	seq_printf(p, "  Machine check exceptions\n");
 
-	seq_printf(p, "%*s: %10u\n", prec, "BAD", ppc_spurious_interrupts);
-
 	return 0;
 }
 
@@ -282,13 +284,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 
 	sum += per_cpu(irq_stat, cpu).pmu_irqs;
 	sum += per_cpu(irq_stat, cpu).mce_exceptions;
-
-	return sum;
-}
-
-u64 arch_irq_stat(void)
-{
-	u64 sum = ppc_spurious_interrupts;
+	sum += per_cpu(irq_stat, cpu).spurious_irqs;
 
 	return sum;
 }
@@ -404,8 +400,7 @@ void do_IRQ(struct pt_regs *regs)
 	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE)
 		handle_one_irq(irq);
 	else if (irq != NO_IRQ_IGNORE)
-		/* That's not SMP safe ... but who cares ? */
-		ppc_spurious_interrupts++;
+		__get_cpu_var(irq_stat).spurious_irqs++;
 
 	irq_exit();
 	set_irq_regs(old_regs);
