Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C50E1A037F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:49 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 14:41:47 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BE2BD2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6H4fSvs7405976
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6H4fiaL010007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:41:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/6] powerpc/eeh: Refactor EEH flag accessors
Date: Thu, 17 Jul 2014 14:41:38 +1000
Message-Id: <1405572103-32152-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405572103-32152-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405572103-32152-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are multiple global EEH flags. Almost each flag has its own
accessor, which doesn't make sense. The patch refactors EEH flag
accessors so that they look unified:

  eeh_add_flag():   Add EEH flag
  eeh_clear_flag(): Clear EEH flag
  eeh_has_flag():   Check if one specific flag has been set
  eeh_enabled():    Check if EEH functionality has been enabled

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 32 ++++++++++------------------
 arch/powerpc/kernel/eeh.c                    | 20 ++++++++---------
 arch/powerpc/kernel/eeh_cache.c              |  2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  6 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c    |  1 -
 arch/powerpc/platforms/pseries/eeh_pseries.c |  4 ++--
 6 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 6e47894..ca8aada 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -206,36 +206,28 @@ extern int eeh_subsystem_flags;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
-static inline bool eeh_enabled(void)
+static inline void eeh_add_flag(int flag)
 {
-	if ((eeh_subsystem_flags & EEH_FORCE_DISABLED) ||
-	    !(eeh_subsystem_flags & EEH_ENABLED))
-		return false;
-
-	return true;
+	eeh_subsystem_flags |= flag;
 }
 
-static inline void eeh_set_enable(bool mode)
+static inline void eeh_clear_flag(int flag)
 {
-	if (mode)
-		eeh_subsystem_flags |= EEH_ENABLED;
-	else
-		eeh_subsystem_flags &= ~EEH_ENABLED;
+	eeh_subsystem_flags &= ~flag;
 }
 
-static inline void eeh_probe_mode_set(int flag)
+static inline bool eeh_has_flag(int flag)
 {
-	eeh_subsystem_flags |= flag;
+        return !!(eeh_subsystem_flags & flag);
 }
 
-static inline int eeh_probe_mode_devtree(void)
+static inline bool eeh_enabled(void)
 {
-	return (eeh_subsystem_flags & EEH_PROBE_MODE_DEVTREE);
-}
+	if (eeh_has_flag(EEH_FORCE_DISABLED) ||
+	    !eeh_has_flag(EEH_ENABLED))
+		return false;
 
-static inline int eeh_probe_mode_dev(void)
-{
-	return (eeh_subsystem_flags & EEH_PROBE_MODE_DEV);
+	return true;
 }
 
 static inline void eeh_serialize_lock(unsigned long *flags)
@@ -314,8 +306,6 @@ static inline bool eeh_enabled(void)
         return false;
 }
 
-static inline void eeh_set_enable(bool mode) { }
-
 static inline int eeh_init(void)
 {
 	return 0;
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 4de2103..65a163f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -142,7 +142,7 @@ static struct eeh_stats eeh_stats;
 static int __init eeh_setup(char *str)
 {
 	if (!strcmp(str, "off"))
-		eeh_subsystem_flags |= EEH_FORCE_DISABLED;
+		eeh_add_flag(EEH_FORCE_DISABLED);
 
 	return 1;
 }
@@ -252,7 +252,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	 * 0xFF's is always returned from PCI config space.
 	 */
 	if (!(pe->type & EEH_PE_PHB)) {
-		if (eeh_probe_mode_devtree())
+		if (eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
 			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 		eeh_ops->configure_bridge(pe);
 		eeh_pe_restore_bars(pe);
@@ -303,7 +303,7 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	unsigned long flags;
 	int ret;
 
-	if (!eeh_probe_mode_dev())
+	if (!eeh_has_flag(EEH_PROBE_MODE_DEV))
 		return -EPERM;
 
 	/* Find the PHB PE */
@@ -801,7 +801,7 @@ int __exit eeh_ops_unregister(const char *name)
 static int eeh_reboot_notifier(struct notifier_block *nb,
 			       unsigned long action, void *unused)
 {
-	eeh_set_enable(false);
+	eeh_clear_flag(EEH_ENABLED);
 	return NOTIFY_DONE;
 }
 
@@ -865,13 +865,13 @@ int eeh_init(void)
 		return ret;
 
 	/* Enable EEH for all adapters */
-	if (eeh_probe_mode_devtree()) {
+	if (eeh_has_flag(EEH_PROBE_MODE_DEVTREE)) {
 		list_for_each_entry_safe(hose, tmp,
 			&hose_list, list_node) {
 			phb = hose->dn;
 			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
 		}
-	} else if (eeh_probe_mode_dev()) {
+	} else if (eeh_has_flag(EEH_PROBE_MODE_DEV)) {
 		list_for_each_entry_safe(hose, tmp,
 			&hose_list, list_node)
 			pci_walk_bus(hose->bus, eeh_ops->dev_probe, NULL);
@@ -923,7 +923,7 @@ void eeh_add_device_early(struct device_node *dn)
 	 * would delay the probe until late stage because
 	 * the PCI device isn't available this moment.
 	 */
-	if (!eeh_probe_mode_devtree())
+	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
 		return;
 
 	if (!of_node_to_eeh_dev(dn))
@@ -1009,7 +1009,7 @@ void eeh_add_device_late(struct pci_dev *dev)
 	 * We have to do the EEH probe here because the PCI device
 	 * hasn't been created yet in the early stage.
 	 */
-	if (eeh_probe_mode_dev())
+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
 		eeh_ops->dev_probe(dev, NULL);
 
 	eeh_addr_cache_insert_dev(dev);
@@ -1430,9 +1430,9 @@ static const struct file_operations proc_eeh_operations = {
 static int eeh_enable_dbgfs_set(void *data, u64 val)
 {
 	if (val)
-		eeh_subsystem_flags &= ~EEH_FORCE_DISABLED;
+		eeh_clear_flag(EEH_FORCE_DISABLED);
 	else
-		eeh_subsystem_flags |= EEH_FORCE_DISABLED;
+		eeh_add_flag(EEH_FORCE_DISABLED);
 
 	/* Notify the backend */
 	if (eeh_ops->post_init)
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index e8c9fd5..3639bee 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -189,7 +189,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 	}
 
 	/* Skip any devices for which EEH is not enabled. */
-	if (!eeh_probe_mode_dev() && !edev->pe) {
+	if (!edev->pe) {
 #ifdef DEBUG
 		pr_info("PCI: skip building address cache for=%s - %s\n",
 			pci_name(dev), dn->full_name);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 48eb223..ba134ac 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -51,8 +51,8 @@ static int powernv_eeh_init(void)
 		return -EINVAL;
 	}
 
-	/* Set EEH probe mode */
-	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
+	/* Set probe mode */
+	eeh_add_flag(EEH_PROBE_MODE_DEV);
 
 	return 0;
 }
@@ -164,7 +164,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * Enable EEH explicitly so that we will do EEH check
 	 * while accessing I/O stuff
 	 */
-	eeh_set_enable(true);
+	eeh_add_flag(EEH_ENABLED);
 
 	/* Save memory bars */
 	eeh_save_bars(edev);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 91333ea..137e324 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1545,7 +1545,6 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_pci_ioda_create_dbgfs();
 
 #ifdef CONFIG_EEH
-	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 0bec0c0..f173705 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -128,7 +128,7 @@ static int pseries_eeh_init(void)
 	}
 
 	/* Set EEH probe mode */
-	eeh_probe_mode_set(EEH_PROBE_MODE_DEVTREE);
+	eeh_add_flag(EEH_PROBE_MODE_DEVTREE);
 
 	return 0;
 }
@@ -297,7 +297,7 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 			enable = 1;
 
 		if (enable) {
-			eeh_set_enable(true);
+			eeh_add_flag(EEH_ENABLED);
 			eeh_add_to_parent_pe(edev);
 
 			pr_debug("%s: EEH enabled on %s PHB#%d-PE#%x, config addr#%x\n",
-- 
1.8.3.2
