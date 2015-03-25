Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6871A2E76
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:29:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 18:29:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 280A12CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:29:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P8T41Q36307000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:29:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P8Scf8025263
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:28:39 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V16 11/20] powerpc/pci: Create pci_dn for VFs
Date: Wed, 25 Mar 2015 16:23:52 +0800
Message-Id: <1427271841-28749-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

pci_dn is the extension of PCI device node and is created from device node.
Unfortunately, VFs are enabled dynamically by PF's driver and they don't
have corresponding device nodes and pci_dn, which is required to access
VFs' config spaces.

The patch creates pci_dn for VFs in pcibios_sriov_enable() on their PF,
and removes pci_dn for VFs in pcibios_sriov_disable() on their PF. When
VF's pci_dn is created, it's put to the child list of the pci_dn of PF's
upstream bridge. The pci_dn is linked to pci_dev during early fixup time
to setup the fast path.

[bhelgaas: add ifdef around add_one_dev_pci_info(), use dev_printk()]
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    3 +
 arch/powerpc/kernel/pci_dn.c              |  116 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   16 ++++
 3 files changed, 135 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 2c6dc2a..ece30f5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -156,6 +156,7 @@ struct iommu_table;
 
 struct pci_dn {
 	int     flags;
+#define PCI_DN_FLAG_IOV_VF	0x01
 
 	int	busno;			/* pci bus number */
 	int	devfn;			/* pci device and function number */
@@ -188,6 +189,8 @@ struct pci_dn {
 extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 					   int devfn);
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
+extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
+extern void remove_dev_pci_data(struct pci_dev *pdev);
 extern void *update_dn_pci_info(struct device_node *dn, void *data);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 65b9836..e5f1d78 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -136,6 +136,122 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 	return NULL;
 }
 
+#ifdef CONFIG_PCI_IOV
+static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
+					   struct pci_dev *pdev,
+					   int busno, int devfn)
+{
+	struct pci_dn *pdn;
+
+	/* Except PHB, we always have the parent */
+	if (!parent)
+		return NULL;
+
+	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
+	if (!pdn) {
+		dev_warn(&pdev->dev, "%s: Out of memory!\n", __func__);
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
+		pdev->dev.archdata.pci_data = pdn;
+
+	return pdn;
+}
+#endif
+
+struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
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
+	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+		pdn = add_one_dev_pci_data(parent, NULL,
+					   pci_iov_virtfn_bus(pdev, i),
+					   pci_iov_virtfn_devfn(pdev, i));
+		if (!pdn) {
+			dev_warn(&pdev->dev, "%s: Cannot create firmware data for VF#%d\n",
+				 __func__, i);
+			return NULL;
+		}
+	}
+#endif /* CONFIG_PCI_IOV */
+
+	return pci_get_pdn(pdev);
+}
+
+void remove_dev_pci_data(struct pci_dev *pdev)
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
+	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+		list_for_each_entry_safe(pdn, tmp,
+			&parent->child_list, list) {
+			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
+			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
+				continue;
+
+			if (!list_empty(&pdn->list))
+				list_del(&pdn->list);
+
+			kfree(pdn);
+		}
+	}
+#endif /* CONFIG_PCI_IOV */
+}
+
 /*
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 26fe099..7f58f19 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -974,6 +974,22 @@ static void pnv_pci_ioda_setup_PEs(void)
 	}
 }
 
+#ifdef CONFIG_PCI_IOV
+int pcibios_sriov_disable(struct pci_dev *pdev)
+{
+	/* Release PCI data */
+	remove_dev_pci_data(pdev);
+	return 0;
+}
+
+int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
+{
+	/* Allocate PCI data */
+	add_dev_pci_data(pdev);
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
-- 
1.7.9.5
