Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV8PG1VtNzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 00:42:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FEdRIn005771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 10:42:22 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jswb9wdm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 10:42:22 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 15:42:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A1B181B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:43:26 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5FEgHCD66519218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 14:42:17 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5FEgH2H030693
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 08:42:17 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Make vPHB device node match adapter's
Date: Wed, 15 Jun 2016 16:42:16 +0200
Message-Id: <1466001736-3074-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested by cxlflash on bare-metal and powerVM.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/vphb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index cdc7723..012b6aa 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -208,20 +208,19 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 
 int cxl_pci_vphb_add(struct cxl_afu *afu)
 {
-	struct pci_dev *phys_dev;
-	struct pci_controller *phb, *phys_phb;
+	struct pci_controller *phb;
 	struct device_node *vphb_dn;
 	struct device *parent;
 
-	if (cpu_has_feature(CPU_FTR_HVMODE)) {
-		phys_dev = to_pci_dev(afu->adapter->dev.parent);
-		phys_phb = pci_bus_to_host(phys_dev->bus);
-		vphb_dn = phys_phb->dn;
-		parent = &phys_dev->dev;
-	} else {
-		vphb_dn = afu->adapter->dev.parent->of_node;
-		parent = afu->adapter->dev.parent;
-	}
+	/* The parent device is the adapter. Reuse the device node of
+	 * the adapter.
+	 * We don't seem to care what device node is used for the vPHB,
+	 * but tools such as lsvpd walk up the device parents looking
+	 * for a valid location code, so we might as well show devices
+	 * attached to the adapter as being located on that adapter.
+	 */
+	parent = afu->adapter->dev.parent;
+	vphb_dn = parent->of_node;
 
 	/* Alloc and setup PHB data structure */
 	phb = pcibios_alloc_controller(vphb_dn);
-- 
2.7.4
