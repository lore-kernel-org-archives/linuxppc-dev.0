Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B59ED1A0764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 11:40:44 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E2111400DD
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Mar 2015 10:40:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 876EF2BB0054
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O0eXqk39976976
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O0e8r7019908
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/3] powerpc/powernv: Fundamental reset for PCI bus reset
Date: Tue, 24 Mar 2015 11:39:41 +1100
Message-Id: <1427157582-11196-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1427157582-11196-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427157582-11196-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function pnv_pci_reset_secondary_bus() is used to reset specified
PCI bus, which is leaded by root complex or PCI bridge. That means
the function shouldn't be called on PCI root bus and the patch
removes the logic for that case.

Also, some adapters beneath the indicated PCI bus may require
fundamental reset in order to successfully reload their firmwares
after the reset. The patch translates hot reset to fundamental reset
for that case.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 79208cd..0f1e5ba 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
 }
 
-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
 {
-	struct pci_controller *hose;
+	int *freset = data;
 
-	if (pci_is_root_bus(dev->bus)) {
-		hose = pci_bus_to_host(dev->bus);
-		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
-		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-	} else {
-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+	/*
+	 * Stop the iteration immediately if there is any
+	 * one PCI device requesting fundamental reset
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
+void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
+{
+	int option = EEH_RESET_HOT;
+	int freset = 0;
+
+	/* Check if there're any PCI devices asking for fundamental reset */
+	if (pdev->subordinate) {
+		pci_walk_bus(pdev->subordinate,
+			     pnv_pci_dev_reset_type,
+			     &freset);
+		if (freset)
+			option = EEH_RESET_FUNDAMENTAL;
 	}
+
+	/* Issue the requested type of reset */
+	pnv_eeh_bridge_reset(pdev, option);
+	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
 }
 
 /**
-- 
1.8.3.2
