Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgvRQ1hBfzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 21:33:06 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61BNeC7042464
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 07:33:03 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23w76pnnhn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 07:33:02 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 12:33:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA33E17D8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 12:34:20 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61BWxZx59965668
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 11:32:59 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61BWwjB003298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 07:32:59 -0400
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
 tgrobeck@us.ibm.com, fbarrat@linux.vnet.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v2] cxl: Ignore CAPI adapters misplaced in switched slots
Date: Fri,  1 Jul 2016 13:32:52 +0200
Message-Id: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
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

Changes since v1:
  - As suggested by Fred, tell user that CAPI adapter is misplaced
    s/dev_dbg/dev_info/

 drivers/misc/cxl/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a08fcc8..0d69eac 100644
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
+		dev_info(&dev->dev, "Ignoring card on incompatible PCI slot\n");
+		return -ENODEV;
+	}
+
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
-- 
2.8.0
