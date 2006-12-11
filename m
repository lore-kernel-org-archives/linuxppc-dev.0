Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52B8D67BB2
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 14:09:15 +1100 (EST)
Subject: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 14:09:07 +1100
Message-Id: <1165806548.7260.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The changes to use pci_read_irq_line() broke interrupt parsing
on some 32 bits powermacs (oops). The reason is a bit obscure.
The code to parse interrupts happens earlier now, during
pcibios_fixup() as the PCI bus is being probed. However, the
current implementation pci_device_to_OF_node() for 32 bits
powerpc relies, on machines like PowerMac who renumber PCI busses,
on a table called pci_OF_bus_map containing a map of bus numbers
between the kernel and the firmware which is setup only later.
Thus, it fails to match the device node. In addition, some of
Apple internal PCI devices lack a proper PCI_INTERRUPT_PIN, thus
preventing the fallback mapping code to work.

This patch fixes it by making pci_device_to_OF_node() 32 bits
implementation use a different algorithm that works without
using the pci_OF_bus_map thing (which I intend to deprecate
anyway). It's a bit slower but that function isn't called in
any hot path hopefully.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2006-12-11 13:27:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2006-12-11 13:54:26.000000000 +1100
@@ -736,25 +736,51 @@ scan_OF_pci_childs(struct device_node* n
 	return NULL;
 }
 
-static int
-scan_OF_pci_childs_iterator(struct device_node* node, void* data)
+static struct device_node *scan_OF_for_pci_dev(struct device_node *parent,
+					       unsigned int devfn)
 {
-	const unsigned int *reg;
-	u8* fdata = (u8*)data;
-	
-	reg = get_property(node, "reg", NULL);
-	if (reg && ((reg[0] >> 8) & 0xff) == fdata[1]
-		&& ((reg[0] >> 16) & 0xff) == fdata[0])
-		return 1;
-	return 0;
+	struct device_node *np = NULL;
+	const u32 *reg;
+	unsigned int psize;
+
+	while ((np = of_get_next_child(parent, np)) != NULL) {
+		reg = get_property(np, "reg", &psize);
+		if (reg == NULL || psize < 4)
+			continue;
+		if (((reg[0] >> 8) & 0xff) == devfn)
+			return np;
+	}
+	return NULL;
 }
 
-static struct device_node*
-scan_OF_childs_for_device(struct device_node* node, u8 bus, u8 dev_fn)
+
+static struct device_node *scan_OF_for_pci_bus(struct pci_bus *bus)
 {
-	u8 filter_data[2] = {bus, dev_fn};
+	struct device_node *parent, *np;
+
+	/* Are we a root bus ? */
+	if (bus->self == NULL || bus->parent == NULL) {
+		struct pci_controller *hose = pci_bus_to_hose(bus->number);
+		if (hose == NULL)
+			return NULL;
+		return of_node_get(hose->arch_data);
+	}
+
+	/* not a root bus, we need to get our parent */
+	parent = scan_OF_for_pci_bus(bus->parent);
+	if (parent == NULL)
+		return NULL;
+
+	/* now iterate for children for a match */
+	np = scan_OF_for_pci_dev(parent, bus->self->devfn);
+	of_node_put(parent);
+
+	/* sanity check */
+	if (strcmp(np->type, "pci") != 0)
+		printk(KERN_WARNING "pci: wrong type \"%s\" for bridge %s\n",
+		       np->type, np->full_name);
 
-	return scan_OF_pci_childs(node, scan_OF_pci_childs_iterator, filter_data);
+	return np;
 }
 
 /*
@@ -763,43 +789,25 @@ scan_OF_childs_for_device(struct device_
 struct device_node *
 pci_busdev_to_OF_node(struct pci_bus *bus, int devfn)
 {
-	struct pci_controller *hose;
-	struct device_node *node;
-	int busnr;
+	struct device_node *parent, *np;
 
 	if (!have_of)
 		return NULL;
-	
-	/* Lookup the hose */
-	busnr = bus->number;
-	hose = pci_bus_to_hose(busnr);
-	if (!hose)
-		return NULL;
 
-	/* Check it has an OF node associated */
-	node = (struct device_node *) hose->arch_data;
-	if (!node)
+	DBG("pci_busdev_to_OF_node(%d,0x%x)\n", bus->number, devfn);
+	parent = scan_OF_for_pci_bus(bus);
+	if (parent == NULL)
 		return NULL;
-
-	/* Fixup bus number according to what OF think it is. */
-#ifdef CONFIG_PPC_PMAC
-	/* The G5 need a special case here. Basically, we don't remap all
-	 * busses on it so we don't create the pci-OF-map. However, we do
-	 * remap the AGP bus and so have to deal with it. A future better
-	 * fix has to be done by making the remapping per-host and always
-	 * filling the pci_to_OF map. --BenH
+	DBG(" parent is %s\n", parent ? parent->full_name : "<NULL>");
+	np = scan_OF_for_pci_dev(parent, devfn);
+	of_node_put(parent);
+	DBG(" result is %s\n", np ? np->full_name : "<NULL>");
+
+	/* XXX most callers don't release the returned node
+	 * mostly because ppc64 doesn't increase the refcount,
+	 * we need to fix that.
 	 */
-	if (machine_is(powermac) && busnr >= 0xf0)
-		busnr -= 0xf0;
-	else
-#endif
-	if (pci_to_OF_bus_map)
-		busnr = pci_to_OF_bus_map[busnr];
-	if (busnr == 0xff)
-		return NULL;
-	
-	/* Now, lookup childs of the hose */
-	return scan_OF_childs_for_device(node->child, busnr, devfn);
+	return np;
 }
 EXPORT_SYMBOL(pci_busdev_to_OF_node);
 
