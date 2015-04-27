Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7EE81A0D15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE1B82BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6dWuM37879984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6d6hh013556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 18/21] powerpc/pci: Export traverse_pci_device_nodes()
Date: Mon, 27 Apr 2015 16:37:50 +1000
Message-Id: <1430116673-22500-19-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch exports following functions, which are derived from their
original implementation, so that the PCI hotplug logic can reuse
the functions to add or remove pci_dn for all device nodes under
specified PCI slot.

   traverse_pci_device_nodes()     traverse_pci_devices()
   add_pci_device_node_info()      update_dn_pci_info()
   remove_pci_device_node_info()   newly added

The patch also releases eeh_dev when its corresponding pci_dn
is released, indicating they have same life cycle.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h  |  3 +-
 arch/powerpc/include/asm/ppc-pci.h     |  6 +--
 arch/powerpc/kernel/pci_dn.c           | 67 +++++++++++++++++++++++++++++-----
 arch/powerpc/platforms/pseries/msi.c   |  4 +-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 5 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index a6ad4b1..e0cb114 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -222,7 +222,8 @@ extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
 extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
-extern void *update_dn_pci_info(struct device_node *dn, void *data);
+extern void *add_pci_device_node_info(struct device_node *dn, void *data);
+extern void remove_pci_device_node_info(struct device_node *dn);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 7388316..3f0874e 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -33,9 +33,9 @@ extern struct pci_dev *isa_bridge_pcidev;	/* may be NULL if no ISA bus */
 struct device_node;
 struct pci_dn;
 
-typedef void *(*traverse_func)(struct device_node *me, void *data);
-void *traverse_pci_devices(struct device_node *start, traverse_func pre,
-		void *data);
+void *traverse_pci_device_nodes(struct device_node *start,
+				void *(*fn)(struct device_node *, void *),
+				void *data);
 void *traverse_pci_dn(struct pci_dn *root,
 		      void *(*fn)(struct pci_dn *, void *),
 		      void *data);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index abc81fa..6bd9d8c 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -265,11 +265,15 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_IOV */
 }
 
-/*
- * Traverse_func that inits the PCI fields of the device node.
- * NOTE: this *must* be done before read/write config to the device.
+/**
+ * add_pci_device_node_info - Add pci_dn for PCI device node
+ * @dn: PCI device node
+ * @data: additonal argument
+ *
+ * Add pci_dn for the indicated PCI device node. The newly created
+ * pci_dn will be put into that one of the parent device node.
  */
-void *update_dn_pci_info(struct device_node *dn, void *data)
+void *add_pci_device_node_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
 	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
@@ -328,8 +332,48 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 
 	return NULL;
 }
+EXPORT_SYMBOL(add_pci_device_node_info);
 
-/*
+/**
+ * remove_pci_device_node_info - Remove pci_dn from PCI device node
+ * @dn: PCI device node
+ *
+ * Remove pci_dn from PCI device node. The pci_dn is also removed
+ * from the child list of the parent pci_dn.
+ */
+void remove_pci_device_node_info(struct device_node *np)
+{
+	struct pci_dn *pdn = np ? PCI_DN(np) : NULL;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+#endif
+
+	if (!pdn)
+		return;
+
+#ifdef CONFIG_EEH
+	if (edev) {
+		pdn->edev = NULL;
+		kfree(edev);
+	}
+#endif
+
+	BUG_ON(!list_empty(&pdn->child_list));
+	list_del(&pdn->list);
+	if (pdn->parent)
+		of_node_put(pdn->parent->node);
+
+	np->data = NULL;
+	kfree(pdn);
+}
+EXPORT_SYMBOL(remove_pci_device_node_info);
+
+/**
+ * traverse_pci_device_nodes - Traverse children of indicated device node
+ * @start: indicated device node
+ * @pre: callback
+ * @data: additional parameter to the callback
+ *
  * Traverse a device tree stopping each PCI device in the tree.
  * This is done depth first.  As each node is processed, a "pre"
  * function is called and the children are processed recursively.
@@ -347,8 +391,9 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
  * one of these nodes we also assume its siblings are non-pci for
  * performance.
  */
-void *traverse_pci_devices(struct device_node *start, traverse_func pre,
-		void *data)
+void *traverse_pci_device_nodes(struct device_node *start,
+				void *(*fn)(struct device_node *, void *data),
+				void *data)
 {
 	struct device_node *dn, *nextdn;
 	void *ret;
@@ -363,7 +408,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		if (classp)
 			class = of_read_number(classp, 1);
 
-		if (pre && ((ret = pre(dn, data)) != NULL))
+		if (fn && ((ret = fn(dn, data)) != NULL))
 			return ret;
 
 		/* If we are a PCI bridge, go down */
@@ -384,8 +429,10 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 			nextdn = dn->sibling;
 		}
 	}
+
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(traverse_pci_device_nodes);
 
 static struct pci_dn *pci_dn_next_one(struct pci_dn *root,
 				      struct pci_dn *pdn)
@@ -441,7 +488,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
-	update_dn_pci_info(dn, phb);
+	add_pci_device_node_info(dn, phb);
 	pdn = dn->data;
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
@@ -451,7 +498,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
-	traverse_pci_devices(dn, update_dn_pci_info, phb);
+	traverse_pci_device_nodes(dn, add_pci_device_node_info, phb);
 }
 
 static void pci_dev_pdn_setup(struct pci_dev *pdev)
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index c8d24f9..9ebbd19 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -303,7 +303,7 @@ static int msi_quota_for_device(struct pci_dev *dev, int request)
 	memset(&counts, 0, sizeof(struct msi_counts));
 
 	/* Work out how many devices we have below this PE */
-	traverse_pci_devices(pe_dn, count_non_bridge_devices, &counts);
+	traverse_pci_device_nodes(pe_dn, count_non_bridge_devices, &counts);
 
 	if (counts.num_devices == 0) {
 		pr_err("rtas_msi: found 0 devices under PE for %s\n",
@@ -318,7 +318,7 @@ static int msi_quota_for_device(struct pci_dev *dev, int request)
 	/* else, we have some more calculating to do */
 	counts.requestor = pci_device_to_OF_node(dev);
 	counts.request = request;
-	traverse_pci_devices(pe_dn, count_spare_msis, &counts);
+	traverse_pci_device_nodes(pe_dn, count_spare_msis, &counts);
 
 	/* If the quota isn't an integer multiple of the total, we can
 	 * use the remainder as spare MSIs for anyone that wants them. */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 92974aa..ed8c894 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -262,7 +262,7 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	case OF_RECONFIG_ATTACH_NODE:
 		pci = np->parent->data;
 		if (pci)
-			update_dn_pci_info(np, pci->phb);
+			add_pci_device_node_info(np, pci->phb);
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.1.0
