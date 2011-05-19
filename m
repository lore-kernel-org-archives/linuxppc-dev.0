Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC291B6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:10:42 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>, <greg@kroah.com>,
	<akpm@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-console@vger.kernel.org>
Subject: [PATCH 1/7] powerpc: make irq_choose_cpu() available to all PIC
	drivers
Date: Thu, 19 May 2011 08:54:26 -0500
Message-ID: <1305813272-31826-2-git-send-email-timur@freescale.com>
In-Reply-To: <1305813272-31826-1-git-send-email-timur@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

Move irq_choose_cpu() into arch/powerpc/kernel/irq.c so that it can be used
by other PIC drivers.  The function is not MPIC-specific.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/irq.h |    2 ++
 arch/powerpc/kernel/irq.c      |   35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/mpic.c     |   36 ------------------------------------
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 67ab5fb..1792d84 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -342,5 +342,7 @@ extern int call_handle_irq(int irq, void *p1,
 			   struct thread_info *tp, void *func);
 extern void do_IRQ(struct pt_regs *regs);
 
+int irq_choose_cpu(const struct cpumask *mask);
+
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f621b7d..ce9bf93 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -870,6 +870,41 @@ unsigned int irq_find_mapping(struct irq_host *host,
 }
 EXPORT_SYMBOL_GPL(irq_find_mapping);
 
+#ifdef CONFIG_SMP
+int irq_choose_cpu(const struct cpumask *mask)
+{
+	int cpuid;
+
+	if (cpumask_equal(mask, cpu_all_mask)) {
+		static int irq_rover;
+		static DEFINE_RAW_SPINLOCK(irq_rover_lock);
+		unsigned long flags;
+
+		/* Round-robin distribution... */
+do_round_robin:
+		raw_spin_lock_irqsave(&irq_rover_lock, flags);
+
+		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
+		if (irq_rover >= nr_cpu_ids)
+			irq_rover = cpumask_first(cpu_online_mask);
+
+		cpuid = irq_rover;
+
+		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
+	} else {
+		cpuid = cpumask_first_and(mask, cpu_online_mask);
+		if (cpuid >= nr_cpu_ids)
+			goto do_round_robin;
+	}
+
+	return get_hard_smp_processor_id(cpuid);
+}
+#else
+int irq_choose_cpu(const struct cpumask *mask)
+{
+	return hard_smp_processor_id();
+}
+#endif
 
 unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 				     irq_hw_number_t hwirq)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f91c065..5ae1142 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -571,42 +571,6 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
-#ifdef CONFIG_SMP
-static int irq_choose_cpu(const struct cpumask *mask)
-{
-	int cpuid;
-
-	if (cpumask_equal(mask, cpu_all_mask)) {
-		static int irq_rover = 0;
-		static DEFINE_RAW_SPINLOCK(irq_rover_lock);
-		unsigned long flags;
-
-		/* Round-robin distribution... */
-	do_round_robin:
-		raw_spin_lock_irqsave(&irq_rover_lock, flags);
-
-		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
-		if (irq_rover >= nr_cpu_ids)
-			irq_rover = cpumask_first(cpu_online_mask);
-
-		cpuid = irq_rover;
-
-		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
-	} else {
-		cpuid = cpumask_first_and(mask, cpu_online_mask);
-		if (cpuid >= nr_cpu_ids)
-			goto do_round_robin;
-	}
-
-	return get_hard_smp_processor_id(cpuid);
-}
-#else
-static int irq_choose_cpu(const struct cpumask *mask)
-{
-	return hard_smp_processor_id();
-}
-#endif
-
 #define mpic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
 /* Find an mpic associated with a given linux interrupt */
-- 
1.7.3.4
