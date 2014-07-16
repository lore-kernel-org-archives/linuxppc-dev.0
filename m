Return-Path: <yan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF06E1A0223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:48 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <yan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 22:24:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 79DB92BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6GC21EG1180148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:02:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6GCOiaW014805
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:45 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/6] powerpc/powernv: Split ioda_eeh_get_state()
Date: Wed, 16 Jul 2014 20:24:32 +0800
Message-Id: <1405513475-24220-4-git-send-email-yan@linux.vnet.ibm.com>
In-Reply-To: <1405513475-24220-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1405513475-24220-1-git-send-email-yan@linux.vnet.ibm.com>
Cc: yan@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

Function ioda_eeh_get_state() is used to fetch EEH state for PHB
or PE. We're going to support compound PE and the function becomes
more complicated with that. The patch splits the function into two
functions for PHB and PE cases separately to improve readability.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 186 +++++++++++++++++-------------
 1 file changed, 105 insertions(+), 81 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index b3b4bc2..dd20ba8 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -255,130 +255,154 @@ static void ioda_eeh_phb_diag(struct pci_controller *hose)
 	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
 }
 
-/**
- * ioda_eeh_get_state - Retrieve the state of PE
- * @pe: EEH PE
- *
- * The PE's state should be retrieved from the PEEV, PEST
- * IODA tables. Since the OPAL has exported the function
- * to do it, it'd better to use that.
- */
-static int ioda_eeh_get_state(struct eeh_pe *pe)
+static int ioda_eeh_get_phb_state(struct eeh_pe *pe)
 {
-	s64 ret = 0;
+	struct pnv_phb *phb = pe->phb->private_data;
 	u8 fstate;
 	__be16 pcierr;
-	u32 pe_no;
-	int result;
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
+	s64 rc;
+	int result = 0;
+
+	rc = opal_pci_eeh_freeze_status(phb->opal_id,
+					pe->addr,
+					&fstate,
+					&pcierr,
+					NULL);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld getting PHB#%x state\n",
+			__func__, rc, phb->hose->global_number);
+                return EEH_STATE_NOT_SUPPORT;
+        }
 
 	/*
-	 * Sanity check on PE address. The PHB PE address should
-	 * be zero.
+	 * Check PHB state. If the PHB is frozen for the
+	 * first time, to dump the PHB diag-data.
 	 */
-	if (pe->addr < 0 || pe->addr >= phb->ioda.total_pe) {
-		pr_err("%s: PE address %x out of range [0, %x] "
-		       "on PHB#%x\n",
-		       __func__, pe->addr, phb->ioda.total_pe,
-		       hose->global_number);
-		return EEH_STATE_NOT_SUPPORT;
+	if (be16_to_cpu(pcierr) != OPAL_EEH_PHB_ERROR) {
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
+	} else if (!(pe->state & EEH_PE_ISOLATED)) {
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		ioda_eeh_phb_diag(phb->hose);
 	}
 
+	return result;
+}
+
+static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb->private_data;
+	u8 fstate;
+	__be16 pcierr;
+	s64 rc;
+	int result;
+
 	/*
-	 * If we're in middle of PE reset, return normal
-	 * state to keep EEH core going. For PHB reset, we
-	 * still expect to have fenced PHB cleared with
-	 * PHB reset.
+	 * We don't clobber hardware frozen state until PE
+	 * reset is completed. In order to keep EEH core
+	 * moving forward, we have to return operational
+	 * state during PE reset.
 	 */
-	if (!(pe->type & EEH_PE_PHB) &&
-	    (pe->state & EEH_PE_RESET)) {
-		result = (EEH_STATE_MMIO_ACTIVE |
-			  EEH_STATE_DMA_ACTIVE |
+	if (pe->state & EEH_PE_RESET) {
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
 			  EEH_STATE_MMIO_ENABLED |
 			  EEH_STATE_DMA_ENABLED);
 		return result;
 	}
 
-	/* Retrieve PE status through OPAL */
-	pe_no = pe->addr;
-	ret = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
-			&fstate, &pcierr, NULL);
-	if (ret) {
-		pr_err("%s: Failed to get EEH status on "
-		       "PHB#%x-PE#%x\n, err=%lld\n",
-		       __func__, hose->global_number, pe_no, ret);
+	/* Fetch state from hardware */
+	rc = opal_pci_eeh_freeze_status(phb->opal_id,
+					pe->addr,
+					&fstate,
+					&pcierr,
+					NULL);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld getting PHB#%x-PE%x state\n",
+			__func__, rc, phb->hose->global_number, pe->addr);
 		return EEH_STATE_NOT_SUPPORT;
 	}
 
-	/* Check PHB status */
-	if (pe->type & EEH_PE_PHB) {
-		result = 0;
-		result &= ~EEH_STATE_RESET_ACTIVE;
-
-		if (be16_to_cpu(pcierr) != OPAL_EEH_PHB_ERROR) {
-			result |= EEH_STATE_MMIO_ACTIVE;
-			result |= EEH_STATE_DMA_ACTIVE;
-			result |= EEH_STATE_MMIO_ENABLED;
-			result |= EEH_STATE_DMA_ENABLED;
-		} else if (!(pe->state & EEH_PE_ISOLATED)) {
-			eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-			ioda_eeh_phb_diag(hose);
-		}
-
-		return result;
-	}
-
-	/* Parse result out */
-	result = 0;
+	/* Figure out state */
 	switch (fstate) {
 	case OPAL_EEH_STOPPED_NOT_FROZEN:
-		result &= ~EEH_STATE_RESET_ACTIVE;
-		result |= EEH_STATE_MMIO_ACTIVE;
-		result |= EEH_STATE_DMA_ACTIVE;
-		result |= EEH_STATE_MMIO_ENABLED;
-		result |= EEH_STATE_DMA_ENABLED;
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
 		break;
 	case OPAL_EEH_STOPPED_MMIO_FREEZE:
-		result &= ~EEH_STATE_RESET_ACTIVE;
-		result |= EEH_STATE_DMA_ACTIVE;
-		result |= EEH_STATE_DMA_ENABLED;
+		result = (EEH_STATE_DMA_ACTIVE |
+			  EEH_STATE_DMA_ENABLED);
 		break;
 	case OPAL_EEH_STOPPED_DMA_FREEZE:
-		result &= ~EEH_STATE_RESET_ACTIVE;
-		result |= EEH_STATE_MMIO_ACTIVE;
-		result |= EEH_STATE_MMIO_ENABLED;
+		result = (EEH_STATE_MMIO_ACTIVE |
+			  EEH_STATE_MMIO_ENABLED);
 		break;
 	case OPAL_EEH_STOPPED_MMIO_DMA_FREEZE:
-		result &= ~EEH_STATE_RESET_ACTIVE;
+		result = 0;
 		break;
 	case OPAL_EEH_STOPPED_RESET:
-		result |= EEH_STATE_RESET_ACTIVE;
+		result = EEH_STATE_RESET_ACTIVE;
 		break;
 	case OPAL_EEH_STOPPED_TEMP_UNAVAIL:
-		result |= EEH_STATE_UNAVAILABLE;
+		result = EEH_STATE_UNAVAILABLE;
 		break;
 	case OPAL_EEH_STOPPED_PERM_UNAVAIL:
-		result |= EEH_STATE_NOT_SUPPORT;
+		result = EEH_STATE_NOT_SUPPORT;
 		break;
 	default:
-		pr_warning("%s: Unexpected EEH status 0x%x "
-			   "on PHB#%x-PE#%x\n",
-			   __func__, fstate, hose->global_number, pe_no);
+		result = EEH_STATE_NOT_SUPPORT;
+		pr_warn("%s: Invalid PHB#%x-PE#%x state %x\n",
+			__func__, phb->hose->global_number,
+			pe->addr, fstate);
 	}
 
-	/* Dump PHB diag-data for frozen PE */
-	if (result != EEH_STATE_NOT_SUPPORT &&
-	    (result & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) !=
-	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE) &&
+	/*
+	 * If the PE is switching to frozen state for the
+	 * first time, to dump the PHB diag-data.
+	 */
+	if (!(result & EEH_STATE_NOT_SUPPORT) &&
+	    !(result & EEH_STATE_UNAVAILABLE) &&
+	    !(result & EEH_STATE_MMIO_ACTIVE) &&
+	    !(result & EEH_STATE_DMA_ACTIVE)  &&
 	    !(pe->state & EEH_PE_ISOLATED)) {
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-		ioda_eeh_phb_diag(hose);
+		ioda_eeh_phb_diag(phb->hose);
 	}
 
 	return result;
 }
 
+/**
+ * ioda_eeh_get_state - Retrieve the state of PE
+ * @pe: EEH PE
+ *
+ * The PE's state should be retrieved from the PEEV, PEST
+ * IODA tables. Since the OPAL has exported the function
+ * to do it, it'd better to use that.
+ */
+static int ioda_eeh_get_state(struct eeh_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb->private_data;
+
+	/* Sanity check on PE number. PHB PE should have 0 */
+	if (pe->addr < 0 ||
+	    pe->addr >= phb->ioda.total_pe) {
+		pr_warn("%s: PHB#%x-PE#%x out of range [0, %x]\n",
+			__func__, phb->hose->global_number,
+			pe->addr, phb->ioda.total_pe);
+		return EEH_STATE_NOT_SUPPORT;
+	}
+
+	if (pe->type & EEH_PE_PHB)
+		return ioda_eeh_get_phb_state(pe);
+
+	return ioda_eeh_get_pe_state(pe);
+}
+
 static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 {
 	s64 rc = OPAL_HARDWARE;
-- 
1.9.1
