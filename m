Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhWgF242tzDqjf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 16:47:05 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAM5hjGR033565
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:47:03 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ed14twfd8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:47:02 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 05:46:58 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH] cxl: Check if vphb exists before iterating over AFU devices
Date: Wed, 22 Nov 2017 11:16:15 +0530
Message-Id: <20171122054615.18092-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During an eeh a kernel-oops is reported if no vPHB to allocated to the
AFU. This happens as during AFU init, an error in creation of vPHB is
a non-fatal error. Hence afu->phb should always be checked for NULL
before iterating over it for the virtual AFU pci devices.

This patch fixes the kenel-oops by adding a NULL pointer check for
afu->phb before it is dereferenced.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index bb7fd3f4edab..80ac40cdc31b 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -2265,6 +2265,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 		if (cxl_afu_select_best_mode(afu))
 			goto err;
 
+		if (afu->phb == NULL)
+			continue;
+
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 			/* Reset the device context.
 			 * TODO: make this less disruptive
@@ -2327,6 +2330,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
+		if (afu->phb != NULL)
+			continue;
+
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 			if (afu_dev->driver && afu_dev->driver->err_handler &&
 			    afu_dev->driver->err_handler->resume)
-- 
2.14.3
