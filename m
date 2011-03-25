Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 068D2100976
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:10 +1100 (EST)
Message-Id: <20110325164141.905019742@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:23 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 13/14] powerpc: Convert to new irq_* function names
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scripted with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c                         |    6 +++---
 arch/powerpc/kernel/machine_kexec.c               |    2 +-
 arch/powerpc/kernel/pci-common.c                  |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c    |    4 ++--
 arch/powerpc/platforms/52xx/media5200.c           |   10 +++++-----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c         |   10 +++++-----
 arch/powerpc/platforms/52xx/mpc52xx_pic.c         |    6 +++---
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c      |   14 +++++++-------
 arch/powerpc/platforms/85xx/ksi8560.c             |    4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |    4 ++--
 arch/powerpc/platforms/85xx/sbc8560.c             |    4 ++--
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c   |   10 +++++-----
 arch/powerpc/platforms/85xx/stx_gp3.c             |    4 ++--
 arch/powerpc/platforms/85xx/tqm85xx.c             |    4 ++--
 arch/powerpc/platforms/86xx/gef_pic.c             |    6 +++---
 arch/powerpc/platforms/86xx/pic.c                 |    4 ++--
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    6 +++---
 arch/powerpc/platforms/cell/axon_msi.c            |   14 +++++++-------
 arch/powerpc/platforms/cell/beat_interrupt.c      |    2 +-
 arch/powerpc/platforms/cell/interrupt.c           |   16 ++++++++--------
 arch/powerpc/platforms/cell/setup.c               |    8 ++++----
 arch/powerpc/platforms/cell/spider-pic.c          |   12 ++++++------
 arch/powerpc/platforms/chrp/setup.c               |    4 ++--
 arch/powerpc/platforms/embedded6xx/flipper-pic.c  |    8 ++++----
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c     |   16 ++++++++--------
 arch/powerpc/platforms/embedded6xx/holly.c        |    4 ++--
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    4 ++--
 arch/powerpc/platforms/iseries/irq.c              |    4 ++--
 arch/powerpc/platforms/maple/pci.c                |    2 +-
 arch/powerpc/platforms/pasemi/setup.c             |    2 +-
 arch/powerpc/platforms/powermac/pci.c             |    2 +-
 arch/powerpc/platforms/powermac/pic.c             |   12 ++++++------
 arch/powerpc/platforms/ps3/interrupt.c            |   14 +++++++-------
 arch/powerpc/platforms/pseries/msi.c              |    4 ++--
 arch/powerpc/platforms/pseries/setup.c            |    4 ++--
 arch/powerpc/platforms/pseries/xics.c             |    6 +++---
 arch/powerpc/sysdev/cpm1.c                        |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                    |    6 +++---
 arch/powerpc/sysdev/fsl_msi.c                     |   22 +++++++++++-----------
 arch/powerpc/sysdev/i8259.c                       |    4 ++--
 arch/powerpc/sysdev/ipic.c                        |    6 +++---
 arch/powerpc/sysdev/mpc8xx_pic.c                  |    4 ++--
 arch/powerpc/sysdev/mpc8xxx_gpio.c                |   12 ++++++------
 arch/powerpc/sysdev/mpic.c                        |   14 +++++++-------
 arch/powerpc/sysdev/mpic_pasemi_msi.c             |    8 ++++----
 arch/powerpc/sysdev/mpic_u3msi.c                  |    8 ++++----
 arch/powerpc/sysdev/mv64x60_pic.c                 |    3 ++-
 arch/powerpc/sysdev/qe_lib/qe_ic.c                |   14 +++++++-------
 arch/powerpc/sysdev/tsi108_pci.c                  |    4 ++--
 arch/powerpc/sysdev/uic.c                         |   14 +++++++-------
 arch/powerpc/sysdev/xilinx_intc.c                 |   14 +++++++-------
 53 files changed, 190 insertions(+), 189 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -829,7 +829,7 @@ unsigned int irq_create_of_mapping(struc
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
 	    type != (irqd_get_trigger_type(irq_get_irq_data(virq))))
-		set_irq_type(virq, type);
+		irq_set_irq_type(virq, type);
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
@@ -852,7 +852,7 @@ void irq_dispose_mapping(unsigned int vi
 		return;
 
 	/* remove chip and handler */
-	set_irq_chip_and_handler(virq, NULL, NULL);
+	irq_set_chip_and_handler(virq, NULL, NULL);
 
 	/* Make sure it's completed */
 	synchronize_irq(virq);
@@ -1157,7 +1157,7 @@ static int virq_debug_show(struct seq_fi
 			seq_printf(m, "%5d  ", i);
 			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
 
-			chip = get_irq_desc_chip(desc);
+			chip = irq_desc_get_chip(desc);
 			if (chip && chip->name)
 				p = chip->name;
 			else
Index: linux-2.6-tip/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/machine_kexec.c
+++ linux-2.6-tip/arch/powerpc/kernel/machine_kexec.c
@@ -31,7 +31,7 @@ void machine_kexec_mask_interrupts(void)
 		if (!desc)
 			continue;
 
-		chip = get_irq_desc_chip(desc);
+		chip = irq_desc_get_chip(desc);
 		if (!chip)
 			continue;
 
Index: linux-2.6-tip/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/pci-common.c
+++ linux-2.6-tip/arch/powerpc/kernel/pci-common.c
@@ -261,7 +261,7 @@ int pci_read_irq_line(struct pci_dev *pc
 
 		virq = irq_create_mapping(NULL, line);
 		if (virq != NO_IRQ)
-			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
+			irq_set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
 		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
 			 oirq.size, oirq.specifier[0], oirq.specifier[1],
Index: linux-2.6-tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ linux-2.6-tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -133,7 +133,7 @@ cpld_pic_host_map(struct irq_host *h, un
 			     irq_hw_number_t hw)
 {
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &cpld_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &cpld_pic, handle_level_irq);
 	return 0;
 }
 
@@ -198,7 +198,7 @@ mpc5121_ads_cpld_pic_init(void)
 		goto end;
 	}
 
-	set_irq_chained_handler(cascade_irq, cpld_pic_cascade);
+	irq_set_chained_handler(cascade_irq, cpld_pic_cascade);
 end:
 	of_node_put(np);
 }
Index: linux-2.6-tip/arch/powerpc/platforms/52xx/media5200.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/52xx/media5200.c
+++ linux-2.6-tip/arch/powerpc/platforms/52xx/media5200.c
@@ -82,7 +82,7 @@ static struct irq_chip media5200_irq_chi
 
 void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int sub_virq, val;
 	u32 status, enable;
 
@@ -116,8 +116,8 @@ static int media5200_irq_map(struct irq_
 			     irq_hw_number_t hw)
 {
 	pr_debug("%s: h=%p, virq=%i, hwirq=%i\n", __func__, h, virq, (int)hw);
-	set_irq_chip_data(virq, &media5200_irq);
-	set_irq_chip_and_handler(virq, &media5200_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, &media5200_irq);
+	irq_set_chip_and_handler(virq, &media5200_irq_chip, handle_level_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	return 0;
 }
@@ -182,8 +182,8 @@ static void __init media5200_init_irq(vo
 
 	media5200_irq.irqhost->host_data = &media5200_irq;
 
-	set_irq_data(cascade_virq, &media5200_irq);
-	set_irq_chained_handler(cascade_virq, media5200_irq_cascade);
+	irq_set_handler_data(cascade_virq, &media5200_irq);
+	irq_set_chained_handler(cascade_virq, media5200_irq_cascade);
 
 	return;
 
Index: linux-2.6-tip/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ linux-2.6-tip/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -192,7 +192,7 @@ static struct irq_chip mpc52xx_gpt_irq_c
 
 void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_data(virq);
+	struct mpc52xx_gpt_priv *gpt = irq_get_handler_data(virq);
 	int sub_virq;
 	u32 status;
 
@@ -209,8 +209,8 @@ static int mpc52xx_gpt_irq_map(struct ir
 	struct mpc52xx_gpt_priv *gpt = h->host_data;
 
 	dev_dbg(gpt->dev, "%s: h=%p, virq=%i\n", __func__, h, virq);
-	set_irq_chip_data(virq, gpt);
-	set_irq_chip_and_handler(virq, &mpc52xx_gpt_irq_chip, handle_edge_irq);
+	irq_set_chip_data(virq, gpt);
+	irq_set_chip_and_handler(virq, &mpc52xx_gpt_irq_chip, handle_edge_irq);
 
 	return 0;
 }
@@ -259,8 +259,8 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt
 	}
 
 	gpt->irqhost->host_data = gpt;
-	set_irq_data(cascade_virq, gpt);
-	set_irq_chained_handler(cascade_virq, mpc52xx_gpt_irq_cascade);
+	irq_set_handler_data(cascade_virq, gpt);
+	irq_set_chained_handler(cascade_virq, mpc52xx_gpt_irq_cascade);
 
 	/* If the GPT is currently disabled, then change it to be in Input
 	 * Capture mode.  If the mode is non-zero, then the pin could be
Index: linux-2.6-tip/arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -214,7 +214,7 @@ static int mpc52xx_extirq_set_type(struc
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
 	out_be32(&intr->ctrl, ctrl_reg);
 
-	__set_irq_handler_unlocked(d->irq, handler);
+	__irq_set_handler_locked(d->irq, handler);
 
 	return 0;
 }
@@ -414,7 +414,7 @@ static int mpc52xx_irqhost_map(struct ir
 		else
 			hndlr = handle_level_irq;
 
-		set_irq_chip_and_handler(virq, &mpc52xx_extirq_irqchip, hndlr);
+		irq_set_chip_and_handler(virq, &mpc52xx_extirq_irqchip, hndlr);
 		pr_debug("%s: External IRQ%i virq=%x, hw=%x. type=%x\n",
 			 __func__, l2irq, virq, (int)irq, type);
 		return 0;
@@ -431,7 +431,7 @@ static int mpc52xx_irqhost_map(struct ir
 		return -EINVAL;
 	}
 
-	set_irq_chip_and_handler(virq, irqchip, handle_level_irq);
+	irq_set_chip_and_handler(virq, irqchip, handle_level_irq);
 	pr_debug("%s: virq=%x, l1=%i, l2=%i\n", __func__, virq, l1irq, l2irq);
 
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -81,7 +81,7 @@ static struct irq_chip pq2ads_pci_ic = {
 
 static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct pq2ads_pci_pic *priv = get_irq_desc_data(desc);
+	struct pq2ads_pci_pic *priv = irq_desc_get_handler_data(desc);
 	u32 stat, mask, pend;
 	int bit;
 
@@ -107,16 +107,16 @@ static int pci_pic_host_map(struct irq_h
 			    irq_hw_number_t hw)
 {
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_data(virq, h->host_data);
-	set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
+	irq_set_chip_data(virq, h->host_data);
+	irq_set_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
 	return 0;
 }
 
 static void pci_host_unmap(struct irq_host *h, unsigned int virq)
 {
 	/* remove chip and handler */
-	set_irq_chip_data(virq, NULL);
-	set_irq_chip(virq, NULL);
+	irq_set_chip_data(virq, NULL);
+	irq_set_chip(virq, NULL);
 }
 
 static struct irq_host_ops pci_pic_host_ops = {
@@ -175,8 +175,8 @@ int __init pq2ads_pci_init_irq(void)
 
 	priv->host = host;
 	host->host_data = priv;
-	set_irq_data(irq, priv);
-	set_irq_chained_handler(irq, pq2ads_pci_irq_demux);
+	irq_set_handler_data(irq, priv);
+	irq_set_chained_handler(irq, pq2ads_pci_irq_demux);
 
 	of_node_put(np);
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/ksi8560.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/ksi8560.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/ksi8560.c
@@ -56,7 +56,7 @@ static void machine_restart(char *cmd)
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
@@ -106,7 +106,7 @@ static void __init ksi8560_pic_init(void
 
 	cpm2_pic_init(np);
 	of_node_put(np);
-	set_irq_chained_handler(irq, cpm2_cascade);
+	irq_set_chained_handler(irq, cpm2_cascade);
 #endif
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -50,7 +50,7 @@ static int mpc85xx_exclude_device(struct
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
@@ -101,7 +101,7 @@ static void __init mpc85xx_ads_pic_init(
 
 	cpm2_pic_init(np);
 	of_node_put(np);
-	set_irq_chained_handler(irq, cpm2_cascade);
+	irq_set_chained_handler(irq, cpm2_cascade);
 #endif
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -255,7 +255,7 @@ static int mpc85xx_cds_8259_attach(void)
 	}
 
 	/* Success. Connect our low-level cascade handler. */
-	set_irq_handler(cascade_irq, mpc85xx_8259_cascade_handler);
+	irq_set_handler(cascade_irq, mpc85xx_8259_cascade_handler);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_ds.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -47,7 +47,7 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ) {
@@ -122,7 +122,7 @@ void __init mpc85xx_ds_pic_init(void)
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
 
-	set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
 #endif	/* CONFIG_PPC_I8259 */
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/sbc8560.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/sbc8560.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/sbc8560.c
@@ -41,7 +41,7 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
@@ -92,7 +92,7 @@ static void __init sbc8560_pic_init(void
 
 	cpm2_pic_init(np);
 	of_node_put(np);
-	set_irq_chained_handler(irq, cpm2_cascade);
+	irq_set_chained_handler(irq, cpm2_cascade);
 #endif
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -93,7 +93,7 @@ static inline unsigned int socrates_fpga
 
 void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -246,8 +246,8 @@ static int socrates_fpga_pic_host_map(st
 {
 	/* All interrupts are LEVEL sensitive */
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &socrates_fpga_pic_chip,
-			handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, &socrates_fpga_pic_chip,
+				 handle_fasteoi_irq);
 
 	return 0;
 }
@@ -308,8 +308,8 @@ void socrates_fpga_pic_init(struct devic
 			pr_warning("FPGA PIC: can't get irq%d.\n", i);
 			continue;
 		}
-		set_irq_chained_handler(socrates_fpga_irqs[i],
-				socrates_fpga_pic_cascade);
+		irq_set_chained_handler(socrates_fpga_irqs[i],
+					socrates_fpga_pic_cascade);
 	}
 
 	socrates_fpga_pic_iobase = of_iomap(pic, 0);
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/stx_gp3.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/stx_gp3.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -46,7 +46,7 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
@@ -102,7 +102,7 @@ static void __init stx_gp3_pic_init(void
 
 	cpm2_pic_init(np);
 	of_node_put(np);
-	set_irq_chained_handler(irq, cpm2_cascade);
+	irq_set_chained_handler(irq, cpm2_cascade);
 #endif
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/tqm85xx.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/tqm85xx.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -44,7 +44,7 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
@@ -100,7 +100,7 @@ static void __init tqm85xx_pic_init(void
 
 	cpm2_pic_init(np);
 	of_node_put(np);
-	set_irq_chained_handler(irq, cpm2_cascade);
+	irq_set_chained_handler(irq, cpm2_cascade);
 #endif
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/86xx/gef_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/86xx/gef_pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/86xx/gef_pic.c
@@ -95,7 +95,7 @@ static int gef_pic_cascade_irq;
 
 void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -164,7 +164,7 @@ static int gef_pic_host_map(struct irq_h
 {
 	/* All interrupts are LEVEL sensitive */
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);
 
 	return 0;
 }
@@ -225,7 +225,7 @@ void __init gef_pic_init(struct device_n
 		return;
 
 	/* Chain with parent controller */
-	set_irq_chained_handler(gef_pic_cascade_irq, gef_pic_cascade);
+	irq_set_chained_handler(gef_pic_cascade_irq, gef_pic_cascade);
 }
 
 /*
Index: linux-2.6-tip/arch/powerpc/platforms/86xx/pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/86xx/pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/86xx/pic.c
@@ -19,7 +19,7 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
@@ -77,6 +77,6 @@ void __init mpc86xx_init_irq(void)
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
 
-	set_irq_chained_handler(cascade_irq, mpc86xx_8259_cascade);
+	irq_set_chained_handler(cascade_irq, mpc86xx_8259_cascade);
 #endif
 }
Index: linux-2.6-tip/arch/powerpc/platforms/8xx/m8xx_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ linux-2.6-tip/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -226,11 +226,11 @@ static void cpm_cascade(unsigned int irq
 
 		generic_handle_irq(cascade_irq);
 
-		chip = get_irq_desc_chip(cdesc);
+		chip = irq_desc_get_chip(cdesc);
 		chip->irq_eoi(&cdesc->irq_data);
 	}
 
-	chip = get_irq_desc_chip(desc);
+	chip = irq_desc_get_chip(desc);
 	chip->irq_eoi(&desc->irq_data);
 }
 
@@ -251,5 +251,5 @@ void __init mpc8xx_pics_init(void)
 
 	irq = cpm_pic_init();
 	if (irq != NO_IRQ)
-		set_irq_chained_handler(irq, cpm_cascade);
+		irq_set_chained_handler(irq, cpm_cascade);
 }
Index: linux-2.6-tip/arch/powerpc/platforms/cell/axon_msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/axon_msi.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/axon_msi.c
@@ -93,8 +93,8 @@ static void msic_dcr_write(struct axon_m
 
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
-	struct axon_msic *msic = get_irq_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct axon_msic *msic = irq_get_handler_data(irq);
 	u32 write_offset, msi;
 	int idx;
 	int retry = 0;
@@ -287,7 +287,7 @@ static int axon_msi_setup_msi_irqs(struc
 		}
 		dev_dbg(&dev->dev, "axon_msi: allocated virq 0x%x\n", virq);
 
-		set_irq_msi(virq, entry);
+		irq_set_msi_desc(virq, entry);
 		msg.data = virq;
 		write_msi_msg(virq, &msg);
 	}
@@ -305,7 +305,7 @@ static void axon_msi_teardown_msi_irqs(s
 		if (entry->irq == NO_IRQ)
 			continue;
 
-		set_irq_msi(entry->irq, NULL);
+		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}
 }
@@ -320,7 +320,7 @@ static struct irq_chip msic_irq_chip = {
 static int msic_host_map(struct irq_host *h, unsigned int virq,
 			 irq_hw_number_t hw)
 {
-	set_irq_chip_and_handler(virq, &msic_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(virq, &msic_irq_chip, handle_simple_irq);
 
 	return 0;
 }
@@ -400,8 +400,8 @@ static int axon_msi_probe(struct platfor
 
 	msic->irq_host->host_data = msic;
 
-	set_irq_data(virq, msic);
-	set_irq_chained_handler(virq, axon_msi_cascade);
+	irq_set_handler_data(virq, msic);
+	irq_set_chained_handler(virq, axon_msi_cascade);
 	pr_devel("axon_msi: irq 0x%x setup for axon_msi\n", virq);
 
 	/* Enable the MSIC hardware */
Index: linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/beat_interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -143,7 +143,7 @@ static int beatic_pic_host_map(struct ir
 		return -EIO;
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &beatic_pic, handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, &beatic_pic, handle_fasteoi_irq);
 	return 0;
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/interrupt.c
@@ -101,9 +101,9 @@ static void iic_ioexc_eoi(struct irq_dat
 
 static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct cbe_iic_regs __iomem *node_iic =
-		(void __iomem *)get_irq_desc_data(desc);
+		(void __iomem *)irq_desc_get_handler_data(desc);
 	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
 	unsigned long bits, ack;
 	int cascade;
@@ -239,7 +239,7 @@ extern int noirqdebug;
 
 static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	raw_spin_lock(&desc->lock);
 
@@ -288,14 +288,14 @@ static int iic_host_map(struct irq_host 
 {
 	switch (hw & IIC_IRQ_TYPE_MASK) {
 	case IIC_IRQ_TYPE_IPI:
-		set_irq_chip_and_handler(virq, &iic_chip, handle_percpu_irq);
+		irq_set_chip_and_handler(virq, &iic_chip, handle_percpu_irq);
 		break;
 	case IIC_IRQ_TYPE_IOEXC:
-		set_irq_chip_and_handler(virq, &iic_ioexc_chip,
+		irq_set_chip_and_handler(virq, &iic_ioexc_chip,
 					 handle_iic_irq);
 		break;
 	default:
-		set_irq_chip_and_handler(virq, &iic_chip, handle_iic_irq);
+		irq_set_chip_and_handler(virq, &iic_chip, handle_iic_irq);
 	}
 	return 0;
 }
@@ -412,8 +412,8 @@ static int __init setup_iic(void)
 		 * irq_data is a generic pointer that gets passed back
 		 * to us later, so the forced cast is fine.
 		 */
-		set_irq_data(cascade, (void __force *)node_iic);
-		set_irq_chained_handler(cascade , iic_ioexc_cascade);
+		irq_set_handler_data(cascade, (void __force *)node_iic);
+		irq_set_chained_handler(cascade, iic_ioexc_cascade);
 		out_be64(&node_iic->iic_ir,
 			 (1 << 12)		/* priority */ |
 			 (node << 4)		/* dest node */ |
Index: linux-2.6-tip/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/setup.c
@@ -187,8 +187,8 @@ machine_subsys_initcall(cell, cell_publi
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
-	struct mpic *mpic = get_irq_desc_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mpic *mpic = irq_desc_get_handler_data(desc);
 	unsigned int virq;
 
 	virq = mpic_get_one_irq(mpic);
@@ -223,8 +223,8 @@ static void __init mpic_init_IRQ(void)
 
 		printk(KERN_INFO "%s : hooking up to IRQ %d\n",
 		       dn->full_name, virq);
-		set_irq_data(virq, mpic);
-		set_irq_chained_handler(virq, cell_mpic_cascade);
+		irq_set_handler_data(virq, mpic);
+		irq_set_chained_handler(virq, cell_mpic_cascade);
 	}
 }
 
Index: linux-2.6-tip/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/spider-pic.c
@@ -171,10 +171,10 @@ static struct irq_chip spider_pic = {
 static int spider_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
-	set_irq_chip_and_handler(virq, &spider_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &spider_pic, handle_level_irq);
 
 	/* Set default irq type */
-	set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
 	return 0;
 }
@@ -200,8 +200,8 @@ static struct irq_host_ops spider_host_o
 
 static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
-	struct spider_pic *pic = get_irq_desc_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct spider_pic *pic = irq_desc_get_handler_data(desc);
 	unsigned int cs, virq;
 
 	cs = in_be32(pic->regs + TIR_CS) >> 24;
@@ -321,8 +321,8 @@ static void __init spider_init_one(struc
 	virq = spider_find_cascade_and_node(pic);
 	if (virq == NO_IRQ)
 		return;
-	set_irq_data(virq, pic);
-	set_irq_chained_handler(virq, spider_irq_cascade);
+	irq_set_handler_data(virq, pic);
+	irq_set_chained_handler(virq, spider_irq_cascade);
 
 	printk(KERN_INFO "spider_pic: node %d, addr: 0x%lx %s\n",
 	       pic->node_id, addr, of_node->full_name);
Index: linux-2.6-tip/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6-tip/arch/powerpc/platforms/chrp/setup.c
@@ -365,7 +365,7 @@ void __init chrp_setup_arch(void)
 
 static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
@@ -517,7 +517,7 @@ static void __init chrp_find_8259(void)
 		if (cascade_irq == NO_IRQ)
 			printk(KERN_ERR "i8259: failed to map cascade irq\n");
 		else
-			set_irq_chained_handler(cascade_irq,
+			irq_set_chained_handler(cascade_irq,
 						chrp_8259_cascade);
 	}
 }
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/flipper-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -101,16 +101,16 @@ static struct irq_host *flipper_irq_host
 static int flipper_pic_map(struct irq_host *h, unsigned int virq,
 			   irq_hw_number_t hwirq)
 {
-	set_irq_chip_data(virq, h->host_data);
+	irq_set_chip_data(virq, h->host_data);
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &flipper_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &flipper_pic, handle_level_irq);
 	return 0;
 }
 
 static void flipper_pic_unmap(struct irq_host *h, unsigned int irq)
 {
-	set_irq_chip_data(irq, NULL);
-	set_irq_chip(irq, NULL);
+	irq_set_chip_data(irq, NULL);
+	irq_set_chip(irq, NULL);
 }
 
 static int flipper_pic_match(struct irq_host *h, struct device_node *np)
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -94,16 +94,16 @@ static struct irq_host *hlwd_irq_host;
 static int hlwd_pic_map(struct irq_host *h, unsigned int virq,
 			   irq_hw_number_t hwirq)
 {
-	set_irq_chip_data(virq, h->host_data);
+	irq_set_chip_data(virq, h->host_data);
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &hlwd_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &hlwd_pic, handle_level_irq);
 	return 0;
 }
 
 static void hlwd_pic_unmap(struct irq_host *h, unsigned int irq)
 {
-	set_irq_chip_data(irq, NULL);
-	set_irq_chip(irq, NULL);
+	irq_set_chip_data(irq, NULL);
+	irq_set_chip(irq, NULL);
 }
 
 static struct irq_host_ops hlwd_irq_host_ops = {
@@ -129,8 +129,8 @@ static unsigned int __hlwd_pic_get_irq(s
 static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 				      struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
-	struct irq_host *irq_host = get_irq_data(cascade_virq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_host *irq_host = irq_get_handler_data(cascade_virq);
 	unsigned int virq;
 
 	raw_spin_lock(&desc->lock);
@@ -218,8 +218,8 @@ void hlwd_pic_probe(void)
 			host = hlwd_pic_init(np);
 			BUG_ON(!host);
 			cascade_virq = irq_of_parse_and_map(np, 0);
-			set_irq_data(cascade_virq, host);
-			set_irq_chained_handler(cascade_virq,
+			irq_set_handler_data(cascade_virq, host);
+			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
 			hlwd_irq_host = host;
 			break;
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/holly.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/holly.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/holly.c
@@ -198,8 +198,8 @@ static void __init holly_init_IRQ(void)
 	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
 	pr_debug("%s: tsi108 cascade_pci_irq = 0x%x\n", __func__, (u32) cascade_pci_irq);
 	tsi108_pci_int_init(cascade_node);
-	set_irq_data(cascade_pci_irq, mpic);
-	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+	irq_set_handler_data(cascade_pci_irq, mpic);
+	irq_set_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -153,8 +153,8 @@ static void __init mpc7448_hpc2_init_IRQ
 	DBG("%s: tsi108 cascade_pci_irq = 0x%x\n", __func__,
 	    (u32) cascade_pci_irq);
 	tsi108_pci_int_init(cascade_node);
-	set_irq_data(cascade_pci_irq, mpic);
-	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+	irq_set_handler_data(cascade_pci_irq, mpic);
+	irq_set_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
Index: linux-2.6-tip/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/iseries/irq.c
+++ linux-2.6-tip/arch/powerpc/platforms/iseries/irq.c
@@ -220,7 +220,7 @@ void __init iSeries_activate_IRQs()
 		if (!desc)
 			continue;
 
-		chip = get_irq_desc_chip(desc);
+		chip = irq_desc_get_chip(desc);
 		if (chip && chip->irq_startup) {
 			raw_spin_lock_irqsave(&desc->lock, flags);
 			chip->irq_startup(&desc->irq_data);
@@ -346,7 +346,7 @@ unsigned int iSeries_get_irq(void)
 static int iseries_irq_host_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
-	set_irq_chip_and_handler(virq, &iseries_pic, handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, &iseries_pic, handle_fasteoi_irq);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6-tip/arch/powerpc/platforms/maple/pci.c
@@ -498,7 +498,7 @@ void __devinit maple_pci_irq_fixup(struc
 		printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
 		dev->irq = irq_create_mapping(NULL, 1);
 		if (dev->irq != NO_IRQ)
-			set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
+			irq_set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
 	}
 
 	/* Hide AMD8111 IDE interrupt when in legacy mode so
Index: linux-2.6-tip/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pasemi/setup.c
+++ linux-2.6-tip/arch/powerpc/platforms/pasemi/setup.c
@@ -239,7 +239,7 @@ static __init void pas_init_IRQ(void)
 	if (nmiprop) {
 		nmi_virq = irq_create_mapping(NULL, *nmiprop);
 		mpic_irq_set_priority(nmi_virq, 15);
-		set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
+		irq_set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pci.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pci.c
@@ -988,7 +988,7 @@ void __devinit pmac_pci_irq_fixup(struct
 	    dev->vendor == PCI_VENDOR_ID_DEC &&
 	    dev->device == PCI_DEVICE_ID_DEC_TULIP_PLUS) {
 		dev->irq = irq_create_mapping(NULL, 60);
-		set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
 	}
 #endif /* CONFIG_PPC32 */
 }
Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
@@ -300,8 +300,8 @@ static int pmac_pic_host_map(struct irq_
 	level = !!(level_mask[hw >> 5] & (1UL << (hw & 0x1f)));
 	if (level)
 		irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &pmac_pic, level ?
-				 handle_level_irq : handle_edge_irq);
+	irq_set_chip_and_handler(virq, &pmac_pic,
+				 level ? handle_level_irq : handle_edge_irq);
 	return 0;
 }
 
@@ -471,8 +471,8 @@ int of_irq_map_oldworld(struct device_no
 
 static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
-	struct mpic *mpic = get_irq_desc_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mpic *mpic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = mpic_get_one_irq(mpic);
 
 	if (cascade_irq != NO_IRQ)
@@ -590,8 +590,8 @@ static int __init pmac_pic_probe_mpic(vo
 		of_node_put(slave);
 		return 0;
 	}
-	set_irq_data(cascade, mpic2);
-	set_irq_chained_handler(cascade, pmac_u3_cascade);
+	irq_set_handler_data(cascade, mpic2);
+	irq_set_chained_handler(cascade, pmac_u3_cascade);
 
 	of_node_put(slave);
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/ps3/interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/ps3/interrupt.c
@@ -194,7 +194,7 @@ static int ps3_virq_setup(enum ps3_cpu_b
 	pr_debug("%s:%d: outlet %lu => cpu %u, virq %u\n", __func__, __LINE__,
 		outlet, cpu, *virq);
 
-	result = set_irq_chip_data(*virq, pd);
+	result = irq_set_chip_data(*virq, pd);
 
 	if (result) {
 		pr_debug("%s:%d: set_irq_chip_data failed\n",
@@ -221,12 +221,12 @@ fail_create:
 
 static int ps3_virq_destroy(unsigned int virq)
 {
-	const struct ps3_private *pd = get_irq_chip_data(virq);
+	const struct ps3_private *pd = irq_get_chip_data(virq);
 
 	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
-	set_irq_chip_data(virq, NULL);
+	irq_set_chip_data(virq, NULL);
 	irq_dispose_mapping(virq);
 
 	pr_debug("%s:%d <-\n", __func__, __LINE__);
@@ -256,7 +256,7 @@ int ps3_irq_plug_setup(enum ps3_cpu_bind
 		goto fail_setup;
 	}
 
-	pd = get_irq_chip_data(*virq);
+	pd = irq_get_chip_data(*virq);
 
 	/* Binds outlet to cpu + virq. */
 
@@ -291,7 +291,7 @@ EXPORT_SYMBOL_GPL(ps3_irq_plug_setup);
 int ps3_irq_plug_destroy(unsigned int virq)
 {
 	int result;
-	const struct ps3_private *pd = get_irq_chip_data(virq);
+	const struct ps3_private *pd = irq_get_chip_data(virq);
 
 	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
@@ -661,7 +661,7 @@ static void dump_bmp(struct ps3_private*
 
 static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
 {
-	set_irq_chip_data(virq, NULL);
+	irq_set_chip_data(virq, NULL);
 }
 
 static int ps3_host_map(struct irq_host *h, unsigned int virq,
@@ -670,7 +670,7 @@ static int ps3_host_map(struct irq_host 
 	pr_debug("%s:%d: hwirq %lu, virq %u\n", __func__, __LINE__, hwirq,
 		virq);
 
-	set_irq_chip_and_handler(virq, &ps3_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, &ps3_irq_chip, handle_fasteoi_irq);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/pseries/msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pseries/msi.c
+++ linux-2.6-tip/arch/powerpc/platforms/pseries/msi.c
@@ -137,7 +137,7 @@ static void rtas_teardown_msi_irqs(struc
 		if (entry->irq == NO_IRQ)
 			continue;
 
-		set_irq_msi(entry->irq, NULL);
+		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}
 
@@ -437,7 +437,7 @@ static int rtas_setup_msi_irqs(struct pc
 		}
 
 		dev_dbg(&pdev->dev, "rtas_msi: allocated virq %d\n", virq);
-		set_irq_msi(virq, entry);
+		irq_set_msi_desc(virq, entry);
 
 		/* Read config space back so we can restore after reset */
 		read_msi_msg(virq, &msg);
Index: linux-2.6-tip/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6-tip/arch/powerpc/platforms/pseries/setup.c
@@ -114,7 +114,7 @@ static void __init fwnmi_init(void)
 
 static void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
@@ -169,7 +169,7 @@ static void __init pseries_setup_i8259_c
 		printk(KERN_DEBUG "pic: PCI 8259 intack at 0x%016lx\n", intack);
 	i8259_init(found, intack);
 	of_node_put(found);
-	set_irq_chained_handler(cascade, pseries_8259_cascade);
+	irq_set_chained_handler(cascade, pseries_8259_cascade);
 }
 
 static void __init pseries_mpic_init_IRQ(void)
Index: linux-2.6-tip/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6-tip/arch/powerpc/platforms/pseries/xics.c
@@ -471,7 +471,7 @@ static int xics_host_map(struct irq_host
 	irq_radix_revmap_insert(xics_host, virq, hw);
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
 	return 0;
 }
 
@@ -600,7 +600,7 @@ static void xics_request_ipi(void)
 	 * IPIs are marked IRQF_DISABLED as they must run with irqs
 	 * disabled
 	 */
-	set_irq_handler(ipi, handle_percpu_irq);
+	irq_set_handler(ipi, handle_percpu_irq);
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		rc = request_irq(ipi, xics_ipi_action_lpar,
 				IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
@@ -912,7 +912,7 @@ void xics_migrate_irqs_away(void)
 		if (desc == NULL || desc->action == NULL)
 			continue;
 
-		chip = get_irq_desc_chip(desc);
+		chip = irq_desc_get_chip(desc);
 		if (chip == NULL || chip->irq_set_affinity == NULL)
 			continue;
 
Index: linux-2.6-tip/arch/powerpc/sysdev/cpm1.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm1.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm1.c
@@ -104,7 +104,7 @@ static int cpm_pic_host_map(struct irq_h
 	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
+	irq_set_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
 	return 0;
 }
 
Index: linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
@@ -157,9 +157,9 @@ static int cpm2_set_irq_type(struct irq_
 
 	irqd_set_trigger_type(d, flow_type);
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)
-		__set_irq_handler_unlocked(d->irq, handle_level_irq);
+		__irq_set_handler_locked(d->irq, handle_level_irq);
 	else
-		__set_irq_handler_unlocked(d->irq, handle_edge_irq);
+		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
 	/* internal IRQ senses are LEVEL_LOW
 	 * EXT IRQ and Port C IRQ senses are programmable
@@ -220,7 +220,7 @@ static int cpm2_pic_host_map(struct irq_
 	pr_debug("cpm2_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &cpm2_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &cpm2_pic, handle_level_irq);
 	return 0;
 }
 
Index: linux-2.6-tip/arch/powerpc/sysdev/fsl_msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/fsl_msi.c
+++ linux-2.6-tip/arch/powerpc/sysdev/fsl_msi.c
@@ -66,8 +66,8 @@ static int fsl_msi_host_map(struct irq_h
 
 	irq_set_status_flags(virq, IRQ_TYPE_EDGE_FALLING);
 
-	set_irq_chip_data(virq, msi_data);
-	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
+	irq_set_chip_data(virq, msi_data);
+	irq_set_chip_and_handler(virq, chip, handle_edge_irq);
 
 	return 0;
 }
@@ -110,8 +110,8 @@ static void fsl_teardown_msi_irqs(struct
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (entry->irq == NO_IRQ)
 			continue;
-		msi_data = get_irq_data(entry->irq);
-		set_irq_msi(entry->irq, NULL);
+		msi_data = irq_get_handler_data(entry->irq);
+		irq_set_msi_desc(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap,
 				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
@@ -168,8 +168,8 @@ static int fsl_setup_msi_irqs(struct pci
 			rc = -ENOSPC;
 			goto out_free;
 		}
-		set_irq_data(virq, msi_data);
-		set_irq_msi(virq, entry);
+		irq_set_handler_data(virq, msi_data);
+		irq_set_msi_desc(virq, entry);
 
 		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
 		write_msi_msg(virq, &msg);
@@ -183,7 +183,7 @@ out_free:
 
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
 	struct fsl_msi *msi_data;
 	int msir_index = -1;
@@ -192,7 +192,7 @@ static void fsl_msi_cascade(unsigned int
 	u32 have_shift = 0;
 	struct fsl_msi_cascade_data *cascade_data;
 
-	cascade_data = (struct fsl_msi_cascade_data *)get_irq_data(irq);
+	cascade_data = (struct fsl_msi_cascade_data *)irq_get_handler_data(irq);
 	msi_data = cascade_data->msi_data;
 
 	raw_spin_lock(&desc->lock);
@@ -261,7 +261,7 @@ static int fsl_of_msi_remove(struct plat
 	for (i = 0; i < NR_MSI_REG; i++) {
 		virq = msi->msi_virqs[i];
 		if (virq != NO_IRQ) {
-			cascade_data = get_irq_data(virq);
+			cascade_data = irq_get_handler_data(virq);
 			kfree(cascade_data);
 			irq_dispose_mapping(virq);
 		}
@@ -297,8 +297,8 @@ static int __devinit fsl_msi_setup_hwirq
 	msi->msi_virqs[irq_index] = virt_msir;
 	cascade_data->index = offset + irq_index;
 	cascade_data->msi_data = msi;
-	set_irq_data(virt_msir, cascade_data);
-	set_irq_chained_handler(virt_msir, fsl_msi_cascade);
+	irq_set_handler_data(virt_msir, cascade_data);
+	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/i8259.c
+++ linux-2.6-tip/arch/powerpc/sysdev/i8259.c
@@ -181,7 +181,7 @@ static int i8259_host_map(struct irq_hos
 	 * be more cautious here but that works for now
 	 */
 	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_chip_and_handler(virq, &i8259_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &i8259_pic, handle_level_irq);
 	return 0;
 }
 
@@ -191,7 +191,7 @@ static void i8259_host_unmap(struct irq_
 	i8259_mask_irq(irq_get_irq_data(virq));
 
 	/* remove chip and handler */
-	set_irq_chip_and_handler(virq, NULL, NULL);
+	irq_set_chip_and_handler(virq, NULL, NULL);
 
 	/* Make sure it's completed */
 	synchronize_irq(virq);
Index: linux-2.6-tip/arch/powerpc/sysdev/ipic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/ipic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/ipic.c
@@ -685,11 +685,11 @@ static int ipic_host_map(struct irq_host
 {
 	struct ipic *ipic = h->host_data;
 
-	set_irq_chip_data(virq, ipic);
-	set_irq_chip_and_handler(virq, &ipic_level_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, ipic);
+	irq_set_chip_and_handler(virq, &ipic_level_irq_chip, handle_level_irq);
 
 	/* Set default irq type */
-	set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/mpc8xx_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpc8xx_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -80,7 +80,7 @@ static int mpc8xx_set_irq_type(struct ir
 		if ((hw & 1) == 0) {
 			siel |= (0x80000000 >> hw);
 			out_be32(&siu_reg->sc_siel, siel);
-			__set_irq_handler_unlocked(irq, handle_edge_irq);
+			__irq_set_handler_locked(irq, handle_edge_irq);
 		}
 	}
 	return 0;
@@ -117,7 +117,7 @@ static int mpc8xx_pic_host_map(struct ir
 	pr_debug("mpc8xx_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
 	/* Set default irq handle */
-	set_irq_chip_and_handler(virq, &mpc8xx_pic, handle_level_irq);
+	irq_set_chip_and_handler(virq, &mpc8xx_pic, handle_level_irq);
 	return 0;
 }
 
Index: linux-2.6-tip/arch/powerpc/sysdev/mpc8xxx_gpio.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -145,7 +145,7 @@ static int mpc8xxx_gpio_to_irq(struct gp
 
 static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_desc_data(desc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_desc_get_handler_data(desc);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned int mask;
 
@@ -278,9 +278,9 @@ static int mpc8xxx_gpio_irq_map(struct i
 	if (mpc8xxx_gc->of_dev_id_data)
 		mpc8xxx_irq_chip.irq_set_type = mpc8xxx_gc->of_dev_id_data;
 
-	set_irq_chip_data(virq, h->host_data);
-	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
-	set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_chip_data(virq, h->host_data);
+	irq_set_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
 	return 0;
 }
@@ -369,8 +369,8 @@ static void __init mpc8xxx_add_controlle
 	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
 	out_be32(mm_gc->regs + GPIO_IMR, 0);
 
-	set_irq_data(hwirq, mpc8xxx_gc);
-	set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
+	irq_set_handler_data(hwirq, mpc8xxx_gc);
+	irq_set_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
 
 skip_irq:
 	return;
Index: linux-2.6-tip/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpic.c
@@ -615,7 +615,7 @@ static struct mpic *mpic_find(unsigned i
 	if (irq < NUM_ISA_INTERRUPTS)
 		return NULL;
 
-	return get_irq_chip_data(irq);
+	return irq_get_chip_data(irq);
 }
 
 /* Determine if the linux irq is an IPI */
@@ -649,7 +649,7 @@ static inline struct mpic * mpic_from_ip
 /* Get the mpic structure from the irq number */
 static inline struct mpic * mpic_from_irq(unsigned int irq)
 {
-	return get_irq_chip_data(irq);
+	return irq_get_chip_data(irq);
 }
 
 /* Get the mpic structure from the irq data */
@@ -978,8 +978,8 @@ static int mpic_host_map(struct irq_host
 		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
 
 		DBG("mpic: mapping as IPI\n");
-		set_irq_chip_data(virq, mpic);
-		set_irq_chip_and_handler(virq, &mpic->hc_ipi,
+		irq_set_chip_data(virq, mpic);
+		irq_set_chip_and_handler(virq, &mpic->hc_ipi,
 					 handle_percpu_irq);
 		return 0;
 	}
@@ -1001,11 +1001,11 @@ static int mpic_host_map(struct irq_host
 
 	DBG("mpic: mapping to irq chip @%p\n", chip);
 
-	set_irq_chip_data(virq, mpic);
-	set_irq_chip_and_handler(virq, chip, handle_fasteoi_irq);
+	irq_set_chip_data(virq, mpic);
+	irq_set_chip_and_handler(virq, chip, handle_fasteoi_irq);
 
 	/* Set default irq type */
-	set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
 	/* If the MPIC was reset, then all vectors have already been
 	 * initialized.  Otherwise, a per source lazy initialization
Index: linux-2.6-tip/arch/powerpc/sysdev/mpic_pasemi_msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -81,7 +81,7 @@ static void pasemi_msi_teardown_msi_irqs
 		if (entry->irq == NO_IRQ)
 			continue;
 
-		set_irq_msi(entry->irq, NULL);
+		irq_set_msi_desc(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
 				       virq_to_hw(entry->irq), ALLOC_CHUNK);
 		irq_dispose_mapping(entry->irq);
@@ -131,9 +131,9 @@ static int pasemi_msi_setup_msi_irqs(str
 		 */
 		mpic_set_vector(virq, 0);
 
-		set_irq_msi(virq, entry);
-		set_irq_chip(virq, &mpic_pasemi_msi_chip);
-		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+		irq_set_msi_desc(virq, entry);
+		irq_set_chip(virq, &mpic_pasemi_msi_chip);
+		irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
 		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%x) " \
 			 "addr 0x%x\n", virq, hwirq, msg.address_lo);
Index: linux-2.6-tip/arch/powerpc/sysdev/mpic_u3msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpic_u3msi.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpic_u3msi.c
@@ -129,7 +129,7 @@ static void u3msi_teardown_msi_irqs(stru
 		if (entry->irq == NO_IRQ)
 			continue;
 
-		set_irq_msi(entry->irq, NULL);
+		irq_set_msi_desc(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
 				       virq_to_hw(entry->irq), 1);
 		irq_dispose_mapping(entry->irq);
@@ -166,9 +166,9 @@ static int u3msi_setup_msi_irqs(struct p
 			return -ENOSPC;
 		}
 
-		set_irq_msi(virq, entry);
-		set_irq_chip(virq, &mpic_u3msi_chip);
-		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+		irq_set_msi_desc(virq, entry);
+		irq_set_chip(virq, &mpic_u3msi_chip);
+		irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
 		pr_debug("u3msi: allocated virq 0x%x (hw 0x%x) addr 0x%lx\n",
 			  virq, hwirq, (unsigned long)addr);
Index: linux-2.6-tip/arch/powerpc/sysdev/mv64x60_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mv64x60_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mv64x60_pic.c
@@ -217,7 +217,8 @@ static int mv64x60_host_map(struct irq_h
 
 	level1 = (hwirq & MV64x60_LEVEL1_MASK) >> MV64x60_LEVEL1_OFFSET;
 	BUG_ON(level1 > MV64x60_LEVEL1_GPP);
-	set_irq_chip_and_handler(virq, mv64x60_chips[level1], handle_level_irq);
+	irq_set_chip_and_handler(virq, mv64x60_chips[level1],
+				 handle_level_irq);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/qe_lib/qe_ic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -189,7 +189,7 @@ static inline void qe_ic_write(volatile 
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
 {
-	return get_irq_chip_data(virq);
+	return irq_get_chip_data(virq);
 }
 
 static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
@@ -267,10 +267,10 @@ static int qe_ic_host_map(struct irq_hos
 	/* Default chip */
 	chip = &qe_ic->hc_irq;
 
-	set_irq_chip_data(virq, qe_ic);
+	irq_set_chip_data(virq, qe_ic);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 
-	set_irq_chip_and_handler(virq, chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, chip, handle_level_irq);
 
 	return 0;
 }
@@ -386,13 +386,13 @@ void __init qe_ic_init(struct device_nod
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-	set_irq_data(qe_ic->virq_low, qe_ic);
-	set_irq_chained_handler(qe_ic->virq_low, low_handler);
+	irq_set_handler_data(qe_ic->virq_low, qe_ic);
+	irq_set_chained_handler(qe_ic->virq_low, low_handler);
 
 	if (qe_ic->virq_high != NO_IRQ &&
 			qe_ic->virq_high != qe_ic->virq_low) {
-		set_irq_data(qe_ic->virq_high, qe_ic);
-		set_irq_chained_handler(qe_ic->virq_high, high_handler);
+		irq_set_handler_data(qe_ic->virq_high, qe_ic);
+		irq_set_chained_handler(qe_ic->virq_high, high_handler);
 	}
 }
 
Index: linux-2.6-tip/arch/powerpc/sysdev/tsi108_pci.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6-tip/arch/powerpc/sysdev/tsi108_pci.c
@@ -392,7 +392,7 @@ static int pci_irq_host_map(struct irq_h
 	if ((virq >= 1) && (virq <= 4)){
 		irq = virq + IRQ_PCI_INTAD_BASE - 1;
 		irq_set_status_flags(irq, IRQ_LEVEL);
-		set_irq_chip(irq, &tsi108_pci_irq);
+		irq_set_chip(irq, &tsi108_pci_irq);
 	}
 	return 0;
 }
@@ -431,7 +431,7 @@ void __init tsi108_pci_int_init(struct d
 
 void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = get_pci_source();
 
 	if (cascade_irq != NO_IRQ)
Index: linux-2.6-tip/arch/powerpc/sysdev/uic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/uic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/uic.c
@@ -182,13 +182,13 @@ static int uic_host_map(struct irq_host 
 {
 	struct uic *uic = h->host_data;
 
-	set_irq_chip_data(virq, uic);
+	irq_set_chip_data(virq, uic);
 	/* Despite the name, handle_level_irq() works for both level
 	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
 
 	/* Set default irq type */
-	set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
 	return 0;
 }
@@ -212,9 +212,9 @@ static struct irq_host_ops uic_host_ops 
 
 void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_data *idata = irq_desc_get_irq_data(desc);
-	struct uic *uic = get_irq_data(virq);
+	struct uic *uic = irq_get_handler_data(virq);
 	u32 msr;
 	int src;
 	int subvirq;
@@ -329,8 +329,8 @@ void __init uic_init_tree(void)
 
 			cascade_virq = irq_of_parse_and_map(np, 0);
 
-			set_irq_data(cascade_virq, uic);
-			set_irq_chained_handler(cascade_virq, uic_irq_cascade);
+			irq_set_handler_data(cascade_virq, uic);
+			irq_set_chained_handler(cascade_virq, uic_irq_cascade);
 
 			/* FIXME: setup critical cascade?? */
 		}
Index: linux-2.6-tip/arch/powerpc/sysdev/xilinx_intc.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/xilinx_intc.c
+++ linux-2.6-tip/arch/powerpc/sysdev/xilinx_intc.c
@@ -164,15 +164,15 @@ static int xilinx_intc_xlate(struct irq_
 static int xilinx_intc_map(struct irq_host *h, unsigned int virq,
 				  irq_hw_number_t irq)
 {
-	set_irq_chip_data(virq, h->host_data);
+	irq_set_chip_data(virq, h->host_data);
 
 	if (xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_HIGH ||
 	    xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_LOW) {
-		set_irq_chip_and_handler(virq, &xilinx_intc_level_irqchip,
-			handle_level_irq);
+		irq_set_chip_and_handler(virq, &xilinx_intc_level_irqchip,
+					 handle_level_irq);
 	} else {
-		set_irq_chip_and_handler(virq, &xilinx_intc_edge_irqchip,
-			handle_edge_irq);
+		irq_set_chip_and_handler(virq, &xilinx_intc_edge_irqchip,
+					 handle_edge_irq);
 	}
 	return 0;
 }
@@ -223,7 +223,7 @@ int xilinx_intc_get_irq(void)
  */
 static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq)
@@ -250,7 +250,7 @@ static void __init xilinx_i8259_setup_ca
 	}
 
 	i8259_init(cascade_node, 0);
-	set_irq_chained_handler(cascade_irq, xilinx_i8259_cascade);
+	irq_set_chained_handler(cascade_irq, xilinx_i8259_cascade);
 
 	/* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive */
 	/* This looks like a dirty hack to me --gcl */
