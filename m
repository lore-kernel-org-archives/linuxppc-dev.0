Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF0191A02D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 12:44:07 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2AD214010F
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 11:44:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5EB462BB0052
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H1hrjo24641758
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H1hRJr018780
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:43:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] powerpc/eeh: Remove device_node dependency
Date: Tue, 17 Mar 2015 12:37:24 +1100
Message-Id: <1426556244-30066-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch removes struct eeh_dev::dn and the corresponding helper
functions: eeh_dev_to_of_node() and of_node_to_eeh_dev(). Instead,
eeh_dev_to_pdn() and pdn_to_eeh_dev() should be used to get the
pdn, which might contain device_node on PowerNV platform.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h        |  7 -------
 arch/powerpc/include/asm/pci-bridge.h | 14 --------------
 arch/powerpc/kernel/eeh.c             | 30 ++++++++++++++++--------------
 arch/powerpc/kernel/eeh_cache.c       | 25 +++++++++++--------------
 arch/powerpc/kernel/eeh_driver.c      | 22 ----------------------
 arch/powerpc/kernel/eeh_pe.c          | 34 +++++++++++++++++++++++++---------
 arch/powerpc/kernel/pci_of_scan.c     |  2 +-
 arch/powerpc/kernel/rtas_pci.c        |  2 +-
 arch/powerpc/platforms/pseries/msi.c  |  6 ++++--
 9 files changed, 58 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2540ad8..61912fc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -29,7 +29,6 @@
 
 struct pci_dev;
 struct pci_bus;
-struct device_node;
 
 #ifdef CONFIG_EEH
 
@@ -136,17 +135,11 @@ struct eeh_dev {
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
-	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
-static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
-{
-	return edev ? edev->dn : NULL;
-}
-
 static inline struct pci_dn *eeh_dev_to_pdn(struct eeh_dev *edev)
 {
 	return edev ? edev->pdn : NULL;
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 23558bc..c480a14 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -204,25 +204,11 @@ static inline int pci_device_from_OF_node(struct device_node *np,
 }
 
 #if defined(CONFIG_EEH)
-static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
-{
-	/*
-	 * For those OF nodes whose parent isn't PCI bridge, they
-	 * don't have PCI_DN actually. So we have to skip them for
-	 * any EEH operations.
-	 */
-	if (!dn || !PCI_DN(dn))
-		return NULL;
-
-	return PCI_DN(dn)->edev;
-}
-
 static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
 {
 	return pdn ? pdn->edev : NULL;
 }
 #else
-#define of_node_to_eeh_dev(x)	(NULL)
 #define pdn_to_eeh_dev(x)	(NULL)
 #endif
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6f9ec77..7a47183 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -418,11 +418,11 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	int ret;
 	int active_flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	unsigned long flags;
-	struct device_node *dn;
+	struct pci_dn *pdn;
 	struct pci_dev *dev;
 	struct eeh_pe *pe, *parent_pe, *phb_pe;
 	int rc = 0;
-	const char *location;
+	const char *location = NULL;
 
 	eeh_stats.total_mmio_ffs++;
 
@@ -433,15 +433,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 		eeh_stats.no_dn++;
 		return 0;
 	}
-	dn = eeh_dev_to_of_node(edev);
 	dev = eeh_dev_to_pci_dev(edev);
 	pe = eeh_dev_to_pe(edev);
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!pe) {
 		eeh_stats.ignored_check++;
-		pr_debug("EEH: Ignored check for %s %s\n",
-			eeh_pci_name(dev), dn->full_name);
+		pr_debug("EEH: Ignored check for %s\n",
+			eeh_pci_name(dev));
 		return 0;
 	}
 
@@ -477,10 +476,13 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	if (pe->state & EEH_PE_ISOLATED) {
 		pe->check_count++;
 		if (pe->check_count % EEH_MAX_FAILS == 0) {
-			location = of_get_property(dn, "ibm,loc-code", NULL);
+			pdn = eeh_dev_to_pdn(edev);
+			if (pdn->node)
+				location = of_get_property(pdn->node, "ibm,loc-code", NULL);
 			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
-				pe->check_count, location,
+				pe->check_count,
+				location ? location : "unknown",
 				eeh_driver_name(dev), eeh_pci_name(dev));
 			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
 				eeh_driver_name(dev));
@@ -702,7 +704,7 @@ static void *eeh_disable_and_save_dev_state(void *data, void *userdata)
 static void *eeh_restore_dev_state(void *data, void *userdata)
 {
 	struct eeh_dev *edev = data;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
 	struct pci_dev *dev = userdata;
 
@@ -710,8 +712,8 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
 		return NULL;
 
 	/* Apply customization from firmware */
-	if (dn && eeh_ops->restore_config)
-		eeh_ops->restore_config(dn);
+	if (pdn && eeh_ops->restore_config)
+		eeh_ops->restore_config(pdn);
 
 	/* The caller should restore state for the specified device */
 	if (pdev != dev)
@@ -1035,7 +1037,7 @@ int eeh_init(void)
 core_initcall_sync(eeh_init);
 
 /**
- * eeh_add_device_early - Enable EEH for the indicated device_node
+ * eeh_add_device_early - Enable EEH for the indicated device node
  * @pdn: PCI device node for which to set up EEH
  *
  * This routine must be used to perform EEH initialization for PCI
@@ -1093,7 +1095,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
-	struct device_node *dn;
+	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 
 	if (!dev || !eeh_enabled())
@@ -1101,8 +1103,8 @@ void eeh_add_device_late(struct pci_dev *dev)
 
 	pr_debug("EEH: Adding device %s\n", pci_name(dev));
 
-	dn = pci_device_to_OF_node(dev);
-	edev = of_node_to_eeh_dev(dn);
+	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
+	edev = pdn_to_eeh_dev(pdn);
 	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 07d8a24..eeabeab 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -171,30 +171,27 @@ eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 
 static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 {
-	struct device_node *dn;
+	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 	int i;
 
-	dn = pci_device_to_OF_node(dev);
-	if (!dn) {
+	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
+	if (!pdn) {
 		pr_warn("PCI: no pci dn found for dev=%s\n",
 			pci_name(dev));
 		return;
 	}
 
-	edev = of_node_to_eeh_dev(dn);
+	edev = pdn_to_eeh_dev(pdn);
 	if (!edev) {
-		pr_warn("PCI: no EEH dev found for dn=%s\n",
-			dn->full_name);
+		pr_warn("PCI: no EEH dev found for %s\n",
+			pci_name(dev));
 		return;
 	}
 
 	/* Skip any devices for which EEH is not enabled. */
 	if (!edev->pe) {
-#ifdef DEBUG
-		pr_info("PCI: skip building address cache for=%s - %s\n",
-			pci_name(dev), dn->full_name);
-#endif
+		dev_dbg(&dev->dev, "EEH: Skip building address cache\n");
 		return;
 	}
 
@@ -282,18 +279,18 @@ void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
  */
 void eeh_addr_cache_build(void)
 {
-	struct device_node *dn;
+	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 	struct pci_dev *dev = NULL;
 
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
 	for_each_pci_dev(dev) {
-		dn = pci_device_to_OF_node(dev);
-		if (!dn)
+		pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
+		if (!pdn)
 			continue;
 
-		edev = of_node_to_eeh_dev(dn);
+		edev = pdn_to_eeh_dev(pdn);
 		if (!edev)
 			continue;
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index d099540..24768ff 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -83,28 +83,6 @@ static inline void eeh_pcid_put(struct pci_dev *pdev)
 	module_put(pdev->driver->driver.owner);
 }
 
-#if 0
-static void print_device_node_tree(struct pci_dn *pdn, int dent)
-{
-	int i;
-	struct device_node *pc;
-
-	if (!pdn)
-		return;
-	for (i = 0; i < dent; i++)
-		printk(" ");
-	printk("dn=%s mode=%x \tcfg_addr=%x pe_addr=%x \tfull=%s\n",
-		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
-		pdn->eeh_pe_config_addr, pdn->node->full_name);
-	dent += 3;
-	pc = pdn->node->child;
-	while (pc) {
-		print_device_node_tree(PCI_DN(pc), dent);
-		pc = pc->sibling;
-	}
-}
-#endif
-
 /**
  * eeh_disable_irq - Disable interrupt for the recovering device
  * @dev: PCI device
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 209cd75..f33cecc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -348,9 +348,12 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
-		pr_debug("EEH: Add %s to Bus PE#%x\n",
-			edev->dn->full_name, pe->addr);
-
+		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Bus PE#%x\n",
+			edev->phb->global_number,
+			edev->config_addr >> 8,
+			PCI_SLOT(edev->config_addr & 0xFF),
+			PCI_FUNC(edev->config_addr & 0xFF),
+			pe->addr);
 		return 0;
 	} else if (pe && (pe->type & EEH_PE_INVALID)) {
 		list_add_tail(&edev->list, &pe->edevs);
@@ -366,9 +369,14 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			parent->type &= ~(EEH_PE_INVALID | EEH_PE_KEEP);
 			parent = parent->parent;
 		}
-		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
-			edev->dn->full_name, pe->addr, pe->parent->addr);
 
+		pr_debug("EEH: Add %04x:%02x:%02x.%01x to Device "
+			 "PE#%x, Parent PE#%x\n",
+			edev->phb->global_number,
+			edev->config_addr >> 8,
+                        PCI_SLOT(edev->config_addr & 0xFF),
+                        PCI_FUNC(edev->config_addr & 0xFF),
+			pe->addr, pe->parent->addr);
 		return 0;
 	}
 
@@ -407,8 +415,13 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	list_add_tail(&pe->child, &parent->child_list);
 	list_add_tail(&edev->list, &pe->edevs);
 	edev->pe = pe;
-	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
-		edev->dn->full_name, pe->addr, pe->parent->addr);
+	pr_debug("EEH: Add %04x:%02x:%02x.%01x to "
+		 "Device PE#%x, Parent PE#%x\n",
+		 edev->phb->global_number,
+		 edev->config_addr >> 8,
+		 PCI_SLOT(edev->config_addr & 0xFF),
+		 PCI_FUNC(edev->config_addr & 0xFF),
+		 pe->addr, pe->parent->addr);
 
 	return 0;
 }
@@ -428,8 +441,11 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	int cnt;
 
 	if (!edev->pe) {
-		pr_debug("%s: No PE found for EEH device %s\n",
-			 __func__, edev->dn->full_name);
+		pr_debug("%s: No PE found for device %04x:%02x:%02x.%01x\n",
+			 __func__,  edev->phb->global_number,
+			 edev->config_addr >> 8,
+			 PCI_SLOT(edev->config_addr & 0xFF),
+			 PCI_FUNC(edev->config_addr & 0xFF));
 		return -EEXIST;
 	}
 
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index e6245e9..7122dfe 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -305,7 +305,7 @@ static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
 	const __be32 *reg;
 	int reglen, devfn;
 #ifdef CONFIG_EEH
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(PCI_DN(dn));
 #endif
 
 	pr_debug("  * %s\n", dn->full_name);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index ce230da..af29df2 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -113,7 +113,7 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 
 	ret = rtas_read_config(pdn, where, size, val);
 	if (*val == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
+	    eeh_dev_check_failure(pdn_to_eeh_dev(pdn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return ret;
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 691a154..c8d24f9 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -195,6 +195,7 @@ static struct device_node *find_pe_total_msi(struct pci_dev *dev, int *total)
 static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 {
 	struct device_node *dn;
+	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 
 	/* Found our PE and assume 8 at that point. */
@@ -204,10 +205,11 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 		return NULL;
 
 	/* Get the top level device in the PE */
-	edev = of_node_to_eeh_dev(dn);
+	edev = pdn_to_eeh_dev(PCI_DN(dn));
 	if (edev->pe)
 		edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
-	dn = eeh_dev_to_of_node(edev);
+	pdn = eeh_dev_to_pdn(edev);
+	dn = pdn ? pdn->node : NULL;
 	if (!dn)
 		return NULL;
 
-- 
1.8.3.2
