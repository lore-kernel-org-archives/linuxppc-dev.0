Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6AB52C0093
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 15:16:33 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Sep 2012 01:16:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 81CA538C8039
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:27 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8C5GQ0s191810
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:27 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8C5GQiV022364
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2012 23:16:26 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] ppc/eeh: global mutex to protect PE tree
Date: Wed, 12 Sep 2012 13:16:18 +0800
Message-Id: <1347426978-6194-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347426978-6194-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347426978-6194-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have missed lots of situations where the PE hierarchy tree need
protection through the EEH global mutex. The patch fixes that for
those public APIs implemented in eeh_pe.c. The only exception is
eeh_pe_restore_bars() because it calls eeh_pe_dev_traverse(), which
has been protected by the mutex.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pe.c |   39 +++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index a2646cf..07b6e4b 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -99,8 +99,6 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 {
 	struct eeh_pe *pe;
 
-	eeh_lock();
-
 	list_for_each_entry(pe, &eeh_phb_pe, child) {
 		/*
 		 * Actually, we needn't check the type since
@@ -114,8 +112,6 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 		}
 	}
 
-	eeh_unlock();
-
 	return NULL;
 }
 
@@ -192,14 +188,21 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		return NULL;
 	}
 
+	eeh_lock();
+
 	/* Traverse root PE */
 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
 		eeh_pe_for_each_dev(pe, edev) {
 			ret = fn(edev, flag);
-			if (ret) return ret;
+			if (ret) {
+				eeh_unlock();
+				return ret;
+			}
 		}
 	}
 
+	eeh_unlock();
+
 	return NULL;
 }
 
@@ -251,9 +254,7 @@ static struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 	struct eeh_pe *root = eeh_phb_pe_get(edev->phb);
 	struct eeh_pe *pe;
 
-	eeh_lock();
 	pe = eeh_pe_traverse(root, __eeh_pe_get, edev);
-	eeh_unlock();
 
 	return pe;
 }
@@ -307,6 +308,8 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
 
+	eeh_lock();
+
 	/*
 	 * Search the PE has been existing or not according
 	 * to the PE address. If that has been existing, the
@@ -316,6 +319,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pe = eeh_pe_get(edev);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
 		if (!edev->pe_config_addr) {
+			eeh_unlock();
 			pr_err("%s: PE with addr 0x%x already exists\n",
 				__func__, edev->config_addr);
 			return -EEXIST;
@@ -327,6 +331,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 		/* Put the edev to PE */
 		list_add_tail(&edev->list, &pe->edevs);
+		eeh_unlock();
 		pr_debug("EEH: Add %s to Bus PE#%x\n",
 			edev->dn->full_name, pe->addr);
 
@@ -345,6 +350,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 			parent->type &= ~EEH_PE_INVALID;
 			parent = parent->parent;
 		}
+		eeh_unlock();
 		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
 			edev->dn->full_name, pe->addr, pe->parent->addr);
 
@@ -354,6 +360,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	/* Create a new EEH PE */
 	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
+		eeh_unlock();
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
 	}
@@ -370,6 +377,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	if (!parent) {
 		parent = eeh_phb_pe_get(edev->phb);
 		if (!parent) {
+			eeh_unlock();
 			pr_err("%s: No PHB PE is found (PHB Domain=%d)\n",
 				__func__, edev->phb->global_number);
 			edev->pe = NULL;
@@ -386,6 +394,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	list_add_tail(&pe->child, &parent->child_list);
 	list_add_tail(&edev->list, &pe->edevs);
 	edev->pe = pe;
+	eeh_unlock();
 	pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
 		edev->dn->full_name, pe->addr, pe->parent->addr);
 
@@ -413,6 +422,8 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 		return -EEXIST;
 	}
 
+	eeh_lock();
+
 	/* Remove the EEH device */
 	pe = edev->pe;
 	edev->pe = NULL;
@@ -457,6 +468,8 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 		pe = parent;
 	}
 
+	eeh_unlock();
+
 	return 0;
 }
 
@@ -502,7 +515,9 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
  */
 void eeh_pe_state_mark(struct eeh_pe *pe, int state)
 {
+	eeh_lock();
 	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
+	eeh_unlock();
 }
 
 /**
@@ -536,7 +551,9 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
  */
 void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 {
+	eeh_lock();
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
+	eeh_unlock();
 }
 
 /**
@@ -598,6 +615,10 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
  */
 void eeh_pe_restore_bars(struct eeh_pe *pe)
 {
+	/*
+	 * We needn't take the EEH lock since eeh_pe_dev_traverse()
+	 * will take that.
+	 */
 	eeh_pe_dev_traverse(pe, eeh_restore_one_device_bars, NULL);
 }
 
@@ -617,6 +638,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
 
+	eeh_lock();
+
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS) {
@@ -626,5 +649,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 			bus = pdev->bus;
 	}
 
+	eeh_unlock();
+
 	return bus;
 }
-- 
1.7.5.4
