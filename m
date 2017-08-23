Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xck1H3GbkzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 20:19:15 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 5/5] powerpc/eeh: Remove unnecessary node from pci_dn
Date: Wed, 23 Aug 2017 20:19:01 +1000
Message-Id: <20170823101901.33961-6-aik@ozlabs.ru>
In-Reply-To: <20170823101901.33961-1-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pci_dn struct caches a OF device node pointer in order to access
the "ibm,loc-code" property when EEH is recovering.

However, when this happens in eeh_dev_check_failure(), we also have
a pci_dev pointer which should have a valid pointer to the device node
when pci_dn has one (both pointers are not NULL for physical functions
and are NULL for virtual functions).

This removes the node pointer from the pci_dn struct and used pdev
in eeh_dev_check_failure() instead.

This changes pci_remove_device_node_info() to look for a parent of
the node being removed, just like pci_add_device_node_info() does when it
references the parent node.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h | 1 -
 arch/powerpc/kernel/eeh.c             | 9 +++++----
 arch/powerpc/kernel/pci_dn.c          | 8 +++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 56c67d3f0108..0b8aa1fe2d5f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -195,7 +195,6 @@ struct pci_dn {
 	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table_group *table_group;	/* for phb's or bridges */
-	struct	device_node *node;	/* back-pointer to the device_node */
 
 	int	pci_ext_config_space;	/* for pci devices */
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c877014d11ce..2c926029adbe 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -435,7 +435,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	int ret;
 	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	unsigned long flags;
-	struct pci_dn *pdn;
+	struct device_node *dn;
 	struct pci_dev *dev;
 	struct eeh_pe *pe, *parent_pe, *phb_pe;
 	int rc = 0;
@@ -493,9 +493,10 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	if (pe->state & EEH_PE_ISOLATED) {
 		pe->check_count++;
 		if (pe->check_count % EEH_MAX_FAILS == 0) {
-			pdn = eeh_dev_to_pdn(edev);
-			if (pdn->node)
-				location = of_get_property(pdn->node, "ibm,loc-code", NULL);
+			dn = pci_device_to_OF_node(dev);
+			if (dn)
+				location = of_get_property(dn, "ibm,loc-code",
+						NULL);
 			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
 				pe->check_count,
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 0256372b72de..0e395afbf0f4 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -293,7 +293,6 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	if (pdn == NULL)
 		return NULL;
 	dn->data = pdn;
-	pdn->node = dn;
 	pdn->phb = hose;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
@@ -342,6 +341,7 @@ EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 void pci_remove_device_node_info(struct device_node *dn)
 {
 	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
+	struct device_node *parent;
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
@@ -354,8 +354,10 @@ void pci_remove_device_node_info(struct device_node *dn)
 
 	WARN_ON(!list_empty(&pdn->child_list));
 	list_del(&pdn->list);
-	if (pdn->parent)
-		of_node_put(pdn->parent->node);
+
+	parent = of_get_parent(dn);
+	if (parent)
+		of_node_put(parent);
 
 	dn->data = NULL;
 	kfree(pdn);
-- 
2.11.0
