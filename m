Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF9861A0BD1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:16:11 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96CC514011D
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 15:16:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 300042BB0052
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H5G09W46596328
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H5FYCP026004
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:15:34 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/7] powerpc/pci: Refactor pci_dn
Date: Tue, 17 Mar 2015 16:15:02 +1100
Message-Id: <1426569308-9470-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426569308-9470-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426569308-9470-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PCI config accessors are implemented based on device node.
Unfortunately, SRIOV VFs won't have the corresponding device nodes. pci_dn
will be used in replacement with device node for SRIOV VFs. So we have to
use pci_dn in PCI config accessors.

The patch refactors pci_dn in following aspects to make it ready to be used
in PCI config accessors as we do in subsequent patch:

   * pci_dn is organized as a hierarchy tree.  PCI device's pci_dn is
     put to the child list of pci_dn of its upstream bridge or PHB. VF's
     pci_dn will be put to the child list of pci_dn of PF's bridge.

   * For one particular PCI device (VF or not), its pci_dn can be
     found from pdev->dev.archdata.pci_data, PCI_DN(devnode), or
     parent's list.  The fast path (fetching pci_dn through PCI device
     instance) is populated during early fixup time.

[bhelgaas: changelog]
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Put SRIOV related logic into separate patch. "struct pci_controller"
    and "struct dev_archdata" dereferences "struct pci_dn *pci_data",
    not "void *firmware_data".
---
 arch/powerpc/include/asm/device.h     |   6 ++
 arch/powerpc/include/asm/pci-bridge.h |  11 ++-
 arch/powerpc/kernel/pci_dn.c          | 130 ++++++++++++++++++++++++++++++++--
 3 files changed, 141 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 38faede..9f1371b 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -8,6 +8,9 @@
 
 struct dma_map_ops;
 struct device_node;
+#ifdef CONFIG_PPC64
+struct pci_dn;
+#endif
 
 /*
  * Arch extensions to struct device.
@@ -34,6 +37,9 @@ struct dev_archdata {
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
+#ifdef CONFIG_PPC64
+	struct pci_dn		*pci_data;
+#endif
 #ifdef CONFIG_EEH
 	struct eeh_dev		*edev;
 #endif
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 546d036..706710b 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -89,6 +89,7 @@ struct pci_controller {
 
 #ifdef CONFIG_PPC64
 	unsigned long buid;
+	struct pci_dn *pci_data;
 #endif	/* CONFIG_PPC64 */
 
 	void *private_data;
@@ -154,9 +155,12 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 struct iommu_table;
 
 struct pci_dn {
+	int     flags;
+
 	int	busno;			/* pci bus number */
 	int	devfn;			/* pci device and function number */
 
+	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 	struct	device_node *node;	/* back-pointer to the device_node */
@@ -171,14 +175,17 @@ struct pci_dn {
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
+extern void *update_dn_pci_info(struct device_node *dn, void *data);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 83df307..0ab2dad 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -32,12 +32,108 @@
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
+	struct device_node *dn = NULL;
+	struct pci_dn *parent, *pdn;
+	struct pci_dev *pdev = NULL;
+
+	/* Fast path: fetch from PCI device */
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (pdev->devfn == devfn) {
+			if (pdev->dev.archdata.pci_data)
+				return pdev->dev.archdata.pci_data;
+
+			dn = pci_device_to_OF_node(pdev);
+			break;
+		}
+	}
+
+	/* Fast path: fetch from device node */
+	pdn = dn ? PCI_DN(dn) : NULL;
+	if (pdn)
+		return pdn;
+
+	/* Slow path: fetch from firmware data hierarchy */
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
+	if (pdev->dev.archdata.pci_data)
+		return pdev->dev.archdata.pci_data;
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
 }
 
 /*
@@ -49,6 +145,7 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	struct pci_controller *phb = data;
 	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
 	const __be32 *regs;
+	struct device_node *parent;
 	struct pci_dn *pdn;
 
 	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
@@ -70,6 +167,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
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
 
@@ -147,8 +253,11 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	/* PHB nodes themselves must not match */
 	update_dn_pci_info(dn, phb);
 	pdn = dn->data;
-	if (pdn)
+	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
+		pdn->phb = phb;
+		phb->pci_data = pdn;
+	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
 	traverse_pci_devices(dn, update_dn_pci_info, phb);
@@ -171,3 +280,16 @@ void __init pci_devs_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
 }
+
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
-- 
1.8.3.2
