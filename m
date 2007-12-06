Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BFC8BDE291
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:03 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 79241368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:03 +1100 (EST)
Date: Fri, 7 Dec 2007 02:05:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 19/19] [POWERPC] pci_controller->arch_data really is a
	struct device_node *
Message-Id: <20071207020542.577bbfe8.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
 arch/powerpc/kernel/pci_32.c               |    6 +++---
 arch/powerpc/kernel/pci_64.c               |    6 ++----
 arch/powerpc/kernel/pci_dn.c               |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 arch/powerpc/platforms/powermac/pci.c      |    2 +-
 arch/powerpc/platforms/pseries/iommu.c     |    2 +-
 include/asm-powerpc/pci-bridge.h           |    5 +++--
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e1151b5..3a05f4f 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -661,8 +661,8 @@ pcibios_make_OF_bus_map(void)
 
 	/* For each hose, we begin searching bridges */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		struct device_node* node;	
-		node = (struct device_node *)hose->arch_data;
+		struct device_node* node = hose->arch_data;
+
 		if (!node)
 			continue;
 		make_one_node_map(node, hose->first_busno);
@@ -813,7 +813,7 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 	hose = pci_find_hose_for_OF_device(node);
 	if (!hose || !hose->arch_data)
 		return -ENODEV;
-	if (!scan_OF_pci_childs(((struct device_node*)hose->arch_data)->child,
+	if (!scan_OF_pci_childs(hose->arch_data->child,
 			find_OF_pci_device_filter, (void *)node))
 		return -ENODEV;
 	reg = of_get_property(node, "reg", NULL);
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index acf1219..b452031 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -612,8 +612,7 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 	if (hose->io_base_alloc == 0)
 		return 0;
 
-	DBG("IO unmapping for PHB %s\n",
-	    ((struct device_node *)hose->arch_data)->full_name);
+	DBG("IO unmapping for PHB %s\n", hose->arch_data->full_name);
 	DBG("  alloc=0x%p\n", hose->io_base_alloc);
 
 	/* This is a PHB, we fully unmap the IO area */
@@ -672,8 +671,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	hose->io_base_virt = (void __iomem *)(area->addr +
 					      hose->io_base_phys - phys_page);
 
-	DBG("IO mapping for PHB %s\n",
-	    ((struct device_node *)hose->arch_data)->full_name);
+	DBG("IO mapping for PHB %s\n", hose->arch_data->full_name);
 	DBG("  phys=0x%016lx, virt=0x%p (alloc=0x%p)\n",
 	    hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
 	DBG("  size=0x%016lx (alloc=0x%016lx)\n",
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b483903..f326e91 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -133,7 +133,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
  */
 void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct device_node * dn = (struct device_node *) phb->arch_data;
+	struct device_node *dn = phb->arch_data;
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 59c121a..d084829 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -123,7 +123,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 	struct device_node* node;
 	struct resource rsrc;
 
-	node = (struct device_node *)hose->arch_data;
+	node = hose->arch_data;
 	of_address_to_resource(node, 0, &rsrc);
 
 	if ((rsrc.start & 0xfffff) == primary_phb_addr) {
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 32a531a..49b2bee 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -116,7 +116,7 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
 	struct device_node* node;	
 	struct resource rsrc;
 
-	node = (struct device_node *)hose->arch_data;
+	node = hose->arch_data;
 	of_address_to_resource(node, 0, &rsrc);
 
 	if ((rsrc.start & 0xfffff) == 0x8000) {
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index ec49099..472f44b 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -778,7 +778,7 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
 
 static void __init setup_u3_ht(struct pci_controller* hose)
 {
-	struct device_node *np = (struct device_node *)hose->arch_data;
+	struct device_node *np = hose->arch_data;
 	struct pci_controller *other = NULL;
 	int i, cur;
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ebb9313..a446e0b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -251,7 +251,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	const unsigned long *basep;
 	const u32 *sizep;
 
-	node = (struct device_node *)phb->arch_data;
+	node = phb->arch_data;
 
 	basep = of_get_property(node, "linux,tce-base", NULL);
 	sizep = of_get_property(node, "linux,tce-size", NULL);
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index beb09b5..4bad3e7 100644
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
+	struct device_node *arch_data;
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
