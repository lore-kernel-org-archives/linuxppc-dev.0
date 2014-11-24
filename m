Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA6571A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:39:00 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54B27140185
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:39:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:38:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0902B2CE802D
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:57 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMcsjN27066468
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcr2V015291
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/powernv: Issue fundamental reset if required
Date: Tue, 25 Nov 2014 09:38:46 +1100
Message-Id: <1416868727-5814-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

pnv_pci_reset_secondary_bus() is the backend for resetting the
secondary bus for the specified PCI bridge. We always issue hot
reset, which isn't enough for some devices who requires fundamental
reset explicitly. The patch switches to fundamental reset if the
devices ask for that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 34 +++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index d02a696..4bf2fb5 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -650,18 +650,34 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
+{
+	int *freset = data;
+
+	/*
+	 * Stop the iteration immediately if any one
+	 * PCI device requires fundamental reset
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
+/*
+ * When the function is called, there should have
+ * valid bridge. We don't need cover root bus here
+ */
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
-	struct pci_controller *hose;
+	int option = EEH_RESET_HOT;
+	int freset = 0;
 
-	if (pci_is_root_bus(dev->bus)) {
-		hose = pci_bus_to_host(dev->bus);
-		ioda_eeh_phb_reset(hose, EEH_RESET_HOT);
-		ioda_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-	} else {
-		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
-	}
+	/* Need fundamental reset ? */
+	pci_walk_bus(dev->subordinate, pnv_pci_dev_reset_type, &freset);
+	if (freset)
+		option = EEH_RESET_FUNDAMENTAL;
+
+	ioda_eeh_bridge_reset(dev, option);
+	ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
 
 /**
-- 
1.8.3.2
