Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8AC8167BDB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:03:14 +1000 (EST)
Date: Fri, 18 Aug 2006 18:03:08 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix interrupts on 8540 ADS board
Message-ID: <Pine.LNX.4.61.0608181800001.2878@ld0175-tx32.am.freescale.net>
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

* Fixed 8540 ADS support for the new irq layer
* Fixed 8540 ADS support for mapping PCI interrupts
* Updated 8540 ADS to use device tree for interrupt assignment
  and sense values
---

Ok.  Many, many apologies for the previous patch.  *This* patch is 
tested on a fresh tree.  The arguments for it going in from before still 
apply, though.  The current mainline for 2.6.18 doesn't build, let alone 
boot, so we *need* this patch to go in, as well as the CDS patch from 
before.

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |  162 ++++++++++-------------------
 1 files changed, 55 insertions(+), 107 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index d0cfcdb..cae6b73 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -37,79 +37,7 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
-/*
- * Internal interrupts are all Level Sensitive, and Positive Polarity
- *
- * Note:  Likely, this table and the following function should be
- *        obtained and derived from the OF Device Tree.
- */
-static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
-	MPC85XX_INTERNAL_IRQ_SENSES,
-	0x0,			/* External  0: */
-#if defined(CONFIG_PCI)
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
-#else
-	0x0,			/* External  1: */
-	0x0,			/* External  2: */
-	0x0,			/* External  3: */
-	0x0,			/* External  4: */
-#endif
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
-	0x0,			/* External  6: */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
-	0x0,			/* External  8: */
-	0x0,			/* External  9: */
-	0x0,			/* External 10: */
-	0x0,			/* External 11: */
-};
-
 #ifdef CONFIG_PCI
-/*
- * interrupt routing
- */
-
-int
-mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	static char pci_irq_table[][4] =
-	    /*
-	     * This is little evil, but works around the fact
-	     * that revA boards have IDSEL starting at 18
-	     * and others boards (older) start at 12
-	     *
-	     *      PCI IDSEL/INTPIN->INTLINE
-	     *       A      B      C      D
-	     */
-	{
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 2 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 5 */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 12 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 15 */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 18 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 21 */
-	};
-
-	const long min_idsel = 2, max_idsel = 21, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP;
-}
-
 int
 mpc85xx_exclude_device(u_char bus, u_char devfn)
 {
@@ -119,44 +47,63 @@ mpc85xx_exclude_device(u_char bus, u_cha
 		return PCIBIOS_SUCCESSFUL;
 }
 
+void __init
+mpc85xx_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
 #endif /* CONFIG_PCI */
 
 
 void __init mpc85xx_ads_pic_init(void)
 {
-	struct mpic *mpic1;
-	phys_addr_t OpenPIC_PAddr;
-
-	/* Determine the Physical Address of the OpenPIC regs */
-	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
-
-	mpic1 = mpic_alloc(OpenPIC_PAddr,
-			   MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			   4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			   mpc85xx_ads_openpic_initsenses,
-			   sizeof(mpc85xx_ads_openpic_initsenses),
-			   " OpenPIC  ");
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
-	mpic_init(mpic1);
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if(of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Could not map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			4, 0, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
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
+	/* Unused on this platform (leave room for 8548) */
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
 }
 
 /*
@@ -165,7 +112,9 @@ void __init mpc85xx_ads_pic_init(void)
 static void __init mpc85xx_ads_setup_arch(void)
 {
 	struct device_node *cpu;
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
@@ -186,8 +135,7 @@ #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc85xx_map_irq;
+	ppc_md.pcibios_fixup = mpc85xx_pcibios_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-- 
2006_06_07.01.gittree_pull-dirty
