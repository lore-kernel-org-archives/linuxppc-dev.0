Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYGHG0XWVzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 00:18:49 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21DG6Nr031369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 08:18:48 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrasafg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 08:18:46 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 17:40:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8EF8A39401DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 16:57:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21BRcCB9240778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 16:57:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21BQqKI023413
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 16:57:37 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: capi-linux <capi-linux@lists.linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [RESEND-RFC v2 3/3] cxl: Reset freeze counters before adapter PERST
 for flashing new image
Date: Wed,  1 Mar 2017 16:54:52 +0530
In-Reply-To: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170301112452.15798-4-vaibhav@linux.vnet.ibm.com>
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
Change-log:

v1 -> v2
Changes as suggested by Russell Currey:
- Changed new variable names inline with eeh code nomenclature.
- Removed the dev_info logging the PHB being reset. The log message is now
  moved to eeh_handle_normal_event()
---
 drivers/misc/cxl/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index ce54dab..7960fd64 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -22,6 +22,7 @@
 #include <asm/pnv-pci.h>
 #include <asm/io.h>
 #include <asm/reg.h>
+#include <asm/eeh.h>
 
 #include "cxl.h"
 #include <misc/cxl.h>
@@ -1231,6 +1232,8 @@ static void cxl_pci_remove_afu(struct cxl_afu *afu)
 int cxl_pci_reset(struct cxl *adapter)
 {
 	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+	struct eeh_pe *pe = eeh_dev_to_pe(edev);
 	int rc;
 
 	if (adapter->perst_same_image) {
@@ -1244,6 +1247,17 @@ int cxl_pci_reset(struct cxl *adapter)
 	/* the adapter is about to be reset, so ignore errors */
 	cxl_data_cache_flush(adapter);
 
+	/* If loading a new image, reset freeze counters for the PHB
+	 * associated with the adapter.
+	 */
+	if (pe && adapter->perst_loads_image) {
+		/* Find the pe associated with the device PHB */
+		while (pe->parent != NULL && (pe->type & EEH_PE_PHB) == 0)
+			pe = pe->parent;
+
+		eeh_pe_reset_freeze_counter(pe);
+	}
+
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
 	 * if "user" or "factory" is selected in sysfs */
-- 
2.9.3
