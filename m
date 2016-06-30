Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgHmX3YljzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 21:45:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UBiEER018194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:45:45 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09qt4cg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:45:45 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 12:45:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB2B817D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:47:00 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UBjeBL18153738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:45:40 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UBjdtW014490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 05:45:39 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
 tgrobeck@us.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Ignore CAPI adapters misplaced in switched slots
Date: Thu, 30 Jun 2016 13:45:37 +0200
Message-Id: <1467287137-25366-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One should not attempt to switch a PHB into CAPI mode if there is
a switch between the PHB and the adapter. This patch modifies the
cxl driver to ignore CAPI adapters misplaced in switched slots.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
This patch fixes Bz 142217.

 drivers/misc/cxl/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a08fcc8..2f978ed 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1280,6 +1280,30 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
 	device_unregister(&adapter->dev);
 }
 
+#define CXL_MAX_PCIEX_PARENT 2
+
+static int cxl_slot_is_switched(struct pci_dev *dev)
+{
+	struct device_node *np;
+	int depth = 0;
+	const __be32 *prop;
+
+	if (!(np = pci_device_to_OF_node(dev))) {
+		pr_err("cxl: np = NULL\n");
+		return -ENODEV;
+	}
+	of_node_get(np);
+	while (np) {
+		np = of_get_next_parent(np);
+		prop = of_get_property(np, "device_type", NULL);
+		if (!prop || strcmp((char *)prop, "pciex"))
+			break;
+		depth++;
+	}
+	of_node_put(np);
+	return (depth > CXL_MAX_PCIEX_PARENT);
+}
+
 static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct cxl *adapter;
@@ -1291,6 +1315,11 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
+	if (cxl_slot_is_switched(dev)) {
+		dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring switched slot device\n");
+		return -ENODEV;
+	}
+
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
-- 
2.8.0
