Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXVQl5YmpzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:22:39 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S7E1uv071703
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:22:37 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28vqj18jpm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:22:36 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 12:52:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 04588E0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:54:15 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S7MVmc14942396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:52:31 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S7MUFG024582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:52:31 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, frederic.barrat@fr.ibm.com
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: [RFC 3/3] cxl: Reset freeze counters before adapter PERST for
 flashing new image
Date: Tue, 28 Feb 2017 12:52:19 +0530
In-Reply-To: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170228072219.24868-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch resets the freeze counter on eeh_pe struct for PHB
associated with the cxl pci adapter. This would enable re-flashing of
the cxl-adapter beyond the default limit of 5.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 679afc9..3b14688 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -22,6 +22,7 @@
 #include <asm/pnv-pci.h>
 #include <asm/io.h>
 #include <asm/reg.h>
+#include <asm/eeh.h>
 
 #include "cxl.h"
 #include <misc/cxl.h>
@@ -1229,6 +1230,8 @@ static void cxl_pci_remove_afu(struct cxl_afu *afu)
 int cxl_pci_reset(struct cxl *adapter)
 {
 	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
+	struct eeh_dev *eehdev = pci_dev_to_eeh_dev(dev);
+	struct eeh_pe *devpe = eeh_dev_to_pe(eehdev);
 	int rc;
 
 	if (adapter->perst_same_image) {
@@ -1242,6 +1245,18 @@ int cxl_pci_reset(struct cxl *adapter)
 	/* the adapter is about to be reset, so ignore errors */
 	cxl_data_cache_flush(adapter);
 
+	/* If loading a new image, reset freeze counters for the PHB
+	 * associated with the adapter.
+	 */
+	if (devpe && adapter->perst_loads_image) {
+		/* Find the pe associated with the device PHB */
+		while (devpe->parent != NULL && (devpe->type & EEH_PE_PHB) == 0)
+			devpe = devpe->parent;
+
+		dev_info(&dev->dev, "Resetting freeze counters for the PHB\n");
+		eeh_pe_reset_freeze_counter(devpe);
+	}
+
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
 	 * if "user" or "factory" is selected in sysfs */
-- 
2.9.3
