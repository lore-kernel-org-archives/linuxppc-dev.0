Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2J4k3T7zzF0BX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 15:07:18 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBL46Fe5008764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:07:16 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f047d3dkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:07:15 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 21 Dec 2017 04:07:13 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: stable@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Check if vphb exists before iterating over AFU devices
Date: Thu, 21 Dec 2017 09:36:19 +0530
Message-Id: <20171221040619.25270-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 12841f87b7a8ceb3d54f171660f72a86941bfcb3 upstream, for 4.3.

During an eeh a kernel-oops is reported if no vPHB is allocated to the
AFU. This happens as during AFU init, an error in creation of vPHB is
a non-fatal error. Hence afu->phb should always be checked for NULL
before iterating over it for the virtual AFU pci devices.

This patch fixes the kenel-oops by adding a NULL pointer check for
afu->phb before it is dereferenced.

Fixes: 9e8df8a21963 ("cxl: EEH support")
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
Changelog:
- Rebased the patch on 4.3 stable tree
---
 drivers/misc/cxl/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 85761d7eb333..b982329f3837 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1328,6 +1328,9 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
+	if (afu->phb == NULL)
+		return result;
+
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 		if (!afu_dev->driver)
 			continue;
@@ -1368,6 +1371,10 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 */
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
+			/*
+			 * Tell the AFU drivers; but we don't care what they
+			 * say, we're going away.
+			 */
 			cxl_vphb_error_detected(afu, state);
 		}
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -1491,6 +1498,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 		if (cxl_afu_select_best_mode(afu))
 			goto err;
 
+		if (afu->phb == NULL)
+			continue;
+
 		cxl_pci_vphb_reconfigure(afu);
 
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
@@ -1555,6 +1565,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
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
