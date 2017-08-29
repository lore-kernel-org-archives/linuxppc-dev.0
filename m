Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xhL4k34b3zDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:34:46 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 5/6] powerpc/eeh: Reduce use of pci_dn::node
Date: Tue, 29 Aug 2017 17:34:03 +1000
Message-Id: <20170829073404.8885-6-aik@ozlabs.ru>
In-Reply-To: <20170829073404.8885-1-aik@ozlabs.ru>
References: <20170829073404.8885-1-aik@ozlabs.ru>
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

This changes pci_remove_device_node_info() to look for a parent of
the node being removed, just like pci_add_device_node_info() does when it
references the parent node.

This is the first step to get rid of pci_dn::node.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changelog:
v2:
* fixed pseries platform
* this does not remove pci_dn::node yet, just prepares
---
 arch/powerpc/kernel/eeh.c    | 9 +++++----
 arch/powerpc/kernel/pci_dn.c | 7 +++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 66c98c158ee3..9e816787c0d4 100644
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
index 0256372b72de..dfb107631116 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -342,6 +342,7 @@ EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 void pci_remove_device_node_info(struct device_node *dn)
 {
 	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
+	struct device_node *parent;
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
@@ -354,8 +355,10 @@ void pci_remove_device_node_info(struct device_node *dn)
 
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
