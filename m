Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B048E1A0780
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:14:26 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8668614029C
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:14:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9B07E3578048
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H7EFx750004112
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H7DnUM007397
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:13:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RESEND v2 2/7] powerpc/powernv: Issue fundamental reset if
 required
Date: Tue, 17 Feb 2015 18:13:18 +1100
Message-Id: <1424157203-691-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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

Also, some adapters may require fundamental reset to reload their
firmwares. The patch translates hot reset to fundamental reset
if required.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 36 +++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 8cec57d..eeda6e1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -811,18 +811,36 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
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
+	/* In case we need fundamental reset */
+	if (pdev->subordinate) {
+		pci_walk_bus(pdev->subordinate,
+			     pnv_pci_dev_reset_type,
+			     &freset);
+
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
