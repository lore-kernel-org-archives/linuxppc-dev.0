Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AD9E1A0221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:39 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 14:42:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 08F4D2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L4Jjdm10289632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:19:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L4gXam020686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/6] powerpc/powernv: Handle compound PE for EEH
Date: Mon, 21 Jul 2014 14:42:34 +1000
Message-Id: <1405917755-28830-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: yan@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch handles compound PE for EEH backend. If one specific
PE in compound group has been frozen, we enforces to freeze
all PEs in the group. If we're enable DMA or MMIO for one PE
in compound group, DMA or MMIO of all PEs in the group will be
enabled.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 125 +++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index a93faba..d98a9e9 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -187,10 +187,10 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
  */
 static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 {
-	s64 ret;
-	u32 pe_no;
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
+	int enable, ret = 0;
+	s64 rc;
 
 	/* Check on PE number */
 	if (pe->addr < 0 || pe->addr >= phb->ioda.total_pe) {
@@ -201,41 +201,38 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 		return -EINVAL;
 	}
 
-	pe_no = pe->addr;
 	switch (option) {
 	case EEH_OPT_DISABLE:
-		ret = -EEXIST;
-		break;
+		return -EPERM;
 	case EEH_OPT_ENABLE:
-		ret = 0;
-		break;
+		return 0;
 	case EEH_OPT_THAW_MMIO:
-		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
-				OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO);
-		if (ret) {
-			pr_warning("%s: Failed to enable MMIO for "
-				   "PHB#%x-PE#%x, err=%lld\n",
-				__func__, hose->global_number, pe_no, ret);
-			return -EIO;
-		}
-
+		enable = OPAL_EEH_ACTION_CLEAR_FREEZE_MMIO;
 		break;
 	case EEH_OPT_THAW_DMA:
-		ret = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
-				OPAL_EEH_ACTION_CLEAR_FREEZE_DMA);
-		if (ret) {
-			pr_warning("%s: Failed to enable DMA for "
-				   "PHB#%x-PE#%x, err=%lld\n",
-				__func__, hose->global_number, pe_no, ret);
-			return -EIO;
-		}
-
+		enable = OPAL_EEH_ACTION_CLEAR_FREEZE_DMA;
 		break;
 	default:
-		pr_warning("%s: Invalid option %d\n", __func__, option);
+		pr_warn("%s: Invalid option %d\n",
+			__func__, option);
 		return -EINVAL;
 	}
 
+	/* If PHB supports compound PE, to handle it */
+	if (phb->unfreeze_pe) {
+		ret = phb->unfreeze_pe(phb, pe->addr, enable);
+	} else {
+		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
+					       pe->addr,
+					       enable);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld enable %d for PHB#%x-PE#%x\n",
+				__func__, rc, option, phb->hose->global_number,
+				pe->addr);
+			ret = -EIO;
+		}
+	}
+
 	return ret;
 }
 
@@ -313,16 +310,23 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 		return result;
 	}
 
-	/* Fetch state from hardware */
-	rc = opal_pci_eeh_freeze_status(phb->opal_id,
-					pe->addr,
-					&fstate,
-					&pcierr,
-					NULL);
-	if (rc != OPAL_SUCCESS) {
-		pr_warn("%s: Failure %lld getting PHB#%x-PE%x state\n",
-			__func__, rc, phb->hose->global_number, pe->addr);
-		return EEH_STATE_NOT_SUPPORT;
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
+				__func__, rc, phb->hose->global_number, pe->addr);
+			return EEH_STATE_NOT_SUPPORT;
+		}
 	}
 
 	/* Figure out state */
@@ -361,6 +365,9 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 	}
 
 	/*
+	 * If PHB supports compound PE, to freeze all
+	 * slave PEs for consistency.
+	 *
 	 * If the PE is switching to frozen state for the
 	 * first time, to dump the PHB diag-data.
 	 */
@@ -369,6 +376,9 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 	    !(result & EEH_STATE_MMIO_ACTIVE) &&
 	    !(result & EEH_STATE_DMA_ACTIVE)  &&
 	    !(pe->state & EEH_PE_ISOLATED)) {
+		if (phb->freeze_pe)
+			phb->freeze_pe(phb, pe->addr);
+
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		ioda_eeh_phb_diag(phb->hose);
 	}
@@ -696,22 +706,43 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 static int ioda_eeh_get_pe(struct pci_controller *hose,
 			   u16 pe_no, struct eeh_pe **pe)
 {
-	struct eeh_pe *phb_pe, *dev_pe;
-	struct eeh_dev dev;
+	struct pnv_phb *phb = hose->private_data;
+	struct pnv_ioda_pe *pnv_pe;
+	struct eeh_pe *dev_pe;
+	struct eeh_dev edev;
 
-	/* Find the PHB PE */
-	phb_pe = eeh_phb_pe_get(hose);
-	if (!phb_pe)
-		return -EEXIST;
+	/*
+	 * If PHB supports compound PE, to fetch
+	 * the master PE because slave PE is invisible
+	 * to EEH core.
+	 */
+	if (phb->get_pe_state) {
+		pnv_pe = &phb->ioda.pe_array[pe_no];
+		if (pnv_pe->flags & PNV_IODA_PE_SLAVE) {
+			pnv_pe = pnv_pe->master;
+			WARN_ON(!pnv_pe ||
+				!(pnv_pe->flags & PNV_IODA_PE_MASTER));
+			pe_no = pnv_pe->pe_number;
+		}
+	}
 
 	/* Find the PE according to PE# */
-	memset(&dev, 0, sizeof(struct eeh_dev));
-	dev.phb = hose;
-	dev.pe_config_addr = pe_no;
-	dev_pe = eeh_pe_get(&dev);
-	if (!dev_pe) return -EEXIST;
+	memset(&edev, 0, sizeof(struct eeh_dev));
+	edev.phb = hose;
+	edev.pe_config_addr = pe_no;
+	dev_pe = eeh_pe_get(&edev);
+	if (!dev_pe)
+		return -EEXIST;
 
+	/*
+	 * At this point, we're sure the compound PE should
+	 * be put into frozen state.
+	 */
 	*pe = dev_pe;
+	if (phb->freeze_pe &&
+	    !(dev_pe->state & EEH_PE_ISOLATED))
+		phb->freeze_pe(phb, pe_no);
+
 	return 0;
 }
 
-- 
1.8.3.2
