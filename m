Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7C62067CCC
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:27:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kAE5fnTr016602
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 22:41:49 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kAE5RmDY000219
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 23:27:49 -0600 (CST)
Subject: [PATCH] Powerpc: Make pci_read_irq_line the default: on
	mpc7448hpc2 board
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1161960682.25801.4.camel@localhost.localdomain>
References: <1161141538.24931.9.camel@localhost.localdomain>
	<1161949906.25263.19.camel@localhost.localdomain>
	<1161960682.25801.4.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1163482111.3748.15.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Nov 2006 13:28:32 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch targets the current powerpc git tree.

The following patch adds a tsi108/9 pci interrupt controller host.
On mpc7448hpc2 board, pci_irq_fixup function is removed, which makes the
pci_read_irq_line be the default pci irq fixup.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

---
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |   44 +++++++---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   90 ++++++---------------
 arch/powerpc/sysdev/tsi108_pci.c                  |   63 +++++++++++++--
 3 files changed, 108 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index d7b985e..3f9454e 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -161,29 +161,41 @@
 			interrupt-map = <
 
 				/* IDSEL 0x11 */
-				0800 0 0 1 7400 24 0
-				0800 0 0 2 7400 25 0
-				0800 0 0 3 7400 26 0
-				0800 0 0 4 7400 27 0
+				0800 0 0 1 1180 24 0
+				0800 0 0 2 1180 25 0
+				0800 0 0 3 1180 26 0
+				0800 0 0 4 1180 27 0
 
 				/* IDSEL 0x12 */
-				1000 0 0 1 7400 25 0
-				1000 0 0 2 7400 26 0
-				1000 0 0 3 7400 27 0
-				1000 0 0 4 7400 24 0
+				1000 0 0 1 1180 25 0
+				1000 0 0 2 1180 26 0
+				1000 0 0 3 1180 27 0
+				1000 0 0 4 1180 24 0
 
 				/* IDSEL 0x13 */
-				1800 0 0 1 7400 26 0
-				1800 0 0 2 7400 27 0
-				1800 0 0 3 7400 24 0
-				1800 0 0 4 7400 25 0
+				1800 0 0 1 1180 26 0
+				1800 0 0 2 1180 27 0
+				1800 0 0 3 1180 24 0
+				1800 0 0 4 1180 25 0
 
 				/* IDSEL 0x14 */
-				2000 0 0 1 7400 27 0
-				2000 0 0 2 7400 24 0
-				2000 0 0 3 7400 25 0
-				2000 0 0 4 7400 26 0
+				2000 0 0 1 1180 27 0
+				2000 0 0 2 1180 24 0
+				2000 0 0 3 1180 25 0
+				2000 0 0 4 1180 26 0
 				>;
+			router@1180 {
+				linux,phandle = <1180>;
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "pic-router";
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+                	        big-endian;
+				interrupts = <17 2>;
+				interrupt-parent = <7400>;
+			};
 		};
 	};
 
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index c6113c3..c77be14 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -60,7 +60,7 @@ #endif
 
 extern int tsi108_setup_pci(struct device_node *dev);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
-extern void tsi108_pci_int_init(void);
+extern void tsi108_pci_int_init(struct device_node *node);
 extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 
 int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
@@ -71,59 +71,6 @@ int mpc7448_hpc2_exclude_device(u_char b
 		return PCIBIOS_SUCCESSFUL;
 }
 
-/*
- * find pci slot by devfn in interrupt map of OF tree
- */
-u8 find_slot_by_devfn(unsigned int *interrupt_map, unsigned int devfn)
-{
-	int i;
-	unsigned int tmp;
-	for (i = 0; i < 4; i++){
-		tmp = interrupt_map[i*4*7];
-		if ((tmp >> 11) == (devfn >> 3))
-			return i;
-	}
-	return i;
-}
-
-/*
- * Scans the interrupt map for pci device
- */
-void __devinit mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
-{
-	struct pci_controller *hose;
-	struct device_node *node;
-	const unsigned int *interrupt;
-	int busnr;
-	int len;
-	u8 slot;
-	u8 pin;
-
-	/* Lookup the hose */
-	busnr = dev->bus->number;
-	hose = pci_bus_to_hose(busnr);
-	if (!hose)
-		printk(KERN_ERR "No pci hose found\n");
-
-	/* Check it has an OF node associated */
-	node = (struct device_node *) hose->arch_data;
-	if (!node)
-		printk(KERN_ERR "No pci node found\n");
-
-	interrupt = get_property(node, "interrupt-map", &len);
-	slot = find_slot_by_devfn(interrupt, dev->devfn);
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin == 0 || pin > 4)
-		pin = 1;
-	pin--;
-	dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
-
-	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-
-	DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
-}
-/* temporary pci irq map fixup*/
-
 static void __init mpc7448_hpc2_setup_arch(void)
 {
 	struct device_node *cpu;
@@ -186,9 +133,12 @@ static void __init mpc7448_hpc2_init_IRQ
 {
 	struct mpic *mpic;
 	phys_addr_t mpic_paddr = 0;
+	struct device_node *tsi_pic;
+#ifdef CONFIG_PCI
 	unsigned int cascade_pci_irq;
 	struct device_node *tsi_pci;
-	struct device_node *tsi_pic;
+	struct device_node *cascade_node = NULL;
+#endif
 
 	tsi_pic = of_find_node_by_type(NULL, "open-pic");
 	if (tsi_pic) {
@@ -202,31 +152,41 @@ static void __init mpc7448_hpc2_init_IRQ
 		return;
 	}
 
-	DBG("%s: tsi108pic phys_addr = 0x%x\n", __FUNCTION__,
+	DBG("%s: tsi108 pic phys_addr = 0x%x\n", __FUNCTION__,
 	    (u32) mpic_paddr);
 
 	mpic = mpic_alloc(tsi_pic, mpic_paddr,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
-			0, /* num_sources used */
-			0, /* num_sources used */
+			24, 
+			NR_IRQS-4, /* num_sources used */
 			"Tsi108_PIC");
 
-	BUG_ON(mpic == NULL); /* XXXX */
+	BUG_ON(mpic == NULL);
+	
+	mpic_assign_isu(mpic, 0, mpic_paddr + 0x100);
+	
 	mpic_init(mpic);
-
+	
+#ifdef CONFIG_PCI
 	tsi_pci = of_find_node_by_type(NULL, "pci");
-	if (tsi_pci == 0) {
+	if (tsi_pci == NULL) {
 		printk("%s: No tsi108 pci node found !\n", __FUNCTION__);
 		return;
 	}
+	cascade_node = of_find_node_by_type(NULL, "pic-router");
+	if (cascade_node == NULL) {
+		printk("%s: No tsi108 pci cascade node found !\n", __FUNCTION__);
+		return;
+	}
 
 	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
+	DBG("%s: tsi108 cascade_pci_irq = 0x%x\n", __FUNCTION__,
+	    (u32) cascade_pci_irq);
+	tsi108_pci_int_init(cascade_node);
 	set_irq_data(cascade_pci_irq, mpic);
 	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
-
-	tsi108_pci_int_init();
-
+#endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
 	of_node_put(tsi_pic);
@@ -284,7 +244,6 @@ static int mpc7448_machine_check_excepti
 		return 1;
 	}
 	return 0;
-
 }
 
 define_machine(mpc7448_hpc2){
@@ -294,7 +253,6 @@ define_machine(mpc7448_hpc2){
 	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
 	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
 	.get_irq 		= mpic_get_irq,
-	.pci_irq_fixup 		= mpc7448_hpc2_fixup_irq,
 	.restart 		= mpc7448_hpc2_restart,
 	.calibrate_decr 	= generic_calibrate_decr,
 	.machine_check_exception= mpc7448_machine_check_exception,
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 322f86e..059d34a 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -3,6 +3,8 @@
  *
  * 2004-2005 (c) Tundra Semiconductor Corp.
  * Author: Alex Bounine (alexandreb@tundra.com)
+ * Author: Roy Zang (tie-fei.zang@freescale.com)
+ * 	   Add pci interrupt router host
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -48,6 +50,8 @@ #define tsi_mk_config_addr(bus, devfunc,
 
 u32 tsi108_pci_cfg_base;
 u32 tsi108_csr_vir_base;
+static struct device_node *pci_irq_node;
+static struct irq_host *pci_irq_host;
 
 extern u32 get_vir_csrbase(void);
 extern u32 tsi108_read_reg(u32 reg_offset);
@@ -378,6 +382,51 @@ static struct irq_chip tsi108_pci_irq = 
 	.unmask = tsi108_pci_irq_enable,
 };
 
+static int pci_irq_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+	*out_hwirq = intspec[0];
+	*out_flags = IRQ_TYPE_LEVEL_HIGH;
+	return 0;
+}
+
+static int pci_irq_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{	unsigned int irq;
+	DBG("%s(%d, 0x%lx)\n", __FUNCTION__, virq, hw);
+	if ((virq >= 1) && (virq <= 4)){
+		irq = virq + IRQ_PCI_INTAD_BASE - 1;
+		get_irq_desc(irq)->status |= IRQ_LEVEL;
+		set_irq_chip(irq, &tsi108_pci_irq);
+	}
+	return 0;
+}
+static void pci_irq_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* Make sure irq is masked in hardware */
+	
+	tsi108_pci_int_mask(virq);
+
+	/* remove chip and handler */
+	set_irq_chip_and_handler(virq, NULL, NULL);
+
+	/* Make sure it's completed */
+	synchronize_irq(virq);
+}
+
+static int pci_irq_host_match(struct irq_host *h, struct device_node *node)
+{
+	return pci_irq_node == NULL || pci_irq_node == node;
+}
+
+static struct irq_host_ops pci_irq_host_ops = {
+	.match = pci_irq_host_match,
+	.map = pci_irq_host_map,
+	.unmap = pci_irq_host_unmap,
+	.xlate = pci_irq_host_xlate,
+};
+
 /*
  * Exported functions
  */
@@ -391,15 +440,15 @@ static struct irq_chip tsi108_pci_irq = 
  * to the MPIC.
  */
 
-void __init tsi108_pci_int_init(void)
+void __init tsi108_pci_int_init(struct device_node *node)
 {
-	u_int i;
-
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
-
-	for (i = 0; i < NUM_PCI_IRQS; i++) {
-		irq_desc[i + IRQ_PCI_INTAD_BASE].chip = &tsi108_pci_irq;
-		irq_desc[i + IRQ_PCI_INTAD_BASE].status |= IRQ_LEVEL;
+	
+	pci_irq_node = of_node_get(node);
+	pci_irq_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &pci_irq_host_ops, 0);
+	if (pci_irq_host == NULL) {
+		printk(KERN_ERR "pci_irq_host: failed to allocate irq host !\n");
+		return;
 	}
 
 	init_pci_source();
-- 
1.4.0
