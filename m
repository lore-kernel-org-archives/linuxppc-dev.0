Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5BFD2C0228
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:10 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:07 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 546F56E804A
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:00 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c5tQ6029698
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:05 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c4mt019643
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:05 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] powerpc/powernv: Remove PNV_EEH_STATE_REMOVED
Date: Tue, 25 Feb 2014 13:37:43 +0800
Message-Id: <1393306670-17435-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PHB state PNV_EEH_STATE_REMOVED maintained in pnv_phb isn't
so useful any more and it's duplicated to EEH_PE_ISOLATED. The
patch replaces PNV_EEH_STATE_REMOVED with EEH_PE_ISOLATED.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   56 ++++++++---------------------
 arch/powerpc/platforms/powernv/pci.h      |    1 -
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index f514743..0d1d424 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -662,22 +662,6 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
 	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
 }
 
-static int ioda_eeh_get_phb_pe(struct pci_controller *hose,
-			       struct eeh_pe **pe)
-{
-	struct eeh_pe *phb_pe;
-
-	phb_pe = eeh_phb_pe_get(hose);
-	if (!phb_pe) {
-		pr_warning("%s Can't find PE for PHB#%d\n",
-			   __func__, hose->global_number);
-		return -EEXIST;
-	}
-
-	*pe = phb_pe;
-	return 0;
-}
-
 static int ioda_eeh_get_pe(struct pci_controller *hose,
 			   u16 pe_no, struct eeh_pe **pe)
 {
@@ -685,7 +669,8 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
 	struct eeh_dev dev;
 
 	/* Find the PHB PE */
-	if (ioda_eeh_get_phb_pe(hose, &phb_pe))
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe)
 		return -EEXIST;
 
 	/* Find the PE according to PE# */
@@ -713,6 +698,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
+	struct eeh_pe *phb_pe;
 	u64 frozen_pe_no;
 	u16 err_type, severity;
 	long rc;
@@ -729,10 +715,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	list_for_each_entry(hose, &hose_list, list_node) {
 		/*
 		 * If the subordinate PCI buses of the PHB has been
-		 * removed, we needn't take care of it any more.
+		 * removed or is exactly under error recovery, we
+		 * needn't take care of it any more.
 		 */
 		phb = hose->private_data;
-		if (phb->eeh_state & PNV_EEH_STATE_REMOVED)
+		phb_pe = eeh_phb_pe_get(hose);
+		if (!phb_pe || (phb_pe->state & EEH_PE_ISOLATED))
 			continue;
 
 		rc = opal_pci_next_error(phb->opal_id,
@@ -765,12 +753,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		switch (err_type) {
 		case OPAL_EEH_IOC_ERROR:
 			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
-				list_for_each_entry(hose, &hose_list,
-						    list_node) {
-					phb = hose->private_data;
-					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
-				}
-
 				pr_err("EEH: dead IOC detected\n");
 				ret = EEH_NEXT_ERR_DEAD_IOC;
 			} else if (severity == OPAL_EEH_SEV_INF) {
@@ -783,17 +765,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			break;
 		case OPAL_EEH_PHB_ERROR:
 			if (severity == OPAL_EEH_SEV_PHB_DEAD) {
-				if (ioda_eeh_get_phb_pe(hose, pe))
-					break;
-
+				*pe = phb_pe;
 				pr_err("EEH: dead PHB#%x detected\n",
 					hose->global_number);
-				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				ret = EEH_NEXT_ERR_DEAD_PHB;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
-				if (ioda_eeh_get_phb_pe(hose, pe))
-					break;
-
+				*pe = phb_pe;
 				pr_err("EEH: fenced PHB#%x detected\n",
 					hose->global_number);
 				ret = EEH_NEXT_ERR_FENCED_PHB;
@@ -813,15 +790,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			 * fenced PHB so that it can be recovered.
 			 */
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
-				if (!ioda_eeh_get_phb_pe(hose, pe)) {
-					pr_err("EEH: Escalated fenced PHB#%x "
-					       "detected for PE#%llx\n",
-						hose->global_number,
-						frozen_pe_no);
-					ret = EEH_NEXT_ERR_FENCED_PHB;
-				} else {
-					ret = EEH_NEXT_ERR_NONE;
-				}
+				*pe = phb_pe;
+				pr_err("EEH: Escalated fenced PHB#%x "
+				       "detected for PE#%llx\n",
+					hose->global_number,
+					frozen_pe_no);
+				ret = EEH_NEXT_ERR_FENCED_PHB;
 			} else {
 				pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
 					(*pe)->addr, (*pe)->phb->global_number);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index cde1694..6870f60 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -83,7 +83,6 @@ struct pnv_eeh_ops {
 };
 
 #define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
-#define PNV_EEH_STATE_REMOVED	(1 << 1)	/* PHB removed	*/
 
 #endif /* CONFIG_EEH */
 
-- 
1.7.10.4
