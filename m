Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D80DB67CF5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 07:03:44 +1000 (EST)
Date: Mon, 16 Oct 2006 16:03:33 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] Fixed up the OF functions to only do PCI stuff if PCI is
	actually configured
Message-ID: <Pine.LNX.4.61.0610161558500.6266@ld0175-tx32.am.freescale.net>
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

The original problem that inspired this patch was solved quite some time 
ago (Turning off PCI didn't work), but this patch neatens things up a 
little (I think), by putting all the PCI stuff inside a single CONFIG_PCI 
block.  It also removes the OF PCI bus matching entries if CONFIG_PCI is 
off.

---

 arch/powerpc/kernel/prom_parse.c |  288 ++++++++++++++++++++------------------
 1 files changed, 148 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 603dff3..346fb7b 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -25,6 +25,12 @@ #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
 			(ns) > 0)
 
+static struct of_bus *of_match_bus(struct device_node *np);
+static int __of_address_to_resource(struct device_node *dev,
+		const u32 *addrp, u64 size, unsigned int flags,
+		struct resource *r);
+
+
 /* Debug utility */
 #ifdef DEBUG
 static void of_dump_addr(const char *s, const u32 *addr, int na)
@@ -101,6 +107,7 @@ static unsigned int of_bus_default_get_f
 }
 
 
+#ifdef CONFIG_PCI
 /*
  * PCI bus specific translator
  */
@@ -162,6 +169,145 @@ static unsigned int of_bus_pci_get_flags
 	return flags;
 }
 
+const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
+			unsigned int *flags)
+{
+	const u32 *prop;
+	unsigned int psize;
+	struct device_node *parent;
+	struct of_bus *bus;
+	int onesize, i, na, ns;
+
+	/* Get parent & match bus type */
+	parent = of_get_parent(dev);
+	if (parent == NULL)
+		return NULL;
+	bus = of_match_bus(parent);
+	if (strcmp(bus->name, "pci")) {
+		of_node_put(parent);
+		return NULL;
+	}
+	bus->count_cells(dev, &na, &ns);
+	of_node_put(parent);
+	if (!OF_CHECK_COUNTS(na, ns))
+		return NULL;
+
+	/* Get "reg" or "assigned-addresses" property */
+	prop = get_property(dev, bus->addresses, &psize);
+	if (prop == NULL)
+		return NULL;
+	psize /= 4;
+
+	onesize = na + ns;
+	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
+		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
+			if (size)
+				*size = of_read_number(prop + na, ns);
+			if (flags)
+				*flags = bus->get_flags(prop);
+			return prop;
+		}
+	return NULL;
+}
+EXPORT_SYMBOL(of_get_pci_address);
+
+int of_pci_address_to_resource(struct device_node *dev, int bar,
+			       struct resource *r)
+{
+	const u32	*addrp;
+	u64		size;
+	unsigned int	flags;
+
+	addrp = of_get_pci_address(dev, bar, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+	return __of_address_to_resource(dev, addrp, size, flags, r);
+}
+EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
+{
+	return (((pin - 1) + slot) % 4) + 1;
+}
+
+int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
+{
+	struct device_node *dn, *ppnode;
+	struct pci_dev *ppdev;
+	u32 lspec;
+	u32 laddr[3];
+	u8 pin;
+	int rc;
+
+	/* Check if we have a device node, if yes, fallback to standard OF
+	 * parsing
+	 */
+	dn = pci_device_to_OF_node(pdev);
+	if (dn)
+		return of_irq_map_one(dn, 0, out_irq);
+
+	/* Ok, we don't, time to have fun. Let's start by building up an
+	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
+	 * for PCI. If you do different, then don't use that routine.
+	 */
+	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+	if (rc != 0)
+		return rc;
+	/* No pin, exit */
+	if (pin == 0)
+		return -ENODEV;
+
+	/* Now we walk up the PCI tree */
+	lspec = pin;
+	for (;;) {
+		/* Get the pci_dev of our parent */
+		ppdev = pdev->bus->self;
+
+		/* Ouch, it's a host bridge... */
+		if (ppdev == NULL) {
+#ifdef CONFIG_PPC64
+			ppnode = pci_bus_to_OF_node(pdev->bus);
+#else
+			struct pci_controller *host;
+			host = pci_bus_to_host(pdev->bus);
+			ppnode = host ? host->arch_data : NULL;
+#endif
+			/* No node for host bridge ? give up */
+			if (ppnode == NULL)
+				return -EINVAL;
+		} else
+			/* We found a P2P bridge, check if it has a node */
+			ppnode = pci_device_to_OF_node(ppdev);
+
+		/* Ok, we have found a parent with a device-node, hand over to
+		 * the OF parsing code.
+		 * We build a unit address from the linux device to be used for
+		 * resolution. Note that we use the linux bus number which may
+		 * not match your firmware bus numbering.
+		 * Fortunately, in most cases, interrupt-map-mask doesn't include
+		 * the bus number as part of the matching.
+		 * You should still be careful about that though if you intend
+		 * to rely on this function (you ship  a firmware that doesn't
+		 * create device nodes for all PCI devices).
+		 */
+		if (ppnode)
+			break;
+
+		/* We can only get here if we hit a P2P bridge with no node,
+		 * let's do standard swizzling and try again
+		 */
+		lspec = of_irq_pci_swizzle(PCI_SLOT(pdev->devfn), lspec);
+		pdev = ppdev;
+	}
+
+	laddr[0] = (pdev->bus->number << 16)
+		| (pdev->devfn << 8);
+	laddr[1]  = laddr[2] = 0;
+	return of_irq_map_raw(ppnode, &lspec, 1, laddr, out_irq);
+}
+EXPORT_SYMBOL_GPL(of_irq_map_pci);
+#endif /* CONFIG_PCI */
+
 /*
  * ISA bus specific translator
  */
@@ -223,6 +369,7 @@ static unsigned int of_bus_isa_get_flags
  */
 
 static struct of_bus of_busses[] = {
+#ifdef CONFIG_PCI
 	/* PCI */
 	{
 		.name = "pci",
@@ -233,6 +380,7 @@ static struct of_bus of_busses[] = {
 		.translate = of_bus_pci_translate,
 		.get_flags = of_bus_pci_get_flags,
 	},
+#endif /* CONFIG_PCI */
 	/* ISA */
 	{
 		.name = "isa",
@@ -445,48 +593,6 @@ const u32 *of_get_address(struct device_
 }
 EXPORT_SYMBOL(of_get_address);
 
-const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
-			unsigned int *flags)
-{
-	const u32 *prop;
-	unsigned int psize;
-	struct device_node *parent;
-	struct of_bus *bus;
-	int onesize, i, na, ns;
-
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
-	if (parent == NULL)
-		return NULL;
-	bus = of_match_bus(parent);
-	if (strcmp(bus->name, "pci")) {
-		of_node_put(parent);
-		return NULL;
-	}
-	bus->count_cells(dev, &na, &ns);
-	of_node_put(parent);
-	if (!OF_CHECK_COUNTS(na, ns))
-		return NULL;
-
-	/* Get "reg" or "assigned-addresses" property */
-	prop = get_property(dev, bus->addresses, &psize);
-	if (prop == NULL)
-		return NULL;
-	psize /= 4;
-
-	onesize = na + ns;
-	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
-		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
-			if (size)
-				*size = of_read_number(prop + na, ns);
-			if (flags)
-				*flags = bus->get_flags(prop);
-			return prop;
-		}
-	return NULL;
-}
-EXPORT_SYMBOL(of_get_pci_address);
-
 static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
 				    u64 size, unsigned int flags,
 				    struct resource *r)
@@ -529,20 +635,6 @@ int of_address_to_resource(struct device
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
-int of_pci_address_to_resource(struct device_node *dev, int bar,
-			       struct resource *r)
-{
-	const u32	*addrp;
-	u64		size;
-	unsigned int	flags;
-
-	addrp = of_get_pci_address(dev, bar, &size, &flags);
-	if (addrp == NULL)
-		return -EINVAL;
-	return __of_address_to_resource(dev, addrp, size, flags, r);
-}
-EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
-
 void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 		unsigned long *busno, unsigned long *phys, unsigned long *size)
 {
@@ -898,87 +990,3 @@ int of_irq_map_one(struct device_node *d
 	return res;
 }
 EXPORT_SYMBOL_GPL(of_irq_map_one);
-
-#ifdef CONFIG_PCI
-static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
-int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
-{
-	struct device_node *dn, *ppnode;
-	struct pci_dev *ppdev;
-	u32 lspec;
-	u32 laddr[3];
-	u8 pin;
-	int rc;
-
-	/* Check if we have a device node, if yes, fallback to standard OF
-	 * parsing
-	 */
-	dn = pci_device_to_OF_node(pdev);
-	if (dn)
-		return of_irq_map_one(dn, 0, out_irq);
-
-	/* Ok, we don't, time to have fun. Let's start by building up an
-	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
-	 * for PCI. If you do different, then don't use that routine.
-	 */
-	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
-	if (rc != 0)
-		return rc;
-	/* No pin, exit */
-	if (pin == 0)
-		return -ENODEV;
-
-	/* Now we walk up the PCI tree */
-	lspec = pin;
-	for (;;) {
-		/* Get the pci_dev of our parent */
-		ppdev = pdev->bus->self;
-
-		/* Ouch, it's a host bridge... */
-		if (ppdev == NULL) {
-#ifdef CONFIG_PPC64
-			ppnode = pci_bus_to_OF_node(pdev->bus);
-#else
-			struct pci_controller *host;
-			host = pci_bus_to_host(pdev->bus);
-			ppnode = host ? host->arch_data : NULL;
-#endif
-			/* No node for host bridge ? give up */
-			if (ppnode == NULL)
-				return -EINVAL;
-		} else
-			/* We found a P2P bridge, check if it has a node */
-			ppnode = pci_device_to_OF_node(ppdev);
-
-		/* Ok, we have found a parent with a device-node, hand over to
-		 * the OF parsing code.
-		 * We build a unit address from the linux device to be used for
-		 * resolution. Note that we use the linux bus number which may
-		 * not match your firmware bus numbering.
-		 * Fortunately, in most cases, interrupt-map-mask doesn't include
-		 * the bus number as part of the matching.
-		 * You should still be careful about that though if you intend
-		 * to rely on this function (you ship  a firmware that doesn't
-		 * create device nodes for all PCI devices).
-		 */
-		if (ppnode)
-			break;
-
-		/* We can only get here if we hit a P2P bridge with no node,
-		 * let's do standard swizzling and try again
-		 */
-		lspec = of_irq_pci_swizzle(PCI_SLOT(pdev->devfn), lspec);
-		pdev = ppdev;
-	}
-
-	laddr[0] = (pdev->bus->number << 16)
-		| (pdev->devfn << 8);
-	laddr[1]  = laddr[2] = 0;
-	return of_irq_map_raw(ppnode, &lspec, 1, laddr, out_irq);
-}
-EXPORT_SYMBOL_GPL(of_irq_map_pci);
-#endif /* CONFIG_PCI */
-- 
1.4.2.3
