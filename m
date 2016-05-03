Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSy1nw1zDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:14 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C0C872BB0069
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h17b8323174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435ga7R019466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 21/26] powerpc/pci: Export pci_add_device_node_info()
Date: Tue,  3 May 2016 15:41:40 +1000
Message-Id: <1462254105-24128-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This renames update_dn_pci_info() to pci_add_device_node_info()
with corresponding adjustment on the parameter type and exports it.
The function is used to create pdn (struct pci_dn) for the indicated
device node. Another function add_pdn(), almost wrapper of
pci_add_device_node_info(), to be used in traverse_pci_devices(). No
logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h  |  3 ++-
 arch/powerpc/kernel/pci_dn.c           | 30 +++++++++++++++++++-----------
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index f0a5b16..07b94ec 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -235,7 +235,8 @@ extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
 extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
-extern void *update_dn_pci_info(struct device_node *dn, void *data);
+extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
+					       struct device_node *dn);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 38102cb..0a249ff 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -282,13 +282,9 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_IOV */
 }
 
-/*
- * Traverse_func that inits the PCI fields of the device node.
- * NOTE: this *must* be done before read/write config to the device.
- */
-void *update_dn_pci_info(struct device_node *dn, void *data)
+struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
+					struct device_node *dn)
 {
-	struct pci_controller *phb = data;
 	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
 	const __be32 *regs;
 	struct device_node *parent;
@@ -299,7 +295,7 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 		return NULL;
 	dn->data = pdn;
 	pdn->node = dn;
-	pdn->phb = phb;
+	pdn->phb = hose;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
@@ -331,8 +327,9 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	if (pdn->parent)
 		list_add_tail(&pdn->list, &pdn->parent->child_list);
 
-	return NULL;
+	return pdn;
 }
+EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 
 /*
  * Traverse a device tree stopping each PCI device in the tree.
@@ -432,6 +429,18 @@ void *traverse_pci_dn(struct pci_dn *root,
 	return NULL;
 }
 
+static void *add_pdn(struct device_node *dn, void *data)
+{
+	struct pci_controller *hose = data;
+	struct pci_dn *pdn;
+
+	pdn = pci_add_device_node_info(hose, dn);
+	if (!pdn)
+		return ERR_PTR(-ENOMEM);
+
+	return NULL;
+}
+
 /** 
  * pci_devs_phb_init_dynamic - setup pci devices under this PHB
  * phb: pci-to-host bridge (top-level bridge connecting to cpu)
@@ -446,8 +455,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
-	update_dn_pci_info(dn, phb);
-	pdn = dn->data;
+	pdn = pci_add_device_node_info(phb, dn);
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
 		pdn->vendor_id = pdn->device_id = pdn->class_code = 0;
@@ -456,7 +464,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
-	traverse_pci_devices(dn, update_dn_pci_info, phb);
+	traverse_pci_devices(dn, add_pdn, phb);
 }
 
 /** 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 6e944fc..cd739da 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -265,7 +265,7 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 		pdn = parent ? PCI_DN(parent) : NULL;
 		if (pdn) {
 			/* Create pdn and EEH device */
-			update_dn_pci_info(np, pdn->phb);
+			pci_add_device_node_info(pdn->phb, np);
 			eeh_dev_init(PCI_DN(np), pdn->phb);
 		}
 
-- 
2.1.0
