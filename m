Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8B1B140158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ABE3E2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dV5t53674066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80OoB023186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:24 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 02/25] powerpc/powernv: Remove PNV_EEH_STATE_REMOVED
Date: Thu, 24 Apr 2014 18:00:08 +1000
Message-Id: <1398326431-24305-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 56 +++++++++----------------------
 arch/powerpc/platforms/powernv/pci.h      |  1 -
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 253fefe..5432598 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -639,22 +639,6 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 	}
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
@@ -662,7 +646,8 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
 	struct eeh_dev dev;
 
 	/* Find the PHB PE */
-	if (ioda_eeh_get_phb_pe(hose, &phb_pe))
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe)
 		return -EEXIST;
 
 	/* Find the PE according to PE# */
@@ -690,6 +675,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
+	struct eeh_pe *phb_pe;
 	u64 frozen_pe_no;
 	u16 err_type, severity;
 	long rc;
@@ -706,10 +692,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
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
@@ -742,12 +730,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
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
@@ -760,17 +742,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
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
@@ -790,15 +767,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
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
1.8.3.2
