Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	by ozlabs.org (Postfix) with ESMTP id 2DC31B7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 00:16:13 +1100 (EST)
Date: Fri, 11 Feb 2011 13:52:13 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: irq_data conversion
Message-ID: <20110211125213.GE1240@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, glikely@secretlab.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts powerpc over to the new irq_data based irq_chip
functions, as was done earlier for ARM and some other architectures.

struct irq_data is described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ff7dcd44dd446db2c3e13bdedf2d52b8e0127f16

The new irq_chip functions are described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8822657e799b02c55556c99a601261e207a299d

As I don't have powerpc hardware myself, this hasn't been well-tested
at all -- build and run-time testing would be much appreciated.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/Kconfig                             |    1 +
 arch/powerpc/include/asm/mpic.h                  |    6 +-
 arch/powerpc/include/asm/qe_ic.h                 |   19 ++--
 arch/powerpc/kernel/irq.c                        |   23 +++--
 arch/powerpc/kernel/machine_kexec.c              |   21 ++--
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   14 ++--
 arch/powerpc/platforms/52xx/media5200.c          |   21 ++--
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        |   26 +++---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |   80 +++++++-------
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |   27 +++---
 arch/powerpc/platforms/85xx/ksi8560.c            |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c        |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c         |    3 +-
 arch/powerpc/platforms/85xx/sbc8560.c            |    3 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  |   40 ++++----
 arch/powerpc/platforms/85xx/stx_gp3.c            |    3 +-
 arch/powerpc/platforms/85xx/tqm85xx.c            |    3 +-
 arch/powerpc/platforms/86xx/gef_pic.c            |   22 ++--
 arch/powerpc/platforms/86xx/pic.c                |    5 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c          |    9 ++-
 arch/powerpc/platforms/cell/axon_msi.c           |    3 +-
 arch/powerpc/platforms/cell/beat_interrupt.c     |   36 +++---
 arch/powerpc/platforms/cell/interrupt.c          |   30 +++---
 arch/powerpc/platforms/cell/setup.c              |    6 +-
 arch/powerpc/platforms/cell/spider-pic.c         |   43 ++++----
 arch/powerpc/platforms/chrp/setup.c              |    5 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |   32 +++---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |   41 ++++----
 arch/powerpc/platforms/iseries/irq.c             |   43 ++++----
 arch/powerpc/platforms/powermac/pic.c            |   48 +++++----
 arch/powerpc/platforms/ps3/interrupt.c           |   28 +++---
 arch/powerpc/platforms/pseries/setup.c           |    5 +-
 arch/powerpc/platforms/pseries/xics.c            |   75 +++++++------
 arch/powerpc/sysdev/cpm1.c                       |   18 ++--
 arch/powerpc/sysdev/cpm2_pic.c                   |   32 +++---
 arch/powerpc/sysdev/fsl_msi.c                    |   19 ++--
 arch/powerpc/sysdev/i8259.c                      |   42 ++++----
 arch/powerpc/sysdev/ipic.c                       |   54 +++++-----
 arch/powerpc/sysdev/mpc8xx_pic.c                 |   32 +++---
 arch/powerpc/sysdev/mpc8xxx_gpio.c               |   42 ++++----
 arch/powerpc/sysdev/mpic.c                       |  127 +++++++++++-----------
 arch/powerpc/sysdev/mpic.h                       |    5 +-
 arch/powerpc/sysdev/mpic_pasemi_msi.c            |   18 ++--
 arch/powerpc/sysdev/mpic_u3msi.c                 |   18 ++--
 arch/powerpc/sysdev/mv64x60_pic.c                |   46 ++++----
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |   20 ++--
 arch/powerpc/sysdev/tsi108_pci.c                 |   41 ++++----
 arch/powerpc/sysdev/uic.c                        |   59 +++++-----
 arch/powerpc/sysdev/xilinx_intc.c                |   48 +++++----
 49 files changed, 705 insertions(+), 643 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7d69e9b..71ba047 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
 	select IRQ_PER_CPU
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e000cce..946ec49 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -467,11 +467,11 @@ extern void mpic_request_ipis(void);
 void smp_mpic_message_pass(int target, int msg);
 
 /* Unmask a specific virq */
-extern void mpic_unmask_irq(unsigned int irq);
+extern void mpic_unmask_irq(struct irq_data *d);
 /* Mask a specific virq */
-extern void mpic_mask_irq(unsigned int irq);
+extern void mpic_mask_irq(struct irq_data *d);
 /* EOI a specific virq */
-extern void mpic_end_irq(unsigned int irq);
+extern void mpic_end_irq(struct irq_data *d);
 
 /* Fetch interrupt from a given mpic */
 extern unsigned int mpic_get_one_irq(struct mpic *mpic);
diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index cf51966..9e2cb20 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -81,7 +81,7 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -91,7 +91,7 @@ static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -101,32 +101,35 @@ static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 static inline void qe_ic_cascade_low_mpic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_high_mpic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
 					    struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
 	if (cascade_irq == NO_IRQ)
@@ -135,7 +138,7 @@ static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* _ASM_POWERPC_QE_IC_H */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ce557f6..4a9fa84 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -237,6 +237,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	int i = *(loff_t *) v, j, prec;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	struct irq_chip *chip;
 
 	if (i > nr_irqs)
 		return 0;
@@ -270,8 +271,9 @@ int show_interrupts(struct seq_file *p, void *v)
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 
-	if (desc->chip)
-		seq_printf(p, "  %-16s", desc->chip->name);
+	chip = get_irq_desc_chip(desc);
+	if (chip)
+		seq_printf(p, "  %-16s", chip->name);
 	else
 		seq_printf(p, "  %-16s", "None");
 	seq_printf(p, " %-8s", (desc->status & IRQ_LEVEL) ? "Level" : "Edge");
@@ -313,6 +315,8 @@ void fixup_irqs(const struct cpumask *map)
 	alloc_cpumask_var(&mask, GFP_KERNEL);
 
 	for_each_irq(irq) {
+		struct irq_chip *chip;
+
 		desc = irq_to_desc(irq);
 		if (!desc)
 			continue;
@@ -320,13 +324,15 @@ void fixup_irqs(const struct cpumask *map)
 		if (desc->status & IRQ_PER_CPU)
 			continue;
 
-		cpumask_and(mask, desc->affinity, map);
+		chip = get_irq_desc_chip(desc);
+
+		cpumask_and(mask, desc->irq_data.affinity, map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			printk("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
 		}
-		if (desc->chip->set_affinity)
-			desc->chip->set_affinity(irq, mask);
+		if (chip->irq_set_affinity)
+			chip->irq_set_affinity(&desc->irq_data, mask, true);
 		else if (desc->action && !(warned++))
 			printk("Cannot set affinity for irq %i\n", irq);
 	}
@@ -1159,11 +1165,14 @@ static int virq_debug_show(struct seq_file *m, void *private)
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
 		if (desc->action && desc->action->handler) {
+			struct irq_chip *chip;
+
 			seq_printf(m, "%5d  ", i);
 			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
 
-			if (desc->chip && desc->chip->name)
-				p = desc->chip->name;
+			chip = get_irq_desc_chip(desc);
+			if (chip && chip->name)
+				p = chip->name;
 			else
 				p = none;
 			seq_printf(m, "%-15s  ", p);
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 49a170a..976de37 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -26,20 +26,23 @@ void machine_kexec_mask_interrupts(void) {
 
 	for_each_irq(i) {
 		struct irq_desc *desc = irq_to_desc(i);
+		struct irq_chip *chip;
 
-		if (!desc || !desc->chip)
+		if (!desc)
 			continue;
 
-		if (desc->chip->eoi &&
-		    desc->status & IRQ_INPROGRESS)
-			desc->chip->eoi(i);
+		chip = get_irq_desc_chip(desc);
+		if (!chip)
+			continue;
+
+		if (chip->irq_eoi && desc->status & IRQ_INPROGRESS)
+			chip->irq_eoi(&desc->irq_data);
 
-		if (desc->chip->mask)
-			desc->chip->mask(i);
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
 
-		if (desc->chip->disable &&
-		    !(desc->status & IRQ_DISABLED))
-			desc->chip->disable(i);
+		if (chip->irq_disable && !(desc->status & IRQ_DISABLED))
+			chip->irq_disable(&desc->irq_data);
 	}
 }
 
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index 4ecf4cf..fde0ea5 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -59,9 +59,9 @@ irq_to_pic_bit(unsigned int irq)
 }
 
 static void
-cpld_mask_irq(unsigned int irq)
+cpld_mask_irq(struct irq_data *d)
 {
-	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpld_irq = (unsigned int)irq_map[d->irq].hwirq;
 	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
 
 	out_8(pic_mask,
@@ -69,9 +69,9 @@ cpld_mask_irq(unsigned int irq)
 }
 
 static void
-cpld_unmask_irq(unsigned int irq)
+cpld_unmask_irq(struct irq_data *d)
 {
-	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpld_irq = (unsigned int)irq_map[d->irq].hwirq;
 	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
 
 	out_8(pic_mask,
@@ -80,9 +80,9 @@ cpld_unmask_irq(unsigned int irq)
 
 static struct irq_chip cpld_pic = {
 	.name = "CPLD PIC",
-	.mask = cpld_mask_irq,
-	.ack = cpld_mask_irq,
-	.unmask = cpld_unmask_irq,
+	.irq_mask = cpld_mask_irq,
+	.irq_ack = cpld_mask_irq,
+	.irq_unmask = cpld_unmask_irq,
 };
 
 static int
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 2c7780c..2bd1e6c 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -49,45 +49,46 @@ struct media5200_irq {
 };
 struct media5200_irq media5200_irq;
 
-static void media5200_irq_unmask(unsigned int virq)
+static void media5200_irq_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&media5200_irq.lock, flags);
 	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
-	val |= 1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq);
+	val |= 1 << (MEDIA5200_IRQ_SHIFT + irq_map[d->irq].hwirq);
 	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
 	spin_unlock_irqrestore(&media5200_irq.lock, flags);
 }
 
-static void media5200_irq_mask(unsigned int virq)
+static void media5200_irq_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&media5200_irq.lock, flags);
 	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
-	val &= ~(1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq));
+	val &= ~(1 << (MEDIA5200_IRQ_SHIFT + irq_map[d->irq].hwirq));
 	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
 	spin_unlock_irqrestore(&media5200_irq.lock, flags);
 }
 
 static struct irq_chip media5200_irq_chip = {
 	.name = "Media5200 FPGA",
-	.unmask = media5200_irq_unmask,
-	.mask = media5200_irq_mask,
-	.mask_ack = media5200_irq_mask,
+	.irq_unmask = media5200_irq_unmask,
+	.irq_mask = media5200_irq_mask,
+	.irq_mask_ack = media5200_irq_mask,
 };
 
 void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int sub_virq, val;
 	u32 status, enable;
 
 	/* Mask off the cascaded IRQ */
 	raw_spin_lock(&desc->lock);
-	desc->chip->mask(virq);
+	chip->irq_mask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 
 	/* Ask the FPGA for IRQ status.  If 'val' is 0, then no irqs
@@ -105,9 +106,9 @@ void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 
 	/* Processing done; can reenable the cascade now */
 	raw_spin_lock(&desc->lock);
-	desc->chip->ack(virq);
+	chip->irq_ack(&desc->irq_data);
 	if (!(desc->status & IRQ_DISABLED))
-		desc->chip->unmask(virq);
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index e0d703c..fe6cc5d 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -135,9 +135,9 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
  * Cascaded interrupt controller hooks
  */
 
-static void mpc52xx_gpt_irq_unmask(unsigned int virq)
+static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -145,9 +145,9 @@ static void mpc52xx_gpt_irq_unmask(unsigned int virq)
 	spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
-static void mpc52xx_gpt_irq_mask(unsigned int virq)
+static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -155,20 +155,20 @@ static void mpc52xx_gpt_irq_mask(unsigned int virq)
 	spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
-static void mpc52xx_gpt_irq_ack(unsigned int virq)
+static void mpc52xx_gpt_irq_ack(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 
 	out_be32(&gpt->regs->status, MPC52xx_GPT_STATUS_IRQMASK);
 }
 
-static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_gpt_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 	u32 reg;
 
-	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, virq, flow_type);
+	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, d->irq, flow_type);
 
 	spin_lock_irqsave(&gpt->lock, flags);
 	reg = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_ICT_MASK;
@@ -184,10 +184,10 @@ static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc52xx_gpt_irq_chip = {
 	.name = "MPC52xx GPT",
-	.unmask = mpc52xx_gpt_irq_unmask,
-	.mask = mpc52xx_gpt_irq_mask,
-	.ack = mpc52xx_gpt_irq_ack,
-	.set_type = mpc52xx_gpt_irq_set_type,
+	.irq_unmask = mpc52xx_gpt_irq_unmask,
+	.irq_mask = mpc52xx_gpt_irq_mask,
+	.irq_ack = mpc52xx_gpt_irq_ack,
+	.irq_set_type = mpc52xx_gpt_irq_set_type,
 };
 
 void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 4bf4bf7..9f3ed58 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -155,47 +155,47 @@ static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
 /*
  * IRQ[0-3] interrupt irq_chip
  */
-static void mpc52xx_extirq_mask(unsigned int virq)
+static void mpc52xx_extirq_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->ctrl, 11 - l2irq);
 }
 
-static void mpc52xx_extirq_unmask(unsigned int virq)
+static void mpc52xx_extirq_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->ctrl, 11 - l2irq);
 }
 
-static void mpc52xx_extirq_ack(unsigned int virq)
+static void mpc52xx_extirq_ack(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->ctrl, 27-l2irq);
 }
 
-static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_extirq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	u32 ctrl_reg, type;
 	int irq;
 	int l2irq;
 	void *handler = handle_level_irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
@@ -214,44 +214,44 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
 	out_be32(&intr->ctrl, ctrl_reg);
 
-	__set_irq_handler_unlocked(virq, handler);
+	__set_irq_handler_unlocked(d->irq, handler);
 
 	return 0;
 }
 
 static struct irq_chip mpc52xx_extirq_irqchip = {
 	.name = "MPC52xx External",
-	.mask = mpc52xx_extirq_mask,
-	.unmask = mpc52xx_extirq_unmask,
-	.ack = mpc52xx_extirq_ack,
-	.set_type = mpc52xx_extirq_set_type,
+	.irq_mask = mpc52xx_extirq_mask,
+	.irq_unmask = mpc52xx_extirq_unmask,
+	.irq_ack = mpc52xx_extirq_ack,
+	.irq_set_type = mpc52xx_extirq_set_type,
 };
 
 /*
  * Main interrupt irq_chip
  */
-static int mpc52xx_null_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_null_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	return 0; /* Do nothing so that the sense mask will get updated */
 }
 
-static void mpc52xx_main_mask(unsigned int virq)
+static void mpc52xx_main_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->main_mask, 16 - l2irq);
 }
 
-static void mpc52xx_main_unmask(unsigned int virq)
+static void mpc52xx_main_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->main_mask, 16 - l2irq);
@@ -259,32 +259,32 @@ static void mpc52xx_main_unmask(unsigned int virq)
 
 static struct irq_chip mpc52xx_main_irqchip = {
 	.name = "MPC52xx Main",
-	.mask = mpc52xx_main_mask,
-	.mask_ack = mpc52xx_main_mask,
-	.unmask = mpc52xx_main_unmask,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_main_mask,
+	.irq_mask_ack = mpc52xx_main_mask,
+	.irq_unmask = mpc52xx_main_unmask,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /*
  * Peripherals interrupt irq_chip
  */
-static void mpc52xx_periph_mask(unsigned int virq)
+static void mpc52xx_periph_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->per_mask, 31 - l2irq);
 }
 
-static void mpc52xx_periph_unmask(unsigned int virq)
+static void mpc52xx_periph_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->per_mask, 31 - l2irq);
@@ -292,43 +292,43 @@ static void mpc52xx_periph_unmask(unsigned int virq)
 
 static struct irq_chip mpc52xx_periph_irqchip = {
 	.name = "MPC52xx Peripherals",
-	.mask = mpc52xx_periph_mask,
-	.mask_ack = mpc52xx_periph_mask,
-	.unmask = mpc52xx_periph_unmask,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_periph_mask,
+	.irq_mask_ack = mpc52xx_periph_mask,
+	.irq_unmask = mpc52xx_periph_unmask,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /*
  * SDMA interrupt irq_chip
  */
-static void mpc52xx_sdma_mask(unsigned int virq)
+static void mpc52xx_sdma_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&sdma->IntMask, l2irq);
 }
 
-static void mpc52xx_sdma_unmask(unsigned int virq)
+static void mpc52xx_sdma_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&sdma->IntMask, l2irq);
 }
 
-static void mpc52xx_sdma_ack(unsigned int virq)
+static void mpc52xx_sdma_ack(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	out_be32(&sdma->IntPend, 1 << l2irq);
@@ -336,10 +336,10 @@ static void mpc52xx_sdma_ack(unsigned int virq)
 
 static struct irq_chip mpc52xx_sdma_irqchip = {
 	.name = "MPC52xx SDMA",
-	.mask = mpc52xx_sdma_mask,
-	.unmask = mpc52xx_sdma_unmask,
-	.ack = mpc52xx_sdma_ack,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_sdma_mask,
+	.irq_unmask = mpc52xx_sdma_unmask,
+	.irq_ack = mpc52xx_sdma_ack,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /**
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 5a55d87..a0cd8ae 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -39,10 +39,10 @@ struct pq2ads_pci_pic {
 
 #define NUM_IRQS 32
 
-static void pq2ads_pci_mask_irq(unsigned int virq)
+static void pq2ads_pci_mask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
-	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(d->irq);
+	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
 		unsigned long flags;
@@ -55,10 +55,10 @@ static void pq2ads_pci_mask_irq(unsigned int virq)
 	}
 }
 
-static void pq2ads_pci_unmask_irq(unsigned int virq)
+static void pq2ads_pci_unmask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
-	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(d->irq);
+	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
 		unsigned long flags;
@@ -71,18 +71,17 @@ static void pq2ads_pci_unmask_irq(unsigned int virq)
 
 static struct irq_chip pq2ads_pci_ic = {
 	.name = "PQ2 ADS PCI",
-	.end = pq2ads_pci_unmask_irq,
-	.mask = pq2ads_pci_mask_irq,
-	.mask_ack = pq2ads_pci_mask_irq,
-	.ack = pq2ads_pci_mask_irq,
-	.unmask = pq2ads_pci_unmask_irq,
-	.enable = pq2ads_pci_unmask_irq,
-	.disable = pq2ads_pci_mask_irq
+	.irq_mask = pq2ads_pci_mask_irq,
+	.irq_mask_ack = pq2ads_pci_mask_irq,
+	.irq_ack = pq2ads_pci_mask_irq,
+	.irq_unmask = pq2ads_pci_unmask_irq,
+	.irq_enable = pq2ads_pci_unmask_irq,
+	.irq_disable = pq2ads_pci_mask_irq
 };
 
 static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct pq2ads_pci_pic *priv = desc->handler_data;
+	struct pq2ads_pci_pic *priv = get_irq_desc_data(desc);
 	u32 stat, mask, pend;
 	int bit;
 
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index f4d36b5..64447e4 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -56,12 +56,13 @@ static void machine_restart(char *cmd)
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init ksi8560_pic_init(void)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 9438a89..1352d11 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -50,12 +50,13 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* CONFIG_CPM2 */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 8190bc2..793ead7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -47,12 +47,13 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ) {
 		generic_handle_irq(cascade_irq);
 	}
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif	/* CONFIG_PPC_I8259 */
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index a5ad1c7..d7e28ec 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -41,12 +41,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* CONFIG_CPM2 */
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index d48527f..79d85ac 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -93,6 +93,7 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 
 void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -103,17 +104,16 @@ void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
-
+	chip->irq_eoi(&desc->irq_data);
 }
 
-static void socrates_fpga_pic_ack(unsigned int virq)
+static void socrates_fpga_pic_ack(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq, irq_line;
 	uint32_t mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -124,14 +124,14 @@ static void socrates_fpga_pic_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_mask(unsigned int virq)
+static void socrates_fpga_pic_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -142,14 +142,14 @@ static void socrates_fpga_pic_mask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_mask_ack(unsigned int virq)
+static void socrates_fpga_pic_mask_ack(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -161,14 +161,14 @@ static void socrates_fpga_pic_mask_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_unmask(unsigned int virq)
+static void socrates_fpga_pic_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -179,14 +179,14 @@ static void socrates_fpga_pic_unmask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_eoi(unsigned int virq)
+static void socrates_fpga_pic_eoi(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -197,7 +197,7 @@ static void socrates_fpga_pic_eoi(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static int socrates_fpga_pic_set_type(unsigned int virq,
+static int socrates_fpga_pic_set_type(struct irq_data *d,
 		unsigned int flow_type)
 {
 	unsigned long flags;
@@ -205,7 +205,7 @@ static int socrates_fpga_pic_set_type(unsigned int virq,
 	int polarity;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	if (fpga_irqs[hwirq].type != IRQ_TYPE_NONE)
 		return -EINVAL;
@@ -233,12 +233,12 @@ static int socrates_fpga_pic_set_type(unsigned int virq,
 
 static struct irq_chip socrates_fpga_pic_chip = {
 	.name		= "FPGA-PIC",
-	.ack		= socrates_fpga_pic_ack,
-	.mask           = socrates_fpga_pic_mask,
-	.mask_ack       = socrates_fpga_pic_mask_ack,
-	.unmask         = socrates_fpga_pic_unmask,
-	.eoi		= socrates_fpga_pic_eoi,
-	.set_type	= socrates_fpga_pic_set_type,
+	.irq_ack	= socrates_fpga_pic_ack,
+	.irq_mask	= socrates_fpga_pic_mask,
+	.irq_mask_ack	= socrates_fpga_pic_mask_ack,
+	.irq_unmask	= socrates_fpga_pic_unmask,
+	.irq_eoi	= socrates_fpga_pic_eoi,
+	.irq_set_type	= socrates_fpga_pic_set_type,
 };
 
 static int socrates_fpga_pic_host_map(struct irq_host *h, unsigned int virq,
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index bc33d18..2b62b06 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -46,12 +46,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif /* CONFIG_CPM2 */
 
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 5e847d0..2265b68 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -44,12 +44,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif /* CONFIG_CPM2 */
 
diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
index 6df9e25..0adfe3b 100644
--- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -95,6 +95,7 @@ static int gef_pic_cascade_irq;
 
 void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -106,17 +107,16 @@ void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
-
+	chip->irq_eoi(&desc->irq_data);
 }
 
-static void gef_pic_mask(unsigned int virq)
+static void gef_pic_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	u32 mask;
 
-	hwirq = gef_irq_to_hw(virq);
+	hwirq = gef_irq_to_hw(d->irq);
 
 	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
@@ -125,21 +125,21 @@ static void gef_pic_mask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&gef_pic_lock, flags);
 }
 
-static void gef_pic_mask_ack(unsigned int virq)
+static void gef_pic_mask_ack(struct irq_data *d)
 {
 	/* Don't think we actually have to do anything to ack an interrupt,
 	 * we just need to clear down the devices interrupt and it will go away
 	 */
-	gef_pic_mask(virq);
+	gef_pic_mask(d);
 }
 
-static void gef_pic_unmask(unsigned int virq)
+static void gef_pic_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	u32 mask;
 
-	hwirq = gef_irq_to_hw(virq);
+	hwirq = gef_irq_to_hw(d->irq);
 
 	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
@@ -150,9 +150,9 @@ static void gef_pic_unmask(unsigned int virq)
 
 static struct irq_chip gef_pic_chip = {
 	.name		= "gefp",
-	.mask		= gef_pic_mask,
-	.mask_ack	= gef_pic_mask_ack,
-	.unmask		= gef_pic_unmask,
+	.irq_mask	= gef_pic_mask,
+	.irq_mask_ack	= gef_pic_mask_ack,
+	.irq_unmask	= gef_pic_unmask,
 };
 
 
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 668275d..cbe3363 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -19,10 +19,13 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif	/* CONFIG_PPC_I8259 */
 
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 60168c1..fabb108 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -218,15 +218,20 @@ void mpc8xx_restart(char *cmd)
 
 static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip;
 	int cascade_irq;
 
 	if ((cascade_irq = cpm_get_irq()) >= 0) {
 		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
 
 		generic_handle_irq(cascade_irq);
-		cdesc->chip->eoi(cascade_irq);
+
+		chip = get_irq_desc_chip(cdesc);
+		chip->irq_eoi(&cdesc->irq_data);
 	}
-	desc->chip->eoi(irq);
+
+	chip = get_irq_desc_chip(desc);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /* Initialize the internal interrupt controllers.  The number of
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index e3e379c..c07930f 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -93,6 +93,7 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct axon_msic *msic = get_irq_data(irq);
 	u32 write_offset, msi;
 	int idx;
@@ -145,7 +146,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		msic->read_offset &= MSIC_FIFO_SIZE_MASK;
 	}
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static struct axon_msic *find_msi_translator(struct pci_dev *dev)
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index 682af97..0b8f7d7 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -61,59 +61,59 @@ static inline void beatic_update_irq_mask(unsigned int irq_plug)
 		panic("Failed to set mask IRQ!");
 }
 
-static void beatic_mask_irq(unsigned int irq_plug)
+static void beatic_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_enable[d->irq/64] &= ~(1UL << (63 - (d->irq%64)));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_unmask_irq(unsigned int irq_plug)
+static void beatic_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_enable[d->irq/64] |= 1UL << (63 - (d->irq%64));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_ack_irq(unsigned int irq_plug)
+static void beatic_ack_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_ack[d->irq/64] &= ~(1UL << (63 - (d->irq%64)));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_end_irq(unsigned int irq_plug)
+static void beatic_end_irq(struct irq_data *d)
 {
 	s64 err;
 	unsigned long flags;
 
-	err = beat_downcount_of_interrupt(irq_plug);
+	err = beat_downcount_of_interrupt(d->irq);
 	if (err != 0) {
 		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
 			panic("Failed to downcount IRQ! Error = %16llx", err);
 
-		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
+		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", d->irq);
 	}
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_ack[d->irq/64] |= 1UL << (63 - (d->irq%64));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static struct irq_chip beatic_pic = {
 	.name = "CELL-BEAT",
-	.unmask = beatic_unmask_irq,
-	.mask = beatic_mask_irq,
-	.eoi = beatic_end_irq,
+	.irq_unmask = beatic_unmask_irq,
+	.irq_mask = beatic_mask_irq,
+	.irq_eoi = beatic_end_irq,
 };
 
 /*
@@ -232,7 +232,7 @@ unsigned int beatic_get_irq(void)
 
 	ret = beatic_get_irq_plug();
 	if (ret != NO_IRQ)
-		beatic_ack_irq(ret);
+		beatic_ack_irq(irq_get_irq_data(ret));
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 10eb1a4..624d26e 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -72,15 +72,15 @@ static irq_hw_number_t iic_pending_to_hwnum(struct cbe_iic_pending_bits bits)
 		return (node << IIC_IRQ_NODE_SHIFT) | (class << 4) | unit;
 }
 
-static void iic_mask(unsigned int irq)
+static void iic_mask(struct irq_data *d)
 {
 }
 
-static void iic_unmask(unsigned int irq)
+static void iic_unmask(struct irq_data *d)
 {
 }
 
-static void iic_eoi(unsigned int irq)
+static void iic_eoi(struct irq_data *d)
 {
 	struct iic *iic = &__get_cpu_var(cpu_iic);
 	out_be64(&iic->regs->prio, iic->eoi_stack[--iic->eoi_ptr]);
@@ -89,19 +89,21 @@ static void iic_eoi(unsigned int irq)
 
 static struct irq_chip iic_chip = {
 	.name = "CELL-IIC",
-	.mask = iic_mask,
-	.unmask = iic_unmask,
-	.eoi = iic_eoi,
+	.irq_mask = iic_mask,
+	.irq_unmask = iic_unmask,
+	.irq_eoi = iic_eoi,
 };
 
 
-static void iic_ioexc_eoi(unsigned int irq)
+static void iic_ioexc_eoi(struct irq_data *d)
 {
 }
 
 static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct cbe_iic_regs __iomem *node_iic = (void __iomem *)desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct cbe_iic_regs __iomem *node_iic =
+		(void __iomem *)get_irq_desc_data(desc);
 	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
 	unsigned long bits, ack;
 	int cascade;
@@ -128,15 +130,15 @@ static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 		if (ack)
 			out_be64(&node_iic->iic_is, ack);
 	}
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 
 static struct irq_chip iic_ioexc_chip = {
 	.name = "CELL-IOEX",
-	.mask = iic_mask,
-	.unmask = iic_unmask,
-	.eoi = iic_ioexc_eoi,
+	.irq_mask = iic_mask,
+	.irq_unmask = iic_unmask,
+	.irq_eoi = iic_ioexc_eoi,
 };
 
 /* Get an IRQ number from the pending state register of the IIC */
@@ -237,6 +239,8 @@ extern int noirqdebug;
 
 static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+
 	raw_spin_lock(&desc->lock);
 
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
@@ -275,7 +279,7 @@ static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 
 	desc->status &= ~IRQ_INPROGRESS;
 out_eoi:
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 6919957..6a28d02 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -187,13 +187,15 @@ machine_subsys_initcall(cell, cell_publish_devices);
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct mpic *mpic = desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct mpic *mpic = get_irq_desc_data(desc);
 	unsigned int virq;
 
 	virq = mpic_get_one_irq(mpic);
 	if (virq != NO_IRQ)
 		generic_handle_irq(virq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init mpic_init_IRQ(void)
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 3f2e557..b38cdfc 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -79,30 +79,30 @@ static void __iomem *spider_get_irq_config(struct spider_pic *pic,
 	return pic->regs + TIR_CFGA + 8 * src;
 }
 
-static void spider_unmask_irq(unsigned int virq)
+static void spider_unmask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	void __iomem *cfg = spider_get_irq_config(pic, irq_map[d->irq].hwirq);
 
 	out_be32(cfg, in_be32(cfg) | 0x30000000u);
 }
 
-static void spider_mask_irq(unsigned int virq)
+static void spider_mask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	void __iomem *cfg = spider_get_irq_config(pic, irq_map[d->irq].hwirq);
 
 	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
 }
 
-static void spider_ack_irq(unsigned int virq)
+static void spider_ack_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	unsigned int src = irq_map[virq].hwirq;
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	/* Reset edge detection logic if necessary
 	 */
-	if (irq_to_desc(virq)->status & IRQ_LEVEL)
+	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
 		return;
 
 	/* Only interrupts 47 to 50 can be set to edge */
@@ -113,13 +113,13 @@ static void spider_ack_irq(unsigned int virq)
 	out_be32(pic->regs + TIR_EDC, 0x100 | (src & 0xf));
 }
 
-static int spider_set_irq_type(unsigned int virq, unsigned int type)
+static int spider_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	unsigned int hw = irq_map[virq].hwirq;
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	unsigned int hw = irq_map[d->irq].hwirq;
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	u32 old_mask;
 	u32 ic;
 
@@ -169,10 +169,10 @@ static int spider_set_irq_type(unsigned int virq, unsigned int type)
 
 static struct irq_chip spider_pic = {
 	.name = "SPIDER",
-	.unmask = spider_unmask_irq,
-	.mask = spider_mask_irq,
-	.ack = spider_ack_irq,
-	.set_type = spider_set_irq_type,
+	.irq_unmask = spider_unmask_irq,
+	.irq_mask = spider_mask_irq,
+	.irq_ack = spider_ack_irq,
+	.irq_set_type = spider_set_irq_type,
 };
 
 static int spider_host_map(struct irq_host *h, unsigned int virq,
@@ -207,7 +207,8 @@ static struct irq_host_ops spider_host_ops = {
 
 static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct spider_pic *pic = desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct spider_pic *pic = get_irq_desc_data(desc);
 	unsigned int cs, virq;
 
 	cs = in_be32(pic->regs + TIR_CS) >> 24;
@@ -215,9 +216,11 @@ static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
 		virq = NO_IRQ;
 	else
 		virq = irq_linear_revmap(pic->host, cs);
+
 	if (virq != NO_IRQ)
 		generic_handle_irq(virq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /* For hooking up the cascace we have a problem. Our device-tree is
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 8553cc4..4c12884 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -365,10 +365,13 @@ void __init chrp_setup_arch(void)
 
 static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /*
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index c278bd3..d7287e8 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -46,10 +46,10 @@
  *
  */
 
-static void flipper_pic_mask_and_ack(unsigned int virq)
+static void flipper_pic_mask_and_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + FLIPPER_IMR, mask);
@@ -57,27 +57,27 @@ static void flipper_pic_mask_and_ack(unsigned int virq)
 	out_be32(io_base + FLIPPER_ICR, mask);
 }
 
-static void flipper_pic_ack(unsigned int virq)
+static void flipper_pic_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	/* this is at least needed for RSW */
 	out_be32(io_base + FLIPPER_ICR, 1 << irq);
 }
 
-static void flipper_pic_mask(unsigned int virq)
+static void flipper_pic_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	clrbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
 
-static void flipper_pic_unmask(unsigned int virq)
+static void flipper_pic_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	setbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
@@ -85,10 +85,10 @@ static void flipper_pic_unmask(unsigned int virq)
 
 static struct irq_chip flipper_pic = {
 	.name		= "flipper-pic",
-	.ack		= flipper_pic_ack,
-	.mask_ack	= flipper_pic_mask_and_ack,
-	.mask		= flipper_pic_mask,
-	.unmask		= flipper_pic_unmask,
+	.irq_ack	= flipper_pic_ack,
+	.irq_mask_ack	= flipper_pic_mask_and_ack,
+	.irq_mask	= flipper_pic_mask,
+	.irq_unmask	= flipper_pic_unmask,
 };
 
 /*
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index a771f91..c6f5fd6 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -41,36 +41,36 @@
  *
  */
 
-static void hlwd_pic_mask_and_ack(unsigned int virq)
+static void hlwd_pic_mask_and_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + HW_BROADWAY_IMR, mask);
 	out_be32(io_base + HW_BROADWAY_ICR, mask);
 }
 
-static void hlwd_pic_ack(unsigned int virq)
+static void hlwd_pic_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	out_be32(io_base + HW_BROADWAY_ICR, 1 << irq);
 }
 
-static void hlwd_pic_mask(unsigned int virq)
+static void hlwd_pic_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	clrbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
 
-static void hlwd_pic_unmask(unsigned int virq)
+static void hlwd_pic_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = get_irq_chip_data(d->irq);
 
 	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
@@ -78,10 +78,10 @@ static void hlwd_pic_unmask(unsigned int virq)
 
 static struct irq_chip hlwd_pic = {
 	.name		= "hlwd-pic",
-	.ack		= hlwd_pic_ack,
-	.mask_ack	= hlwd_pic_mask_and_ack,
-	.mask		= hlwd_pic_mask,
-	.unmask		= hlwd_pic_unmask,
+	.irq_ack	= hlwd_pic_ack,
+	.irq_mask_ack	= hlwd_pic_mask_and_ack,
+	.irq_mask	= hlwd_pic_mask,
+	.irq_unmask	= hlwd_pic_unmask,
 };
 
 /*
@@ -129,11 +129,12 @@ static unsigned int __hlwd_pic_get_irq(struct irq_host *h)
 static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 				      struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct irq_host *irq_host = get_irq_data(cascade_virq);
 	unsigned int virq;
 
 	raw_spin_lock(&desc->lock);
-	desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
+	chip->irq_mask(&desc->irq_data); /* IRQ_LEVEL */
 	raw_spin_unlock(&desc->lock);
 
 	virq = __hlwd_pic_get_irq(irq_host);
@@ -143,9 +144,9 @@ static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 		pr_err("spurious interrupt!\n");
 
 	raw_spin_lock(&desc->lock);
-	desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(cascade_virq);
+	chip->irq_ack(&desc->irq_data); /* IRQ_LEVEL */
+	if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index ba446bf..4fb96f0 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -167,11 +167,11 @@ static void pci_event_handler(struct HvLpEvent *event)
  * This will be called by device drivers (via enable_IRQ)
  * to enable INTA in the bridge interrupt status register.
  */
-static void iseries_enable_IRQ(unsigned int irq)
+static void iseries_enable_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* The IRQ has already been locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -184,23 +184,23 @@ static void iseries_enable_IRQ(unsigned int irq)
 }
 
 /* This is called by iseries_activate_IRQs */
-static unsigned int iseries_startup_IRQ(unsigned int irq)
+static unsigned int iseries_startup_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	bus = REAL_IRQ_TO_BUS(rirq);
 	function = REAL_IRQ_TO_FUNC(rirq);
 	dev_id = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Link the IRQ number to the bridge */
-	HvCallXm_connectBusUnit(bus, sub_bus, dev_id, irq);
+	HvCallXm_connectBusUnit(bus, sub_bus, dev_id, d->irq);
 
 	/* Unmask bridge interrupts in the FISR */
 	mask = 0x01010000 << function;
 	HvCallPci_unmaskFisr(bus, sub_bus, dev_id, mask);
-	iseries_enable_IRQ(irq);
+	iseries_enable_IRQ(d);
 	return 0;
 }
 
@@ -215,21 +215,26 @@ void __init iSeries_activate_IRQs()
 
 	for_each_irq (irq) {
 		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
 
-		if (desc && desc->chip && desc->chip->startup) {
+		if (!desc)
+			continue;
+
+		chip = get_irq_desc_chip(desc);
+		if (chip && chip->irq_startup) {
 			raw_spin_lock_irqsave(&desc->lock, flags);
-			desc->chip->startup(irq);
+			chip->irq_startup(&desc->irq_data);
 			raw_spin_unlock_irqrestore(&desc->lock, flags);
 		}
 	}
 }
 
 /*  this is not called anywhere currently */
-static void iseries_shutdown_IRQ(unsigned int irq)
+static void iseries_shutdown_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* irq should be locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -248,11 +253,11 @@ static void iseries_shutdown_IRQ(unsigned int irq)
  * This will be called by device drivers (via disable_IRQ)
  * to disable INTA in the bridge interrupt status register.
  */
-static void iseries_disable_IRQ(unsigned int irq)
+static void iseries_disable_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* The IRQ has already been locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -264,9 +269,9 @@ static void iseries_disable_IRQ(unsigned int irq)
 	HvCallPci_maskInterrupts(bus, sub_bus, dev_id, mask);
 }
 
-static void iseries_end_IRQ(unsigned int irq)
+static void iseries_end_IRQ(struct irq_data *d)
 {
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	HvCallPci_eoi(REAL_IRQ_TO_BUS(rirq), REAL_IRQ_TO_SUBBUS(rirq),
 		(REAL_IRQ_TO_IDSEL(rirq) << 4) + REAL_IRQ_TO_FUNC(rirq));
@@ -274,11 +279,11 @@ static void iseries_end_IRQ(unsigned int irq)
 
 static struct irq_chip iseries_pic = {
 	.name		= "iSeries",
-	.startup	= iseries_startup_IRQ,
-	.shutdown	= iseries_shutdown_IRQ,
-	.unmask		= iseries_enable_IRQ,
-	.mask		= iseries_disable_IRQ,
-	.eoi		= iseries_end_IRQ
+	.irq_startup	= iseries_startup_IRQ,
+	.irq_shutdown	= iseries_shutdown_IRQ,
+	.irq_unmask	= iseries_enable_IRQ,
+	.irq_mask	= iseries_disable_IRQ,
+	.irq_eoi	= iseries_end_IRQ
 };
 
 /*
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 890d5f7..c55812b 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -82,9 +82,9 @@ static void __pmac_retrigger(unsigned int irq_nr)
 	}
 }
 
-static void pmac_mask_and_ack_irq(unsigned int virq)
+static void pmac_mask_and_ack_irq(struct irq_data *d)
 {
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
         unsigned long flags;
@@ -104,9 +104,9 @@ static void pmac_mask_and_ack_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_ack_irq(unsigned int virq)
+static void pmac_ack_irq(struct irq_data *d)
 {
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
         unsigned long flags;
@@ -149,15 +149,15 @@ static void __pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
 /* When an irq gets requested for the first client, if it's an
  * edge interrupt, we clear any previous one on the controller
  */
-static unsigned int pmac_startup_irq(unsigned int virq)
+static unsigned int pmac_startup_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
-	if ((irq_to_desc(virq)->status & IRQ_LEVEL) == 0)
+	if ((irq_to_desc(d->irq)->status & IRQ_LEVEL) == 0)
 		out_le32(&pmac_irq_hw[i]->ack, bit);
         __set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
@@ -166,10 +166,10 @@ static unsigned int pmac_startup_irq(unsigned int virq)
 	return 0;
 }
 
-static void pmac_mask_irq(unsigned int virq)
+static void pmac_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
         __clear_bit(src, ppc_cached_irq_mask);
@@ -177,10 +177,10 @@ static void pmac_mask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_unmask_irq(unsigned int virq)
+static void pmac_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	__set_bit(src, ppc_cached_irq_mask);
@@ -188,24 +188,24 @@ static void pmac_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static int pmac_retrigger(unsigned int virq)
+static int pmac_retrigger(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
-	__pmac_retrigger(irq_map[virq].hwirq);
+	__pmac_retrigger(irq_map[d->irq].hwirq);
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	return 1;
 }
 
 static struct irq_chip pmac_pic = {
 	.name		= "PMAC-PIC",
-	.startup	= pmac_startup_irq,
-	.mask		= pmac_mask_irq,
-	.ack		= pmac_ack_irq,
-	.mask_ack	= pmac_mask_and_ack_irq,
-	.unmask		= pmac_unmask_irq,
-	.retrigger	= pmac_retrigger,
+	.irq_startup	= pmac_startup_irq,
+	.irq_mask	= pmac_mask_irq,
+	.irq_ack	= pmac_ack_irq,
+	.irq_mask_ack	= pmac_mask_and_ack_irq,
+	.irq_unmask	= pmac_unmask_irq,
+	.irq_retrigger	= pmac_retrigger,
 };
 
 static irqreturn_t gatwick_action(int cpl, void *dev_id)
@@ -472,12 +472,14 @@ int of_irq_map_oldworld(struct device_node *device, int index,
 
 static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct mpic *mpic = desc->handler_data;
-
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct mpic *mpic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = mpic_get_one_irq(mpic);
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
@@ -707,7 +709,7 @@ static int pmacpic_resume(struct sys_device *sysdev)
 	mb();
 	for (i = 0; i < max_real_irqs; ++i)
 		if (test_bit(i, sleep_save_mask))
-			pmac_unmask_irq(i);
+			pmac_unmask_irq(irq_get_irq_data(i));
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 92290ff..4b3cc34 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -99,16 +99,16 @@ static DEFINE_PER_CPU(struct ps3_private, ps3_private);
  * Sets ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
  */
 
-static void ps3_chip_mask(unsigned int virq)
+static void ps3_chip_mask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
-		pd->thread_id, virq);
+		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
-	clear_bit(63 - virq, &pd->bmp.mask);
+	clear_bit(63 - d->irq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
@@ -120,16 +120,16 @@ static void ps3_chip_mask(unsigned int virq)
  * Clears ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
  */
 
-static void ps3_chip_unmask(unsigned int virq)
+static void ps3_chip_unmask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
-		pd->thread_id, virq);
+		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
-	set_bit(63 - virq, &pd->bmp.mask);
+	set_bit(63 - d->irq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
@@ -141,10 +141,10 @@ static void ps3_chip_unmask(unsigned int virq)
  * Calls lv1_end_of_interrupt_ext().
  */
 
-static void ps3_chip_eoi(unsigned int virq)
+static void ps3_chip_eoi(struct irq_data *d)
 {
-	const struct ps3_private *pd = get_irq_chip_data(virq);
-	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, virq);
+	const struct ps3_private *pd = get_irq_chip_data(d->irq);
+	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, d->irq);
 }
 
 /**
@@ -153,9 +153,9 @@ static void ps3_chip_eoi(unsigned int virq)
 
 static struct irq_chip ps3_irq_chip = {
 	.name = "ps3",
-	.mask = ps3_chip_mask,
-	.unmask = ps3_chip_unmask,
-	.eoi = ps3_chip_eoi,
+	.irq_mask = ps3_chip_mask,
+	.irq_unmask = ps3_chip_unmask,
+	.irq_eoi = ps3_chip_eoi,
 };
 
 /**
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index d345bfd..2a0089a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -114,10 +114,13 @@ static void __init fwnmi_init(void)
 
 static void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init pseries_setup_i8259_cascade(void)
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 7b96e5a..7e8ad8e 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -202,20 +202,20 @@ static int get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 #define get_irq_server(virq, cpumask, strict_check) (default_server)
 #endif
 
-static void xics_unmask_irq(unsigned int virq)
+static void xics_unmask_irq(struct irq_data *d)
 {
 	unsigned int irq;
 	int call_status;
 	int server;
 
-	pr_devel("xics: unmask virq %d\n", virq);
+	pr_devel("xics: unmask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	pr_devel(" -> map to hwirq 0x%x\n", irq);
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq, irq_to_desc(virq)->affinity, 0);
+	server = get_irq_server(d->irq, irq_to_desc(d->irq)->affinity, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -235,22 +235,22 @@ static void xics_unmask_irq(unsigned int virq)
 	}
 }
 
-static unsigned int xics_startup(unsigned int virq)
+static unsigned int xics_startup(struct irq_data *d)
 {
 	/*
 	 * The generic MSI code returns with the interrupt disabled on the
 	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
 	 * at that level, so we do it here by hand.
 	 */
-	if (irq_to_desc(virq)->msi_desc)
-		unmask_msi_irq(irq_get_irq_data(virq));
+	if (irq_to_desc(d->irq)->msi_desc)
+		unmask_msi_irq(d);
 
 	/* unmask it */
-	xics_unmask_irq(virq);
+	xics_unmask_irq(d);
 	return 0;
 }
 
-static void xics_mask_real_irq(unsigned int irq)
+static void xics_mask_real_irq(struct irq_data *d)
 {
 	int call_status;
 
@@ -274,13 +274,13 @@ static void xics_mask_real_irq(unsigned int irq)
 	}
 }
 
-static void xics_mask_irq(unsigned int virq)
+static void xics_mask_irq(struct irq_data *d)
 {
 	unsigned int irq;
 
-	pr_devel("xics: mask virq %d\n", virq);
+	pr_devel("xics: mask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 	xics_mask_real_irq(irq);
@@ -371,30 +371,31 @@ static unsigned char pop_cppr(void)
 	return os_cppr->stack[--os_cppr->index];
 }
 
-static void xics_eoi_direct(unsigned int virq)
+static void xics_eoi_direct(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
 	direct_xirr_info_set((pop_cppr() << 24) | irq);
 }
 
-static void xics_eoi_lpar(unsigned int virq)
+static void xics_eoi_lpar(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
 	lpar_xirr_info_set((pop_cppr() << 24) | irq);
 }
 
-static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
+static int
+xics_set_affinity(struct irq_data *d, const struct cpumask *cpumask, bool force)
 {
 	unsigned int irq;
 	int status;
 	int xics_status[2];
 	int irq_server;
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return -1;
 
@@ -406,13 +407,13 @@ static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
 		return -1;
 	}
 
-	irq_server = get_irq_server(virq, cpumask, 1);
+	irq_server = get_irq_server(d->irq, cpumask, 1);
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
 		printk(KERN_WARNING
 			"%s: No online cpus in the mask %s for irq %d\n",
-			__func__, cpulist, virq);
+			__func__, cpulist, d->irq);
 		return -1;
 	}
 
@@ -430,20 +431,20 @@ static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
 
 static struct irq_chip xics_pic_direct = {
 	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_direct,
-	.set_affinity = xics_set_affinity
+	.irq_startup = xics_startup,
+	.irq_mask = xics_mask_irq,
+	.irq_unmask = xics_unmask_irq,
+	.irq_eoi = xics_eoi_direct,
+	.irq_set_affinity = xics_set_affinity
 };
 
 static struct irq_chip xics_pic_lpar = {
 	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_lpar,
-	.set_affinity = xics_set_affinity
+	.irq_startup = xics_startup,
+	.irq_mask = xics_mask_irq,
+	.irq_unmask = xics_unmask_irq,
+	.irq_eoi = xics_eoi_lpar,
+	.irq_set_affinity = xics_set_affinity
 };
 
 
@@ -890,6 +891,7 @@ void xics_migrate_irqs_away(void)
 
 	for_each_irq(virq) {
 		struct irq_desc *desc;
+		struct irq_chip *chip;
 		int xics_status[2];
 		int status;
 		unsigned long flags;
@@ -903,12 +905,15 @@ void xics_migrate_irqs_away(void)
 		/* We need to get IPIs still. */
 		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 			continue;
+
 		desc = irq_to_desc(virq);
 
 		/* We only need to migrate enabled IRQS */
-		if (desc == NULL || desc->chip == NULL
-		    || desc->action == NULL
-		    || desc->chip->set_affinity == NULL)
+		if (desc == NULL || desc->action == NULL)
+			continue;
+
+		chip = get_irq_desc_chip(desc);
+		if (chip == NULL || chip->irq_set_affinity == NULL)
 			continue;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
@@ -934,8 +939,8 @@ void xics_migrate_irqs_away(void)
 			       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		cpumask_setall(irq_to_desc(virq)->affinity);
-		desc->chip->set_affinity(virq, cpu_all_mask);
+		cpumask_setall(desc->irq_data.affinity);
+		chip->irq_set_affinity(&desc->irq_data, cpu_all_mask, true);
 unlock:
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 0085212..0476bcc 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -56,32 +56,32 @@ static cpic8xx_t __iomem *cpic_reg;
 
 static struct irq_host *cpm_pic_host;
 
-static void cpm_mask_irq(unsigned int irq)
+static void cpm_mask_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
-static void cpm_unmask_irq(unsigned int irq)
+static void cpm_unmask_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
-static void cpm_end_irq(unsigned int irq)
+static void cpm_end_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
 }
 
 static struct irq_chip cpm_pic = {
 	.name = "CPM PIC",
-	.mask = cpm_mask_irq,
-	.unmask = cpm_unmask_irq,
-	.eoi = cpm_end_irq,
+	.irq_mask = cpm_mask_irq,
+	.irq_unmask = cpm_unmask_irq,
+	.irq_eoi = cpm_end_irq,
 };
 
 int cpm_get_irq(void)
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index fcea4ff..4730325 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -78,10 +78,10 @@ static const u_char irq_to_siubit[] = {
 	24, 25, 26, 27, 28, 29, 30, 31,
 };
 
-static void cpm2_mask_irq(unsigned int virq)
+static void cpm2_mask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -90,10 +90,10 @@ static void cpm2_mask_irq(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_unmask_irq(unsigned int virq)
+static void cpm2_unmask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -102,10 +102,10 @@ static void cpm2_unmask_irq(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_ack(unsigned int virq)
+static void cpm2_ack(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -113,11 +113,11 @@ static void cpm2_ack(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_sipnrh + word, 1 << bit);
 }
 
-static void cpm2_end_irq(unsigned int virq)
+static void cpm2_end_irq(struct irq_data *d)
 {
 	struct irq_desc *desc;
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	desc = irq_to_desc(irq_nr);
 	if (!(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS))
@@ -137,10 +137,10 @@ static void cpm2_end_irq(unsigned int virq)
 	}
 }
 
-static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int cpm2_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	unsigned int src = virq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	unsigned int src = virq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
@@ -199,11 +199,11 @@ err_sense:
 
 static struct irq_chip cpm2_pic = {
 	.name = "CPM2 SIU",
-	.mask = cpm2_mask_irq,
-	.unmask = cpm2_unmask_irq,
-	.ack = cpm2_ack,
-	.eoi = cpm2_end_irq,
-	.set_type = cpm2_set_irq_type,
+	.irq_mask = cpm2_mask_irq,
+	.irq_unmask = cpm2_unmask_irq,
+	.irq_ack = cpm2_ack,
+	.irq_eoi = cpm2_end_irq,
+	.irq_set_type = cpm2_set_irq_type,
 };
 
 unsigned int cpm2_get_irq(void)
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 108d76f..f6051d7 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -47,14 +47,14 @@ static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
  * We do not need this actually. The MSIR register has been read once
  * in the cascade interrupt. So, this MSI interrupt has been acked
 */
-static void fsl_msi_end_irq(unsigned int virq)
+static void fsl_msi_end_irq(struct irq_data *d)
 {
 }
 
 static struct irq_chip fsl_msi_chip = {
 	.irq_mask	= mask_msi_irq,
 	.irq_unmask	= unmask_msi_irq,
-	.ack		= fsl_msi_end_irq,
+	.irq_ack	= fsl_msi_end_irq,
 	.name		= "FSL-MSI",
 };
 
@@ -183,6 +183,7 @@ out_free:
 
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 	struct fsl_msi *msi_data;
 	int msir_index = -1;
@@ -196,11 +197,11 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
-		if (desc->chip->mask_ack)
-			desc->chip->mask_ack(irq);
+		if (chip->irq_mask_ack)
+			chip->irq_mask_ack(&desc->irq_data);
 		else {
-			desc->chip->mask(irq);
-			desc->chip->ack(irq);
+			chip->irq_mask(&desc->irq_data);
+			chip->irq_ack(&desc->irq_data);
 		}
 	}
 
@@ -238,11 +239,11 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
-		desc->chip->eoi(irq);
+		chip->irq_eoi(&desc->irq_data);
 		break;
 	case FSL_PIC_IP_IPIC:
-		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-			desc->chip->unmask(irq);
+		if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+			chip->irq_unmask(&desc->irq_data);
 		break;
 	}
 unlock:
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 6323e70..aeda4c8 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -78,19 +78,19 @@ unsigned int i8259_irq(void)
 	return irq;
 }
 
-static void i8259_mask_and_ack_irq(unsigned int irq_nr)
+static void i8259_mask_and_ack_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr > 7) {
-		cached_A1 |= 1 << (irq_nr-8);
+	if (d->irq > 7) {
+		cached_A1 |= 1 << (d->irq-8);
 		inb(0xA1); 	/* DUMMY */
 		outb(cached_A1, 0xA1);
 		outb(0x20, 0xA0);	/* Non-specific EOI */
 		outb(0x20, 0x20);	/* Non-specific EOI to cascade */
 	} else {
-		cached_21 |= 1 << irq_nr;
+		cached_21 |= 1 << d->irq;
 		inb(0x21); 	/* DUMMY */
 		outb(cached_21, 0x21);
 		outb(0x20, 0x20);	/* Non-specific EOI */
@@ -104,42 +104,42 @@ static void i8259_set_irq_mask(int irq_nr)
 	outb(cached_21,0x21);
 }
 
-static void i8259_mask_irq(unsigned int irq_nr)
+static void i8259_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
-	pr_debug("i8259_mask_irq(%d)\n", irq_nr);
+	pr_debug("i8259_mask_irq(%d)\n", d->irq);
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr < 8)
-		cached_21 |= 1 << irq_nr;
+	if (d->irq < 8)
+		cached_21 |= 1 << d->irq;
 	else
-		cached_A1 |= 1 << (irq_nr-8);
-	i8259_set_irq_mask(irq_nr);
+		cached_A1 |= 1 << (d->irq-8);
+	i8259_set_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
-static void i8259_unmask_irq(unsigned int irq_nr)
+static void i8259_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
-	pr_debug("i8259_unmask_irq(%d)\n", irq_nr);
+	pr_debug("i8259_unmask_irq(%d)\n", d->irq);
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr < 8)
-		cached_21 &= ~(1 << irq_nr);
+	if (d->irq < 8)
+		cached_21 &= ~(1 << d->irq);
 	else
-		cached_A1 &= ~(1 << (irq_nr-8));
-	i8259_set_irq_mask(irq_nr);
+		cached_A1 &= ~(1 << (d->irq-8));
+	i8259_set_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
 static struct irq_chip i8259_pic = {
 	.name		= "i8259",
-	.mask		= i8259_mask_irq,
-	.disable	= i8259_mask_irq,
-	.unmask		= i8259_unmask_irq,
-	.mask_ack	= i8259_mask_and_ack_irq,
+	.irq_mask	= i8259_mask_irq,
+	.irq_disable	= i8259_mask_irq,
+	.irq_unmask	= i8259_unmask_irq,
+	.irq_mask_ack	= i8259_mask_and_ack_irq,
 };
 
 static struct resource pic1_iores = {
@@ -188,7 +188,7 @@ static int i8259_host_map(struct irq_host *h, unsigned int virq,
 static void i8259_host_unmap(struct irq_host *h, unsigned int virq)
 {
 	/* Make sure irq is masked in hardware */
-	i8259_mask_irq(virq);
+	i8259_mask_irq(irq_get_irq_data(virq));
 
 	/* remove chip and handler */
 	set_irq_chip_and_handler(virq, NULL, NULL);
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index d7b9b9c..497047d 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -523,10 +523,10 @@ static inline struct ipic * ipic_from_irq(unsigned int virq)
 
 #define ipic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
-static void ipic_unmask_irq(unsigned int virq)
+static void ipic_unmask_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -539,10 +539,10 @@ static void ipic_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_mask_irq(unsigned int virq)
+static void ipic_mask_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -559,10 +559,10 @@ static void ipic_mask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_ack_irq(unsigned int virq)
+static void ipic_ack_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -578,10 +578,10 @@ static void ipic_ack_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_mask_irq_and_ack(unsigned int virq)
+static void ipic_mask_irq_and_ack(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -601,11 +601,11 @@ static void ipic_mask_irq_and_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int ipic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	if (flow_type == IRQ_TYPE_NONE)
@@ -630,10 +630,10 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
 		desc->status |= IRQ_LEVEL;
 		desc->handle_irq = handle_level_irq;
-		desc->chip = &ipic_level_irq_chip;
+		desc->irq_data.chip = &ipic_level_irq_chip;
 	} else {
 		desc->handle_irq = handle_edge_irq;
-		desc->chip = &ipic_edge_irq_chip;
+		desc->irq_data.chip = &ipic_edge_irq_chip;
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
@@ -661,19 +661,19 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 /* level interrupts and edge interrupts have different ack operations */
 static struct irq_chip ipic_level_irq_chip = {
 	.name		= "IPIC",
-	.unmask		= ipic_unmask_irq,
-	.mask		= ipic_mask_irq,
-	.mask_ack	= ipic_mask_irq,
-	.set_type	= ipic_set_irq_type,
+	.irq_unmask	= ipic_unmask_irq,
+	.irq_mask	= ipic_mask_irq,
+	.irq_mask_ack	= ipic_mask_irq,
+	.irq_set_type	= ipic_set_irq_type,
 };
 
 static struct irq_chip ipic_edge_irq_chip = {
 	.name		= "IPIC",
-	.unmask		= ipic_unmask_irq,
-	.mask		= ipic_mask_irq,
-	.mask_ack	= ipic_mask_irq_and_ack,
-	.ack		= ipic_ack_irq,
-	.set_type	= ipic_set_irq_type,
+	.irq_unmask	= ipic_unmask_irq,
+	.irq_mask	= ipic_mask_irq,
+	.irq_mask_ack	= ipic_mask_irq_and_ack,
+	.irq_ack	= ipic_ack_irq,
+	.irq_set_type	= ipic_set_irq_type,
 };
 
 static int ipic_host_match(struct irq_host *h, struct device_node *node)
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 8c27d26..1a75a7f 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -25,10 +25,10 @@ static sysconf8xx_t __iomem *siu_reg;
 
 int cpm_get_irq(struct pt_regs *regs);
 
-static void mpc8xx_unmask_irq(unsigned int virq)
+static void mpc8xx_unmask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -37,10 +37,10 @@ static void mpc8xx_unmask_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static void mpc8xx_mask_irq(unsigned int virq)
+static void mpc8xx_mask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -49,19 +49,19 @@ static void mpc8xx_mask_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static void mpc8xx_ack(unsigned int virq)
+static void mpc8xx_ack(struct irq_data *d)
 {
 	int	bit;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	out_be32(&siu_reg->sc_sipend, 1 << (31-bit));
 }
 
-static void mpc8xx_end_irq(unsigned int virq)
+static void mpc8xx_end_irq(struct irq_data *d)
 {
 	int bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -70,9 +70,9 @@ static void mpc8xx_end_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
@@ -80,7 +80,7 @@ static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
 		desc->status |= IRQ_LEVEL;
 
 	if (flow_type & IRQ_TYPE_EDGE_FALLING) {
-		irq_hw_number_t hw = (unsigned int)irq_map[virq].hwirq;
+		irq_hw_number_t hw = (unsigned int)irq_map[d->irq].hwirq;
 		unsigned int siel = in_be32(&siu_reg->sc_siel);
 
 		/* only external IRQ senses are programmable */
@@ -95,11 +95,11 @@ static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc8xx_pic = {
 	.name = "MPC8XX SIU",
-	.unmask = mpc8xx_unmask_irq,
-	.mask = mpc8xx_mask_irq,
-	.ack = mpc8xx_ack,
-	.eoi = mpc8xx_end_irq,
-	.set_type = mpc8xx_set_irq_type,
+	.irq_unmask = mpc8xx_unmask_irq,
+	.irq_mask = mpc8xx_mask_irq,
+	.irq_ack = mpc8xx_ack,
+	.irq_eoi = mpc8xx_end_irq,
+	.irq_set_type = mpc8xx_set_irq_type,
 };
 
 unsigned int mpc8xx_get_irq(void)
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index c48cd81..519a877 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -155,43 +155,43 @@ static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 						     32 - ffs(mask)));
 }
 
-static void mpc8xxx_irq_unmask(unsigned int virq)
+static void mpc8xxx_irq_unmask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 
 	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
 
-static void mpc8xxx_irq_mask(unsigned int virq)
+static void mpc8xxx_irq_mask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 
 	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
 
-static void mpc8xxx_irq_ack(unsigned int virq)
+static void mpc8xxx_irq_ack(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 
-	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 }
 
-static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
@@ -199,14 +199,14 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_FALLING:
 		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 		setbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
+			  mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 		clrbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
+			  mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
@@ -217,11 +217,11 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 	return 0;
 }
 
-static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long gpio = virq_to_hw(virq);
+	unsigned long gpio = virq_to_hw(d->irq);
 	void __iomem *reg;
 	unsigned int shift;
 	unsigned long flags;
@@ -264,10 +264,10 @@ static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc8xxx_irq_chip = {
 	.name		= "mpc8xxx-gpio",
-	.unmask		= mpc8xxx_irq_unmask,
-	.mask		= mpc8xxx_irq_mask,
-	.ack		= mpc8xxx_irq_ack,
-	.set_type	= mpc8xxx_irq_set_type,
+	.irq_unmask	= mpc8xxx_irq_unmask,
+	.irq_mask	= mpc8xxx_irq_mask,
+	.irq_ack	= mpc8xxx_irq_ack,
+	.irq_set_type	= mpc8xxx_irq_set_type,
 };
 
 static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
@@ -276,7 +276,7 @@ static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = h->host_data;
 
 	if (mpc8xxx_gc->of_dev_id_data)
-		mpc8xxx_irq_chip.set_type = mpc8xxx_gc->of_dev_id_data;
+		mpc8xxx_irq_chip.irq_set_type = mpc8xxx_gc->of_dev_id_data;
 
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b0c8469..83b34eb 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -611,7 +611,7 @@ static struct mpic *mpic_find(unsigned int irq)
 	if (irq < NUM_ISA_INTERRUPTS)
 		return NULL;
 
-	return irq_to_desc(irq)->chip_data;
+	return get_irq_chip_data(irq);
 }
 
 /* Determine if the linux irq is an IPI */
@@ -645,7 +645,7 @@ static inline struct mpic * mpic_from_ipi(unsigned int ipi)
 /* Get the mpic structure from the irq number */
 static inline struct mpic * mpic_from_irq(unsigned int irq)
 {
-	return irq_to_desc(irq)->chip_data;
+	return get_irq_chip_data(irq);
 }
 
 /* Send an EOI */
@@ -660,13 +660,13 @@ static inline void mpic_eoi(struct mpic *mpic)
  */
 
 
-void mpic_unmask_irq(unsigned int irq)
+void mpic_unmask_irq(struct irq_data *d)
 {
 	unsigned int loops = 100000;
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
+	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, d->irq, src);
 
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
@@ -681,13 +681,13 @@ void mpic_unmask_irq(unsigned int irq)
 	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK);
 }
 
-void mpic_mask_irq(unsigned int irq)
+void mpic_mask_irq(struct irq_data *d)
 {
 	unsigned int loops = 100000;
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
+	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, d->irq, src);
 
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
@@ -703,12 +703,12 @@ void mpic_mask_irq(unsigned int irq)
 	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK));
 }
 
-void mpic_end_irq(unsigned int irq)
+void mpic_end_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
 
 #ifdef DEBUG_IRQ
-	DBG("%s: end_irq: %d\n", mpic->name, irq);
+	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
 #endif
 	/* We always EOI on end_irq() even for edge interrupts since that
 	 * should only lower the priority, the MPIC should have properly
@@ -720,51 +720,51 @@ void mpic_end_irq(unsigned int irq)
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 
-static void mpic_unmask_ht_irq(unsigned int irq)
+static void mpic_unmask_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	mpic_unmask_irq(irq);
+	mpic_unmask_irq(d);
 
-	if (irq_to_desc(irq)->status & IRQ_LEVEL)
+	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
 		mpic_ht_end_irq(mpic, src);
 }
 
-static unsigned int mpic_startup_ht_irq(unsigned int irq)
+static unsigned int mpic_startup_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	mpic_unmask_irq(irq);
-	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
+	mpic_unmask_irq(d);
+	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
 
 	return 0;
 }
 
-static void mpic_shutdown_ht_irq(unsigned int irq)
+static void mpic_shutdown_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
-	mpic_mask_irq(irq);
+	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
+	mpic_mask_irq(d);
 }
 
-static void mpic_end_ht_irq(unsigned int irq)
+static void mpic_end_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
 #ifdef DEBUG_IRQ
-	DBG("%s: end_irq: %d\n", mpic->name, irq);
+	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
 #endif
 	/* We always EOI on end_irq() even for edge interrupts since that
 	 * should only lower the priority, the MPIC should have properly
 	 * latched another edge interrupt coming in anyway
 	 */
 
-	if (irq_to_desc(irq)->status & IRQ_LEVEL)
+	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
 		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
@@ -772,23 +772,23 @@ static void mpic_end_ht_irq(unsigned int irq)
 
 #ifdef CONFIG_SMP
 
-static void mpic_unmask_ipi(unsigned int irq)
+static void mpic_unmask_ipi(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_ipi(irq);
-	unsigned int src = mpic_irq_to_hw(irq) - mpic->ipi_vecs[0];
+	struct mpic *mpic = mpic_from_ipi(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq) - mpic->ipi_vecs[0];
 
-	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
+	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, d->irq, src);
 	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
 }
 
-static void mpic_mask_ipi(unsigned int irq)
+static void mpic_mask_ipi(struct irq_data *d)
 {
 	/* NEVER disable an IPI... that's just plain wrong! */
 }
 
-static void mpic_end_ipi(unsigned int irq)
+static void mpic_end_ipi(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_ipi(irq);
+	struct mpic *mpic = mpic_from_ipi(d->irq);
 
 	/*
 	 * IPIs are marked IRQ_PER_CPU. This has the side effect of
@@ -802,10 +802,11 @@ static void mpic_end_ipi(unsigned int irq)
 
 #endif /* CONFIG_SMP */
 
-int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+int mpic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
+		      bool force)
 {
-	struct mpic *mpic = mpic_from_irq(irq);
-	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	if (mpic->flags & MPIC_SINGLE_DEST_CPU) {
 		int cpuid = irq_choose_cpu(cpumask);
@@ -848,15 +849,15 @@ static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
 	}
 }
 
-int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
+int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpic *mpic = mpic_from_irq(virq);
-	unsigned int src = mpic_irq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct mpic *mpic = mpic_from_irq(d->irq);
+	unsigned int src = mpic_irq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vecpri, vold, vnew;
 
 	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
-	    mpic, virq, src, flow_type);
+	    mpic, d->irq, src, flow_type);
 
 	if (src >= mpic->irq_count)
 		return -EINVAL;
@@ -907,28 +908,28 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
 }
 
 static struct irq_chip mpic_irq_chip = {
-	.mask		= mpic_mask_irq,
-	.unmask		= mpic_unmask_irq,
-	.eoi		= mpic_end_irq,
-	.set_type	= mpic_set_irq_type,
+	.irq_mask	= mpic_mask_irq,
+	.irq_unmask	= mpic_unmask_irq,
+	.irq_eoi	= mpic_end_irq,
+	.irq_set_type	= mpic_set_irq_type,
 };
 
 #ifdef CONFIG_SMP
 static struct irq_chip mpic_ipi_chip = {
-	.mask		= mpic_mask_ipi,
-	.unmask		= mpic_unmask_ipi,
-	.eoi		= mpic_end_ipi,
+	.irq_mask	= mpic_mask_ipi,
+	.irq_unmask	= mpic_unmask_ipi,
+	.irq_eoi	= mpic_end_ipi,
 };
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 static struct irq_chip mpic_irq_ht_chip = {
-	.startup	= mpic_startup_ht_irq,
-	.shutdown	= mpic_shutdown_ht_irq,
-	.mask		= mpic_mask_irq,
-	.unmask		= mpic_unmask_ht_irq,
-	.eoi		= mpic_end_ht_irq,
-	.set_type	= mpic_set_irq_type,
+	.irq_startup	= mpic_startup_ht_irq,
+	.irq_shutdown	= mpic_shutdown_ht_irq,
+	.irq_mask	= mpic_mask_irq,
+	.irq_unmask	= mpic_unmask_ht_irq,
+	.irq_eoi	= mpic_end_ht_irq,
+	.irq_set_type	= mpic_set_irq_type,
 };
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
@@ -1060,12 +1061,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->hc_irq = mpic_irq_chip;
 	mpic->hc_irq.name = name;
 	if (flags & MPIC_PRIMARY)
-		mpic->hc_irq.set_affinity = mpic_set_affinity;
+		mpic->hc_irq.irq_set_affinity = mpic_set_affinity;
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 	mpic->hc_ht_irq = mpic_irq_ht_chip;
 	mpic->hc_ht_irq.name = name;
 	if (flags & MPIC_PRIMARY)
-		mpic->hc_ht_irq.set_affinity = mpic_set_affinity;
+		mpic->hc_ht_irq.irq_set_affinity = mpic_set_affinity;
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index e4a6df7..13f3e89 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -34,9 +34,10 @@ static inline int mpic_pasemi_msi_init(struct mpic *mpic)
 }
 #endif
 
-extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
+extern int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type);
 extern void mpic_set_vector(unsigned int virq, unsigned int vector);
-extern int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int mpic_set_affinity(struct irq_data *d,
+			     const struct cpumask *cpumask, bool force);
 extern void mpic_reset_core(int cpu);
 
 #endif /* _POWERPC_SYSDEV_MPIC_H */
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 320ad5a..0b7794a 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -43,24 +43,24 @@ static void mpic_pasemi_msi_mask_irq(struct irq_data *data)
 {
 	pr_debug("mpic_pasemi_msi_mask_irq %d\n", data->irq);
 	mask_msi_irq(data);
-	mpic_mask_irq(data->irq);
+	mpic_mask_irq(data);
 }
 
 static void mpic_pasemi_msi_unmask_irq(struct irq_data *data)
 {
 	pr_debug("mpic_pasemi_msi_unmask_irq %d\n", data->irq);
-	mpic_unmask_irq(data->irq);
+	mpic_unmask_irq(data);
 	unmask_msi_irq(data);
 }
 
 static struct irq_chip mpic_pasemi_msi_chip = {
-	.irq_shutdown	= mpic_pasemi_msi_mask_irq,
-	.irq_mask	= mpic_pasemi_msi_mask_irq,
-	.irq_unmask	= mpic_pasemi_msi_unmask_irq,
-	.eoi		= mpic_end_irq,
-	.set_type	= mpic_set_irq_type,
-	.set_affinity	= mpic_set_affinity,
-	.name		= "PASEMI-MSI",
+	.irq_shutdown		= mpic_pasemi_msi_mask_irq,
+	.irq_mask		= mpic_pasemi_msi_mask_irq,
+	.irq_unmask		= mpic_pasemi_msi_unmask_irq,
+	.irq_eoi		= mpic_end_irq,
+	.irq_set_type		= mpic_set_irq_type,
+	.irq_set_affinity	= mpic_set_affinity,
+	.name			= "PASEMI-MSI",
 };
 
 static int pasemi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index a2b028b..71900ac 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -26,23 +26,23 @@ static struct mpic *msi_mpic;
 static void mpic_u3msi_mask_irq(struct irq_data *data)
 {
 	mask_msi_irq(data);
-	mpic_mask_irq(data->irq);
+	mpic_mask_irq(data);
 }
 
 static void mpic_u3msi_unmask_irq(struct irq_data *data)
 {
-	mpic_unmask_irq(data->irq);
+	mpic_unmask_irq(data);
 	unmask_msi_irq(data);
 }
 
 static struct irq_chip mpic_u3msi_chip = {
-	.irq_shutdown	= mpic_u3msi_mask_irq,
-	.irq_mask	= mpic_u3msi_mask_irq,
-	.irq_unmask	= mpic_u3msi_unmask_irq,
-	.eoi		= mpic_end_irq,
-	.set_type	= mpic_set_irq_type,
-	.set_affinity	= mpic_set_affinity,
-	.name		= "MPIC-U3MSI",
+	.irq_shutdown		= mpic_u3msi_mask_irq,
+	.irq_mask		= mpic_u3msi_mask_irq,
+	.irq_unmask		= mpic_u3msi_unmask_irq,
+	.irq_eoi		= mpic_end_irq,
+	.irq_set_type		= mpic_set_irq_type,
+	.irq_set_affinity	= mpic_set_affinity,
+	.name			= "MPIC-U3MSI",
 };
 
 static u64 read_ht_magic_addr(struct pci_dev *pdev, unsigned int pos)
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 485b924..bc61ebb 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -76,9 +76,9 @@ static struct irq_host *mv64x60_irq_host;
  * mv64x60_chip_low functions
  */
 
-static void mv64x60_mask_low(unsigned int virq)
+static void mv64x60_mask_low(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -89,9 +89,9 @@ static void mv64x60_mask_low(unsigned int virq)
 	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO);
 }
 
-static void mv64x60_unmask_low(unsigned int virq)
+static void mv64x60_unmask_low(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -104,18 +104,18 @@ static void mv64x60_unmask_low(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_low = {
 	.name		= "mv64x60_low",
-	.mask		= mv64x60_mask_low,
-	.mask_ack	= mv64x60_mask_low,
-	.unmask		= mv64x60_unmask_low,
+	.irq_mask	= mv64x60_mask_low,
+	.irq_mask_ack	= mv64x60_mask_low,
+	.irq_unmask	= mv64x60_unmask_low,
 };
 
 /*
  * mv64x60_chip_high functions
  */
 
-static void mv64x60_mask_high(unsigned int virq)
+static void mv64x60_mask_high(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -126,9 +126,9 @@ static void mv64x60_mask_high(unsigned int virq)
 	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI);
 }
 
-static void mv64x60_unmask_high(unsigned int virq)
+static void mv64x60_unmask_high(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -141,18 +141,18 @@ static void mv64x60_unmask_high(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_high = {
 	.name		= "mv64x60_high",
-	.mask		= mv64x60_mask_high,
-	.mask_ack	= mv64x60_mask_high,
-	.unmask		= mv64x60_unmask_high,
+	.irq_mask	= mv64x60_mask_high,
+	.irq_mask_ack	= mv64x60_mask_high,
+	.irq_unmask	= mv64x60_unmask_high,
 };
 
 /*
  * mv64x60_chip_gpp functions
  */
 
-static void mv64x60_mask_gpp(unsigned int virq)
+static void mv64x60_mask_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -163,9 +163,9 @@ static void mv64x60_mask_gpp(unsigned int virq)
 	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK);
 }
 
-static void mv64x60_mask_ack_gpp(unsigned int virq)
+static void mv64x60_mask_ack_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -178,9 +178,9 @@ static void mv64x60_mask_ack_gpp(unsigned int virq)
 	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_CAUSE);
 }
 
-static void mv64x60_unmask_gpp(unsigned int virq)
+static void mv64x60_unmask_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -193,9 +193,9 @@ static void mv64x60_unmask_gpp(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_gpp = {
 	.name		= "mv64x60_gpp",
-	.mask		= mv64x60_mask_gpp,
-	.mask_ack	= mv64x60_mask_ack_gpp,
-	.unmask		= mv64x60_unmask_gpp,
+	.irq_mask	= mv64x60_mask_gpp,
+	.irq_mask_ack	= mv64x60_mask_ack_gpp,
+	.irq_unmask	= mv64x60_unmask_gpp,
 };
 
 /*
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 541ba98..24bfc1e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -189,15 +189,15 @@ static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
 {
-	return irq_to_desc(virq)->chip_data;
+	return get_irq_chip_data(virq);
 }
 
 #define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
-static void qe_ic_unmask_irq(unsigned int virq)
+static void qe_ic_unmask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct qe_ic *qe_ic = qe_ic_from_irq(d->irq);
+	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -210,10 +210,10 @@ static void qe_ic_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
-static void qe_ic_mask_irq(unsigned int virq)
+static void qe_ic_mask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct qe_ic *qe_ic = qe_ic_from_irq(d->irq);
+	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -238,9 +238,9 @@ static void qe_ic_mask_irq(unsigned int virq)
 
 static struct irq_chip qe_ic_irq_chip = {
 	.name = "QEIC",
-	.unmask = qe_ic_unmask_irq,
-	.mask = qe_ic_mask_irq,
-	.mask_ack = qe_ic_mask_irq,
+	.irq_unmask = qe_ic_unmask_irq,
+	.irq_mask = qe_ic_mask_irq,
+	.irq_mask_ack = qe_ic_mask_irq,
 };
 
 static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 0ab9281..02c91db 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -343,24 +343,9 @@ static inline unsigned int get_pci_source(void)
  * Linux descriptor level callbacks
  */
 
-static void tsi108_pci_irq_enable(u_int irq)
+static void tsi108_pci_irq_unmask(struct irq_data *d)
 {
-	tsi108_pci_int_unmask(irq);
-}
-
-static void tsi108_pci_irq_disable(u_int irq)
-{
-	tsi108_pci_int_mask(irq);
-}
-
-static void tsi108_pci_irq_ack(u_int irq)
-{
-	tsi108_pci_int_mask(irq);
-}
-
-static void tsi108_pci_irq_end(u_int irq)
-{
-	tsi108_pci_int_unmask(irq);
+	tsi108_pci_int_unmask(d->irq);
 
 	/* Enable interrupts from PCI block */
 	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE,
@@ -370,16 +355,25 @@ static void tsi108_pci_irq_end(u_int irq)
 	mb();
 }
 
+static void tsi108_pci_irq_mask(struct irq_data *d)
+{
+	tsi108_pci_int_mask(d->irq);
+}
+
+static void tsi108_pci_irq_ack(struct irq_data *d)
+{
+	tsi108_pci_int_mask(d->irq);
+}
+
 /*
  * Interrupt controller descriptor for cascaded PCI interrupt controller.
  */
 
 static struct irq_chip tsi108_pci_irq = {
 	.name = "tsi108_PCI_int",
-	.mask = tsi108_pci_irq_disable,
-	.ack = tsi108_pci_irq_ack,
-	.end = tsi108_pci_irq_end,
-	.unmask = tsi108_pci_irq_enable,
+	.irq_mask = tsi108_pci_irq_mask,
+	.irq_ack = tsi108_pci_irq_ack,
+	.irq_unmask = tsi108_pci_irq_unmask,
 };
 
 static int pci_irq_host_xlate(struct irq_host *h, struct device_node *ct,
@@ -437,8 +431,11 @@ void __init tsi108_pci_int_init(struct device_node *node)
 
 void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = get_pci_source();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 0038fb7..1fb46fe 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -55,11 +55,11 @@ struct uic {
 	struct irq_host	*irqhost;
 };
 
-static void uic_unmask_irq(unsigned int virq)
+static void uic_unmask_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
 
@@ -74,10 +74,10 @@ static void uic_unmask_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_mask_irq(unsigned int virq)
+static void uic_mask_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er;
 
@@ -88,10 +88,10 @@ static void uic_mask_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_ack_irq(unsigned int virq)
+static void uic_ack_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&uic->lock, flags);
@@ -99,11 +99,11 @@ static void uic_ack_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_mask_ack_irq(unsigned int virq)
+static void uic_mask_ack_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
 
@@ -125,18 +125,18 @@ static void uic_mask_ack_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned long flags;
 	int trigger, polarity;
 	u32 tr, pr, mask;
 
 	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_NONE:
-		uic_mask_irq(virq);
+		uic_mask_irq(d);
 		return 0;
 
 	case IRQ_TYPE_EDGE_RISING:
@@ -178,11 +178,11 @@ static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip uic_irq_chip = {
 	.name		= "UIC",
-	.unmask		= uic_unmask_irq,
-	.mask		= uic_mask_irq,
- 	.mask_ack	= uic_mask_ack_irq,
-	.ack		= uic_ack_irq,
-	.set_type	= uic_set_irq_type,
+	.irq_unmask	= uic_unmask_irq,
+	.irq_mask	= uic_mask_irq,
+ 	.irq_mask_ack	= uic_mask_ack_irq,
+	.irq_ack	= uic_ack_irq,
+	.irq_set_type	= uic_set_irq_type,
 };
 
 static int uic_host_map(struct irq_host *h, unsigned int virq,
@@ -220,6 +220,7 @@ static struct irq_host_ops uic_host_ops = {
 
 void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct uic *uic = get_irq_data(virq);
 	u32 msr;
 	int src;
@@ -227,9 +228,9 @@ void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 	if (desc->status & IRQ_LEVEL)
-		desc->chip->mask(virq);
+		chip->irq_mask(&desc->irq_data);
 	else
-		desc->chip->mask_ack(virq);
+		chip->irq_mask_ack(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
@@ -244,9 +245,9 @@ void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 uic_irq_ret:
 	raw_spin_lock(&desc->lock);
 	if (desc->status & IRQ_LEVEL)
-		desc->chip->ack(virq);
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(virq);
+		chip->irq_ack(&desc->irq_data);
+	if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 1e0ccfa..0512f58 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -69,17 +69,17 @@ static unsigned char xilinx_intc_map_senses[] = {
  *
  * IRQ Chip common (across level and edge) operations
  */
-static void xilinx_intc_mask(unsigned int virq)
+static void xilinx_intc_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("mask: %d\n", irq);
 	out_be32(regs + XINTC_CIE, 1 << irq);
 }
 
-static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
+static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
@@ -91,10 +91,10 @@ static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
 /*
  * IRQ Chip level operations
  */
-static void xilinx_intc_level_unmask(unsigned int virq)
+static void xilinx_intc_level_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 
@@ -107,37 +107,37 @@ static void xilinx_intc_level_unmask(unsigned int virq)
 
 static struct irq_chip xilinx_intc_level_irqchip = {
 	.name = "Xilinx Level INTC",
-	.mask = xilinx_intc_mask,
-	.mask_ack = xilinx_intc_mask,
-	.unmask = xilinx_intc_level_unmask,
-	.set_type = xilinx_intc_set_type,
+	.irq_mask = xilinx_intc_mask,
+	.irq_mask_ack = xilinx_intc_mask,
+	.irq_unmask = xilinx_intc_level_unmask,
+	.irq_set_type = xilinx_intc_set_type,
 };
 
 /*
  * IRQ Chip edge operations
  */
-static void xilinx_intc_edge_unmask(unsigned int virq)
+static void xilinx_intc_edge_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void *regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void *regs = get_irq_chip_data(d->irq);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 }
 
-static void xilinx_intc_edge_ack(unsigned int virq)
+static void xilinx_intc_edge_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("ack: %d\n", irq);
 	out_be32(regs + XINTC_IAR, 1 << irq);
 }
 
 static struct irq_chip xilinx_intc_edge_irqchip = {
 	.name = "Xilinx Edge  INTC",
-	.mask = xilinx_intc_mask,
-	.unmask = xilinx_intc_edge_unmask,
-	.ack = xilinx_intc_edge_ack,
-	.set_type = xilinx_intc_set_type,
+	.irq_mask = xilinx_intc_mask,
+	.irq_unmask = xilinx_intc_edge_unmask,
+	.irq_ack = xilinx_intc_edge_ack,
+	.irq_set_type = xilinx_intc_set_type,
 };
 
 /*
@@ -229,12 +229,14 @@ int xilinx_intc_get_irq(void)
  */
 static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	/* Let xilinx_intc end the interrupt */
-	desc->chip->unmask(irq);
+	chip->irq_unmask(&desc->irq_data);
 }
 
 static void __init xilinx_i8259_setup_cascade(void)
-- 
1.7.1
