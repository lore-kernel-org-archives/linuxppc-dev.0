Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C048967A6F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 04:05:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5MI59Jl027652
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:05:09 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5MI578p010333
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:05:08 -0500 (CDT)
Subject: [PATCH] Use IRQ and senses from OF-tree on 8641hpcn.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1150999473.9022.79.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 22 Jun 2006 13:04:33 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h |   11 -
 arch/powerpc/platforms/86xx/mpc86xx.h      |    1 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  118 +---------------
 arch/powerpc/platforms/86xx/pci.c          |  212 ++++++++++++++++++++++++----
 4 files changed, 187 insertions(+), 155 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
index 5042253..747e549 100644
--- a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
+++ b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
@@ -17,17 +17,6 @@ #define __MPC8641_HPCN_H__
 #include <linux/config.h>
 #include <linux/init.h>
 
-/* PCI interrupt controller */
-#define PIRQA		3
-#define PIRQB		4
-#define PIRQC		5
-#define PIRQD		6
-#define PIRQ7		7
-#define PIRQE		9
-#define PIRQF		10
-#define PIRQG		11
-#define PIRQH		12
-
 /* PCI-Express memory map */
 #define MPC86XX_PCIE_LOWER_IO        0x00000000
 #define MPC86XX_PCIE_UPPER_IO        0x00ffffff
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index e3c9e4f..96010c6 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -16,6 +16,7 @@ #define __MPC86XX_H__
  */
 
 extern int __init add_bridge(struct device_node *dev);
+extern void mpc86xx_pcibios_fixup(void);
 
 extern void __init setup_indirect_pcie(struct pci_controller *hose,
 				       u32 cfg_addr, u32 cfg_data);
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 483c21d..092bca3 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -44,93 +44,24 @@ unsigned long pci_dram_offset = 0;
 #endif
 
 
-/*
- * Internal interrupts are all Level Sensitive, and Positive Polarity
- */
-
-static u_char mpc86xx_hpcn_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: MCM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCIE1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: PCIE2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: DUART2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: TSEC 3 transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: TSEC 3 receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: TSEC 3 error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 2 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 2 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: TSEC 4 transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: TSEC 4 receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: TSEC 4 error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 2 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 32: SRIO error/write-port unit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 33: SRIO outbound doorbell */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 34: SRIO inbound doorbell */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 35: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 36: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 37: SRIO outbound message unit 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 38: SRIO inbound message unit 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 39: SRIO outbound message unit 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 40: SRIO inbound message unit 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 41: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 42: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 43: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 44: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 45: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 46: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 47: Unused */
-	0x0,						/* External  0: */
-	0x0,						/* External  1: */
-	0x0,						/* External  2: */
-	0x0,						/* External  3: */
-	0x0,						/* External  4: */
-	0x0,						/* External  5: */
-	0x0,						/* External  6: */
-	0x0,						/* External  7: */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  8: Pixis FPGA */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External  9: ULI 8259 INTR Cascade */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 10: Quad ETH PHY */
-	0x0,						/* External 11: */
-	0x0,
-	0x0,
-	0x0,
-	0x0,
-};
-
-
 void __init
 mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
 	phys_addr_t openpic_paddr;
+	int irq_count =
+		NR_IRQS - NUM_8259_INTERRUPTS - 4; /* leave room for IPIs */
+	unsigned char init_senses[NR_IRQS - NUM_8259_INTERRUPTS - 4];
 
+	prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS - 4);
 	/* Determine the Physical Address of the OpenPIC regs */
 	openpic_paddr = get_immrbase() + MPC86xx_OPENPIC_OFFSET;
 
 	/* Alloc mpic structure and per isu has 16 INT entries. */
 	mpic1 = mpic_alloc(openpic_paddr,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			16, MPC86xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			mpc86xx_hpcn_openpic_initsenses,
-			sizeof(mpc86xx_hpcn_openpic_initsenses),
+			16, NUM_8259_INTERRUPTS, irq_count,
+			NR_IRQS - 4, init_senses, irq_count,
 			" MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
@@ -153,40 +84,6 @@ #endif
 
 
 #ifdef CONFIG_PCI
-/*
- * interrupt routing
- */
-
-int
-mpc86xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	static char pci_irq_table[][4] = {
-		/*
-		 *      PCI IDSEL/INTPIN->INTLINE
-		 *       A      B      C      D
-		 */
-		{PIRQA, PIRQB, PIRQC, PIRQD},   /* IDSEL 17 -- PCI Slot 1 */
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 18 -- PCI Slot 2 */
-		{0, 0, 0, 0},			/* IDSEL 19 */
-		{0, 0, 0, 0},			/* IDSEL 20 */
-		{0, 0, 0, 0},			/* IDSEL 21 */
-		{0, 0, 0, 0},			/* IDSEL 22 */
-		{0, 0, 0, 0},			/* IDSEL 23 */
-		{0, 0, 0, 0},			/* IDSEL 24 */
-		{0, 0, 0, 0},			/* IDSEL 25 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},	/* IDSEL 26 -- PCI Bridge*/
-		{PIRQC, 0, 0, 0},		/* IDSEL 27 -- LAN */
-		{PIRQE, PIRQF, PIRQH, PIRQ7},	/* IDSEL 28 -- USB 1.1 */
-		{PIRQE, PIRQF, PIRQG, 0},	/* IDSEL 29 -- Audio & Modem */
-		{PIRQH, 0, 0, 0},		/* IDSEL 30 -- LPC & PMU*/
-		{PIRQD, 0, 0, 0},		/* IDSEL 31 -- ATA */
-	};
-
-	const long min_idsel = 17, max_idsel = 31, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP + I8259_OFFSET;
-}
-
-
 int
 mpc86xx_exclude_device(u_char bus, u_char devfn)
 {
@@ -224,8 +121,6 @@ #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc86xx_map_irq;
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 #endif
 
@@ -316,6 +211,7 @@ define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
 	.probe			= mpc86xx_hpcn_probe,
 	.setup_arch		= mpc86xx_hpcn_setup_arch,
+	.pcibios_fixup		= mpc86xx_pcibios_fixup,
 	.init_IRQ		= mpc86xx_hpcn_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 5180df7..a03b36f 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -199,63 +199,207 @@ int __init add_bridge(struct device_node
 	return 0;
 }
 
-static void __devinit quirk_ali1575(struct pci_dev *dev)
+static int __init get_pci_irq_from_of(struct pci_controller *hose,
+				   int slot, int pin)
+{
+	struct device_node *node;
+	unsigned long *interrupt, *interrupt_mask;
+	int len, mask_len;
+	int shift, i;
+	int irq = 0;
+
+	if (!hose) {
+		printk(KERN_ERR "No PCI hose found!\n");
+		return -EFAULT;
+	}
+
+	node = (struct device_node *)hose->arch_data;
+	interrupt = (unsigned long *)get_property(node,
+			"interrupt-map", &len);
+	interrupt_mask = (unsigned long *)get_property(node,
+			"interrupt-map-mask", &mask_len);
+	if (!interrupt || !interrupt_mask) {
+		printk(KERN_ERR "No PCI interrupt-map or interrupt-map-mask"
+				"property in OpenFirmware device tree!\n");
+		return -EFAULT;
+	}
+	shift = __ilog2((~interrupt_mask[0] + 1) & 0xffff);
+
+	/*
+	 * Find matched irq in interrupt-map node of OF-tree.
+	 *
+	 * interrupt-map entries format:
+	 * <slot>     <pin> <interrupt-parent> <irq#>
+	 *  8800  0 0   1         40000           3   0
+	 */
+	pr_debug("PCI slot %x, pin %d ", slot, pin);
+	for (i = 0; i < (len / 7); i++)
+		if (((interrupt[i * 7] & interrupt_mask[0]) == (slot << shift))
+				&& (interrupt[i * 7 + 3] == pin))
+			irq = interrupt[i * 7 + 5] & interrupt_mask[3];
+	pr_debug("irq %d\n", irq);
+
+	if (!irq)
+		printk(KERN_WARNING "PCI Slot %d, Pin %d device "
+				"has no matched irq!\n", slot, pin);
+
+	return irq;
+}
+
+static int __init mpc86xx_irq_fixup(struct pci_dev *dev)
+{
+	struct pci_controller *hose = NULL;
+	int pin, slot;
+
+	hose = pci_bus_to_hose(dev->bus->number);
+	if (!hose) {
+		printk(KERN_ERR "No PCI hose found!\n");
+		return -EFAULT;
+	}
+
+	pin = dev->pin;
+	if (dev->bus->number != hose->first_busno) {
+		do {
+			pin = ((pin-1) + PCI_SLOT(dev->devfn)) %4 + 1;
+			/* Move up the chain of bridges. */
+			dev = dev->bus->self;
+		} while (dev->bus->self);
+		/* The slot is the idsel of the last bridge. */
+	}
+	slot = PCI_SLOT(dev->devfn);
+
+	return get_pci_irq_from_of(hose, slot, pin);
+}
+
+void __init mpc86xx_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev) {
+		dev->irq = mpc86xx_irq_fixup(dev);
+		if (dev->irq < 0)
+			return;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+}
+
+enum pirq{PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH};
+const unsigned char uli1575_irq_route_table[16] = {
+	0, 	/* 0: Reserved */
+	0x8, 	/* 1: 0b1000 */
+	0, 	/* 2: Reserved */
+	0x2,	/* 3: 0b0010 */
+	0x4,	/* 4: 0b0100 */
+	0x5, 	/* 5: 0b0101 */
+	0x7,	/* 6: 0b0111 */
+	0x6,	/* 7: 0b0110 */
+	0, 	/* 8: Reserved */
+	0x1,	/* 9: 0b0001 */
+	0x3,	/* 10: 0b0011 */
+	0x9,	/* 11: 0b1001 */
+	0xb,	/* 12: 0b1011 */
+	0, 	/* 13: Reserved */
+	0xd,	/* 14, 0b1101 */
+	0xf,	/* 15, 0b1111 */
+};
+
+
+static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	unsigned short temp;
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	int i, irq;
+	unsigned char irq2pin[16];
+	unsigned long pirq_map_word = 0;
+
+	if (!hose) {
+		printk(KERN_ERR "No PCI hose!\n");
+		return;
+	}
 
 	/*
-	 * ALI1575 interrupts route table setup:
+	 * ULI1575 interrupts route setup
+	 */
+	memset(irq2pin, 0, 16); /* Initialize default value 0 */
+
+	/*
+	 * PIRQA -> PIRQD mapping read from OF-tree
+	 *
+	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
+	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
+	 */
+	for (i = 0; i < 4; i++){
+		irq = get_pci_irq_from_of(hose, 17, i + 1);
+		if (irq >= 0 && irq <= 15)
+			irq2pin[irq] = PIRQA + i;
+	}
+
+	/*
+	 * PIRQE -> PIRQF mapping set manually
 	 *
 	 * IRQ pin   IRQ#
-	 * PIRQA ---- 3
-	 * PIRQB ---- 4
-	 * PIRQC ---- 5
-	 * PIRQD ---- 6
 	 * PIRQE ---- 9
 	 * PIRQF ---- 10
 	 * PIRQG ---- 11
 	 * PIRQH ---- 12
-	 *
-	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
-	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
 	 */
-	pci_write_config_dword(dev, 0x48, 0xb9317542);
+	for (i = 0; i < 4; i++) irq2pin[i + 9] = PIRQE + i;
 
-	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
-	pci_write_config_byte(dev, 0x86, 0x0c);
+	/* Set IRQ-PIRQ Mapping to ULI1575 */
+	for (i = 0; i < 16; i++)
+		if (irq2pin[i])
+			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
+				<< ((irq2pin[i] - PIRQA) * 4);
 
-	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
-	pci_write_config_byte(dev, 0x87, 0x0d);
+	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
+			pirq_map_word);
+	pci_write_config_dword(dev, 0x48, pirq_map_word);
 
-	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x88, 0x0f);
+#define ULI1575_SET_DEV_IRQ(slot, pin, reg) 				\
+	do { 								\
+		int irq; 						\
+		irq = get_pci_irq_from_of(hose, slot, pin); 		\
+		if (irq >= 0 && irq <=15) 				\
+			pci_write_config_byte(dev, reg, irq2pin[irq]); 	\
+	} while(0)
 
-	/* USB 2.0 controller, interrupt: PIRQ7 */
-	pci_write_config_byte(dev, 0x74, 0x06);
+	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
+	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
 
-	/* Audio controller, interrupt: PIRQE */
-	pci_write_config_byte(dev, 0x8a, 0x0c);
+	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
+	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
 
-	/* Modem controller, interrupt: PIRQF */
-	pci_write_config_byte(dev, 0x8b, 0x0d);
+	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
+	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
 
-	/* HD audio controller, interrupt: PIRQG */
-	pci_write_config_byte(dev, 0x8c, 0x0e);
+	/* USB 2.0 controller, slot 28, pin 4 */
+	irq = get_pci_irq_from_of(hose, 28, 4);
+	if (irq >= 0 && irq <=15)
+		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
 
-	/* Serial ATA interrupt: PIRQD */
-	pci_write_config_byte(dev, 0x8d, 0x0b);
+	/* Audio controller, slot 29, pin 1 */
+	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
 
-	/* SMB interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x8e, 0x0f);
+	/* Modem controller, slot 29, pin 2 */
+	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
 
-	/* PMU ACPI SCI interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x8f, 0x0f);
+	/* HD audio controller, slot 29, pin 3 */
+	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
+
+	/* SMB interrupt: slot 30, pin 1 */
+	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
+
+	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
+	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
+
+	/* Serial ATA interrupt: slot 31, pin 1 */
+	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
 
 	/* Primary PATA IDE IRQ: 14
 	 * Secondary PATA IDE IRQ: 15
 	 */
-	pci_write_config_byte(dev, 0x44, 0x3d);
-	pci_write_config_byte(dev, 0x75, 0x0f);
+	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
+	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
 
 	/* Set IRQ14 and IRQ15 to legacy IRQs */
 	pci_read_config_word(dev, 0x46, &temp);
@@ -277,6 +421,8 @@ static void __devinit quirk_ali1575(stru
 	 */
 	outb(0xfa, 0x4d0);
 	outb(0x1e, 0x4d1);
+
+#undef ULI1575_SET_DEV_IRQ
 }
 
 static void __devinit quirk_uli5288(struct pci_dev *dev)
@@ -319,7 +465,7 @@ static void __devinit early_uli5249(stru
 	dev->class |= 0x1;
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
-- 
2006_06_07.01.gittree_pull-dirty
