Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2007 16:22:56 +1100
Subject: [PATCH 4/13] [POWERPC] pci32: Add flags modifying the PCI code
	behaviour
In-Reply-To: <1197436973.110379.888292904645.qpush@grosgo>
Message-Id: <20071212052300.AD5A2DDF4A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds to the 32 bits PCI code some flags, replacing the old
pci_assign_all_busses global, that allow to control various
aspects of the PCI probing, such as whether to re-assign all
resources or not, or to not try to assign anything at all.

This also adds the flag x86 already has to avoid ISA alignment
on bridges that don't have ISA forwarding enabled (no legacy
devices on the top level bus) and sets it for PowerMacs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c              |   42 ++++++++++++++++++++++++------
 arch/powerpc/kernel/pci_64.c              |    1 
 arch/powerpc/kernel/rtas_pci.c            |    6 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    2 -
 arch/powerpc/platforms/82xx/pq2.c         |    2 -
 arch/powerpc/platforms/83xx/pci.c         |    2 -
 arch/powerpc/platforms/chrp/pci.c         |    2 -
 arch/powerpc/platforms/powermac/pci.c     |    7 +++--
 arch/powerpc/sysdev/fsl_pci.c             |    2 -
 arch/powerpc/sysdev/grackle.c             |    2 -
 include/asm-powerpc/pci-bridge.h          |   20 ++++++++++++++
 include/asm-powerpc/pci.h                 |   10 ++++---
 12 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index dfb1658..beb6f04 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -35,6 +35,9 @@ unsigned long isa_io_base     = 0;
 unsigned long pci_dram_offset = 0;
 int pcibios_assign_bus_offset = 1;
 
+/* Default PCI flags is 0 */
+unsigned int ppc_pci_flags;
+
 void pcibios_make_OF_bus_map(void);
 
 static void pcibios_fixup_resources(struct pci_dev* dev);
@@ -48,7 +51,7 @@ static u8* pci_to_OF_bus_map;
 /* By default, we don't re-assign bus numbers. We do this only on
  * some pmacs
  */
-int pci_assign_all_buses;
+static int pci_assign_all_buses;
 
 LIST_HEAD(hose_list);
 
@@ -174,6 +177,14 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
 
+static int skip_isa_ioresource_align(struct pci_dev *dev)
+{
+	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
+	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
+		return 1;
+	return 0;
+}
+
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -195,6 +206,8 @@ void pcibios_align_resource(void *data, struct resource *res,
 	if (res->flags & IORESOURCE_IO) {
 		resource_size_t start = res->start;
 
+		if (skip_isa_ioresource_align(dev))
+			return;
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
 			res->start = start;
@@ -251,8 +264,13 @@ pcibios_allocate_bus_resources(struct list_head *bus_list)
 				continue;
 			if (bus->parent == NULL)
 				pr = (res->flags & IORESOURCE_IO)?
-					&ioport_resource: &iomem_resource;
+					&ioport_resource : &iomem_resource;
 			else {
+				/* Don't bother with non-root busses when
+				 * re-assigning all resources.
+				 */
+				if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)
+					continue;
 				pr = pci_find_parent_resource(bus->self, res);
 				if (pr == res) {
 					/* this happens when the generic PCI
@@ -720,6 +738,9 @@ pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_BUS)
+		pci_assign_all_buses = 1;
+
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		if (pci_assign_all_buses)
@@ -746,13 +767,18 @@ pcibios_init(void)
 	if (ppc_md.pcibios_fixup)
 		ppc_md.pcibios_fixup();
 
-	/* Allocate and assign resources */
+	/* Allocate and assign resources. If we re-assign everything, then
+	 * we skip the allocate phase
+	 */
 	pcibios_allocate_bus_resources(&pci_root_buses);
-	pcibios_allocate_resources(0);
-	pcibios_allocate_resources(1);
-
-	DBG("PCI: Assigning unassigned resouces...\n");
-	pci_assign_unassigned_resources();
+	if (!(ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)) {
+		pcibios_allocate_resources(0);
+		pcibios_allocate_resources(1);
+	}
+	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
+		DBG("PCI: Assigning unassigned resouces...\n");
+		pci_assign_unassigned_resources();
+	}
 
 	/* Call machine dependent post-init code */
 	if (ppc_md.pcibios_after_init)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index bf06926..115becf 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -40,7 +40,6 @@
 #endif
 
 unsigned long pci_probe_only = 1;
-int pci_assign_all_buses = 0;
 
 static void fixup_resource(struct resource *res, struct pci_dev *dev);
 static void do_bus_setup(struct pci_bus *bus);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 3650eb5..99aaae3 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -311,10 +311,12 @@ void __init find_and_init_phbs(void)
 		if (prop)
 			pci_probe_only = *prop;
 
+#ifdef CONFIG_PPC32 /* Will be made generic soon */
 		prop = of_get_property(of_chosen,
 				"linux,pci-assign-all-buses", NULL);
-		if (prop)
-			pci_assign_all_buses = *prop;
+		if (prop && *prop)
+			ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+#endif /* CONFIG_PPC32 */
 	}
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 4c6c82a..262eda8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -363,7 +363,7 @@ mpc52xx_add_bridge(struct device_node *node)
 
 	pr_debug("Adding MPC52xx PCI host bridge %s\n", node->full_name);
 
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 
 	if (of_address_to_resource(node, 0, &rsrc) != 0) {
 		printk(KERN_ERR "Can't get %s resources\n", node->full_name);
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 11d1db8..1b75902 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -53,7 +53,7 @@ static void __init pq2_pci_add_bridge(struct device_node *np)
 	if (of_address_to_resource(np, 0, &r) || r.end - r.start < 0x10b)
 		goto err;
 
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 
 	hose = pcibios_alloc_controller(np);
 	if (!hose)
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 80425d7..14f1080 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -54,7 +54,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 	}
 
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index e43465d..75c9e79 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -198,7 +198,7 @@ static void __init setup_peg2(struct pci_controller *hose, struct device_node *d
 		printk ("RTAS supporting Pegasos OF not found, please upgrade"
 			" your firmware\n");
 	}
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 	/* keep the reference to the root node */
 }
 
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 778c249..27cad1d 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -725,7 +725,7 @@ static void __init setup_bandit(struct pci_controller *hose,
 static int __init setup_uninorth(struct pci_controller *hose,
 				 struct resource *addr)
 {
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 	has_uninorth = 1;
 	hose->ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
@@ -994,6 +994,9 @@ void __init pmac_pci_init(void)
 	struct device_node *np, *root;
 	struct device_node *ht = NULL;
 
+#ifdef CONFIG_PPC32
+	ppc_pci_flags = PPC_PCI_CAN_SKIP_ISA_ALIGN;
+#endif
 	root = of_find_node_by_path("/");
 	if (root == NULL) {
 		printk(KERN_CRIT "pmac_pci_init: can't find root "
@@ -1051,7 +1054,7 @@ void __init pmac_pci_init(void)
 	 * some offset between bus number and domains for now when we
 	 * assign all busses should help for now
 	 */
-	if (pci_assign_all_buses)
+	if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_BUS)
 		pcibios_assign_bus_offset = 0x10;
 #endif
 }
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 87e58e0..4b1d512 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -202,7 +202,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 			" bus 0\n", dev->full_name);
 
-	pci_assign_all_buses = 1;
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
diff --git a/arch/powerpc/sysdev/grackle.c b/arch/powerpc/sysdev/grackle.c
index 11ad562..d502927 100644
--- a/arch/powerpc/sysdev/grackle.c
+++ b/arch/powerpc/sysdev/grackle.c
@@ -57,7 +57,7 @@ void __init setup_grackle(struct pci_controller *hose)
 {
 	setup_indirect_pci(hose, 0xfec00000, 0xfee00000, 0);
 	if (machine_is_compatible("PowerMac1,1"))
-		pci_assign_all_buses = 1;
+		ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
 	if (machine_is_compatible("AAPL,PowerBook1998"))
 		grackle_set_loop_snoop(hose, 1);
 #if 0	/* Disabled for now, HW problems ??? */
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 8245e84..2972f0d 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -13,6 +13,26 @@
 
 struct device_node;
 
+extern unsigned int ppc_pci_flags;
+enum {
+	/* Force re-assigning all resources (ignore firmware
+	 * setup completely)
+	 */
+	PPC_PCI_REASSIGN_ALL_RSRC	= 0x00000001,
+
+	/* Re-assign all bus numbers */
+	PPC_PCI_REASSIGN_ALL_BUS	= 0x00000002,
+
+	/* Do not try to assign, just use existing setup */
+	PPC_PCI_PROBE_ONLY		= 0x00000004,
+
+	/* Don't bother with ISA alignment unless the bridge has
+	 * ISA forwarding enabled
+	 */
+	PPC_PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
+};
+
+
 /*
  * Structure of a PCI controller (host bridge)
  */
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index 7b11765..47cc117 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -38,9 +38,12 @@ struct pci_dev;
  * Set this to 1 if you want the kernel to re-assign all PCI
  * bus numbers
  */
-extern int pci_assign_all_buses;
-#define pcibios_assign_all_busses()	(pci_assign_all_buses)
-
+#ifdef CONFIG_PPC64
+#define pcibios_assign_all_busses()	0
+#else
+#define pcibios_assign_all_busses()    	(ppc_pci_flags & \
+					 PPC_PCI_REASSIGN_ALL_BUS)
+#endif
 #define pcibios_scan_all_fns(a, b)	0
 
 static inline void pcibios_set_master(struct pci_dev *dev)
-- 
1.5.3.7
