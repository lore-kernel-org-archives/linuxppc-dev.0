Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1qS16FglzDrYD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 20:37:21 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK9axUd044445
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 04:37:19 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eymdhtgkj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 04:37:18 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 09:37:16 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: stable@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] cxl: Check if vphb exists before iterating over AFU devices
Date: Wed, 20 Dec 2017 15:07:06 +0530
Message-Id: <20171220093706.16217-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 12841f87b7a8ceb3d54f171660f72a86941bfcb3 upstream, for 4.9.

During an eeh a kernel-oops is reported if no vPHB is allocated to the
AFU. This happens as during AFU init, an error in creation of vPHB is
a non-fatal error. Hence afu->phb should always be checked for NULL
before iterating over it for the virtual AFU pci devices.

This patch fixes the kenel-oops by adding a NULL pointer check for
afu->phb before it is dereferenced.

Fixes: 9e8df8a21963 ("cxl: EEH support")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
Changelog:
Rebased the upstream patch over stable 4.9 tree
---
 drivers/misc/cxl/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index eef202d4399b..a5422f483ad5 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1758,6 +1758,9 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
+	if (afu->phb == NULL)
+		return result;
+
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 		if (!afu_dev->driver)
 			continue;
@@ -1801,6 +1804,11 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 			/* Only participate in EEH if we are on a virtual PHB */
 			if (afu->phb == NULL)
 				return PCI_ERS_RESULT_NONE;
+
+			/*
+			 * Tell the AFU drivers; but we don't care what they
+			 * say, we're going away.
+			 */
 			cxl_vphb_error_detected(afu, state);
 		}
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -1941,6 +1949,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 		if (cxl_afu_select_best_mode(afu))
 			goto err;
 
+		if (afu->phb == NULL)
+			continue;
+
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 			/* Reset the device context.
 			 * TODO: make this less disruptive
@@ -2003,6 +2014,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
+		if (afu->phb == NULL)
+			continue;
+
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 			if (afu_dev->driver && afu_dev->driver->err_handler &&
 			    afu_dev->driver->err_handler->resume)
-- 
2.14.3
