Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB00D1A03B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:27 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BEA914027F
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 18CFC2BB0052
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3lEBD40698048
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3knbr021546
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/10] powerpc/powernv: Drop PHB operation get_state()
Date: Mon, 16 Feb 2015 14:45:45 +1100
Message-Id: <1424058348-28951-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation get_state() and merges its logic
to eeh_ops::get_state().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 170 +-----------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 185 ++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci.h         |   1 -
 3 files changed, 170 insertions(+), 186 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 349c083..dc34c36 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -46,173 +46,6 @@ static void ioda_eeh_phb_diag(struct eeh_pe *pe)
 			__func__, pe->phb->global_number, rc);
 }
 
-static int ioda_eeh_get_phb_state(struct eeh_pe *pe)
-{
-	struct pnv_phb *phb = pe->phb->private_data;
-	u8 fstate;
-	__be16 pcierr;
-	s64 rc;
-	int result = 0;
-
-	rc = opal_pci_eeh_freeze_status(phb->opal_id,
-					pe->addr,
-					&fstate,
-					&pcierr,
-					NULL);
-	if (rc != OPAL_SUCCESS) {
-		pr_warn("%s: Failure %lld getting PHB#%x state\n",
-			__func__, rc, phb->hose->global_number);
-		return EEH_STATE_NOT_SUPPORT;
-	}
-
-	/*
-	 * Check PHB state. If the PHB is frozen for the
-	 * first time, to dump the PHB diag-data.
-	 */
-	if (be16_to_cpu(pcierr) != OPAL_EEH_PHB_ERROR) {
-		result = (EEH_STATE_MMIO_ACTIVE  |
-			  EEH_STATE_DMA_ACTIVE   |
-			  EEH_STATE_MMIO_ENABLED |
-			  EEH_STATE_DMA_ENABLED);
-	} else if (!(pe->state & EEH_PE_ISOLATED)) {
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-		ioda_eeh_phb_diag(pe);
-
-		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
-			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
-	}
-
-	return result;
-}
-
-static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
-{
-	struct pnv_phb *phb = pe->phb->private_data;
-	u8 fstate;
-	__be16 pcierr;
-	s64 rc;
-	int result;
-
-	/*
-	 * We don't clobber hardware frozen state until PE
-	 * reset is completed. In order to keep EEH core
-	 * moving forward, we have to return operational
-	 * state during PE reset.
-	 */
-	if (pe->state & EEH_PE_RESET) {
-		result = (EEH_STATE_MMIO_ACTIVE  |
-			  EEH_STATE_DMA_ACTIVE   |
-			  EEH_STATE_MMIO_ENABLED |
-			  EEH_STATE_DMA_ENABLED);
-		return result;
-	}
-
-	/*
-	 * Fetch PE state from hardware. If the PHB
-	 * supports compound PE, let it handle that.
-	 */
-	if (phb->get_pe_state) {
-		fstate = phb->get_pe_state(phb, pe->addr);
-	} else {
-		rc = opal_pci_eeh_freeze_status(phb->opal_id,
-						pe->addr,
-						&fstate,
-						&pcierr,
-						NULL);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("%s: Failure %lld getting PHB#%x-PE%x state\n",
-				__func__, rc, phb->hose->global_number, pe->addr);
-			return EEH_STATE_NOT_SUPPORT;
-		}
-	}
-
-	/* Figure out state */
-	switch (fstate) {
-	case OPAL_EEH_STOPPED_NOT_FROZEN:
-		result = (EEH_STATE_MMIO_ACTIVE  |
-			  EEH_STATE_DMA_ACTIVE   |
-			  EEH_STATE_MMIO_ENABLED |
-			  EEH_STATE_DMA_ENABLED);
-		break;
-	case OPAL_EEH_STOPPED_MMIO_FREEZE:
-		result = (EEH_STATE_DMA_ACTIVE |
-			  EEH_STATE_DMA_ENABLED);
-		break;
-	case OPAL_EEH_STOPPED_DMA_FREEZE:
-		result = (EEH_STATE_MMIO_ACTIVE |
-			  EEH_STATE_MMIO_ENABLED);
-		break;
-	case OPAL_EEH_STOPPED_MMIO_DMA_FREEZE:
-		result = 0;
-		break;
-	case OPAL_EEH_STOPPED_RESET:
-		result = EEH_STATE_RESET_ACTIVE;
-		break;
-	case OPAL_EEH_STOPPED_TEMP_UNAVAIL:
-		result = EEH_STATE_UNAVAILABLE;
-		break;
-	case OPAL_EEH_STOPPED_PERM_UNAVAIL:
-		result = EEH_STATE_NOT_SUPPORT;
-		break;
-	default:
-		result = EEH_STATE_NOT_SUPPORT;
-		pr_warn("%s: Invalid PHB#%x-PE#%x state %x\n",
-			__func__, phb->hose->global_number,
-			pe->addr, fstate);
-	}
-
-	/*
-	 * If PHB supports compound PE, to freeze all
-	 * slave PEs for consistency.
-	 *
-	 * If the PE is switching to frozen state for the
-	 * first time, to dump the PHB diag-data.
-	 */
-	if (!(result & EEH_STATE_NOT_SUPPORT) &&
-	    !(result & EEH_STATE_UNAVAILABLE) &&
-	    !(result & EEH_STATE_MMIO_ACTIVE) &&
-	    !(result & EEH_STATE_DMA_ACTIVE)  &&
-	    !(pe->state & EEH_PE_ISOLATED)) {
-		if (phb->freeze_pe)
-			phb->freeze_pe(phb, pe->addr);
-
-		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-		ioda_eeh_phb_diag(pe);
-
-		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
-			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
-	}
-
-	return result;
-}
-
-/**
- * ioda_eeh_get_state - Retrieve the state of PE
- * @pe: EEH PE
- *
- * The PE's state should be retrieved from the PEEV, PEST
- * IODA tables. Since the OPAL has exported the function
- * to do it, it'd better to use that.
- */
-static int ioda_eeh_get_state(struct eeh_pe *pe)
-{
-	struct pnv_phb *phb = pe->phb->private_data;
-
-	/* Sanity check on PE number. PHB PE should have 0 */
-	if (pe->addr < 0 ||
-	    pe->addr >= phb->ioda.total_pe) {
-		pr_warn("%s: PHB#%x-PE#%x out of range [0, %x]\n",
-			__func__, phb->hose->global_number,
-			pe->addr, phb->ioda.total_pe);
-		return EEH_STATE_NOT_SUPPORT;
-	}
-
-	if (pe->type & EEH_PE_PHB)
-		return ioda_eeh_get_phb_state(pe);
-
-	return ioda_eeh_get_pe_state(pe);
-}
-
 static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 {
 	s64 rc = OPAL_HARDWARE;
@@ -759,7 +592,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					break;
 
 				/* Frozen parent PE ? */
-				state = ioda_eeh_get_state(parent_pe);
+				state = eeh_ops->get_state(parent_pe, NULL);
 				if (state > 0 &&
 				    (state & active_flags) != active_flags)
 					*pe = parent_pe;
@@ -786,7 +619,6 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 }
 
 struct pnv_eeh_ops ioda_eeh_ops = {
-	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 2429a23..127ef0c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -478,6 +478,159 @@ static int pnv_eeh_get_pe_addr(struct eeh_pe *pe)
 	return pe->addr;
 }
 
+static void pnv_eeh_get_phb_diag(struct eeh_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb->private_data;
+	s64 rc;
+
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, pe->data,
+					 PNV_PCI_DIAG_BUF_SIZE);
+	if (rc != OPAL_SUCCESS)
+		pr_warn("%s: Failure %lld getting PHB#%x diag-data\n",
+			__func__, rc, pe->phb->global_number);
+}
+
+static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb->private_data;
+	u8 fstate;
+	__be16 pcierr;
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
+		return EEH_STATE_NOT_SUPPORT;
+	}
+
+	/*
+	 * Check PHB state. If the PHB is frozen for the
+	 * first time, to dump the PHB diag-data.
+	 */
+	if (be16_to_cpu(pcierr) != OPAL_EEH_PHB_ERROR) {
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
+	} else if (!(pe->state & EEH_PE_ISOLATED)) {
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		pnv_eeh_get_phb_diag(pe);
+
+		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
+			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
+	}
+
+	return result;
+}
+
+static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb->private_data;
+	u8 fstate;
+	__be16 pcierr;
+	s64 rc;
+	int result;
+
+	/*
+	 * We don't clobber hardware frozen state until PE
+	 * reset is completed. In order to keep EEH core
+	 * moving forward, we have to return operational
+	 * state during PE reset.
+	 */
+	if (pe->state & EEH_PE_RESET) {
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
+		return result;
+	}
+
+	/*
+	 * Fetch PE state from hardware. If the PHB
+	 * supports compound PE, let it handle that.
+	 */
+	if (phb->get_pe_state) {
+		fstate = phb->get_pe_state(phb, pe->addr);
+	} else {
+		rc = opal_pci_eeh_freeze_status(phb->opal_id,
+						pe->addr,
+						&fstate,
+						&pcierr,
+						NULL);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld getting PHB#%x-PE%x state\n",
+				__func__, rc, phb->hose->global_number,
+				pe->addr);
+			return EEH_STATE_NOT_SUPPORT;
+		}
+	}
+
+	/* Figure out state */
+	switch (fstate) {
+	case OPAL_EEH_STOPPED_NOT_FROZEN:
+		result = (EEH_STATE_MMIO_ACTIVE  |
+			  EEH_STATE_DMA_ACTIVE   |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
+		break;
+	case OPAL_EEH_STOPPED_MMIO_FREEZE:
+		result = (EEH_STATE_DMA_ACTIVE |
+			  EEH_STATE_DMA_ENABLED);
+		break;
+	case OPAL_EEH_STOPPED_DMA_FREEZE:
+		result = (EEH_STATE_MMIO_ACTIVE |
+			  EEH_STATE_MMIO_ENABLED);
+		break;
+	case OPAL_EEH_STOPPED_MMIO_DMA_FREEZE:
+		result = 0;
+		break;
+	case OPAL_EEH_STOPPED_RESET:
+		result = EEH_STATE_RESET_ACTIVE;
+		break;
+	case OPAL_EEH_STOPPED_TEMP_UNAVAIL:
+		result = EEH_STATE_UNAVAILABLE;
+		break;
+	case OPAL_EEH_STOPPED_PERM_UNAVAIL:
+		result = EEH_STATE_NOT_SUPPORT;
+		break;
+	default:
+		result = EEH_STATE_NOT_SUPPORT;
+		pr_warn("%s: Invalid PHB#%x-PE#%x state %x\n",
+			__func__, phb->hose->global_number,
+			pe->addr, fstate);
+	}
+
+	/*
+	 * If PHB supports compound PE, to freeze all
+	 * slave PEs for consistency.
+	 *
+	 * If the PE is switching to frozen state for the
+	 * first time, to dump the PHB diag-data.
+	 */
+	if (!(result & EEH_STATE_NOT_SUPPORT) &&
+	    !(result & EEH_STATE_UNAVAILABLE) &&
+	    !(result & EEH_STATE_MMIO_ACTIVE) &&
+	    !(result & EEH_STATE_DMA_ACTIVE)  &&
+	    !(pe->state & EEH_PE_ISOLATED)) {
+		if (phb->freeze_pe)
+			phb->freeze_pe(phb, pe->addr);
+
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
+		pnv_eeh_get_phb_diag(pe);
+
+		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
+			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
+	}
+
+	return result;
+}
+
 /**
  * pnv_eeh_get_state - Retrieve PE state
  * @pe: EEH PE
@@ -490,24 +643,24 @@ static int pnv_eeh_get_pe_addr(struct eeh_pe *pe)
  */
 static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 {
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	int ret = EEH_STATE_NOT_SUPPORT;
+	int ret;
 
-	if (phb->eeh_ops && phb->eeh_ops->get_state) {
-		ret = phb->eeh_ops->get_state(pe);
+	if (pe->type & EEH_PE_PHB)
+		ret = pnv_eeh_get_phb_state(pe);
+	else
+		ret = pnv_eeh_get_pe_state(pe);
 
-		/*
-		 * If the PE state is temporarily unavailable,
-		 * to inform the EEH core delay for default
-		 * period (1 second)
-		 */
-		if (delay) {
-			*delay = 0;
-			if (ret & EEH_STATE_UNAVAILABLE)
-				*delay = 1000;
-		}
-	}
+	if (!delay)
+		return ret;
+
+	/*
+	 * If the PE state is temporarily unavailable,
+	 * to inform the EEH core delay for default
+	 * period (1 second)
+	 */
+	*delay = 0;
+	if (ret & EEH_STATE_UNAVAILABLE)
+		*delay = 1000;
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8043dee..773a026 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,7 +78,6 @@ struct pnv_ioda_pe {
 /* IOC dependent EEH operations */
 #ifdef CONFIG_EEH
 struct pnv_eeh_ops {
-	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
 	int (*next_error)(struct eeh_pe **pe);
 };
-- 
1.8.3.2
