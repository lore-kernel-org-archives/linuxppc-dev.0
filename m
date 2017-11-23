Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yj4nf1kZwzDrJB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 14:39:33 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAN3cvcf011013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:39:31 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2edp0xt53d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:39:30 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 03:39:29 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: [PATCH v3] cxl: Check if vphb exists before iterating over AFU devices
Date: Thu, 23 Nov 2017 09:08:57 +0530
Message-Id: <20171123033857.13122-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During an eeh a kernel-oops is reported if no vPHB is allocated to the
AFU. This happens as during AFU init, an error in creation of vPHB is
a non-fatal error. Hence afu->phb should always be checked for NULL
before iterating over it for the virtual AFU pci devices.

This patch fixes the kenel-oops by adding a NULL pointer check for
afu->phb before it is dereferenced.

Fixes: 9e8df8a2196("cxl: EEH support")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Changelog:

v3	-> Fixed a reverse NULL check [Fred]

Resend 	-> Added the 'Fixes' info and marking the patch to stable tree [Mpe]

v2     	-> Added the vphb NULL check to cxl_vphb_error_detected() [Andrew]
---
 drivers/misc/cxl/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index bb7fd3f4edab..19969ee86d6f 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -2083,6 +2083,9 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
 	/* There should only be one entry, but go through the list
 	 * anyway
 	 */
+	if (afu->phb == NULL)
+		return result;
+
 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 		if (!afu_dev->driver)
 			continue;
@@ -2124,8 +2127,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 			 * Tell the AFU drivers; but we don't care what they
 			 * say, we're going away.
 			 */
-			if (afu->phb != NULL)
-				cxl_vphb_error_detected(afu, state);
+			cxl_vphb_error_detected(afu, state);
 		}
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
@@ -2265,6 +2267,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 		if (cxl_afu_select_best_mode(afu))
 			goto err;
 
+		if (afu->phb == NULL)
+			continue;
+
 		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
 			/* Reset the device context.
 			 * TODO: make this less disruptive
@@ -2327,6 +2332,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
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
