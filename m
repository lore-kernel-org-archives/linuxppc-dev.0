Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWry5fWrzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL91EG096620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:08 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24567dd3gy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:08 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E51752BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:02 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLI2s011862072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLI28K023388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:02 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 08/15] cxl: Add support for using the kernel API with a real
 PHB
Date: Thu, 14 Jul 2016 07:17:07 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-9-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This hooks up support for using the kernel API with a real PHB. After
the AFU initialisation has completed it calls into the PHB code to pass
it the AFU that will be used by other peer physical functions on the
adapter.

The cxl_pci_to_afu API is extended to work with peer PCI devices,
retrieving the peer AFU from the PHB. This API may also now return an
error if it is called on a PCI device that is not associated with either
a cxl vPHB or a peer PCI device to an AFU, and this error is propagated
down.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---
V1->V2:
	- Removed change to skip participating in EEH without a vPHB -
	  moved out into an earlier patch.
---
 drivers/misc/cxl/api.c  |  5 +++++
 drivers/misc/cxl/pci.c  |  3 +++
 drivers/misc/cxl/vphb.c | 16 ++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 7707055..6a030bf 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <misc/cxl.h>
 #include <linux/fs.h>
+#include <asm/pnv-pci.h>
 
 #include "cxl.h"
 
@@ -24,6 +25,8 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 	int rc;
 
 	afu = cxl_pci_to_afu(dev);
+	if (IS_ERR(afu))
+		return ERR_CAST(afu);
 
 	ctx = cxl_context_alloc();
 	if (IS_ERR(ctx)) {
@@ -438,6 +441,8 @@ EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
 ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count)
 {
 	struct cxl_afu *afu = cxl_pci_to_afu(dev);
+	if (IS_ERR(afu))
+		return -ENODEV;
 
 	return cxl_ops->read_adapter_vpd(afu->adapter, buf, count);
 }
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index dd7ff22..cb5d172 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1502,6 +1502,9 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			dev_err(&dev->dev, "AFU %i failed to start: %i\n", slice, rc);
 	}
 
+	if (pnv_pci_on_cxl_phb(dev) && adapter->slices >= 1)
+		pnv_cxl_phb_set_peer_afu(dev, adapter->afu[0]);
+
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 8865e8d..dee8def 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -9,6 +9,7 @@
 
 #include <linux/pci.h>
 #include <misc/cxl.h>
+#include <asm/pnv-pci.h>
 #include "cxl.h"
 
 static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
@@ -258,13 +259,18 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
 	pcibios_free_controller(phb);
 }
 
+static bool _cxl_pci_is_vphb_device(struct pci_controller *phb)
+{
+	return (phb->ops == &cxl_pcie_pci_ops);
+}
+
 bool cxl_pci_is_vphb_device(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
 
 	phb = pci_bus_to_host(dev->bus);
 
-	return (phb->ops == &cxl_pcie_pci_ops);
+	return _cxl_pci_is_vphb_device(phb);
 }
 
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
@@ -273,7 +279,13 @@ struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
 
 	phb = pci_bus_to_host(dev->bus);
 
-	return (struct cxl_afu *)phb->private_data;
+	if (_cxl_pci_is_vphb_device(phb))
+		return (struct cxl_afu *)phb->private_data;
+
+	if (pnv_pci_on_cxl_phb(dev))
+		return pnv_cxl_phb_to_afu(phb);
+
+	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
 
-- 
2.8.1
