Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXkm02W4KzDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:37:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8CAWqdK026783
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 06:37:49 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25cbsyc3g2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 06:37:49 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 12 Sep 2016 11:37:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D1C2817D805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 11:39:39 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8CAbjXT9699682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 10:37:45 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8CAbiA0026685
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 04:37:44 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Fix informational message
Date: Mon, 12 Sep 2016 12:37:43 +0200
Message-Id: <1473676663-11057-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When set_sl_ops() is called, the adapter data structure is not fully
initialized yet. Therefore the device name is not showing up in the
trace. Fix is simply to get the device name from the pci_dev
structure.

Fixes: 6d382616ac22 ("cxl: Abstract the differences between the PSL and XSL")
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 6f0c4ac..cd922a8 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1530,11 +1530,11 @@ static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
 {
 	if (dev->vendor == PCI_VENDOR_ID_MELLANOX && dev->device == 0x1013) {
 		/* Mellanox CX-4 */
-		dev_info(&adapter->dev, "Device uses an XSL\n");
+		dev_info(&dev->dev, "Device uses an XSL\n");
 		adapter->native->sl_ops = &xsl_ops;
 		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
 	} else {
-		dev_info(&adapter->dev, "Device uses a PSL\n");
+		dev_info(&dev->dev, "Device uses a PSL\n");
 		adapter->native->sl_ops = &psl_ops;
 	}
 }
-- 
2.7.4
