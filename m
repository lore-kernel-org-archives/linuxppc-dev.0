Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45D422C0098
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 16:16:25 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 00:16:22 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C7E2B6E805D
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 00:16:16 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F5GKVP28311564
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 05:16:20 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F5GKFp013995
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 00:16:20 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/3] powerpc/eeh: Handle multiple EEH errors
Date: Wed, 15 Jan 2014 13:16:11 +0800
Message-Id: <1389762974-14176-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For one PCI error relevant OPAL event, we possibly have multiple
EEH errors for that. For example, multiple frozen PEs detected on
different PHBs. Unfortunately, we didn't cover the case. The patch
enumarates the return value from eeh_ops::next_error() and change
eeh_handle_special_event() and eeh_ops::next_error() to handle all
existing EEH errors.

As Ben pointed out, we needn't list_for_each_entry_safe() since we
are not deleting any PHB from the hose_list and the EEH serialized
lock should be held while purging EEH events. The patch covers those
suggestions as well.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |   10 ++
 arch/powerpc/kernel/eeh_driver.c          |  150 +++++++++++++++--------------
 arch/powerpc/platforms/powernv/eeh-ioda.c |   39 +++++---
 3 files changed, 112 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d3e5e9b..e37db7f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -117,6 +117,16 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 	return edev ? edev->pdev : NULL;
 }
 
+/* Return values from eeh_ops::next_error */
+enum {
+	EEH_NEXT_ERR_NONE = 0,
+	EEH_NEXT_ERR_INF,
+	EEH_NEXT_ERR_FROZEN_PE,
+	EEH_NEXT_ERR_FENCED_PHB,
+	EEH_NEXT_ERR_DEAD_PHB,
+	EEH_NEXT_ERR_DEAD_IOC
+};
+
 /*
  * The struct is used to trace the registered EEH operation
  * callback functions. Actually, those operation callback
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 36bed5a..d3a132c 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -626,84 +626,90 @@ static void eeh_handle_special_event(void)
 {
 	struct eeh_pe *pe, *phb_pe;
 	struct pci_bus *bus;
-	struct pci_controller *hose, *tmp;
+	struct pci_controller *hose;
 	unsigned long flags;
-	int rc = 0;
+	int rc;
 
-	/*
-	 * The return value from next_error() has been classified as follows.
-	 * It might be good to enumerate them. However, next_error() is only
-	 * supported by PowerNV platform for now. So it would be fine to use
-	 * integer directly:
-	 *
-	 * 4 - Dead IOC           3 - Dead PHB
-	 * 2 - Fenced PHB         1 - Frozen PE
-	 * 0 - No error found
-	 *
-	 */
-	rc = eeh_ops->next_error(&pe);
-	if (rc <= 0)
-		return;
 
-	switch (rc) {
-	case 4:
-		/* Mark all PHBs in dead state */
-		eeh_serialize_lock(&flags);
-		list_for_each_entry_safe(hose, tmp,
-				&hose_list, list_node) {
-			phb_pe = eeh_phb_pe_get(hose);
-			if (!phb_pe) continue;
-
-			eeh_pe_state_mark(phb_pe,
-				EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+	do {
+		rc = eeh_ops->next_error(&pe);
+
+		switch (rc) {
+		case EEH_NEXT_ERR_DEAD_IOC:
+			/* Mark all PHBs in dead state */
+			eeh_serialize_lock(&flags);
+
+			/* Purge all events */
+			eeh_remove_event(NULL);
+
+			list_for_each_entry(hose, &hose_list, list_node) {
+				phb_pe = eeh_phb_pe_get(hose);
+				if (!phb_pe) continue;
+
+				eeh_pe_state_mark(phb_pe,
+					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+			}
+
+			eeh_serialize_unlock(flags);
+
+			break;
+		case EEH_NEXT_ERR_FROZEN_PE:
+		case EEH_NEXT_ERR_FENCED_PHB:
+		case EEH_NEXT_ERR_DEAD_PHB:
+			/* Mark the PE in fenced state */
+			eeh_serialize_lock(&flags);
+
+			/* Purge all events of the PHB */
+			eeh_remove_event(pe);
+
+			if (rc == EEH_NEXT_ERR_DEAD_PHB)
+				eeh_pe_state_mark(pe,
+					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+			else
+				eeh_pe_state_mark(pe,
+					EEH_PE_ISOLATED | EEH_PE_RECOVERING);
+
+			eeh_serialize_unlock(flags);
+
+			break;
+		case EEH_NEXT_ERR_NONE:
+			return;
+		default:
+			pr_warn("%s: Invalid value %d from next_error()\n",
+				__func__, rc);
+			return;
 		}
-		eeh_serialize_unlock(flags);
-
-		/* Purge all events */
-		eeh_remove_event(NULL);
-		break;
-	case 3:
-	case 2:
-	case 1:
-		/* Mark the PE in fenced state */
-		eeh_serialize_lock(&flags);
-		if (rc == 3)
-			eeh_pe_state_mark(pe,
-				EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
-		else
-			eeh_pe_state_mark(pe,
-				EEH_PE_ISOLATED | EEH_PE_RECOVERING);
-		eeh_serialize_unlock(flags);
-
-		/* Purge all events of the PHB */
-		eeh_remove_event(pe);
-		break;
-	default:
-		pr_err("%s: Invalid value %d from next_error()\n",
-		       __func__, rc);
-		return;
-	}
 
-	/*
-	 * For fenced PHB and frozen PE, it's handled as normal
-	 * event. We have to remove the affected PHBs for dead
-	 * PHB and IOC
-	 */
-	if (rc == 2 || rc == 1)
-		eeh_handle_normal_event(pe);
-	else {
-		list_for_each_entry_safe(hose, tmp,
-			&hose_list, list_node) {
-			phb_pe = eeh_phb_pe_get(hose);
-			if (!phb_pe || !(phb_pe->state & EEH_PE_PHB_DEAD))
-				continue;
-
-			bus = eeh_pe_bus_get(phb_pe);
-			/* Notify all devices that they're about to go down. */
-			eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
-			pcibios_remove_pci_devices(bus);
+		/*
+		 * For fenced PHB and frozen PE, it's handled as normal
+		 * event. We have to remove the affected PHBs for dead
+		 * PHB and IOC
+		 */
+		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
+		    rc == EEH_NEXT_ERR_FENCED_PHB) {
+			eeh_handle_normal_event(pe);
+		} else {
+			list_for_each_entry(hose, &hose_list, list_node) {
+				phb_pe = eeh_phb_pe_get(hose);
+				if (!phb_pe ||
+				    !(phb_pe->state & EEH_PE_PHB_DEAD))
+					continue;
+
+				/* Notify all devices to be down */
+				bus = eeh_pe_bus_get(phb_pe);
+				eeh_pe_dev_traverse(pe,
+					eeh_report_failure, NULL);
+				pcibios_remove_pci_devices(bus);
+			}
 		}
-	}
+
+		/*
+		 * If we have detected dead IOC, we needn't proceed
+		 * any more since all PHBs would have been removed
+		 */
+		if (rc == EEH_NEXT_ERR_DEAD_IOC)
+			break;
+	} while (rc != EEH_NEXT_ERR_NONE);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index d7ddcee..e0b12d0 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -884,12 +884,12 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
  */
 static int ioda_eeh_next_error(struct eeh_pe **pe)
 {
-	struct pci_controller *hose, *tmp;
+	struct pci_controller *hose;
 	struct pnv_phb *phb;
 	u64 frozen_pe_no;
 	u16 err_type, severity;
 	long rc;
-	int ret = 1;
+	int ret = EEH_NEXT_ERR_NONE;
 
 	/*
 	 * While running here, it's safe to purge the event queue.
@@ -899,7 +899,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	eeh_remove_event(NULL);
 	opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+	list_for_each_entry(hose, &hose_list, list_node) {
 		/*
 		 * If the subordinate PCI buses of the PHB has been
 		 * removed, we needn't take care of it any more.
@@ -938,19 +938,19 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		switch (err_type) {
 		case OPAL_EEH_IOC_ERROR:
 			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
-				list_for_each_entry_safe(hose, tmp,
-						&hose_list, list_node) {
+				list_for_each_entry(hose, &hose_list,
+						    list_node) {
 					phb = hose->private_data;
 					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				}
 
 				pr_err("EEH: dead IOC detected\n");
-				ret = 4;
-				goto out;
+				ret = EEH_NEXT_ERR_DEAD_IOC;
 			} else if (severity == OPAL_EEH_SEV_INF) {
 				pr_info("EEH: IOC informative error "
 					"detected\n");
 				ioda_eeh_hub_diag(hose);
+				ret = EEH_NEXT_ERR_NONE;
 			}
 
 			break;
@@ -962,21 +962,20 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				pr_err("EEH: dead PHB#%x detected\n",
 					hose->global_number);
 				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
-				ret = 3;
-				goto out;
+				ret = EEH_NEXT_ERR_DEAD_PHB;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
 				if (ioda_eeh_get_phb_pe(hose, pe))
 					break;
 
 				pr_err("EEH: fenced PHB#%x detected\n",
 					hose->global_number);
-				ret = 2;
-				goto out;
+				ret = EEH_NEXT_ERR_FENCED_PHB;
 			} else if (severity == OPAL_EEH_SEV_INF) {
 				pr_info("EEH: PHB#%x informative error "
 					"detected\n",
 					hose->global_number);
 				ioda_eeh_phb_diag(hose);
+				ret = EEH_NEXT_ERR_NONE;
 			}
 
 			break;
@@ -986,13 +985,23 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
 				(*pe)->addr, (*pe)->phb->global_number);
-			ret = 1;
-			goto out;
+			ret = EEH_NEXT_ERR_FROZEN_PE;
+			break;
+		default:
+			pr_warn("%s: Unexpected error type %d\n",
+				__func__, err_type);
 		}
+
+		/*
+		 * If we have no errors on the specific PHB or only
+		 * informative error there, we continue poking it.
+		 * Otherwise, we need actions to be taken by upper
+		 * layer.
+		 */
+		if (ret > EEH_NEXT_ERR_INF)
+			break;
 	}
 
-	ret = 0;
-out:
 	return ret;
 }
 
-- 
1.7.10.4
