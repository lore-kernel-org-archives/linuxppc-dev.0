Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Gb4q0nKgzF1Pt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 20:05:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SA3k4E055540
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jvw409f51-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:27 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Thu, 28 Jun 2018 11:05:26 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH v2 06/10] Revert "cxl: Add support for using the kernel API
 with a real PHB"
Date: Thu, 28 Jun 2018 12:05:05 +0200
In-Reply-To: <20180628100509.17413-1-fbarrat@linux.ibm.com>
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
Message-Id: <20180628100509.17413-7-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

Remove abandonned capi support for the Mellanox CX4.

This reverts commit 317f5ef1b363417b6f1e93b90dfd2ffd6be6e867.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/cxl/pci.c  |  3 ---
 drivers/misc/cxl/vphb.c | 16 ++--------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9c5a21fee835..193ff22f610b 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1886,9 +1886,6 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			dev_err(&dev->dev, "AFU %i failed to start: %i\n", slice, rc);
 	}
 
-	if (pnv_pci_on_cxl_phb(dev) && adapter->slices >= 1)
-		pnv_cxl_phb_set_peer_afu(dev, adapter->afu[0]);
-
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 7fd0bdc1436a..1a99c9c7a6fb 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -9,7 +9,6 @@
 
 #include <linux/pci.h>
 #include <misc/cxl.h>
-#include <asm/pnv-pci.h>
 #include "cxl.h"
 
 static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
@@ -284,18 +283,13 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
 	 */
 }
 
-static bool _cxl_pci_is_vphb_device(struct pci_controller *phb)
-{
-	return (phb->ops == &cxl_pcie_pci_ops);
-}
-
 bool cxl_pci_is_vphb_device(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
 
 	phb = pci_bus_to_host(dev->bus);
 
-	return _cxl_pci_is_vphb_device(phb);
+	return (phb->ops == &cxl_pcie_pci_ops);
 }
 
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
@@ -304,13 +298,7 @@ struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
 
 	phb = pci_bus_to_host(dev->bus);
 
-	if (_cxl_pci_is_vphb_device(phb))
-		return (struct cxl_afu *)phb->private_data;
-
-	if (pnv_pci_on_cxl_phb(dev))
-		return pnv_cxl_phb_to_afu(phb);
-
-	return ERR_PTR(-ENODEV);
+	return (struct cxl_afu *)phb->private_data;
 }
 EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
 
-- 
2.17.1
