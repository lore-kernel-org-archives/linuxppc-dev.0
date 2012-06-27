Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87245100E24
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:12:31 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:12:28 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4A5EDC93A7D
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:11 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2CbI152030
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RLWn8i030262
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 17:32:54 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/21] ppc/eeh: move EEH initialization around
Date: Thu, 28 Jun 2012 00:01:31 +0800
Message-Id: <1340812911-6793-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we have 3 phases for EEH initialization on pSeries platform
using builtin functions: platform initialization, EEH device creation,
and EEH subsystem enablement. All of them are done no later than
ppc_md.setup_arch. That means that the slab/slub isn't ready yet, so
we have to allocate memory chunks on basis of PAGE_SIZE for those
dynamically created EEH devices. That's pretty expensive.

In order to utilize slab/slub for memory allocation, we have to move
the EEH initialization functions around, but all of them should be
called after slab/slub is ready.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   16 ----------------
 arch/powerpc/kernel/rtas_pci.c               |    3 ---
 arch/powerpc/platforms/pseries/eeh.c         |   10 +++++++---
 arch/powerpc/platforms/pseries/eeh_dev.c     |    6 +++++-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    4 +++-
 arch/powerpc/platforms/pseries/setup.c       |    2 --
 6 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d60f998..06dedff 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -117,11 +117,6 @@ extern int eeh_subsystem_enabled;
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
-void __init eeh_dev_phb_init(void);
-void __init eeh_init(void);
-#ifdef CONFIG_PPC_PSERIES
-int __init eeh_pseries_init(void);
-#endif
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
@@ -156,17 +151,6 @@ static inline void *eeh_dev_init(struct device_node *dn, void *data)
 
 static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
 
-static inline void eeh_dev_phb_init(void) { }
-
-static inline void eeh_init(void) { }
-
-#ifdef CONFIG_PPC_PSERIES
-static inline int eeh_pseries_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_PPC_PSERIES */
-
 static inline unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	return val;
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 179af90..140735c 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -275,9 +275,6 @@ void __init find_and_init_phbs(void)
 	of_node_put(root);
 	pci_devs_phb_init();
 
-	/* Create EEH devices for all PHBs */
-	eeh_dev_phb_init();
-
 	/*
 	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
 	 * in chosen.
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index ecd394c..e819448 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -982,7 +982,7 @@ int __exit eeh_ops_unregister(const char *name)
  * Even if force-off is set, the EEH hardware is still enabled, so that
  * newer systems can boot.
  */
-void __init eeh_init(void)
+static int __init eeh_init(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct device_node *phb;
@@ -992,11 +992,11 @@ void __init eeh_init(void)
 	if (!eeh_ops) {
 		pr_warning("%s: Platform EEH operation not found\n",
 			__func__);
-		return;
+		return -EEXIST;
 	} else if ((ret = eeh_ops->init())) {
 		pr_warning("%s: Failed to call platform init function (%d)\n",
 			__func__, ret);
-		return;
+		return ret;
 	}
 
 	raw_spin_lock_init(&confirm_error_lock);
@@ -1011,8 +1011,12 @@ void __init eeh_init(void)
 		printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
 		printk(KERN_WARNING "EEH: No capable adapters found\n");
+
+	return ret;
 }
 
+core_initcall_sync(eeh_init);
+
 /**
  * eeh_add_device_early - Enable EEH for the indicated device_node
  * @dn: device node for which to set up EEH
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index c4507d0..ab68c59 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -93,10 +93,14 @@ void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb)
  * Scan all the existing PHBs and create EEH devices for their OF
  * nodes and their children OF nodes
  */
-void __init eeh_dev_phb_init(void)
+static int __init eeh_dev_phb_init(void)
 {
 	struct pci_controller *phb, *tmp;
 
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		eeh_dev_phb_init_dynamic(phb);
+
+	return 0;
 }
+
+core_initcall(eeh_dev_phb_init);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8752f79..bcf0bb8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -559,7 +559,9 @@ static struct eeh_ops pseries_eeh_ops = {
  * EEH initialization on pseries platform. This function should be
  * called before any EEH related functions.
  */
-int __init eeh_pseries_init(void)
+static int __init eeh_pseries_init(void)
 {
 	return eeh_ops_register(&pseries_eeh_ops);
 }
+
+early_initcall(eeh_pseries_init);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 51ecac9..5406473 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -388,10 +388,8 @@ static void __init pSeries_setup_arch(void)
 
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
-	eeh_pseries_init();
 	find_and_init_phbs();
 	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
-	eeh_init();
 
 	pSeries_nvram_init();
 
-- 
1.7.9.5
