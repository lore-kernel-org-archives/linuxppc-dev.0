Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 934DF1A0CAD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 87B612BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:40 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6dWgh42729476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6d6nu029857
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 17/21] powerpc/pci: Create eeh_dev while creating pci_dn
Date: Mon, 27 Apr 2015 16:37:49 +1000
Message-Id: <1430116673-22500-18-git-send-email-gwshan@linux.vnet.ibm.com>
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

The eeh_dev is always created based on pci_dn, but with initcall
supported by core_initcall_sync(). The patch creates eeh_dev
when pci_dn is created, indicating they have same life cycle.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h         |  6 ++++--
 arch/powerpc/kernel/eeh_dev.c          | 18 ++++--------------
 arch/powerpc/kernel/pci_dn.c           | 12 ++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  6 +-----
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2793d24..4ed88f6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -269,7 +269,8 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-void *eeh_dev_init(struct pci_dn *pdn, void *data);
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+			     struct pci_controller *phb);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
@@ -322,7 +323,8 @@ static inline int eeh_init(void)
 	return 0;
 }
 
-static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
+static inline struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+					   struct pci_controller *phb)
 {
 	return NULL;
 }
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index f33ce5b..7486932 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -44,14 +44,14 @@
 /**
  * eeh_dev_init - Create EEH device according to OF node
  * @pdn: PCI device node
- * @data: PHB
+ * @phb: PCI controller
  *
  * It will create EEH device according to the given OF node. The function
  * might be called by PCI emunation, DR, PHB hotplug.
  */
-void *eeh_dev_init(struct pci_dn *pdn, void *data)
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+			     struct pci_controller *phb)
 {
-	struct pci_controller *phb = data;
 	struct eeh_dev *edev;
 
 	/* Allocate EEH device */
@@ -68,7 +68,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
 	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
 
-	return NULL;
+	return edev;
 }
 
 /**
@@ -80,16 +80,8 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
  */
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct pci_dn *root = phb->pci_data;
-
 	/* EEH PE for PHB */
 	eeh_phb_pe_create(phb);
-
-	/* EEH device for PHB */
-	eeh_dev_init(root, phb);
-
-	/* EEH devices for children OF nodes */
-	traverse_pci_dn(root, eeh_dev_init, phb);
 }
 
 /**
@@ -105,8 +97,6 @@ static int __init eeh_dev_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		eeh_dev_phb_init_dynamic(phb);
 
-	pr_info("EEH: devices created\n");
-
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index d3833af..abc81fa 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -276,6 +276,9 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	const __be32 *regs;
 	struct device_node *parent;
 	struct pci_dn *pdn;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev;
+#endif
 
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
@@ -306,6 +309,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	/* Extended config space */
 	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
 
+	/* Initialize EEH device */
+#ifdef CONFIG_EEH
+	edev = eeh_dev_init(pdn, phb);
+	if (!edev) {
+		kfree(pdn);
+		return NULL;
+	}
+#endif
+
 	/* Attach to parent node */
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5f80758..92974aa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -261,12 +261,8 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		pci = np->parent->data;
-		if (pci) {
+		if (pci)
 			update_dn_pci_info(np, pci->phb);
-
-			/* Create EEH device for the OF node */
-			eeh_dev_init(PCI_DN(np), pci->phb);
-		}
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.1.0
