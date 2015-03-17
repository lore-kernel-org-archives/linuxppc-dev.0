Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C6141A0BB2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:16:13 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ABE3314011D
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 15:16:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 61926357804C
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H5G2Fc44826646
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:10 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H5FaXa001553
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:15:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 4/7] powerpc/eeh: Create eeh_dev from pci_dn instead of
 device_node
Date: Tue, 17 Mar 2015 16:15:05 +1100
Message-Id: <1426569308-9470-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch adds function traverse_pci_dn(), which is similar to
traverse_pci_devices() except it takes pci_dn, not device_node
as parameter. The pci_dev.c has been reworked to create eeh_dev
from pci_dn, instead of device_node.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h         | 10 +++++++--
 arch/powerpc/include/asm/pci-bridge.h  |  8 ++++++-
 arch/powerpc/include/asm/ppc-pci.h     |  3 +++
 arch/powerpc/kernel/eeh_dev.c          | 14 ++++++------
 arch/powerpc/kernel/pci_dn.c           | 40 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 6 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 55abfd0..bb24172 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -137,6 +137,7 @@ struct eeh_dev {
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct device_node *dn;		/* Associated device node	*/
+	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
@@ -146,6 +147,11 @@ static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
 	return edev ? edev->dn : NULL;
 }
 
+static inline struct pci_dn *eeh_dev_to_pdn(struct eeh_dev *edev)
+{
+	return edev ? edev->pdn : NULL;
+}
+
 static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 {
 	return edev ? edev->pdev : NULL;
@@ -272,7 +278,7 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-void *eeh_dev_init(struct device_node *dn, void *data);
+void *eeh_dev_init(struct pci_dn *pdn, void *data);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
@@ -323,7 +329,7 @@ static inline int eeh_init(void)
 	return 0;
 }
 
-static inline void *eeh_dev_init(struct device_node *dn, void *data)
+static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
 {
 	return NULL;
 }
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 01b730a..7b74499 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -213,8 +213,14 @@ static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 
 	return PCI_DN(dn)->edev;
 }
+
+static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
+{
+	return pdn ? pdn->edev : NULL;
+}
 #else
-#define of_node_to_eeh_dev(x) (NULL)
+#define of_node_to_eeh_dev(x)	(NULL)
+#define pdn_to_eeh_dev(x)	(NULL)
 #endif
 
 /** Find the bus corresponding to the indicated device node */
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index db1e2b8..eef127e 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -36,6 +36,9 @@ struct device_node;
 typedef void *(*traverse_func)(struct device_node *me, void *data);
 void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		void *data);
+void *traverse_pci_dn(struct pci_dn *root,
+		      void *(*fn)(struct pci_dn *, void *),
+		      void *data);
 
 extern void pci_devs_phb_init(void);
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index e5274ee..aabba94 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -43,13 +43,13 @@
 
 /**
  * eeh_dev_init - Create EEH device according to OF node
- * @dn: device node
+ * @pdn: PCI device node
  * @data: PHB
  *
  * It will create EEH device according to the given OF node. The function
  * might be called by PCI emunation, DR, PHB hotplug.
  */
-void *eeh_dev_init(struct device_node *dn, void *data)
+void *eeh_dev_init(struct pci_dn *pdn, void *data)
 {
 	struct pci_controller *phb = data;
 	struct eeh_dev *edev;
@@ -63,8 +63,8 @@ void *eeh_dev_init(struct device_node *dn, void *data)
 	}
 
 	/* Associate EEH device with OF node */
-	PCI_DN(dn)->edev = edev;
-	edev->dn  = dn;
+	pdn->edev = edev;
+	edev->pdn = pdn;
 	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
 
@@ -80,16 +80,16 @@ void *eeh_dev_init(struct device_node *dn, void *data)
  */
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct device_node *dn = phb->dn;
+	struct pci_dn *root = phb->pci_data;
 
 	/* EEH PE for PHB */
 	eeh_phb_pe_create(phb);
 
 	/* EEH device for PHB */
-	eeh_dev_init(dn, phb);
+	eeh_dev_init(root, phb);
 
 	/* EEH devices for children OF nodes */
-	traverse_pci_devices(dn, eeh_dev_init, phb);
+	traverse_pci_dn(root, eeh_dev_init, phb);
 }
 
 /**
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index d139f72f..65b9836 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -246,6 +246,46 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 	return NULL;
 }
 
+static struct pci_dn *pci_dn_next_one(struct pci_dn *root,
+				      struct pci_dn *pdn)
+{
+	struct list_head *next = pdn->child_list.next;
+
+	if (next != &pdn->child_list)
+		return list_entry(next, struct pci_dn, list);
+
+	while (1) {
+		if (pdn == root)
+			return NULL;
+
+		next = pdn->list.next;
+		if (next != &pdn->parent->child_list)
+			break;
+
+		pdn = pdn->parent;
+	}
+
+	return list_entry(next, struct pci_dn, list);
+}
+
+void *traverse_pci_dn(struct pci_dn *root,
+		      void *(*fn)(struct pci_dn *, void *),
+		      void *data)
+{
+	struct pci_dn *pdn = root;
+	void *ret;
+
+	/* Only scan the child nodes */
+	for (pdn = pci_dn_next_one(root, pdn); pdn;
+	     pdn = pci_dn_next_one(root, pdn)) {
+		ret = fn(pdn, data);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /** 
  * pci_devs_phb_init_dynamic - setup pci devices under this PHB
  * phb: pci-to-host bridge (top-level bridge connecting to cpu)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e445b67..7030407 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -265,7 +265,7 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 			update_dn_pci_info(np, pci->phb);
 
 			/* Create EEH device for the OF node */
-			eeh_dev_init(np, pci->phb);
+			eeh_dev_init(PCI_DN(np), pci->phb);
 		}
 		break;
 	default:
-- 
1.8.3.2
