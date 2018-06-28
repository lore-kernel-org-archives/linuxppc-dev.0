Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Gb4m0hctzF1Pm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 20:05:27 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SA3xew022765
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jvskdjm10-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:25 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Thu, 28 Jun 2018 11:05:23 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH v2 04/10] Revert "cxl: Add kernel APIs to get & set the max
 irqs per context"
Date: Thu, 28 Jun 2018 12:05:03 +0200
In-Reply-To: <20180628100509.17413-1-fbarrat@linux.ibm.com>
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
Message-Id: <20180628100509.17413-5-fbarrat@linux.ibm.com>
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

This reverts commit 79384e4b71240abf50c375eea56060b0d79c242a.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/cxl/api.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 34ba67bc41bd..a535c1e6aa92 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -552,30 +552,3 @@ ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count)
 	return cxl_ops->read_adapter_vpd(afu->adapter, buf, count);
 }
 EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
-
-int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs)
-{
-	struct cxl_afu *afu = cxl_pci_to_afu(dev);
-	if (IS_ERR(afu))
-		return -ENODEV;
-
-	if (irqs > afu->adapter->user_irqs)
-		return -EINVAL;
-
-	/* Limit user_irqs to prevent the user increasing this via sysfs */
-	afu->adapter->user_irqs = irqs;
-	afu->irqs_max = irqs;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_set_max_irqs_per_process);
-
-int cxl_get_max_irqs_per_process(struct pci_dev *dev)
-{
-	struct cxl_afu *afu = cxl_pci_to_afu(dev);
-	if (IS_ERR(afu))
-		return -ENODEV;
-
-	return afu->irqs_max;
-}
-EXPORT_SYMBOL_GPL(cxl_get_max_irqs_per_process);
-- 
2.17.1
