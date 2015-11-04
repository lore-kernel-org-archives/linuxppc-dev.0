Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF7161A3A92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:43:14 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 19:13:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A4EAD1258019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 19:13:09 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DZEPI51839092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 19:13:09 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDK0G022590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:21 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 31/50] powerpc/pci: Export pci_add_device_node_info()
Date: Thu,  5 Nov 2015 00:12:31 +1100
Message-Id: <1446642770-4681-32-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
---
 arch/powerpc/include/asm/pci-bridge.h  |  3 ++-
 arch/powerpc/kernel/pci_dn.c           | 30 +++++++++++++++++++-----------
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 28385cb..7e0c67d 100644
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
index b3b4df9..36ae515 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -265,13 +265,9 @@ void remove_dev_pci_data(struct pci_dev *pdev)
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
@@ -282,7 +278,7 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 		return NULL;
 	dn->data = pdn;
 	pdn->node = dn;
-	pdn->phb = phb;
+	pdn->phb = hose;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
@@ -314,8 +310,9 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	if (pdn->parent)
 		list_add_tail(&pdn->list, &pdn->parent->child_list);
 
-	return NULL;
+	return pdn;
 }
+EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 
 /*
  * Traverse a device tree stopping each PCI device in the tree.
@@ -415,6 +412,18 @@ void *traverse_pci_dn(struct pci_dn *root,
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
@@ -429,8 +438,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
-	update_dn_pci_info(dn, phb);
-	pdn = dn->data;
+	pdn = pci_add_device_node_info(phb, dn);
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
 		pdn->vendor_id = pdn->device_id = pdn->class_code = 0;
@@ -439,7 +447,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
-	traverse_pci_devices(dn, update_dn_pci_info, phb);
+	traverse_pci_devices(dn, add_pdn, phb);
 }
 
 /** 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9e524c2..6c274cb 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -264,7 +264,7 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 		pdn = parent ? PCI_DN(parent) : NULL;
 		if (pdn) {
 			/* Create pdn and EEH device */
-			update_dn_pci_info(np, pdn->phb);
+			pci_add_device_node_info(pdn->phb, np);
 			eeh_dev_init(PCI_DN(np), pdn->phb);
 		}
 
-- 
2.1.0
