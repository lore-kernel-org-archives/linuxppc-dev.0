Return-Path: <yan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBDA1A024A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:52 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <yan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 22:24:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 63C793578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:49 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6GC81JP19660800
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:08:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6GCOmLM014887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:24:48 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/6] powerpc/powernv: Handle compound PE in config accessors
Date: Wed, 16 Jul 2014 20:24:35 +0800
Message-Id: <1405513475-24220-7-git-send-email-yan@linux.vnet.ibm.com>
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

The PCI config accessors check for PE frozen state and clear it if
EEH isn't functional. The patch handles compound PE in config accessors
if PHB supports it. For consistency, all PEs will be put into frozen
state if any one in compound group gets frozen by hardware.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 89 ++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 02f4bd9..353e35b 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -319,43 +319,52 @@ void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
 {
 	unsigned long flags, rc;
-	int has_diag;
+	int has_diag, ret = 0;
 
 	spin_lock_irqsave(&phb->lock, flags);
 
+	/* Fetch PHB diag-data */
 	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
 					 PNV_PCI_DIAG_BUF_SIZE);
 	has_diag = (rc == OPAL_SUCCESS);
 
-	rc = opal_pci_eeh_freeze_set(phb->opal_id, pe_no,
-				     OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-	if (rc) {
-		pr_warning("PCI %d: Failed to clear EEH freeze state"
-			   " for PE#%d, err %ld\n",
-			   phb->hose->global_number, pe_no, rc);
-
-		/* For now, let's only display the diag buffer when we fail to clear
-		 * the EEH status. We'll do more sensible things later when we have
-		 * proper EEH support. We need to make sure we don't pollute ourselves
-		 * with the normal errors generated when probing empty slots
-		 */
-		if (has_diag)
-			pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
-		else
-			pr_warning("PCI %d: No diag data available\n",
-				   phb->hose->global_number);
+	/* If PHB supports compound PE, to handle it */
+	if (phb->unfreeze_pe) {
+		ret = phb->unfreeze_pe(phb,
+				       pe_no,
+				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	} else {
+		rc = opal_pci_eeh_freeze_set(phb->opal_id,
+					     pe_no,
+					     OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		if (rc) {
+			pr_warn("%s: Failure %ld clearing frozen "
+				"PHB#%x-PE#%x\n",
+				__func__, rc, phb->hose->global_number,
+				pe_no);
+			ret = -EIO;
+		}
 	}
 
+	/*
+	 * For now, let's only display the diag buffer when we fail to clear
+	 * the EEH status. We'll do more sensible things later when we have
+	 * proper EEH support. We need to make sure we don't pollute ourselves
+	 * with the normal errors generated when probing empty slots
+	 */
+	if (has_diag && ret)
+		pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
+
 	spin_unlock_irqrestore(&phb->lock, flags);
 }
 
 static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 				     struct device_node *dn)
 {
-	s64	rc;
 	u8	fstate;
 	__be16	pcierr;
-	u32	pe_no;
+	int	pe_no;
+	s64	rc;
 
 	/*
 	 * Get the PE#. During the PCI probe stage, we might not
@@ -370,20 +379,42 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 			pe_no = phb->ioda.reserved_pe;
 	}
 
-	/* Read freeze status */
-	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no, &fstate, &pcierr,
-					NULL);
-	if (rc) {
-		pr_warning("%s: Can't read EEH status (PE#%d) for "
-			   "%s, err %lld\n",
-			   __func__, pe_no, dn->full_name, rc);
-		return;
+	/*
+	 * Fetch frozen state. If the PHB support compound PE,
+	 * we need handle that case.
+	 */
+	if (phb->get_pe_state) {
+		fstate = phb->get_pe_state(phb, pe_no);
+	} else {
+		rc = opal_pci_eeh_freeze_status(phb->opal_id,
+						pe_no,
+						&fstate,
+						&pcierr,
+						NULL);
+		if (rc) {
+			pr_warn("%s: Failure %lld getting PHB#%x-PE#%x state\n",
+				__func__, rc, phb->hose->global_number, pe_no);
+			return;
+		}
 	}
+
 	cfg_dbg(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
 		(PCI_DN(dn)->busno << 8) | (PCI_DN(dn)->devfn),
 		pe_no, fstate);
-	if (fstate != 0)
+
+	/* Clear the frozen state if applicable */
+	if (fstate == OPAL_EEH_STOPPED_MMIO_FREEZE ||
+	    fstate == OPAL_EEH_STOPPED_DMA_FREEZE  ||
+	    fstate == OPAL_EEH_STOPPED_MMIO_DMA_FREEZE) {
+		/*
+		 * If PHB supports compound PE, freeze it for
+		 * consistency.
+		 */
+		if (phb->freeze_pe)
+			phb->freeze_pe(phb, pe_no);
+
 		pnv_pci_handle_eeh_config(phb, pe_no);
+	}
 }
 
 int pnv_pci_cfg_read(struct device_node *dn,
-- 
1.9.1
