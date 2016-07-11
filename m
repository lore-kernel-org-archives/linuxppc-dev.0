Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp3NR1DCzzDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:51 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BBnImd002593
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:51:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242ws8954g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:51:48 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 11 Jul 2016 21:51:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B1613578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6BBphAZ28704968
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6BBpgMo025866
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:43 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 06/15] cxl: Do not create vPHB if there are no AFU
 configuration records
Date: Mon, 11 Jul 2016 21:50:13 +1000
In-Reply-To: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468237822-26276-7-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The vPHB model of the cxl kernel API is a hierarchy where the AFU is
represented by the vPHB, and it's AFU configuration records are exposed
as functions under that vPHB. If there are no AFU configuration records
we will create a vPHB with nothing under it, which is a waste of
resources and will opt us into EEH handling despite not having anything
special to handle.

This also does not make sense for cards using the peer model of the cxl
kernel API, where the other functions of the device are exposed via
additional peer physical functions rather than AFU configuration
records. This model will also not work with the existing EEH handling in
the cxl driver, as that is designed around the vPHB model.

Skip creating the vPHB for AFUs without any AFU configuration records,
and opt out of EEH handling for them.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c  |  3 +++
 drivers/misc/cxl/vphb.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index deef9c7..dd7ff22 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1572,6 +1572,9 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 */
 		for (i = 0; i < adapter->slices; i++) {
 			afu = adapter->afu[i];
+			/* Only participate in EEH if we are on a virtual PHB */
+			if (afu->phb == NULL)
+				return PCI_ERS_RESULT_NONE;
 			cxl_vphb_error_detected(afu, state);
 		}
 		return PCI_ERS_RESULT_DISCONNECT;
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index c5b9c201..4b81f0f 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -221,6 +221,17 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	struct device_node *vphb_dn;
 	struct device *parent;
 
+	/*
+	 * If there are no AFU configuration records we won't have anything to
+	 * expose under the vPHB, so skip creating one, returning success since
+	 * this is still a valid case. This will also opt us out of EEH
+	 * handling since we won't have anything special to do if there are no
+	 * kernel drivers attached to the vPHB, and EEH handling is not yet
+	 * supported in the peer model.
+	 */
+	if (!afu->crs_num)
+		return 0;
+
 	/* The parent device is the adapter. Reuse the device node of
 	 * the adapter.
 	 * We don't seem to care what device node is used for the vPHB,
-- 
2.8.1
