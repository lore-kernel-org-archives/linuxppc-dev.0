Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 89685DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 14:33:37 +1100 (EST)
Date: Mon, 10 Dec 2007 14:33:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: [PATCH 19/19] [POWERPC] pci_controller->arch_data really is a
	struct device_node *
Message-Id: <20071210143321.6d40628f.sfr@canb.auug.org.au>
In-Reply-To: <1197185271.6572.41.camel@pasglop>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020542.577bbfe8.sfr@canb.auug.org.au>
	<1197185271.6572.41.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

This version also renames the arch_data field to dn.

 arch/powerpc/kernel/isa-bridge.c               |    2 +-
 arch/powerpc/kernel/pci-common.c               |    4 ++--
 arch/powerpc/kernel/pci_32.c                   |   10 +++++-----
 arch/powerpc/kernel/pci_64.c                   |    8 +++-----
 arch/powerpc/kernel/pci_dn.c                   |    2 +-
 arch/powerpc/kernel/prom_parse.c               |    2 +-
 arch/powerpc/kernel/rtas_pci.c                 |    2 +-
 arch/powerpc/platforms/82xx/pq2.c              |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c       |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c     |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |    2 +-
 arch/powerpc/platforms/cell/io-workarounds.c   |    4 ++--
 arch/powerpc/platforms/celleb/io-workarounds.c |    4 ++--
 arch/powerpc/platforms/celleb/pci.c            |    2 +-
 arch/powerpc/platforms/maple/pci.c             |    2 +-
 arch/powerpc/platforms/powermac/pci.c          |    6 +++---
 arch/powerpc/platforms/pseries/iommu.c         |    2 +-
 include/asm-powerpc/pci-bridge.h               |    5 +++--
 18 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 965bfcc..ee172aa 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -145,7 +145,7 @@ void __init isa_bridge_find_early(struct pci_controller *hose)
 	for_each_node_by_type(np, "isa") {
 		/* Look for our hose being a parent */
 		for (parent = of_get_parent(np); parent;) {
-			if (parent == hose->arch_data) {
+			if (parent == hose->dn) {
 				of_node_put(parent);
 				break;
 			}
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e0d4a2a..8f80591 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -65,7 +65,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	phb->global_number = global_phb_number++;
 	list_add_tail(&phb->list_node, &hose_list);
 	spin_unlock(&hose_spinlock);
-	phb->arch_data = dev;
+	phb->dn = dev;
 	phb->is_dynamic = mem_init_done;
 #ifdef CONFIG_PPC64
 	if (dev) {
@@ -140,7 +140,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
 	while(node) {
 		struct pci_controller *hose, *tmp;
 		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-			if (hose->arch_data == node)
+			if (hose->dn == node)
 				return hose;
 		node = node->parent;
 	}
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e1151b5..20a1192 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -661,8 +661,8 @@ pcibios_make_OF_bus_map(void)
 
 	/* For each hose, we begin searching bridges */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		struct device_node* node;	
-		node = (struct device_node *)hose->arch_data;
+		struct device_node* node = hose->dn;
+
 		if (!node)
 			continue;
 		make_one_node_map(node, hose->first_busno);
@@ -741,7 +741,7 @@ static struct device_node *scan_OF_for_pci_bus(struct pci_bus *bus)
 		struct pci_controller *hose = pci_bus_to_host(bus);
 		if (hose == NULL)
 			return NULL;
-		return of_node_get(hose->arch_data);
+		return of_node_get(hose->dn);
 	}
 
 	/* not a root bus, we need to get our parent */
@@ -811,9 +811,9 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 		return -ENODEV;
 	/* Make sure it's really a PCI device */
 	hose = pci_find_hose_for_OF_device(node);
-	if (!hose || !hose->arch_data)
+	if (!hose || !hose->dn)
 		return -ENODEV;
-	if (!scan_OF_pci_childs(((struct device_node*)hose->arch_data)->child,
+	if (!scan_OF_pci_childs(hose->dn->child,
 			find_OF_pci_device_filter, (void *)node))
 		return -ENODEV;
 	reg = of_get_property(node, "reg", NULL);
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index acf1219..bf06926 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -458,7 +458,7 @@ EXPORT_SYMBOL(of_scan_pci_bridge);
 void __devinit scan_phb(struct pci_controller *hose)
 {
 	struct pci_bus *bus;
-	struct device_node *node = hose->arch_data;
+	struct device_node *node = hose->dn;
 	int i, mode;
 	struct resource *res;
 
@@ -612,8 +612,7 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 	if (hose->io_base_alloc == 0)
 		return 0;
 
-	DBG("IO unmapping for PHB %s\n",
-	    ((struct device_node *)hose->arch_data)->full_name);
+	DBG("IO unmapping for PHB %s\n", hose->dn->full_name);
 	DBG("  alloc=0x%p\n", hose->io_base_alloc);
 
 	/* This is a PHB, we fully unmap the IO area */
@@ -672,8 +671,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	hose->io_base_virt = (void __iomem *)(area->addr +
 					      hose->io_base_phys - phys_page);
 
-	DBG("IO mapping for PHB %s\n",
-	    ((struct device_node *)hose->arch_data)->full_name);
+	DBG("IO mapping for PHB %s\n", hose->dn->full_name);
 	DBG("  phys=0x%016lx, virt=0x%p (alloc=0x%p)\n",
 	    hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
 	DBG("  size=0x%016lx (alloc=0x%016lx)\n",
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b483903..85d4d89 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -133,7 +133,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
  */
 void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct device_node * dn = (struct device_node *) phb->arch_data;
+	struct device_node *dn = phb->dn;
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index b5c96af..6bdfaf3 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -273,7 +273,7 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 #else
 			struct pci_controller *host;
 			host = pci_bus_to_host(pdev->bus);
-			ppnode = host ? host->arch_data : NULL;
+			ppnode = host ? host->dn : NULL;
 #endif
 			/* No node for host bridge ? give up */
 			if (ppnode == NULL)
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 21f14e5..3650eb5 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -260,7 +260,7 @@ static int phb_set_bus_ranges(struct device_node *dev,
 
 int __devinit rtas_setup_phb(struct pci_controller *phb)
 {
-	struct device_node *dev = phb->arch_data;
+	struct device_node *dev = phb->dn;
 
 	if (is_python(dev))
 		python_countermeasures(dev);
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index a497cba..11d1db8 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -59,7 +59,7 @@ static void __init pq2_pci_add_bridge(struct device_node *np)
 	if (!hose)
 		return;
 
-	hose->arch_data = np;
+	hose->dn = np;
 
 	setup_indirect_pci(hose, r.start + 0x100, r.start + 0x104, 0);
 	pci_process_bridge_OF_ranges(hose, np, 1);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 59c121a..bdb3d0b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -123,7 +123,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 	struct device_node* node;
 	struct resource rsrc;
 
-	node = (struct device_node *)hose->arch_data;
+	node = hose->dn;
 	of_address_to_resource(node, 0, &rsrc);
 
 	if ((rsrc.start & 0xfffff) == primary_phb_addr) {
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 6390895..c6d2f48 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -124,7 +124,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 static void __devinit final_uli5288(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct device_node *hosenode = hose ? hose->arch_data : NULL;
+	struct device_node *hosenode = hose ? hose->dn : NULL;
 	struct of_irq oirq;
 	int virq, pin = 2;
 	u32 laddr[3];
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 32a531a..14f4e52 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -116,7 +116,7 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
 	struct device_node* node;	
 	struct resource rsrc;
 
-	node = (struct device_node *)hose->arch_data;
+	node = hose->dn;
 	of_address_to_resource(node, 0, &rsrc);
 
 	if ((rsrc.start & 0xfffff) == 0x8000) {
diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
index 9d7c2ef..b86076e 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.c
+++ b/arch/powerpc/platforms/cell/io-workarounds.c
@@ -238,7 +238,7 @@ static void __init spider_pci_setup_chip(struct spider_pci_bus *bus)
 static void __init spider_pci_add_one(struct pci_controller *phb)
 {
 	struct spider_pci_bus *bus = &spider_pci_busses[spider_pci_count];
-	struct device_node *np = phb->arch_data;
+	struct device_node *np = phb->dn;
 	struct resource rsrc;
 	void __iomem *regs;
 
@@ -317,7 +317,7 @@ static int __init spider_pci_workaround_init(void)
 	 * update this code to cope with dynamically added busses
 	 */
 	list_for_each_entry(phb, &hose_list, list_node) {
-		struct device_node *np = phb->arch_data;
+		struct device_node *np = phb->dn;
 		const char *model = of_get_property(np, "model", NULL);
 
 		/* If no model property or name isn't exactly "pci", skip */
diff --git a/arch/powerpc/platforms/celleb/io-workarounds.c b/arch/powerpc/platforms/celleb/io-workarounds.c
index 32b9cec..b939c0e 100644
--- a/arch/powerpc/platforms/celleb/io-workarounds.c
+++ b/arch/powerpc/platforms/celleb/io-workarounds.c
@@ -222,7 +222,7 @@ void __init celleb_pci_add_one(struct pci_controller *phb,
 			       void (*dummy_read)(struct pci_controller *))
 {
 	struct celleb_pci_bus *bus = &celleb_pci_busses[celleb_pci_count];
-	struct device_node *np = phb->arch_data;
+	struct device_node *np = phb->dn;
 
 	if (celleb_pci_count >= MAX_CELLEB_PCI_BUS) {
 		printk(KERN_ERR "Too many pci bridges, workarounds"
@@ -262,7 +262,7 @@ int __init celleb_pci_workaround_init(void)
 	}
 
 	list_for_each_entry(phb, &hose_list, list_node) {
-		node = phb->arch_data;
+		node = phb->dn;
 		match = of_match_node(celleb_pci_workaround_match, node);
 
 		if (match) {
diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index 13ec4a6..5d399e0 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -480,7 +480,7 @@ static struct of_device_id celleb_phb_match[] __initdata = {
 
 int __init celleb_setup_phb(struct pci_controller *phb)
 {
-	struct device_node *dev = phb->arch_data;
+	struct device_node *dev = phb->dn;
 	const struct of_device_id *match;
 	int (*setup_func)(struct device_node *, struct pci_controller *);
 
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 771ed0c..3ffa0ac 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -558,7 +558,7 @@ void __init maple_pci_init(void)
 	 * safe assumptions hopefully.
 	 */
 	if (u3_agp) {
-		struct device_node *np = u3_agp->arch_data;
+		struct device_node *np = u3_agp->dn;
 		PCI_DN(np)->busno = 0xf0;
 		for (np = np->child; np; np = np->sibling)
 			PCI_DN(np)->busno = 0xf0;
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index ec49099..778c249 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -319,7 +319,7 @@ static int u3_ht_skip_device(struct pci_controller *hose,
 	if (bus->self)
 		busdn = pci_device_to_OF_node(bus->self);
 	else
-		busdn = hose->arch_data;
+		busdn = hose->dn;
 	for (dn = busdn->child; dn; dn = dn->sibling)
 		if (PCI_DN(dn) && PCI_DN(dn)->devfn == devfn)
 			break;
@@ -778,7 +778,7 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
 
 static void __init setup_u3_ht(struct pci_controller* hose)
 {
-	struct device_node *np = (struct device_node *)hose->arch_data;
+	struct device_node *np = hose->dn;
 	struct pci_controller *other = NULL;
 	int i, cur;
 
@@ -1032,7 +1032,7 @@ void __init pmac_pci_init(void)
 	 * future though
 	 */
 	if (u3_agp) {
-		struct device_node *np = u3_agp->arch_data;
+		struct device_node *np = u3_agp->dn;
 		PCI_DN(np)->busno = 0xf0;
 		for (np = np->child; np; np = np->sibling)
 			PCI_DN(np)->busno = 0xf0;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ebb9313..a65c763 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -251,7 +251,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	const unsigned long *basep;
 	const u32 *sizep;
 
-	node = (struct device_node *)phb->arch_data;
+	node = phb->dn;
 
 	basep = of_get_property(node, "linux,tce-base", NULL);
 	sizep = of_get_property(node, "linux,tce-size", NULL);
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index beb09b5..6b81e22 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -11,6 +11,8 @@
 #include <linux/list.h>
 #include <linux/ioport.h>
 
+struct device_node;
+
 /*
  * Structure of a PCI controller (host bridge)
  */
@@ -20,7 +22,7 @@ struct pci_controller {
 #ifdef CONFIG_PPC64
 	int node;
 #endif
-	void *arch_data;
+	struct device_node *dn;
 	struct list_head list_node;
 	struct device *parent;
 
@@ -130,7 +132,6 @@ extern void __init update_bridge_resource(struct pci_dev *dev,
  * by device_node->data.
  */
 struct iommu_table;
-struct device_node;
 
 struct pci_dn {
 	int	busno;			/* pci bus number */
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
