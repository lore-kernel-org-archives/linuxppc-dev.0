Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F22BA2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:35:39 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 02:35:37 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 64D9738C804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:35:34 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P6ZYFO000482
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:35:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P6ZWSU020965
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 03:35:34 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/eeh: Remove eeh_mutex
Date: Tue, 25 Jun 2013 14:35:27 +0800
Message-Id: <1372142128-18077-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Originally, eeh_mutex was introduced to protect the PE hierarchy
tree and the attached EEH devices because EEH core was possiblly
running with multiple threads to access the PE hierarchy tree.
However, we now have only one kthread in EEH core. So we needn't
the eeh_mutex and just remove it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |   14 --------------
 arch/powerpc/kernel/eeh.c      |    3 ---
 arch/powerpc/kernel/eeh_pe.c   |   30 +-----------------------------
 3 files changed, 1 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a0b11fb..dd65e31 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -151,7 +151,6 @@ struct eeh_ops {
 
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
-extern struct mutex eeh_mutex;
 extern raw_spinlock_t confirm_error_lock;
 extern int eeh_probe_mode;
 
@@ -173,16 +172,6 @@ static inline int eeh_probe_mode_dev(void)
 	return (eeh_probe_mode == EEH_PROBE_MODE_DEV);
 }
 
-static inline void eeh_lock(void)
-{
-	mutex_lock(&eeh_mutex);
-}
-
-static inline void eeh_unlock(void)
-{
-	mutex_unlock(&eeh_mutex);
-}
-
 static inline void eeh_serialize_lock(unsigned long *flags)
 {
 	raw_spin_lock_irqsave(&confirm_error_lock, *flags);
@@ -271,9 +260,6 @@ static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
 
 static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
 
-static inline void eeh_lock(void) { }
-static inline void eeh_unlock(void) { }
-
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7c567be..951a632 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -103,9 +103,6 @@ EXPORT_SYMBOL(eeh_subsystem_enabled);
  */
 int eeh_probe_mode;
 
-/* Global EEH mutex */
-DEFINE_MUTEX(eeh_mutex);
-
 /* Lock to avoid races due to multiple reports of an error */
 DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index ae75722..55943fc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -78,9 +78,7 @@ int eeh_phb_pe_create(struct pci_controller *phb)
 	}
 
 	/* Put it into the list */
-	eeh_lock();
 	list_add_tail(&pe->child, &eeh_phb_pe);
-	eeh_unlock();
 
 	pr_debug("EEH: Add PE for PHB#%d\n", phb->global_number);
 
@@ -185,21 +183,15 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		return NULL;
 	}
 
-	eeh_lock();
-
 	/* Traverse root PE */
 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
 		eeh_pe_for_each_dev(pe, edev) {
 			ret = fn(edev, flag);
-			if (ret) {
-				eeh_unlock();
+			if (ret)
 				return ret;
-			}
 		}
 	}
 
-	eeh_unlock();
-
 	return NULL;
 }
 
@@ -305,8 +297,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
 
-	eeh_lock();
-
 	/*
 	 * Search the PE has been existing or not according
 	 * to the PE address. If that has been existing, the
@@ -316,7 +306,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pe = eeh_pe_get(edev);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		if (!edev->pe_config_addr) {
-			eeh_unlock();
 			pr_err("%s: PE with addr 0x%x already exists\n",
 				__func__, edev->config_addr);
 			return -EEXIST;
@@ -328,7 +317,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
-		eeh_unlock();
 		pr_debug("EEH: Add %s to Bus PE#%x\n",
 			edev->dn->full_name, pe->addr);
 
@@ -347,7 +335,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			parent->type &= ~EEH_PE_INVALID;
 			parent = parent->parent;
 		}
-		eeh_unlock();
 		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
 			edev->dn->full_name, pe->addr, pe->parent->addr);
 
@@ -357,7 +344,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	/* Create a new EEH PE */
 	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
-		eeh_unlock();
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
 	}
@@ -385,7 +371,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	if (!parent) {
 		parent = eeh_phb_pe_get(edev->phb);
 		if (!parent) {
-			eeh_unlock();
 			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
 				__func__, edev->phb->global_number);
 			edev->pe = NULL;
@@ -402,7 +387,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	list_add_tail(&pe->child, &parent->child_list);
 	list_add_tail(&edev->list, &pe->edevs);
 	edev->pe = pe;
-	eeh_unlock();
 	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
 		edev->dn->full_name, pe->addr, pe->parent->addr);
 
@@ -430,8 +414,6 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 		return -EEXIST;
 	}
 
-	eeh_lock();
-
 	/* Remove the EEH device */
 	pe = edev->pe;
 	edev->pe = NULL;
@@ -476,8 +458,6 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 		pe = parent;
 	}
 
-	eeh_unlock();
-
 	return 0;
 }
 
@@ -550,9 +530,7 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
  */
 void eeh_pe_state_mark(struct eeh_pe *pe, int state)
 {
-	eeh_lock();
 	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
-	eeh_unlock();
 }
 
 /**
@@ -586,9 +564,7 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
  */
 void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 {
-	eeh_lock();
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
-	eeh_unlock();
 }
 
 /**
@@ -673,8 +649,6 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
 
-	eeh_lock();
-
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS ||
@@ -691,7 +665,5 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	}
 
 out:
-	eeh_unlock();
-
 	return bus;
 }
-- 
1.7.5.4
