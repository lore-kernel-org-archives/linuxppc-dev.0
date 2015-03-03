Return-Path: <Bharat.Bhushan@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF1F61A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 16:43:29 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB0D2140146
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 16:43:27 +1100 (AEDT)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 2/4 RFC] fsl/msi: Move fsl,
 msi mode specific MSI device search out of main loop
Date: Tue, 3 Mar 2015 10:47:44 +0530
Message-ID: <1425359866-31049-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moving out the specific MSI device search out of main loop. And now
the specific msi device search is placed with other "fsl.msi" specific
code in same function.
This is in preparation to MSI bank partitioning.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ec3161b..32ba1e3 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -178,7 +178,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	struct fsl_msi *msi_data;
+	struct fsl_msi *msi_data = NULL;
+	bool specific_msi_bank = false;
 
 	if (type == PCI_CAP_ID_MSIX)
 		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
@@ -199,12 +200,9 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 				hose->dn->full_name, np->phandle);
 			return -EINVAL;
 		}
-	}
-
-	list_for_each_entry(entry, &pdev->msi_list, list) {
 		/*
-		 * Loop over all the MSI devices until we find one that has an
-		 * available interrupt.
+		 * Loop over all the MSI devices till we find
+		 * specific MSI device.
 		 */
 		list_for_each_entry(msi_data, &msi_head, list) {
 			/*
@@ -215,12 +213,33 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			 * has the additional benefit of skipping over MSI
 			 * nodes that are not mapped in the PAMU.
 			 */
-			if (phandle && (phandle != msi_data->phandle))
-				continue;
+			if (phandle == msi_data->phandle) {
+				specific_msi_bank = true;
+				break;
+			}
+		}
 
+		if (!specific_msi_bank) {
+			dev_err(&pdev->dev,
+				"No specific MSI device found for node %s\n",
+				hose->dn->full_name);
+			return -EINVAL;
+		}
+	}
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (specific_msi_bank) {
 			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
-			if (hwirq >= 0)
-				break;
+		} else {
+			/*
+			 * Loop over all the MSI devices until we find one that has an
+			 * available interrupt.
+			 */
+			list_for_each_entry(msi_data, &msi_head, list) {
+				hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
+				if (hwirq >= 0)
+					break;
+			}
 		}
 
 		if (hwirq < 0) {
-- 
1.9.3
