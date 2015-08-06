Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61B3E1A1C11
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D46DF2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D1sh60752120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764Cc6Z001294
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 34/42] powerpc/pci: Delay creating pci_dn
Date: Thu,  6 Aug 2015 14:11:39 +1000
Message-Id: <1438834307-26960-35-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pci_dn instances are allocated from memblock or bootmem when
creating PCI controller (hoses) in setup_arch(). The PCI hotplug,
which will be supported by proceeding patches, will release PCI
device nodes and their corresponding pci_dn on unplugging event.
The pci_dn instance memory chunks alloed from memblock or bootmem
are hard to reused after being released.

This delays creating pci_dn using core_initcall() so that they can
be allocated from slab. In turn, the memory chunks for them can be
reused after being released without problem. Since the pci_dn and
eeh_dev has same life cycle, the eeh_dev is created when pci_dn is
populated. We needn't create eeh_dev with another initcall. The
time to create PHB PEs is delayed a bit from core_initcall() to
core_initcall_sync().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h         |  2 +-
 arch/powerpc/include/asm/ppc-pci.h     |  1 -
 arch/powerpc/kernel/eeh_dev.c          | 19 ++++------------
 arch/powerpc/kernel/pci_dn.c           | 20 +++++++++++++++--
 arch/powerpc/platforms/maple/pci.c     | 34 ++++++++++++++++++-----------
 arch/powerpc/platforms/pasemi/pci.c    |  3 ---
 arch/powerpc/platforms/powermac/pci.c  | 40 ++++++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.c   |  3 ---
 arch/powerpc/platforms/pseries/setup.c |  7 +-----
 9 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ea1f13c4..19b6050 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -272,7 +272,7 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-void *eeh_dev_init(struct pci_dn *pdn, void *data);
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn, struct pci_controller *phb);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index ca0c5bf..916775d 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -40,7 +40,6 @@ void *traverse_pci_dn(struct pci_dn *root,
 		      void *(*fn)(struct pci_dn *, void *),
 		      void *data);
 
-extern void pci_devs_phb_init(void);
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
 
 /* From rtas_pci.h */
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index aabba94..7a135c1 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -44,14 +44,13 @@
 /**
  * eeh_dev_init - Create EEH device according to OF node
  * @pdn: PCI device node
- * @data: PHB
+ * @phb: PCI controller
  *
  * It will create EEH device according to the given OF node. The function
  * might be called by PCI emunation, DR, PHB hotplug.
  */
-void *eeh_dev_init(struct pci_dn *pdn, void *data)
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn, struct pci_controller *phb)
 {
-	struct pci_controller *phb = data;
 	struct eeh_dev *edev;
 
 	/* Allocate EEH device */
@@ -68,7 +67,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
 	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
 
-	return NULL;
+	return edev;
 }
 
 /**
@@ -80,16 +79,8 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
  */
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct pci_dn *root = phb->pci_data;
-
 	/* EEH PE for PHB */
 	eeh_phb_pe_create(phb);
-
-	/* EEH device for PHB */
-	eeh_dev_init(root, phb);
-
-	/* EEH devices for children OF nodes */
-	traverse_pci_dn(root, eeh_dev_init, phb);
 }
 
 /**
@@ -105,9 +96,7 @@ static int __init eeh_dev_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		eeh_dev_phb_init_dynamic(phb);
 
-	pr_info("EEH: devices created\n");
-
 	return 0;
 }
 
-core_initcall(eeh_dev_phb_init);
+core_initcall_sync(eeh_dev_phb_init);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index f0ddde7..53a11e9 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -290,8 +290,11 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	const __be32 *regs;
 	struct device_node *parent;
 	struct pci_dn *pdn;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev;
+#endif
 
-	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
 		return NULL;
 	dn->data = pdn;
@@ -320,6 +323,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	/* Extended config space */
 	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
 
+	/* Initialize EEH device */
+#ifdef CONFIG_EEH
+	edev = eeh_dev_init(pdn, phb);
+	if (!edev) {
+		kfree(pdn);
+		return NULL;
+	}
+#endif
+
 	/* Attach to parent node */
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
@@ -465,15 +477,19 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
  * pci device found underneath.  This routine runs once,
  * early in the boot sequence.
  */
-void __init pci_devs_phb_init(void)
+static int __init pci_devs_phb_init(void)
 {
 	struct pci_controller *phb, *tmp;
 
 	/* This must be done first so the device nodes have valid pci info! */
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
+
+	return 0;
 }
 
+core_initcall(pci_devs_phb_init);
+
 static void pci_dev_pdn_setup(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn;
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a923230..a2f89e6 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -568,6 +568,26 @@ void maple_pci_irq_fixup(struct pci_dev *dev)
 	DBG(" <- maple_pci_irq_fixup\n");
 }
 
+static int maple_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
+	struct device_node *np, *child;
+
+	if (hose != u3_agp)
+		return 0;
+
+	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
+	 * assume there is no P2P bridge on the AGP bus, which should be a
+	 * safe assumptions hopefully.
+	 */
+	np = hose->dn;
+	PCI_DN(np)->busno = 0xf0;
+	for_each_child_of_node(np, child)
+		PCI_DN(child)->busno = 0xf0;
+
+	return 0;
+}
+
 void __init maple_pci_init(void)
 {
 	struct device_node *np, *root;
@@ -605,19 +625,7 @@ void __init maple_pci_init(void)
 	if (ht && maple_add_bridge(ht) != 0)
 		of_node_put(ht);
 
-	/* Setup the linkage between OF nodes and PHBs */ 
-	pci_devs_phb_init();
-
-	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
-	 * assume there is no P2P bridge on the AGP bus, which should be a
-	 * safe assumptions hopefully.
-	 */
-	if (u3_agp) {
-		struct device_node *np = u3_agp->dn;
-		PCI_DN(np)->busno = 0xf0;
-		for (np = np->child; np; np = np->sibling)
-			PCI_DN(np)->busno = 0xf0;
-	}
+	ppc_md.pcibios_root_bridge_prepare = maple_pci_root_bridge_prepare;
 
 	/* Tell pci.c to not change any resource allocations.  */
 	pci_add_flags(PCI_PROBE_ONLY);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index f3a68a0..10c4e8f 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -229,9 +229,6 @@ void __init pas_pci_init(void)
 			of_node_get(np);
 
 	of_node_put(root);
-
-	/* Setup the linkage between OF nodes and PHBs */
-	pci_devs_phb_init();
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 59ab16f..20d7bde 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -878,6 +878,29 @@ void pmac_pci_irq_fixup(struct pci_dev *dev)
 #endif /* CONFIG_PPC32 */
 }
 
+#ifdef CONFIG_PPC64
+static int pmac_pci_root_bridge_prepare(struct pci_hot_bridge *bridge)
+{
+	struct pci_controller *hose = pci_bus_to_host(bridge->bus);
+	struct device_node *np, *child;
+
+	if (hose != u3_agp)
+		return 0;
+
+	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
+	 * assume there is no P2P bridge on the AGP bus, which should be a
+	 * safe assumptions for now. We should do something better in the
+	 * future though
+	 */
+	np = hose->dn;
+	PCI_DN(np)->busno = 0xf0;
+	for_each_child_of_node(np, child)
+		PCI_DN(child)->busno = 0xf0;
+
+	return 0;
+}
+#endif /* CONFIG_PPC64 */
+
 void __init pmac_pci_init(void)
 {
 	struct device_node *np, *root;
@@ -914,22 +937,7 @@ void __init pmac_pci_init(void)
 	if (ht && pmac_add_bridge(ht) != 0)
 		of_node_put(ht);
 
-	/* Setup the linkage between OF nodes and PHBs */
-	pci_devs_phb_init();
-
-	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
-	 * assume there is no P2P bridge on the AGP bus, which should be a
-	 * safe assumptions for now. We should do something better in the
-	 * future though
-	 */
-	if (u3_agp) {
-		struct device_node *np = u3_agp->dn;
-		PCI_DN(np)->busno = 0xf0;
-		for (np = np->child; np; np = np->sibling)
-			PCI_DN(np)->busno = 0xf0;
-	}
-	/* pmac_check_ht_link(); */
-
+	ppc_md.pcibios_root_bridge_prepare = pmac_pci_root_bridge_prepare;
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
 	init_second_ohare();
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 5982110..b13186d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -935,9 +935,6 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
 		pnv_pci_init_ioda2_phb(np);
 
-	/* Setup the linkage between OF nodes and PHBs */
-	pci_devs_phb_init();
-
 	/* Configure IOMMU DMA hooks */
 	set_pci_dma_ops(&dma_iommu_ops);
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a704..92974aa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -261,12 +261,8 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		pci = np->parent->data;
-		if (pci) {
+		if (pci)
 			update_dn_pci_info(np, pci->phb);
-
-			/* Create EEH device for the OF node */
-			eeh_dev_init(PCI_DN(np), pci->phb);
-		}
 		break;
 	default:
 		err = NOTIFY_DONE;
@@ -482,7 +478,6 @@ static void __init find_and_init_phbs(void)
 	}
 
 	of_node_put(root);
-	pci_devs_phb_init();
 
 	/*
 	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
-- 
2.1.0
