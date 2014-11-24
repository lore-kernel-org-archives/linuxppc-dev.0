Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0398C1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:38:56 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5B55140185
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:38:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A97812BB0052
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMcrVF31326266
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcq5U015262
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/powernv: Refactor ioda_eeh_reset()
Date: Tue, 25 Nov 2014 09:38:44 +1100
Message-Id: <1416868727-5814-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch refactors ioda_eeh_reset() to avoid unnecessary nested
if statements, so that the code looks simplified to earn a bit
more readibility, no logic changed.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 58 ++++++++++++++-----------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index e5fa4ff..3b82384 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -679,8 +679,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb;
 	struct pci_bus *bus;
-	int ret;
+	s64 rc;
 
 	/*
 	 * For PHB reset, we always have complete reset. For those PEs whose
@@ -696,41 +697,34 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	 * reset. The side effect is that EEH core has to clear the frozen
 	 * state explicitly after BAR restore.
 	 */
-	if (pe->type & EEH_PE_PHB) {
-		ret = ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
-	} else {
-		struct pnv_phb *phb;
-		s64 rc;
+	if (pe->type & EEH_PE_PHB)
+		return ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
 
-		/*
-		 * The frozen PE might be caused by PAPR error injection
-		 * registers, which are expected to be cleared after hitting
-		 * frozen PE as stated in the hardware spec. Unfortunately,
-		 * that's not true on P7IOC. So we have to clear it manually
-		 * to avoid recursive EEH errors during recovery.
-		 */
-		phb = hose->private_data;
-		if (phb->model == PNV_PHB_MODEL_P7IOC &&
-		    (option == EEH_RESET_HOT ||
-		    option == EEH_RESET_FUNDAMENTAL)) {
-			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld clearing "
-					"error injection registers\n",
-					__func__, rc);
-				return -EIO;
-			}
+	/*
+	 * The frozen PE might be caused by PAPR error injection
+	 * registers, which are expected to be cleared after hitting
+	 * frozen PE as stated in the hardware spec. Unfortunately,
+	 * that's not true on P7IOC. So we have to clear it manually
+	 * to avoid recursive EEH errors during recovery.
+	 */
+	phb = hose->private_data;
+	if (phb->model == PNV_PHB_MODEL_P7IOC &&
+	    (option == EEH_RESET_HOT ||
+	     option == EEH_RESET_FUNDAMENTAL)) {
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Error %lld clearing error injection\n",
+				__func__, rc);
+			return -EIO;
 		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus))
-			ret = ioda_eeh_phb_reset(hose, option);
-		else
-			ret = ioda_eeh_bridge_reset(bus->self, option);
 	}
 
-	return ret;
+	bus = eeh_pe_bus_get(pe);
+	if (pci_is_root_bus(bus))
+		return ioda_eeh_phb_reset(hose, option);
+
+	return ioda_eeh_bridge_reset(bus->self, option);
 }
 
 /**
-- 
1.8.3.2
