Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6440BDEF9C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1Zls3019124
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:48 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZlmC001522
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:47 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B6Eh007938
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:06 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4C8A5AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:46 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zk7i015400
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:46 -0500
Date: Tue, 17 Jul 2007 20:35:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 35/61] 82xx: Factor PCI PIC out of 8272ads code.
Message-ID: <20070718013546.GG15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The same PIC exists on other boards, such as the PQ2FADS.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig                         |    2 +-
 arch/powerpc/platforms/82xx/Kconfig          |    4 +
 arch/powerpc/platforms/82xx/Makefile         |    1 +
 arch/powerpc/platforms/82xx/mpc8272ads.c     |  190 +------------------------
 arch/powerpc/platforms/82xx/pq2.h            |    9 ++
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |  200 ++++++++++++++++++++++++++
 6 files changed, 218 insertions(+), 188 deletions(-)
 create mode 100644 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cbfbd98..1a96260 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -458,7 +458,7 @@ config PCI_8260
 
 config 8260_PCI9
 	bool "Enable workaround for MPC826x erratum PCI 9"
-	depends on PCI_8260 && !ADS8272
+	depends on PCI_8260 && !8272
 	default y
 
 choice
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index b4af8c2..428e1e5 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -10,6 +10,7 @@ config MPC8272ADS
 	select 8272
 	select 8260
 	select FSL_SOC
+	select PQ2_ADS_PCI_PIC if PCI
 	help
 	This option enables support for the MPC8272 ADS board
 
@@ -34,3 +35,6 @@ config 8272
 	help
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
+
+config PQ2_ADS_PCI_PIC
+	bool
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 6049640..57c9e1d 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -4,3 +4,4 @@
 obj-$(CONFIG_PPC_82xx) += mpc82xx.o
 obj-$(CONFIG_MPC8272ADS) += mpc8272ads.o
 obj-$(CONFIG_CPM2) += pq2.o
+obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index b23fa73..e5b7a0f 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -31,18 +31,7 @@
 #include <sysdev/cpm2_pic.h>
 
 #include "pq2ads.h"
-
-#ifdef CONFIG_PCI
-static uint pci_clk_frq;
-static struct {
-	unsigned long *pci_int_stat_reg;
-	unsigned long *pci_int_mask_reg;
-} pci_regs;
-
-static unsigned long pci_int_base;
-static struct irq_host *pci_pic_host;
-static struct device_node *pci_pic_node;
-#endif
+#include "pq2.h"
 
 static void __init mpc8272ads_pic_init(void)
 {
@@ -68,10 +57,9 @@ static void __init mpc8272ads_pic_init(void)
 	cpm_reg = (cpm2_map_t *) ioremap(get_immrbase(), sizeof(cpm2_map_t));
 	cpm_reg->im_intctl.ic_siprr = 0x05309770;
 	iounmap(cpm_reg);
-#ifdef CONFIG_PCI
+
 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
-	m82xx_pci_init_irq();
-#endif
+	pq2ads_pci_init_irq();
 }
 
 static void init_fcc1_ioports(struct fs_platform_info *fpi)
@@ -315,177 +303,6 @@ void __init mpc8272ads_board_setup(void)
 }
 
 #ifdef CONFIG_PCI
-static void m82xx_pci_mask_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
-
-	*pci_regs.pci_int_mask_reg |= (1 << (31 - bit));
-	return;
-}
-
-static void m82xx_pci_unmask_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
-
-	*pci_regs.pci_int_mask_reg &= ~(1 << (31 - bit));
-	return;
-}
-
-static void m82xx_pci_mask_and_ack(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
-
-	*pci_regs.pci_int_mask_reg |= (1 << (31 - bit));
-	return;
-}
-
-static void m82xx_pci_end_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
-
-	*pci_regs.pci_int_mask_reg &= ~(1 << (31 - bit));
-	return;
-}
-
-struct hw_interrupt_type m82xx_pci_ic = {
-	.typename = "MPC82xx ADS PCI",
-	.name = "MPC82xx ADS PCI",
-	.enable = m82xx_pci_unmask_irq,
-	.disable = m82xx_pci_mask_irq,
-	.ack = m82xx_pci_mask_and_ack,
-	.end = m82xx_pci_end_irq,
-	.mask = m82xx_pci_mask_irq,
-	.mask_ack = m82xx_pci_mask_and_ack,
-	.unmask = m82xx_pci_unmask_irq,
-	.eoi = m82xx_pci_end_irq,
-};
-
-static void
-m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long stat, mask, pend;
-	int bit;
-
-	for (;;) {
-		stat = *pci_regs.pci_int_stat_reg;
-		mask = *pci_regs.pci_int_mask_reg;
-		pend = stat & ~mask & 0xf0000000;
-		if (!pend)
-			break;
-		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
-			if (pend & 0x80000000)
-				__do_IRQ(pci_int_base + bit);
-		}
-	}
-}
-
-static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return node == pci_pic_node;
-}
-
-static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
-			    irq_hw_number_t hw)
-{
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip(virq, &m82xx_pci_ic);
-	return 0;
-}
-
-static void pci_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	/* remove chip and handler */
-	set_irq_chip(virq, NULL);
-}
-
-static struct irq_host_ops pci_pic_host_ops = {
-	.match = pci_pic_host_match,
-	.map = pci_pic_host_map,
-	.unmap = pci_host_unmap,
-};
-
-void m82xx_pci_init_irq(void)
-{
-	int irq;
-	cpm2_map_t *immap;
-	struct device_node *np;
-	struct resource r;
-	const u32 *regs;
-	unsigned int size;
-	const u32 *irq_map;
-	int i;
-	unsigned int irq_max, irq_min;
-
-	if ((np = of_find_node_by_type(NULL, "soc")) == NULL) {
-		printk(KERN_INFO "No SOC node in device tree\n");
-		return;
-	}
-	memset(&r, 0, sizeof(r));
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_INFO "No SOC reg property in device tree\n");
-		return;
-	}
-	immap = ioremap(r.start, sizeof(*immap));
-	of_node_put(np);
-
-	/* install the demultiplexer for the PCI cascade interrupt */
-	np = of_find_node_by_type(NULL, "pci");
-	if (!np) {
-		printk(KERN_INFO "No pci node on device tree\n");
-		iounmap(immap);
-		return;
-	}
-	irq_map = of_get_property(np, "interrupt-map", &size);
-	if ((!irq_map) || (size <= 7)) {
-		printk(KERN_INFO "No interrupt-map property of pci node\n");
-		iounmap(immap);
-		return;
-	}
-	size /= sizeof(irq_map[0]);
-	for (i = 0, irq_max = 0, irq_min = 512; i < size; i += 7, irq_map += 7) {
-		if (irq_map[5] < irq_min)
-			irq_min = irq_map[5];
-		if (irq_map[5] > irq_max)
-			irq_max = irq_map[5];
-	}
-	pci_int_base = irq_min;
-	irq = irq_of_parse_and_map(np, 0);
-	set_irq_chained_handler(irq, m82xx_pci_irq_demux);
-	of_node_put(np);
-	np = of_find_node_by_type(NULL, "pci-pic");
-	if (!np) {
-		printk(KERN_INFO "No pci pic node on device tree\n");
-		iounmap(immap);
-		return;
-	}
-	pci_pic_node = of_node_get(np);
-	/* PCI interrupt controller registers: status and mask */
-	regs = of_get_property(np, "reg", &size);
-	if ((!regs) || (size <= 2)) {
-		printk(KERN_INFO "No reg property in pci pic node\n");
-		iounmap(immap);
-		return;
-	}
-	pci_regs.pci_int_stat_reg =
-	    ioremap(regs[0], sizeof(*pci_regs.pci_int_stat_reg));
-	pci_regs.pci_int_mask_reg =
-	    ioremap(regs[1], sizeof(*pci_regs.pci_int_mask_reg));
-	of_node_put(np);
-	/* configure chip select for PCI interrupt controller */
-	immap->im_memctl.memc_br3 = regs[0] | 0x00001801;
-	immap->im_memctl.memc_or3 = 0xffff8010;
-	/* make PCI IRQ level sensitive */
-	immap->im_intctl.ic_siexr &= ~(1 << (14 - (irq - SIU_INT_IRQ1)));
-
-	/* mask all PCI interrupts */
-	*pci_regs.pci_int_mask_reg |= 0xfff00000;
-	iounmap(immap);
-	pci_pic_host =
-	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, irq_max - irq_min + 1,
-			   &pci_pic_host_ops, irq_max + 1);
-	return;
-}
-
 static int m82xx_pci_exclude_device(struct pci_controller *hose,
 				    u_char bus, u_char devfn)
 {
@@ -512,7 +329,6 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 		printk(KERN_INFO "No clock-frequency property in PCI node");
 		return;
 	}
-	pci_clk_frq = *ptr;
 	of_node_put(np);
 	bus_range = of_get_property(np, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
index 3c9620f..6bce391 100644
--- a/arch/powerpc/platforms/82xx/pq2.h
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -4,4 +4,13 @@
 void pq2_restart(char *cmd);
 void pq2_halt(void);
 
+#ifdef CONFIG_PCI
+int pq2ads_pci_init_irq(void);
+#else
+static inline int pq2ads_pci_init_irq(void)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
new file mode 100644
index 0000000..cb77858
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -0,0 +1,200 @@
+/*
+ * PQ2 ADS-style PCI interrupt controller
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Loosely based on mpc82xx ADS support by Vitaly Bordug <vbordug@ru.mvista.com>
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/cpm2.h>
+
+static DEFINE_SPINLOCK(pci_pic_lock);
+
+struct pq2ads_pci_pic {
+	struct device_node *node;
+	struct irq_host *host;
+
+	struct {
+		u32 stat;
+		u32 mask;
+	} __iomem *regs;
+};
+
+#define NUM_IRQS 32
+
+static void pq2ads_pci_mask_irq(unsigned int virq)
+{
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
+	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+
+	if (irq != -1) {
+		unsigned long flags;
+		spin_lock_irqsave(&pci_pic_lock, flags);
+
+		setbits32(&priv->regs->mask, 1 << irq);
+		mb();
+
+		spin_unlock_irqrestore(&pci_pic_lock, flags);
+	}
+}
+
+static void pq2ads_pci_unmask_irq(unsigned int virq)
+{
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
+	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+
+	if (irq != -1) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&pci_pic_lock, flags);
+		clrbits32(&priv->regs->mask, 1 << irq);
+		spin_unlock_irqrestore(&pci_pic_lock, flags);
+	}
+}
+
+struct irq_chip pq2ads_pci_ic = {
+	.typename = "PQ2 ADS PCI",
+	.name = "PQ2 ADS PCI",
+	.end = pq2ads_pci_unmask_irq,
+	.mask = pq2ads_pci_mask_irq,
+	.mask_ack = pq2ads_pci_mask_irq,
+	.ack = pq2ads_pci_mask_irq,
+	.unmask = pq2ads_pci_unmask_irq,
+	.enable = pq2ads_pci_unmask_irq,
+	.disable = pq2ads_pci_mask_irq
+};
+
+static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
+{
+	struct pq2ads_pci_pic *priv = desc->handler_data;
+	u32 stat, mask, pend;
+	int bit;
+
+	for (;;) {
+		stat = in_be32(&priv->regs->stat);
+		mask = in_be32(&priv->regs->mask);
+
+		pend = stat & ~mask;
+
+		if (!pend)
+			break;
+
+		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
+			if (pend & 0x80000000) {
+				int irq = irq_linear_revmap(priv->host, bit);
+				generic_handle_irq(irq);
+			}
+		}
+	}
+}
+
+static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct pq2ads_pci_pic *priv = h->host_data;
+	return node == priv->node;
+}
+
+static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
+			    irq_hw_number_t hw)
+{
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_data(virq, h->host_data);
+	set_irq_chip(virq, &pq2ads_pci_ic);
+	return 0;
+}
+
+static void pci_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* remove chip and handler */
+	set_irq_chip_data(virq, NULL);
+	set_irq_chip(virq, NULL);
+}
+
+static struct irq_host_ops pci_pic_host_ops = {
+	.match = pci_pic_host_match,
+	.map = pci_pic_host_map,
+	.unmap = pci_host_unmap,
+};
+
+int __init pq2ads_pci_init_irq(void)
+{
+	struct pq2ads_pci_pic *priv;
+	struct irq_host *host;
+	struct device_node *np;
+	int ret = -ENODEV;
+	int irq;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,pq2ads-pci-pic");
+	if (!np) {
+		printk(KERN_ERR "No pci pic node in device tree.\n");
+		of_node_put(np);
+		goto out;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR "No interrupt in pci pic node.\n");
+		of_node_put(np);
+		goto out;
+	}
+
+	priv = alloc_bootmem(sizeof(struct pq2ads_pci_pic));
+	if (!priv) {
+		of_node_put(np);
+		ret = -ENOMEM;
+		goto out_unmap_irq;
+	}
+
+	priv->node = np;
+	of_node_put(np);
+
+	/* PCI interrupt controller registers: status and mask */
+	priv->regs = of_iomap(priv->node, 0);
+	if (!priv->regs) {
+		printk(KERN_ERR "Cannot map PCI PIC registers.\n");
+		goto out_free_bootmem;
+	}
+
+	/* mask all PCI interrupts */
+	out_be32(&priv->regs->mask, ~0);
+	mb();
+
+	host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NUM_IRQS,
+	                      &pci_pic_host_ops, NUM_IRQS);
+	if (!host) {
+		ret = -ENOMEM;
+		goto out_unmap_regs;
+	}
+
+	host->host_data = priv;
+
+	priv->host = host;
+	host->host_data = priv;
+	set_irq_data(irq, priv);
+	set_irq_chained_handler(irq, pq2ads_pci_irq_demux);
+	return 0;
+
+out_unmap_regs:
+	iounmap(priv->regs);
+out_free_bootmem:
+	free_bootmem((unsigned long)priv,
+	             sizeof(sizeof(struct pq2ads_pci_pic)));
+out_unmap_irq:
+	irq_dispose_mapping(irq);
+out:
+	return ret;
+}
-- 
1.5.0.3
