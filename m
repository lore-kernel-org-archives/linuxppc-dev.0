Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD6CC1A0BEE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:18 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A28FD2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6d8dE45285480
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6chaF016106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:38:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 16/21] powerpc/pci: Delay creating pci_dn
Date: Mon, 27 Apr 2015 16:37:48 +1000
Message-Id: <1430116673-22500-17-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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

The patch delay creating pci_dn so that they can be allocated from
slab. In turn, the memory chunks for them can be reused after being
released without problem. The creation of eeh_dev instances, which
depends on pci_dn, is delayed a bit as well.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h     |  1 -
 arch/powerpc/kernel/eeh_dev.c          |  2 +-
 arch/powerpc/kernel/pci_dn.c           | 40 +++++++++++++++++++---------------
 arch/powerpc/platforms/maple/pci.c     | 35 +++++++++++++++++------------
 arch/powerpc/platforms/pasemi/pci.c    |  3 ---
 arch/powerpc/platforms/powermac/pci.c  | 39 ++++++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.c   |  3 ---
 arch/powerpc/platforms/pseries/setup.c |  1 -
 8 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 4122a86..7388316 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -40,7 +40,6 @@ void *traverse_pci_dn(struct pci_dn *root,
 		      void *(*fn)(struct pci_dn *, void *),
 		      void *data);
 
-extern void pci_devs_phb_init(void);
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
 
 /* From rtas_pci.h */
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index aabba94..f33ce5b 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -110,4 +110,4 @@ static int __init eeh_dev_phb_init(void)
 	return 0;
 }
 
-core_initcall(eeh_dev_phb_init);
+core_initcall_sync(eeh_dev_phb_init);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..d3833af 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -277,7 +277,7 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	struct device_node *parent;
 	struct pci_dn *pdn;
 
-	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
 		return NULL;
 	dn->data = pdn;
@@ -442,33 +442,37 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	traverse_pci_devices(dn, update_dn_pci_info, phb);
 }
 
-/** 
+static void pci_dev_pdn_setup(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn;
+
+	if (pdev->dev.archdata.pci_data)
+		return;
+
+	/* Setup the fast path */
+	pdn = pci_get_pdn(pdev);
+	pdev->dev.archdata.pci_data = pdn;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
+
+/*
  * pci_devs_phb_init - Initialize phbs and pci devs under them.
- * 
- * This routine walks over all phb's (pci-host bridges) on the
- * system, and sets up assorted pci-related structures 
+ *
+ * This routine walks over all phb's (pci-host bridges) on
+ * the system, and sets up assorted pci-related structures
  * (including pci info in the device node structs) for each
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
-}
-
-static void pci_dev_pdn_setup(struct pci_dev *pdev)
-{
-	struct pci_dn *pdn;
 
-	if (pdev->dev.archdata.pci_data)
-		return;
-
-	/* Setup the fast path */
-	pdn = pci_get_pdn(pdev);
-	pdev->dev.archdata.pci_data = pdn;
+	return 0;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
+
+core_initcall(pci_devs_phb_init);
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a923230..04a69a8 100644
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
@@ -605,20 +625,7 @@ void __init maple_pci_init(void)
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
-
+	ppc_md.pcibios_root_bridge_prepare = maple_pci_root_bridge_prepare;
 	/* Tell pci.c to not change any resource allocations.  */
 	pci_add_flags(PCI_PROBE_ONLY);
 }
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
index 59ab16f..368716f 100644
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
@@ -914,22 +937,8 @@ void __init pmac_pci_init(void)
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
 	/* pmac_check_ht_link(); */
-
+	ppc_md.pcibios_root_bridge_prepare = pmac_pci_root_bridge_prepare;
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
 	init_second_ohare();
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 60e6d65..21a4eb3 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -819,9 +819,6 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
 		pnv_pci_init_ioda2_phb(np);
 
-	/* Setup the linkage between OF nodes and PHBs */
-	pci_devs_phb_init();
-
 	/* Configure IOMMU DMA hooks */
 	ppc_md.tce_build = pnv_tce_build_vm;
 	ppc_md.tce_free = pnv_tce_free_vm;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a704..5f80758 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -482,7 +482,6 @@ static void __init find_and_init_phbs(void)
 	}
 
 	of_node_put(root);
-	pci_devs_phb_init();
 
 	/*
 	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
-- 
2.1.0
