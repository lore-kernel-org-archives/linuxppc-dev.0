Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9250267B56
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 11:24:53 +1000 (EST)
Date: Thu, 17 Aug 2006 20:24:48 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix CDS IRQ handling and PCI code
Message-ID: <Pine.LNX.4.61.0608172022300.420@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Fix IRQ support in the 85xx CDS boards so it uses the new
  generic stuff
* Fix PCI IRQ mapping to use the device tree
* Disabled i8259 support to allow the CDS to boot.  This will be
  fixed soon, but the current code doesn't even compile, so this
  is a vast improvement

Signed-off-by: Andy Fleming <afleming@freescale.com>
---

This patch *also* really needs to go in for 2.6.18.

Thanks,
Andy

 arch/powerpc/platforms/85xx/Kconfig       |    1 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |  210 ++++++++++++-----------------
 2 files changed, 88 insertions(+), 123 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 454fc53..c3268d9 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -14,7 +14,6 @@ config MPC8540_ADS
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
-	select PPC_I8259 if PCI
 	help
 	  This option enables support for the MPC85xx CDS board
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 5fd53eb..c9c7ffc 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -57,94 +57,8 @@ #endif
 static int cds_pci_slot = 2;
 static volatile u8 *cadmus;
 
-/*
- * Internal interrupts are all Level Sensitive, and Positive Polarity
- *
- * Note:  Likely, this table and the following function should be
- *        obtained and derived from the OF Device Tree.
- */
-static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
-	MPC85XX_INTERNAL_IRQ_SENSES,
-#if defined(CONFIG_PCI)
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Ext 0: PCI slot 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 3 */
-#else
-	0x0,				/* External  0: */
-	0x0,				/* External  1: */
-	0x0,				/* External  2: */
-	0x0,				/* External  3: */
-#endif
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
-	0x0,				/* External  6: */
-	0x0,				/* External  7: */
-	0x0,				/* External  8: */
-	0x0,				/* External  9: */
-	0x0,				/* External 10: */
-#ifdef CONFIG_PCI
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),    /* Ext 11: PCI2 slot 0 */
-#else
-	0x0,				/* External 11: */
-#endif
-};
-
 
 #ifdef CONFIG_PCI
-/*
- * interrupt routing
- */
-int
-mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
-
-	if (!hose->index)
-	{
-		/* Handle PCI1 interrupts */
-		char pci_irq_table[][4] =
-			/*
-			 *      PCI IDSEL/INTPIN->INTLINE
-			 *        A      B      C      D
-			 */
-
-			/* Note IRQ assignment for slots is based on which slot the elysium is
-			 * in -- in this setup elysium is in slot #2 (this PIRQA as first
-			 * interrupt on slot */
-		{
-			{ 0, 1, 2, 3 }, /* 16 - PMC */
-			{ 0, 1, 2, 3 }, /* 17 P2P (Tsi320) */
-			{ 0, 1, 2, 3 }, /* 18 - Slot 1 */
-			{ 1, 2, 3, 0 }, /* 19 - Slot 2 */
-			{ 2, 3, 0, 1 }, /* 20 - Slot 3 */
-			{ 3, 0, 1, 2 }, /* 21 - Slot 4 */
-		};
-
-		const long min_idsel = 16, max_idsel = 21, irqs_per_slot = 4;
-		int i, j;
-
-		for (i = 0; i < 6; i++)
-			for (j = 0; j < 4; j++)
-				pci_irq_table[i][j] =
-					((pci_irq_table[i][j] + 5 -
-					  cds_pci_slot) & 0x3) + PIRQ0A;
-
-		return PCI_IRQ_TABLE_LOOKUP;
-	} else {
-		/* Handle PCI2 interrupts (if we have one) */
-		char pci_irq_table[][4] =
-		{
-			/*
-			 * We only have one slot and one interrupt
-			 * going to PIRQA - PIRQD */
-			{ PIRQ1A, PIRQ1A, PIRQ1A, PIRQ1A }, /* 21 - slot 0 */
-		};
-
-		const long min_idsel = 21, max_idsel = 21, irqs_per_slot = 4;
-
-		return PCI_IRQ_TABLE_LOOKUP;
-	}
-}
 
 #define ARCADIA_HOST_BRIDGE_IDSEL	17
 #define ARCADIA_2ND_BRIDGE_IDSEL	3
@@ -210,50 +124,104 @@ mpc85xx_cds_pcibios_fixup(void)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
 		pci_dev_put(dev);
 	}
+
+	/* Now map all the PCI irqs */
+	dev = NULL;
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
+
+#ifdef CONFIG_PPC_I8259
+#warning The i8259 PIC support is currently broken
+static void mpc85xx_8259_cascade(unsigned int irq, struct
+		irq_desc *desc, struct pt_regs *regs)
+{
+	unsigned int cascade_irq = i8259_irq(regs);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+
+	desc->chip->eoi(irq);
 }
+#endif /* PPC_I8259 */
 #endif /* CONFIG_PCI */
 
 void __init mpc85xx_cds_pic_init(void)
 {
-	struct mpic *mpic1;
-	phys_addr_t OpenPIC_PAddr;
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
 
-	/* Determine the Physical Address of the OpenPIC regs */
-	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
 
-	mpic1 = mpic_alloc(OpenPIC_PAddr,
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			mpc85xx_cds_openpic_initsenses,
-			sizeof(mpc85xx_cds_openpic_initsenses), " OpenPIC  ");
-	BUG_ON(mpic1 == NULL);
-	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
-	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
-	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
-	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
-	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
-	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
-	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
-	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
-
-	/* dummy mappings to get to 48 */
-	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
-	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
-	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
-	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
-
-	/* External ints */
-	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
-	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
-	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
-
-	mpic_init(mpic1);
+			4, 0, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	
+	/* Return the mpic node */
+	of_node_put(np);
+
+	mpic_assign_isu(mpic, 0, r.start + 0x10200);
+	mpic_assign_isu(mpic, 1, r.start + 0x10280);
+	mpic_assign_isu(mpic, 2, r.start + 0x10300);
+	mpic_assign_isu(mpic, 3, r.start + 0x10380);
+	mpic_assign_isu(mpic, 4, r.start + 0x10400);
+	mpic_assign_isu(mpic, 5, r.start + 0x10480);
+	mpic_assign_isu(mpic, 6, r.start + 0x10500);
+	mpic_assign_isu(mpic, 7, r.start + 0x10580);
+
+	/* Used only for 8548 so far, but no harm in
+	 * allocating them for everyone */
+	mpic_assign_isu(mpic, 8, r.start + 0x10600);
+	mpic_assign_isu(mpic, 9, r.start + 0x10680);
+	mpic_assign_isu(mpic, 10, r.start + 0x10700);
+	mpic_assign_isu(mpic, 11, r.start + 0x10780);
+
+	/* External Interrupts */
+	mpic_assign_isu(mpic, 12, r.start + 0x10000);
+	mpic_assign_isu(mpic, 13, r.start + 0x10080);
+	mpic_assign_isu(mpic, 14, r.start + 0x10100);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+		if (device_is_compatible(np, "chrp,iic")) {
+			cascade_node = np;
+			break;
+		}
+
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		return;
+	}
 
-#ifdef CONFIG_PCI
-	mpic_setup_cascade(PIRQ0A, i8259_irq_cascade, NULL);
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		return;
+	}
 
-	i8259_init(0,0);
-#endif
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+#endif /* CONFIG_PPC_I8259 */
 }
 
 
@@ -298,8 +266,6 @@ #ifdef CONFIG_PCI
 		add_bridge(np);
 
 	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc85xx_map_irq;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-- 
2006_06_07.01.gittree_pull-dirty
