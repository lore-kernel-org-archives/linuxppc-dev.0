Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a78e4bb1b3a65314dd4bd0c253a0abf242bd34a6.1255499081.git.michael@ellerman.id.au>
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/6] powerpc: Remove get_irq_desc()
Date: Wed, 14 Oct 2009 16:44:51 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_irq_desc() is a powerpc-specific version of irq_to_desc(). That
is reason enough to remove it, but it also doesn't know about sparse
irq_desc support which irq_to_desc() does (when we enable it).

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/irq.h                  |    2 -
 arch/powerpc/kernel/crash.c                     |    2 +-
 arch/powerpc/kernel/irq.c                       |   28 ++++++++++++----------
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c  |    2 +-
 arch/powerpc/platforms/52xx/media5200.c         |    2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    2 +-
 arch/powerpc/platforms/86xx/gef_pic.c           |    2 +-
 arch/powerpc/platforms/cell/beat_interrupt.c    |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c        |    4 +-
 arch/powerpc/platforms/iseries/irq.c            |    2 +-
 arch/powerpc/platforms/powermac/pic.c           |    8 +++---
 arch/powerpc/platforms/pseries/xics.c           |    8 +++---
 arch/powerpc/sysdev/cpm1.c                      |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                  |   10 +++++---
 arch/powerpc/sysdev/fsl_msi.c                   |    2 +-
 arch/powerpc/sysdev/i8259.c                     |    4 +-
 arch/powerpc/sysdev/ipic.c                      |    2 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                |    2 +-
 arch/powerpc/sysdev/mpic.c                      |   18 +++++++-------
 arch/powerpc/sysdev/mv64x60_pic.c               |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c              |    4 +-
 arch/powerpc/sysdev/tsi108_pci.c                |    2 +-
 arch/powerpc/sysdev/uic.c                       |    6 ++--
 arch/powerpc/sysdev/xilinx_intc.c               |    2 +-
 25 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index b83fcc8..03dc28c 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -17,8 +17,6 @@
 #include <asm/atomic.h>
 
 
-#define get_irq_desc(irq) (&irq_desc[(irq)])
-
 /* Define a way to iterate across irqs. */
 #define for_each_irq(i) \
 	for ((i) = 0; (i) < NR_IRQS; ++(i))
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 0a8439a..6f4613d 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -373,7 +373,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	hard_irq_disable();
 
 	for_each_irq(i) {
-		struct irq_desc *desc = irq_desc + i;
+		struct irq_desc *desc = irq_to_desc(i);
 
 		if (desc->status & IRQ_INPROGRESS)
 			desc->chip->eoi(i);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e5d1211..6563221 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -190,7 +190,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 
 	if (i < NR_IRQS) {
-		desc = get_irq_desc(i);
+		desc = irq_to_desc(i);
 		spin_lock_irqsave(&desc->lock, flags);
 		action = desc->action;
 		if (!action || !action->handler)
@@ -230,23 +230,25 @@ skip:
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(cpumask_t map)
 {
+	struct irq_desc *desc;
 	unsigned int irq;
 	static int warned;
 
 	for_each_irq(irq) {
 		cpumask_t mask;
 
-		if (irq_desc[irq].status & IRQ_PER_CPU)
+		desc = irq_to_desc(irq);
+		if (desc && desc->status & IRQ_PER_CPU)
 			continue;
 
-		cpumask_and(&mask, irq_desc[irq].affinity, &map);
+		cpumask_and(&mask, desc->affinity, &map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			printk("Breaking affinity for irq %i\n", irq);
 			mask = map;
 		}
-		if (irq_desc[irq].chip->set_affinity)
-			irq_desc[irq].chip->set_affinity(irq, &mask);
-		else if (irq_desc[irq].action && !(warned++))
+		if (desc->chip->set_affinity)
+			desc->chip->set_affinity(irq, &mask);
+		else if (desc->action && !(warned++))
 			printk("Cannot set affinity for irq %i\n", irq);
 	}
 
@@ -273,7 +275,7 @@ static inline void handle_one_irq(unsigned int irq)
 		return;
 	}
 
-	desc = irq_desc + irq;
+	desc = irq_to_desc(irq);
 	saved_sp_limit = current->thread.ksp_limit;
 
 	irqtp->task = curtp->task;
@@ -535,7 +537,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 			smp_wmb();
 
 			/* Clear norequest flags */
-			get_irq_desc(i)->status &= ~IRQ_NOREQUEST;
+			irq_to_desc(i)->status &= ~IRQ_NOREQUEST;
 
 			/* Legacy flags are left to default at this point,
 			 * one can then use irq_create_mapping() to
@@ -602,7 +604,7 @@ static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
 	/* Clear IRQ_NOREQUEST flag */
-	get_irq_desc(virq)->status &= ~IRQ_NOREQUEST;
+	irq_to_desc(virq)->status &= ~IRQ_NOREQUEST;
 
 	/* map it */
 	smp_wmb();
@@ -732,7 +734,7 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
-	    type != (get_irq_desc(virq)->status & IRQF_TRIGGER_MASK))
+	    type != (irq_to_desc(virq)->status & IRQF_TRIGGER_MASK))
 		set_irq_type(virq, type);
 	return virq;
 }
@@ -804,7 +806,7 @@ void irq_dispose_mapping(unsigned int virq)
 	irq_map[virq].hwirq = host->inval_irq;
 
 	/* Set some flags */
-	get_irq_desc(virq)->status |= IRQ_NOREQUEST;
+	irq_to_desc(virq)->status |= IRQ_NOREQUEST;
 
 	/* Free it */
 	irq_free_virt(virq, 1);
@@ -1001,7 +1003,7 @@ void irq_early_init(void)
 	unsigned int i;
 
 	for (i = 0; i < NR_IRQS; i++)
-		get_irq_desc(i)->status |= IRQ_NOREQUEST;
+		irq_to_desc(i)->status |= IRQ_NOREQUEST;
 }
 
 /* We need to create the radix trees late */
@@ -1064,7 +1066,7 @@ static int virq_debug_show(struct seq_file *m, void *private)
 		      "chip name", "host name");
 
 	for (i = 1; i < NR_IRQS; i++) {
-		desc = get_irq_desc(i);
+		desc = irq_to_desc(i);
 		spin_lock_irqsave(&desc->lock, flags);
 
 		if (desc->action && desc->action->handler) {
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index a6ce805..cd70ee1 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -132,7 +132,7 @@ static int
 cpld_pic_host_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &cpld_pic, handle_level_irq);
 	return 0;
 }
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 68e4f16..4780203 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -114,7 +114,7 @@ void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 static int media5200_irq_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 
 	pr_debug("%s: h=%p, virq=%i, hwirq=%i\n", __func__, h, virq, (int)hw);
 	set_irq_chip_data(virq, &media5200_irq);
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 7ee979f..a682331 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -107,7 +107,7 @@ static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
 			    irq_hw_number_t hw)
 {
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
 	return 0;
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 60edf63..e59920a 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -245,7 +245,7 @@ static int socrates_fpga_pic_host_map(struct irq_host *h, unsigned int virq,
 		irq_hw_number_t hwirq)
 {
 	/* All interrupts are LEVEL sensitive */
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &socrates_fpga_pic_chip,
 			handle_fasteoi_irq);
 
diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
index 50d0a2b..978d6cb 100644
--- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -163,7 +163,7 @@ static int gef_pic_host_map(struct irq_host *h, unsigned int virq,
 			  irq_hw_number_t hwirq)
 {
 	/* All interrupts are LEVEL sensitive */
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);
 
 	return 0;
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index 7225484..4a2bbff 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -136,7 +136,7 @@ static void beatic_pic_host_unmap(struct irq_host *h, unsigned int virq)
 static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
 			       irq_hw_number_t hw)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	int64_t	err;
 
 	err = beat_construct_and_connect_irq_plug(virq, hw);
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 4e56556..9dd63c5 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -102,7 +102,7 @@ static void spider_ack_irq(unsigned int virq)
 
 	/* Reset edge detection logic if necessary
 	 */
-	if (get_irq_desc(virq)->status & IRQ_LEVEL)
+	if (irq_to_desc(virq)->status & IRQ_LEVEL)
 		return;
 
 	/* Only interrupts 47 to 50 can be set to edge */
@@ -119,7 +119,7 @@ static int spider_set_irq_type(unsigned int virq, unsigned int type)
 	struct spider_pic *pic = spider_virq_to_pic(virq);
 	unsigned int hw = irq_map[virq].hwirq;
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	u32 old_mask;
 	u32 ic;
 
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 94f4447..f8446ea 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -214,7 +214,7 @@ void __init iSeries_activate_IRQs()
 	unsigned long flags;
 
 	for_each_irq (irq) {
-		struct irq_desc *desc = get_irq_desc(irq);
+		struct irq_desc *desc = irq_to_desc(irq);
 
 		if (desc && desc->chip && desc->chip->startup) {
 			spin_lock_irqsave(&desc->lock, flags);
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index d212006..484d21e 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -152,12 +152,12 @@ static unsigned int pmac_startup_irq(unsigned int virq)
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
 
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
-	if ((irq_desc[virq].status & IRQ_LEVEL) == 0)
+	spin_lock_irqsave(&pmac_pic_lock, flags);
+	if ((irq_to_desc(virq)->status & IRQ_LEVEL) == 0)
 		out_le32(&pmac_irq_hw[i]->ack, bit);
         __set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 
 	return 0;
 }
@@ -285,7 +285,7 @@ static int pmac_pic_host_match(struct irq_host *h, struct device_node *node)
 static int pmac_pic_host_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	int level;
 
 	if (hw >= max_irqs)
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 419f8a6..75935ae 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -156,7 +156,7 @@ static int get_irq_server(unsigned int virq, unsigned int strict_check)
 	cpumask_t cpumask;
 	cpumask_t tmp = CPU_MASK_NONE;
 
-	cpumask_copy(&cpumask, irq_desc[virq].affinity);
+	cpumask_copy(&cpumask, irq_to_desc(virq)->affinity);
 	if (!distribute_irqs)
 		return default_server;
 
@@ -419,7 +419,7 @@ static int xics_host_map(struct irq_host *h, unsigned int virq,
 	/* Insert the interrupt mapping into the radix tree for fast lookup */
 	irq_radix_revmap_insert(xics_host, virq, hw);
 
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
 	return 0;
 }
@@ -843,7 +843,7 @@ void xics_migrate_irqs_away(void)
 		/* We need to get IPIs still. */
 		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 			continue;
-		desc = get_irq_desc(virq);
+		desc = irq_to_desc(virq);
 
 		/* We only need to migrate enabled IRQS */
 		if (desc == NULL || desc->chip == NULL
@@ -872,7 +872,7 @@ void xics_migrate_irqs_away(void)
 		       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		cpumask_setall(irq_desc[virq].affinity);
+		cpumask_setall(irq_to_desc(virq)->affinity);
 		desc->chip->set_affinity(virq, cpu_all_mask);
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 82424cd..5235373 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -102,7 +102,7 @@ static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
 {
 	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..722cf72 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -115,11 +115,13 @@ static void cpm2_ack(unsigned int virq)
 
 static void cpm2_end_irq(unsigned int virq)
 {
+	struct irq_desc *desc;
 	int	bit, word;
 	unsigned int irq_nr = virq_to_hw(virq);
 
-	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
-			&& irq_desc[irq_nr].action) {
+	desc = irq_to_desc(irq_nr);
+	if (!(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS))
+			&& desc->action) {
 
 		bit = irq_to_siubit[irq_nr];
 		word = irq_to_siureg[irq_nr];
@@ -138,7 +140,7 @@ static void cpm2_end_irq(unsigned int virq)
 static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	unsigned int src = virq_to_hw(virq);
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	unsigned int vold, vnew, edibit;
 
 	if (flow_type == IRQ_TYPE_NONE)
@@ -210,7 +212,7 @@ static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
 {
 	pr_debug("cpm2_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &cpm2_pic, handle_level_irq);
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index da38a1f..7174374 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -55,7 +55,7 @@ static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
 {
 	struct irq_chip *chip = &fsl_msi_chip;
 
-	get_irq_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
+	irq_to_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
 
 	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
 
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index a96584a..78ed945 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -175,12 +175,12 @@ static int i8259_host_map(struct irq_host *h, unsigned int virq,
 
 	/* We block the internal cascade */
 	if (hw == 2)
-		get_irq_desc(virq)->status |= IRQ_NOREQUEST;
+		irq_to_desc(virq)->status |= IRQ_NOREQUEST;
 
 	/* We use the level handler only for now, we might want to
 	 * be more cautious here but that works for now
 	 */
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &i8259_pic, handle_level_irq);
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index cb7689c..f042c1d 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -605,7 +605,7 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	struct ipic *ipic = ipic_from_irq(virq);
 	unsigned int src = ipic_irq_to_hw(virq);
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	unsigned int vold, vnew, edibit;
 
 	if (flow_type == IRQ_TYPE_NONE)
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 5d2d552..0117958 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -72,7 +72,7 @@ static void mpc8xx_end_irq(unsigned int virq)
 
 static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 30c44e6..4fd57ab 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -572,7 +572,7 @@ static int irq_choose_cpu(unsigned int virt_irq)
 	cpumask_t mask;
 	int cpuid;
 
-	cpumask_copy(&mask, irq_desc[virt_irq].affinity);
+	cpumask_copy(&mask, irq_to_desc(virt_irq)->affinity);
 	if (cpus_equal(mask, CPU_MASK_ALL)) {
 		static int irq_rover;
 		static DEFINE_SPINLOCK(irq_rover_lock);
@@ -621,7 +621,7 @@ static struct mpic *mpic_find(unsigned int irq)
 	if (irq < NUM_ISA_INTERRUPTS)
 		return NULL;
 
-	return irq_desc[irq].chip_data;
+	return irq_to_desc(irq)->chip_data;
 }
 
 /* Determine if the linux irq is an IPI */
@@ -648,14 +648,14 @@ static inline u32 mpic_physmask(u32 cpumask)
 /* Get the mpic structure from the IPI number */
 static inline struct mpic * mpic_from_ipi(unsigned int ipi)
 {
-	return irq_desc[ipi].chip_data;
+	return irq_to_desc(ipi)->chip_data;
 }
 #endif
 
 /* Get the mpic structure from the irq number */
 static inline struct mpic * mpic_from_irq(unsigned int irq)
 {
-	return irq_desc[irq].chip_data;
+	return irq_to_desc(irq)->chip_data;
 }
 
 /* Send an EOI */
@@ -735,7 +735,7 @@ static void mpic_unmask_ht_irq(unsigned int irq)
 
 	mpic_unmask_irq(irq);
 
-	if (irq_desc[irq].status & IRQ_LEVEL)
+	if (irq_to_desc(irq)->status & IRQ_LEVEL)
 		mpic_ht_end_irq(mpic, src);
 }
 
@@ -745,7 +745,7 @@ static unsigned int mpic_startup_ht_irq(unsigned int irq)
 	unsigned int src = mpic_irq_to_hw(irq);
 
 	mpic_unmask_irq(irq);
-	mpic_startup_ht_interrupt(mpic, src, irq_desc[irq].status);
+	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
 
 	return 0;
 }
@@ -755,7 +755,7 @@ static void mpic_shutdown_ht_irq(unsigned int irq)
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
 
-	mpic_shutdown_ht_interrupt(mpic, src, irq_desc[irq].status);
+	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
 	mpic_mask_irq(irq);
 }
 
@@ -772,7 +772,7 @@ static void mpic_end_ht_irq(unsigned int irq)
 	 * latched another edge interrupt coming in anyway
 	 */
 
-	if (irq_desc[irq].status & IRQ_LEVEL)
+	if (irq_to_desc(irq)->status & IRQ_LEVEL)
 		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
@@ -856,7 +856,7 @@ int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	struct mpic *mpic = mpic_from_irq(virq);
 	unsigned int src = mpic_irq_to_hw(virq);
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	unsigned int vecpri, vold, vnew;
 
 	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 2aa4ed0..485b924 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -213,7 +213,7 @@ static int mv64x60_host_map(struct irq_host *h, unsigned int virq,
 {
 	int level1;
 
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 
 	level1 = (hwirq & MV64x60_LEVEL1_MASK) >> MV64x60_LEVEL1_OFFSET;
 	BUG_ON(level1 > MV64x60_LEVEL1_GPP);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 3faa42e..fc09874 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -189,7 +189,7 @@ static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
 {
-	return irq_desc[virq].chip_data;
+	return irq_to_desc(virq)->chip_data;
 }
 
 #define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
@@ -263,7 +263,7 @@ static int qe_ic_host_map(struct irq_host *h, unsigned int virq,
 	chip = &qe_ic->hc_irq;
 
 	set_irq_chip_data(virq, qe_ic);
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 
 	set_irq_chip_and_handler(virq, chip, handle_level_irq);
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index cf244a4..02f6009 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -398,7 +398,7 @@ static int pci_irq_host_map(struct irq_host *h, unsigned int virq,
 	DBG("%s(%d, 0x%lx)\n", __func__, virq, hw);
 	if ((virq >= 1) && (virq <= 4)){
 		irq = virq + IRQ_PCI_INTAD_BASE - 1;
-		get_irq_desc(irq)->status |= IRQ_LEVEL;
+		irq_to_desc(irq)->status |= IRQ_LEVEL;
 		set_irq_chip(irq, &tsi108_pci_irq);
 	}
 	return 0;
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 466ce9a..cf97935 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -57,7 +57,7 @@ struct uic {
 
 static void uic_unmask_irq(unsigned int virq)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	struct uic *uic = get_irq_chip_data(virq);
 	unsigned int src = uic_irq_to_hw(virq);
 	unsigned long flags;
@@ -101,7 +101,7 @@ static void uic_ack_irq(unsigned int virq)
 
 static void uic_mask_ack_irq(unsigned int virq)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	struct uic *uic = get_irq_chip_data(virq);
 	unsigned int src = uic_irq_to_hw(virq);
 	unsigned long flags;
@@ -129,7 +129,7 @@ static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	struct uic *uic = get_irq_chip_data(virq);
 	unsigned int src = uic_irq_to_hw(virq);
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 	unsigned long flags;
 	int trigger, polarity;
 	u32 tr, pr, mask;
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 40edad5..ab74371 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -79,7 +79,7 @@ static void xilinx_intc_mask(unsigned int virq)
 
 static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
+	struct irq_desc *desc = irq_to_desc(virq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-- 
1.6.2.1
