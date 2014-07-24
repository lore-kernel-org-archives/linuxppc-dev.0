Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB2491A0971
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:51 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:52:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id BBA6F3940043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:45 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6N5O35636438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:53:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MiWc021918
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:44 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 07/17] powrepc/pci: Refactor pci_dn
Date: Thu, 24 Jul 2014 14:22:17 +0800
Message-Id: <1406182947-11302-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

pci_dn is the extension of PCI device node and it's created from
device node. Unfortunately, VFs that are enabled dynamically by
PF's driver and they don't have corresponding device nodes, and
pci_dn. The patch refactors pci_dn to support VFs:

   * pci_dn is organized as a hierarchy tree. VF's pci_dn is put
     to the child list of pci_dn of PF's bridge. pci_dn of other
     device put to the child list of pci_dn of its upstream bridge.

   * VF's pci_dn is expected to be created dynamically when applying
     final fixup to PF. VF's pci_dn will be destroyed when releasing
     PF's pci_dev instance. pci_dn of other device is still created
     from device node as before.

   * For one particular PCI device (VF or not), its pci_dn can be
     found from pdev->dev.archdata.firmware_data, PCI_DN(devnode),
     or parent's list. The fast path (fetching pci_dn through PCI
     device instance) is populated during early fixup time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/device.h     |    3 +
 arch/powerpc/include/asm/pci-bridge.h |   14 +-
 arch/powerpc/kernel/pci-hotplug.c     |    3 +
 arch/powerpc/kernel/pci_dn.c          |  248 ++++++++++++++++++++++++++++++++-
 4 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 38faede..29992cd 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -34,6 +34,9 @@ struct dev_archdata {
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
+#ifdef CONFIG_PPC64
+	void			*firmware_data;
+#endif
 #ifdef CONFIG_EEH
 	struct eeh_dev		*edev;
 #endif
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4ca90a3..757d7bb 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -89,6 +89,7 @@ struct pci_controller {
 
 #ifdef CONFIG_PPC64
 	unsigned long buid;
+	void *firmware_data;
 #endif	/* CONFIG_PPC64 */
 
 	void *private_data;
@@ -150,9 +151,13 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 struct iommu_table;
 
 struct pci_dn {
+	int     flags;
+#define PCI_DN_FLAG_IOV_VF     0x01
+
 	int	busno;			/* pci bus number */
 	int	devfn;			/* pci device and function number */
 
+	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 	struct	device_node *node;	/* back-pointer to the device_node */
@@ -169,14 +174,19 @@ struct pci_dn {
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
 #endif
+	struct list_head child_list;
+	struct list_head list;
 };
 
 /* Get the pointer to a device_node's pci_dn */
 #define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
 
+extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
+					   int devfn);
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
-
-extern void * update_dn_pci_info(struct device_node *dn, void *data);
+extern struct pci_dn *add_dev_pci_info(struct pci_dev *pdev);
+extern void remove_dev_pci_info(struct pci_dev *pdev);
+extern void *update_dn_pci_info(struct device_node *dn, void *data);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 5b78917..af60efe 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -30,6 +30,9 @@
 void pcibios_release_device(struct pci_dev *dev)
 {
 	eeh_remove_device(dev);
+
+	/* Release firmware data */
+	remove_dev_pci_info(dev);
 }
 
 /**
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 1f61fab..9723108 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -32,12 +32,224 @@
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
 
+/*
+ * The function is used to find the firmware data of one
+ * specific PCI device, which is attached to the indicated
+ * PCI bus. For VFs, their firmware data is linked to that
+ * one of PF's bridge. For other devices, their firmware
+ * data is linked to that of their bridge.
+ */
+static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
+{
+	struct pci_bus *pbus;
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	/*
+	 * We probably have virtual bus which doesn't
+	 * have associated bridge.
+	 */
+	pbus = bus;
+	while (pbus) {
+		if (pci_is_root_bus(pbus) || pbus->self)
+			break;
+
+		pbus = pbus->parent;
+	}
+
+	/*
+	 * Except virtual bus, all PCI buses should
+	 * have device nodes.
+	 */
+	dn = pci_bus_to_OF_node(pbus);
+	pdn = dn ? PCI_DN(dn) : NULL;
+
+	return pdn;
+}
+
+struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
+				    int devfn)
+{
+	struct device_node *dn;
+	struct pci_dn *parent, *pdn;
+	struct pci_dev *pdev = NULL;
+
+	/* We can't call pci_get_slot() from interrupt context */
+	if (in_interrupt())
+		goto slow_path;
+
+	/* Fast path: fetch from PCI device */
+	pdev = pci_get_slot(bus, devfn);
+	pdn = pdev ? pdev->dev.archdata.firmware_data : NULL;
+	pci_dev_put(pdev);
+	if (pdn)
+		return pdn;
+
+	/* Fast path: fetch from device node */
+	dn = pdev ? pci_device_to_OF_node(pdev) : NULL;
+	pdn = dn ? PCI_DN(dn) : NULL;
+	if (pdn)
+		return pdn;
+
+	/* Slow path: fetch from firmware data hierarchy */
+slow_path:
+	parent = pci_bus_to_pdn(bus);
+	if (!parent)
+		return NULL;
+
+	list_for_each_entry(pdn, &parent->child_list, list) {
+		if (pdn->busno == bus->number &&
+                    pdn->devfn == devfn)
+                        return pdn;
+        }
+
+	return NULL;
+}
+
 struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 {
-	struct device_node *dn = pci_device_to_OF_node(pdev);
-	if (!dn)
+	struct device_node *dn;
+	struct pci_dn *parent, *pdn;
+
+	/* Search device directly */
+	if (pdev->dev.archdata.firmware_data)
+		return pdev->dev.archdata.firmware_data;
+
+	/* Check device node */
+	dn = pci_device_to_OF_node(pdev);
+	pdn = dn ? PCI_DN(dn) : NULL;
+	if (pdn)
+		return pdn;
+
+	/*
+	 * VFs don't have device nodes. We hook their
+	 * firmware data to PF's bridge.
+	 */
+	parent = pci_bus_to_pdn(pdev->bus);
+	if (!parent)
 		return NULL;
-	return PCI_DN(dn);
+
+	list_for_each_entry(pdn, &parent->child_list, list) {
+		if (pdn->busno == pdev->bus->number &&
+		    pdn->devfn == pdev->devfn)
+			return pdn;
+	}
+
+	return NULL;
+}
+
+static struct pci_dn *add_one_dev_pci_info(struct pci_dn *parent,
+					   struct pci_dev *pdev,
+					   int busno, int devfn)
+{
+	struct pci_dn *pdn;
+
+	/* Except PHB, we always have parent firmware data */
+	if (!parent)
+		return NULL;
+
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
+	if (!pdn) {
+		pr_warn("%s: Out of memory !\n", __func__);
+		return NULL;
+	}
+
+	pdn->phb = parent->phb;
+	pdn->parent = parent;
+	pdn->busno = busno;
+	pdn->devfn = devfn;
+#ifdef CONFIG_PPC_POWERNV
+	pdn->pe_number = IODA_INVALID_PE;
+#endif
+	INIT_LIST_HEAD(&pdn->child_list);
+	INIT_LIST_HEAD(&pdn->list);
+	list_add_tail(&pdn->list, &parent->child_list);
+
+	/*
+	 * If we already have PCI device instance, lets
+	 * bind them.
+	 */
+	if (pdev)
+		pdev->dev.archdata.firmware_data = pdn;
+
+	return pdn;
+}
+
+struct pci_dn *add_dev_pci_info(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_IOV
+	struct pci_dn *parent, *pdn;
+	int i;
+
+	/* Only support IOV for now */
+	if (!pdev->is_physfn)
+		return pci_get_pdn(pdev);
+
+	/* Check if VFs have been populated */
+	pdn = pci_get_pdn(pdev);
+	if (!pdn || (pdn->flags & PCI_DN_FLAG_IOV_VF))
+		return NULL;
+
+	pdn->flags |= PCI_DN_FLAG_IOV_VF;
+	parent = pci_bus_to_pdn(pdev->bus);
+	if (!parent)
+		return NULL;
+
+	for (i = 0; i < pdev->sriov->total_VFs; i++) {
+		pdn = add_one_dev_pci_info(parent, NULL,
+					   pci_iov_virtfn_bus(pdev, i),
+					   pci_iov_virtfn_devfn(pdev, i));
+		if (!pdn) {
+			pr_warn("%s: Cannot create firmware data "
+				"for VF#%d of %s\n",
+				__func__, i, pci_name(pdev));
+			return NULL;
+		}
+	}
+#endif
+
+	return pci_get_pdn(pdev);
+}
+
+void remove_dev_pci_info(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_IOV
+	struct pci_dn *parent;
+	struct pci_dn *pdn, *tmp;
+	int i;
+
+	/* Only support IOV PF for now */
+	if (!pdev->is_physfn)
+		return;
+
+	/* Check if VFs have been populated */
+	pdn = pci_get_pdn(pdev);
+	if (!pdn || !(pdn->flags & PCI_DN_FLAG_IOV_VF))
+		return;
+
+	pdn->flags &= ~PCI_DN_FLAG_IOV_VF;
+	parent = pci_bus_to_pdn(pdev->bus);
+	if (!parent)
+		return;
+
+	/*
+	 * We might introduce flag to pci_dn in future
+	 * so that we can release VF's firmware data in
+	 * a batch mode.
+	 */
+	for (i = 0; i < pdev->sriov->total_VFs; i++) {
+		list_for_each_entry_safe(pdn, tmp,
+			&parent->child_list, list) {
+			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
+			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
+				continue;
+
+			if (!list_empty(&pdn->list))
+				list_del(&pdn->list);
+			kfree(pdn);
+		}
+	}
+#endif
 }
 
 /*
@@ -49,6 +261,7 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	struct pci_controller *phb = data;
 	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
 	const __be32 *regs;
+	struct device_node *parent;
 	struct pci_dn *pdn;
 
 	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
@@ -70,6 +283,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	}
 
 	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
+
+	/* Attach to parent node */
+	INIT_LIST_HEAD(&pdn->child_list);
+	INIT_LIST_HEAD(&pdn->list);
+	parent = of_get_parent(dn);
+	pdn->parent = parent ? PCI_DN(parent) : NULL;
+	if (pdn->parent)
+		list_add_tail(&pdn->list, &pdn->parent->child_list);
+
 	return NULL;
 }
 
@@ -150,6 +372,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
 		pdn->phb = phb;
+		phb->firmware_data = pdn;
 	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
@@ -173,3 +396,22 @@ void __init pci_devs_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
 }
+
+static void pci_dev_pdn_create(struct pci_dev *pdev)
+{
+	add_dev_pci_info(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_create);
+
+static void pci_dev_pdn_setup(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn;
+
+	if (pdev->dev.archdata.firmware_data)
+		return;
+
+	/* Setup the fast path */
+	pdn = pci_get_pdn(pdev);
+	pdev->dev.archdata.firmware_data = pdn;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
-- 
1.7.9.5
