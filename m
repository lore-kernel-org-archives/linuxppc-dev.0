Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 036C1B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:07:57 +1100 (EST)
Message-Id: <20110325164140.742282793@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:13 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 01/14] powerpc: Use proper accessors for IRQ_* flags
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

Use the proper accessors instead of open access to irq_desc.
Converted with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c                        |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |    2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |    2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  |    2 +-
 arch/powerpc/platforms/86xx/gef_pic.c            |    2 +-
 arch/powerpc/platforms/cell/beat_interrupt.c     |    3 +--
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    2 +-
 arch/powerpc/platforms/powermac/pic.c            |    3 +--
 arch/powerpc/platforms/pseries/xics.c            |    2 +-
 arch/powerpc/sysdev/cpm1.c                       |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                   |    2 +-
 arch/powerpc/sysdev/fsl_msi.c                    |    2 +-
 arch/powerpc/sysdev/i8259.c                      |    4 ++--
 arch/powerpc/sysdev/mv64x60_pic.c                |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |    2 +-
 arch/powerpc/sysdev/tsi108_pci.c                 |    2 +-
 17 files changed, 18 insertions(+), 20 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -618,7 +618,7 @@ struct irq_host *irq_alloc_host(struct d
 			smp_wmb();
 
 			/* Clear norequest flags */
-			irq_to_desc(i)->status &= ~IRQ_NOREQUEST;
+			irq_clear_status_flags(i, IRQ_NOREQUEST);
 
 			/* Legacy flags are left to default at this point,
 			 * one can then use irq_create_mapping() to
Index: linux-2.6-tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ linux-2.6-tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -132,7 +132,7 @@ static int
 cpld_pic_host_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &cpld_pic, handle_level_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -106,7 +106,7 @@ static void pq2ads_pci_irq_demux(unsigne
 static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
 			    irq_hw_number_t hw)
 {
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -245,7 +245,7 @@ static int socrates_fpga_pic_host_map(st
 		irq_hw_number_t hwirq)
 {
 	/* All interrupts are LEVEL sensitive */
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &socrates_fpga_pic_chip,
 			handle_fasteoi_irq);
 
Index: linux-2.6-tip/arch/powerpc/platforms/86xx/gef_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/86xx/gef_pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/86xx/gef_pic.c
@@ -163,7 +163,7 @@ static int gef_pic_host_map(struct irq_h
 			  irq_hw_number_t hwirq)
 {
 	/* All interrupts are LEVEL sensitive */
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);
 
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/beat_interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -136,14 +136,13 @@ static void beatic_pic_host_unmap(struct
 static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
 			       irq_hw_number_t hw)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
 	int64_t	err;
 
 	err = beat_construct_and_connect_irq_plug(virq, hw);
 	if (err < 0)
 		return -EIO;
 
-	desc->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &beatic_pic, handle_fasteoi_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/flipper-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -102,7 +102,7 @@ static int flipper_pic_map(struct irq_ho
 			   irq_hw_number_t hwirq)
 {
 	set_irq_chip_data(virq, h->host_data);
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &flipper_pic, handle_level_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -95,7 +95,7 @@ static int hlwd_pic_map(struct irq_host 
 			   irq_hw_number_t hwirq)
 {
 	set_irq_chip_data(virq, h->host_data);
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &hlwd_pic, handle_level_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
@@ -289,7 +289,6 @@ static int pmac_pic_host_match(struct ir
 static int pmac_pic_host_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
 	int level;
 
 	if (hw >= max_irqs)
@@ -300,7 +299,7 @@ static int pmac_pic_host_map(struct irq_
 	 */
 	level = !!(level_mask[hw >> 5] & (1UL << (hw & 0x1f)));
 	if (level)
-		desc->status |= IRQ_LEVEL;
+		irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &pmac_pic, level ?
 				 handle_level_irq : handle_edge_irq);
 	return 0;
Index: linux-2.6-tip/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6-tip/arch/powerpc/platforms/pseries/xics.c
@@ -470,7 +470,7 @@ static int xics_host_map(struct irq_host
 	/* Insert the interrupt mapping into the radix tree for fast lookup */
 	irq_radix_revmap_insert(xics_host, virq, hw);
 
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/cpm1.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm1.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm1.c
@@ -103,7 +103,7 @@ static int cpm_pic_host_map(struct irq_h
 {
 	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
@@ -226,7 +226,7 @@ static int cpm2_pic_host_map(struct irq_
 {
 	pr_debug("cpm2_pic_host_map(%d, 0x%lx)\n", virq, hw);
 
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &cpm2_pic, handle_level_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/fsl_msi.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/fsl_msi.c
+++ linux-2.6-tip/arch/powerpc/sysdev/fsl_msi.c
@@ -64,7 +64,7 @@ static int fsl_msi_host_map(struct irq_h
 	struct fsl_msi *msi_data = h->host_data;
 	struct irq_chip *chip = &fsl_msi_chip;
 
-	irq_to_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
+	irq_set_status_flags(virq, IRQ_TYPE_EDGE_FALLING);
 
 	set_irq_chip_data(virq, msi_data);
 	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
Index: linux-2.6-tip/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/i8259.c
+++ linux-2.6-tip/arch/powerpc/sysdev/i8259.c
@@ -175,12 +175,12 @@ static int i8259_host_map(struct irq_hos
 
 	/* We block the internal cascade */
 	if (hw == 2)
-		irq_to_desc(virq)->status |= IRQ_NOREQUEST;
+		irq_set_status_flags(virq, IRQ_NOREQUEST);
 
 	/* We use the level handler only for now, we might want to
 	 * be more cautious here but that works for now
 	 */
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	set_irq_chip_and_handler(virq, &i8259_pic, handle_level_irq);
 	return 0;
 }
Index: linux-2.6-tip/arch/powerpc/sysdev/mv64x60_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mv64x60_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mv64x60_pic.c
@@ -213,7 +213,7 @@ static int mv64x60_host_map(struct irq_h
 {
 	int level1;
 
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 
 	level1 = (hwirq & MV64x60_LEVEL1_MASK) >> MV64x60_LEVEL1_OFFSET;
 	BUG_ON(level1 > MV64x60_LEVEL1_GPP);
Index: linux-2.6-tip/arch/powerpc/sysdev/qe_lib/qe_ic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -268,7 +268,7 @@ static int qe_ic_host_map(struct irq_hos
 	chip = &qe_ic->hc_irq;
 
 	set_irq_chip_data(virq, qe_ic);
-	irq_to_desc(virq)->status |= IRQ_LEVEL;
+	irq_set_status_flags(virq, IRQ_LEVEL);
 
 	set_irq_chip_and_handler(virq, chip, handle_level_irq);
 
Index: linux-2.6-tip/arch/powerpc/sysdev/tsi108_pci.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6-tip/arch/powerpc/sysdev/tsi108_pci.c
@@ -391,7 +391,7 @@ static int pci_irq_host_map(struct irq_h
 	DBG("%s(%d, 0x%lx)\n", __func__, virq, hw);
 	if ((virq >= 1) && (virq <= 4)){
 		irq = virq + IRQ_PCI_INTAD_BASE - 1;
-		irq_to_desc(irq)->status |= IRQ_LEVEL;
+		irq_set_status_flags(irq, IRQ_LEVEL);
 		set_irq_chip(irq, &tsi108_pci_irq);
 	}
 	return 0;
