Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 842561A0347
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7991D2BB0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jiv43997852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jI0d018117
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 28/45] powerpc/pci: Introduce pci_remove_device_node_info()
Date: Wed, 17 Feb 2016 14:44:11 +1100
Message-Id: <1455680668-23298-29-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implements and exports pci_remove_device_node_info(). It's
used to remove the pdn (struct pci_dn) for the indicated device
node. The function is going to be used by PowerNV PCI hotplug
driver.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  1 +
 arch/powerpc/kernel/pci_dn.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 72a9d4e..c6310e2 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -240,6 +240,7 @@ extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
 extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 					       struct device_node *dn);
+extern void pci_remove_device_node_info(struct device_node *dn);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 0a249ff..ce10281 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -331,6 +331,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 }
 EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 
+void pci_remove_device_node_info(struct device_node *dn)
+{
+	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	if (edev)
+		edev->pdn = NULL;
+#endif
+
+	if (!pdn)
+		return;
+
+	WARN_ON(!list_empty(&pdn->child_list));
+	list_del(&pdn->list);
+	if (pdn->parent)
+		of_node_put(pdn->parent->node);
+
+	dn->data = NULL;
+	kfree(pdn);
+}
+EXPORT_SYMBOL_GPL(pci_remove_device_node_info);
+
 /*
  * Traverse a device tree stopping each PCI device in the tree.
  * This is done depth first.  As each node is processed, a "pre"
-- 
2.1.0
