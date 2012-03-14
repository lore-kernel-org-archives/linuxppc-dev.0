Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35156B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:31:41 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 14 Mar 2012 10:23:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2EAPjLJ2375794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:25:45 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2EAVWxD022011
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:31:34 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: sfr@canb.auug.org.au, grant.likely@secretlab.ca, benh@kernel.crashing.org
Subject: [PATCH] EEH: remove eeh device from OF node
Date: Wed, 14 Mar 2012 18:31:26 +0800
Message-Id: <1331721086-4314-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Originally, the PCI sensitive OF node is tracing the eeh device
through struct device_node::edev. However, it was regarded as
bad idea.

The patch removes struct device_node::edev. In addition, the
global list of eeh devices is introduced, and do retrival of
eeh device according to the given OF node through the global
list.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h           |    7 +++++++
 arch/powerpc/platforms/pseries/eeh_dev.c |   29 ++++++++++++++++++++++++++++-
 include/linux/of.h                       |   10 ----------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d60f998..591e0a1 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -56,6 +56,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct list_head list;		/* Form the global link list	*/
 };
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
@@ -115,6 +116,7 @@ extern int eeh_subsystem_enabled;
  */
 #define EEH_MAX_ALLOWED_FREEZES 5
 
+struct eeh_dev *eeh_dev_from_of_node(struct device_node *dn);
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 void __init eeh_dev_phb_init(void);
@@ -132,6 +134,11 @@ void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_remove_bus_device(struct pci_dev *);
 
+static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
+{
+	return eeh_dev_from_of_node(dn);
+}
+
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index f3aed7d..925d3a3 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -34,6 +34,7 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
@@ -41,6 +42,30 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
+/* eeh device list */
+static LIST_HEAD(eeh_dev_list);
+
+/**
+ * eeh_dev_from_of_node - Retrieve EEH device according to OF node
+ * @dn: OF node
+ *
+ * All existing eeh devices have been put into the global list.
+ * In addition, the eeh device is tracing the corresponding
+ * OF node. The function is used to retrieve the corresponding
+ * eeh device according to the given OF node.
+ */
+struct eeh_dev *eeh_dev_from_of_node(struct device_node *dn)
+{
+	struct eeh_dev *edev = NULL;
+
+	list_for_each_entry(edev, &eeh_dev_list, list) {
+		if (edev->dn && edev->dn == dn)
+			return edev;
+	}
+
+	return NULL;
+}
+
 /**
  * eeh_dev_init - Create EEH device according to OF node
  * @dn: device node
@@ -62,10 +87,12 @@ void * __devinit eeh_dev_init(struct device_node *dn, void *data)
 	}
 
 	/* Associate EEH device with OF node */
-	dn->edev  = edev;
 	edev->dn  = dn;
 	edev->phb = phb;
 
+	/* Add to global list */
+	list_add_tail(&edev->list, &eeh_dev_list);
+
 	return NULL;
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 3e710d8..a75a831 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -58,9 +58,6 @@ struct device_node {
 	struct	kref kref;
 	unsigned long _flags;
 	void	*data;
-#if defined(CONFIG_EEH)
-	struct eeh_dev *edev;
-#endif
 #if defined(CONFIG_SPARC)
 	char	*path_component_name;
 	unsigned int unique_id;
@@ -75,13 +72,6 @@ struct of_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
-#if defined(CONFIG_EEH)
-static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
-{
-	return dn->edev;
-}
-#endif
-
 #if defined(CONFIG_SPARC) || !defined(CONFIG_OF)
 /* Dummy ref counting routines - to be implemented later */
 static inline struct device_node *of_node_get(struct device_node *node)
-- 
1.7.5.4
