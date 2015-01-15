Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 689101A0D52
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 12:28:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 415072CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F2SPe87143524
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F2SOUO019837
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:24 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V11 08/17] powrepc/pci: Refactor pci_dn
Date: Thu, 15 Jan 2015 10:27:58 +0800
Message-Id: <1421288887-7765-9-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

   * VF's pci_dn is expected to be created dynamically when PF
     enabling VFs. VF's pci_dn will be destroyed when PF disabling
     VFs. pci_dn of other device is still created from device node
     as before.

   * For one particular PCI device (VF or not), its pci_dn can be
     found from pdev->dev.archdata.firmware_data, PCI_DN(devnode),
     or parent's list. The fast path (fetching pci_dn through PCI
     device instance) is populated during early fixup time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/device.h         |    3 +
 arch/powerpc/include/asm/pci-bridge.h     |   14 +-
 arch/powerpc/kernel/pci_dn.c              |  242 ++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c |   16 ++
 4 files changed, 270 insertions(+), 5 deletions(-)

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
index 725247b..c1b7dd5 100644
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
@@ -167,14 +172,19 @@ struct pci_dn {
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
+extern struct pci_dn *add_dev_pci_info(struct pci_dev *pdev, u16 vf_num);
+extern void remove_dev_pci_info(struct pci_dev *pdev, u16 vf_num);
+extern void *update_dn_pci_info(struct device_node *dn, void *data);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 1f61fab..6536573 100644
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
+	struct device_node *dn = NULL;
+	struct pci_dn *parent, *pdn;
+	struct pci_dev *pdev = NULL;
+
+	/* Fast path: fetch from PCI device */
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (pdev->devfn == devfn) {
+			if (pdev->dev.archdata.firmware_data)
+				return pdev->dev.archdata.firmware_data;
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
+		return NULL;
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
+#ifdef CONFIG_PCI_IOV
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
+#endif // CONFIG_PCI_IOV
+
+struct pci_dn *add_dev_pci_info(struct pci_dev *pdev, u16 vf_num)
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
 		return NULL;
-	return PCI_DN(dn);
+
+	for (i = 0; i < vf_num; i++) {
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
+void remove_dev_pci_info(struct pci_dev *pdev, u16 vf_num)
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
+	for (i = 0; i < vf_num; i++) {
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
@@ -173,3 +396,16 @@ void __init pci_devs_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
 }
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
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fac88ed..5a8e6b1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -949,6 +949,22 @@ static void pnv_pci_ioda_setup_PEs(void)
 	}
 }
 
+#ifdef CONFIG_PCI_IOV
+int pcibios_sriov_disable(struct pci_dev *pdev, u16 vf_num)
+{
+	/* Release firmware data */
+	remove_dev_pci_info(pdev, vf_num);
+	return 0;
+}
+
+int pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
+{
+	/* Allocate firmware data */
+	add_dev_pci_info(pdev, vf_num);
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
-- 
1.7.9.5
