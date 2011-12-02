Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 6A0E9100C0C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:17 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 10/10] powerpc/mpic: Add in-core support for cascaded MPICs
Date: Fri,  2 Dec 2011 11:28:07 -0500
Message-Id: <1322843287-2745-11-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Cell and PowerMac platforms use virtually identical cascaded-IRQ
setup code, so just merge it into the core.  Ideally this code would
trigger automatically when an MPIC device-node specifies an "interrupts"
property, perhaps even enabling MPIC_SECONDARY along the way.

Unfortunately, Benjamin Herrenschmidt has had bad experiences in the
past with the quality of Apple PowerMac device-trees, so to be safe we
will only try to parse out an IRQ if the MPIC_SECONDARY flag is set by
the caller.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/cell/setup.c   |   23 ---------------------
 arch/powerpc/platforms/powermac/pic.c |   36 ++++----------------------------
 arch/powerpc/sysdev/mpic.c            |   30 +++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index cd00ca8..62002a7 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -184,24 +184,10 @@ static int __init cell_publish_devices(void)
 }
 machine_subsys_initcall(cell, cell_publish_devices);
 
-static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct mpic *mpic = irq_desc_get_handler_data(desc);
-	unsigned int virq;
-
-	virq = mpic_get_one_irq(mpic);
-	if (virq != NO_IRQ)
-		generic_handle_irq(virq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
 static void __init mpic_init_IRQ(void)
 {
 	struct device_node *dn;
 	struct mpic *mpic;
-	unsigned int virq;
 
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
@@ -215,15 +201,6 @@ static void __init mpic_init_IRQ(void)
 		if (mpic == NULL)
 			continue;
 		mpic_init(mpic);
-
-		virq = irq_of_parse_and_map(dn, 0);
-		if (virq == NO_IRQ)
-			continue;
-
-		printk(KERN_INFO "%s : hooking up to IRQ %d\n",
-		       dn->full_name, virq);
-		irq_set_handler_data(virq, mpic);
-		irq_set_chained_handler(virq, cell_mpic_cascade);
 	}
 }
 
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index b962101..d8aedf1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -464,18 +464,6 @@ int of_irq_map_oldworld(struct device_node *device, int index,
 }
 #endif /* CONFIG_PPC32 */
 
-static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct mpic *mpic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = mpic_get_one_irq(mpic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
 static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
 {
 #if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
@@ -526,7 +514,6 @@ static int __init pmac_pic_probe_mpic(void)
 {
 	struct mpic *mpic1, *mpic2;
 	struct device_node *np, *master = NULL, *slave = NULL;
-	unsigned int cascade;
 
 	/* We can have up to 2 MPICs cascaded */
 	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
@@ -562,27 +549,14 @@ static int __init pmac_pic_probe_mpic(void)
 
 	of_node_put(master);
 
-	/* No slave, let's go out */
-	if (slave == NULL)
-		return 0;
-
-	/* Get/Map slave interrupt */
-	cascade = irq_of_parse_and_map(slave, 0);
-	if (cascade == NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade IRQ\n");
-		return 0;
-	}
-
-	mpic2 = pmac_setup_one_mpic(slave, 0);
-	if (mpic2 == NULL) {
-		printk(KERN_ERR "Failed to setup slave MPIC\n");
+	/* Set up a cascaded controller, if present */
+	if (slave) {
+		mpic2 = pmac_setup_one_mpic(slave, 0);
+		if (mpic2 == NULL)
+			printk(KERN_ERR "Failed to setup slave MPIC\n");
 		of_node_put(slave);
-		return 0;
 	}
-	irq_set_handler_data(cascade, mpic2);
-	irq_set_chained_handler(cascade, pmac_u3_cascade);
 
-	of_node_put(slave);
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7611060..4e9ccb1 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1111,6 +1111,22 @@ static int mpic_host_xlate(struct irq_host *h, struct device_node *ct,
 	return 0;
 }
 
+/* IRQ handler for a secondary MPIC cascaded from another IRQ controller */
+static void mpic_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mpic *mpic = irq_desc_get_handler_data(desc);
+	unsigned int virq;
+
+	BUG_ON(!(mpic->flags & MPIC_SECONDARY));
+
+	virq = mpic_get_one_irq(mpic);
+	if (virq != NO_IRQ)
+		generic_handle_irq(virq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
 static struct irq_host_ops mpic_host_ops = {
 	.match = mpic_host_match,
 	.map = mpic_host_map,
@@ -1402,8 +1418,7 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
 
 void __init mpic_init(struct mpic *mpic)
 {
-	int i;
-	int cpu;
+	int i, cpu;
 
 	BUG_ON(mpic->num_sources == 0);
 
@@ -1488,6 +1503,17 @@ void __init mpic_init(struct mpic *mpic)
 				  GFP_KERNEL);
 	BUG_ON(mpic->save_data == NULL);
 #endif
+
+	/* Check if this MPIC is chained from a parent interrupt controller */
+	if (mpic->flags & MPIC_SECONDARY) {
+		int virq = irq_of_parse_and_map(mpic->node, 0);
+		if (virq != NO_IRQ) {
+			printk(KERN_INFO "%s: hooking up to IRQ %d\n",
+					mpic->node->full_name, virq);
+			irq_set_handler_data(virq, mpic);
+			irq_set_chained_handler(virq, &mpic_cascade);
+		}
+	}
 }
 
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
-- 
1.7.2.5
