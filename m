Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C637E2C008F
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 17:13:58 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 11 Jan 2014 23:13:56 -0700
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C97261FF001B
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 23:13:23 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0C6DeGD5439964
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 07:13:40 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0C6Drob004309
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 23:13:53 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/eeh: Handle multiple EEH errors
Date: Sun, 12 Jan 2014 14:13:44 +0800
Message-Id: <1389507226-32002-1-git-send-email-shangw@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |   10 ++
 arch/powerpc/kernel/eeh_driver.c          |  144 ++++++++++++++---------------
 arch/powerpc/platforms/powernv/eeh-ioda.c |   31 ++++---
 3 files changed, 102 insertions(+), 83 deletions(-)

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
index 36bed5a..c1e8bb9 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -628,82 +628,82 @@ static void eeh_handle_special_event(void)
 	struct pci_bus *bus;
 	struct pci_controller *hose, *tmp;
 	unsigned long flags;
-	int rc = 0;
-
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
+	int rc;
+
+
+	do {
+		rc = eeh_ops->next_error(&pe);
+
+		switch (rc) {
+		case EEH_NEXT_ERR_DEAD_IOC:
+			/* Mark all PHBs in dead state */
+			eeh_serialize_lock(&flags);
+			list_for_each_entry_safe(hose, tmp,
+					&hose_list, list_node) {
+				phb_pe = eeh_phb_pe_get(hose);
+				if (!phb_pe) continue;
+
+				eeh_pe_state_mark(phb_pe,
+					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+			}
+			eeh_serialize_unlock(flags);
+
+			/* Purge all events */
+			eeh_remove_event(NULL);
+			break;
+		case EEH_NEXT_ERR_FROZEN_PE:
+		case EEH_NEXT_ERR_FENCED_PHB:
+		case EEH_NEXT_ERR_DEAD_PHB:
+			/* Mark the PE in fenced state */
+			eeh_serialize_lock(&flags);
+			if (rc == EEH_NEXT_ERR_DEAD_PHB)
+				eeh_pe_state_mark(pe,
+					EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
+			else
+				eeh_pe_state_mark(pe,
+					EEH_PE_ISOLATED | EEH_PE_RECOVERING);
+			eeh_serialize_unlock(flags);
+
+			/* Purge all events of the PHB */
+			eeh_remove_event(pe);
+			break;
+		default:
+			pr_warn("%s: Invalid value %d from next_error()\n",
+				__func__, rc);
+			return;
+		}
 
-	switch (rc) {
-	case 4:
-		/* Mark all PHBs in dead state */
-		eeh_serialize_lock(&flags);
-		list_for_each_entry_safe(hose, tmp,
+		/*
+		 * For fenced PHB and frozen PE, it's handled as normal
+		 * event. We have to remove the affected PHBs for dead
+		 * PHB and IOC
+		 */
+		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
+		    rc == EEH_NEXT_ERR_FENCED_PHB) {
+			eeh_handle_normal_event(pe);
+		} else {
+			list_for_each_entry_safe(hose, tmp,
 				&hose_list, list_node) {
-			phb_pe = eeh_phb_pe_get(hose);
-			if (!phb_pe) continue;
-
-			eeh_pe_state_mark(phb_pe,
-				EEH_PE_ISOLATED | EEH_PE_PHB_DEAD);
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
-		}
-	}
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
index d7ddcee..6971146 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -889,7 +889,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	u64 frozen_pe_no;
 	u16 err_type, severity;
 	long rc;
-	int ret = 1;
+	int ret = EEH_NEXT_ERR_NONE;
 
 	/*
 	 * While running here, it's safe to purge the event queue.
@@ -945,12 +945,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				}
 
 				pr_err("EEH: dead IOC detected\n");
-				ret = 4;
-				goto out;
+				ret = EEH_NEXT_ERR_DEAD_IOC;
 			} else if (severity == OPAL_EEH_SEV_INF) {
 				pr_info("EEH: IOC informative error "
 					"detected\n");
 				ioda_eeh_hub_diag(hose);
+				ret = EEH_NEXT_ERR_INF;
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
+				ret = EEH_NEXT_ERR_INF;
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
