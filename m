Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8C351A0A44
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:09 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 11:09:07 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1A8A02BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:04 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N0oqRX23724276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 10:50:53 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N193aX017004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/powernv: Sync OpalPciResetScope with firmware
Date: Tue, 23 Sep 2014 11:09:02 +1000
Message-Id: <1411434544-10025-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The names of PCI reset scopes aren't sychronized with firmware.
The patch fixes it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           |  9 ++++++---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 12 ++++++------
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9113653..bdf9f61 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -385,9 +385,12 @@ enum OpalM64EnableAction {
 };
 
 enum OpalPciResetScope {
-	OPAL_PHB_COMPLETE = 1, OPAL_PCI_LINK = 2, OPAL_PHB_ERROR = 3,
-	OPAL_PCI_HOT_RESET = 4, OPAL_PCI_FUNDAMENTAL_RESET = 5,
-	OPAL_PCI_IODA_TABLE_RESET = 6,
+	OPAL_RESET_PHB_COMPLETE		= 1,
+	OPAL_RESET_PCI_LINK		= 2,
+	OPAL_RESET_PHB_ERROR		= 3,
+	OPAL_RESET_PCI_HOT		= 4,
+	OPAL_RESET_PCI_FUNDAMENTAL	= 5,
+	OPAL_RESET_PCI_IODA_TABLE	= 6
 };
 
 enum OpalPciReinitScope {
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 729e445..f248586 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -514,11 +514,11 @@ int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 	if (option == EEH_RESET_FUNDAMENTAL ||
 	    option == EEH_RESET_HOT)
 		rc = opal_pci_reset(phb->opal_id,
-				OPAL_PHB_COMPLETE,
+				OPAL_RESET_PHB_COMPLETE,
 				OPAL_ASSERT_RESET);
 	else if (option == EEH_RESET_DEACTIVATE)
 		rc = opal_pci_reset(phb->opal_id,
-				OPAL_PHB_COMPLETE,
+				OPAL_RESET_PHB_COMPLETE,
 				OPAL_DEASSERT_RESET);
 	if (rc < 0)
 		goto out;
@@ -558,15 +558,15 @@ static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
 	 */
 	if (option == EEH_RESET_FUNDAMENTAL)
 		rc = opal_pci_reset(phb->opal_id,
-				OPAL_PCI_FUNDAMENTAL_RESET,
+				OPAL_RESET_PCI_FUNDAMENTAL,
 				OPAL_ASSERT_RESET);
 	else if (option == EEH_RESET_HOT)
 		rc = opal_pci_reset(phb->opal_id,
-				OPAL_PCI_HOT_RESET,
+				OPAL_RESET_PCI_HOT,
 				OPAL_ASSERT_RESET);
 	else if (option == EEH_RESET_DEACTIVATE)
 		rc = opal_pci_reset(phb->opal_id,
-				OPAL_PCI_HOT_RESET,
+				OPAL_RESET_PCI_HOT,
 				OPAL_DEASSERT_RESET);
 	if (rc < 0)
 		goto out;
@@ -697,7 +697,7 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		    (option == EEH_RESET_HOT ||
 		    option == EEH_RESET_FUNDAMENTAL)) {
 			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_PHB_ERROR,
+					    OPAL_RESET_PHB_ERROR,
 					    OPAL_ASSERT_RESET);
 			if (rc != OPAL_SUCCESS) {
 				pr_warn("%s: Failure %lld clearing "
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..36b1a7a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1627,7 +1627,7 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 
 static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
 {
-	opal_pci_reset(phb->opal_id, OPAL_PCI_IODA_TABLE_RESET,
+	opal_pci_reset(phb->opal_id, OPAL_RESET_PCI_IODA_TABLE,
 		       OPAL_ASSERT_RESET);
 }
 
@@ -1803,7 +1803,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
+	rc = opal_pci_reset(phb_id, OPAL_RESET_PCI_IODA_TABLE, OPAL_ASSERT_RESET);
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
 
-- 
1.8.3.2
