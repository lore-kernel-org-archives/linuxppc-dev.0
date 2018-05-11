Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jKM20cwkzF2rQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 05:06:21 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BIx2ga026491
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:06:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hwf8x4707-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:06:18 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 11 May 2018 15:06:16 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 6/7] cxlflash: Abstract hardware dependent assignments
Date: Fri, 11 May 2018 14:06:05 -0500
In-Reply-To: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1526065565-39041-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a staging cleanup to support transport specific builds of the cxlflash
module, relocate device dependent assignments to header files. This will
avoid littering the core driver with conditional compilation logic.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c |  7 ++-----
 drivers/scsi/cxlflash/main.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index c91e912..cd7dcc5 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3708,11 +3708,8 @@ static int cxlflash_probe(struct pci_dev *pdev,
 	cfg->init_state = INIT_STATE_NONE;
 	cfg->dev = pdev;
 	cfg->cxl_fops = cxlflash_cxl_fops;
-
-	if (ddv->flags & CXLFLASH_OCXL_DEV)
-		cfg->ops = &cxlflash_ocxl_ops;
-	else
-		cfg->ops = &cxlflash_cxl_ops;
+	cfg->ops = cxlflash_assign_ops(ddv);
+	WARN_ON_ONCE(!cfg->ops);
 
 	/*
 	 * Promoted LUNs move to the top of the LUN table. The rest stay on
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index 6f1be62..ed4908e 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -20,6 +20,8 @@
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
 
+#include "backend.h"
+
 #define CXLFLASH_NAME		"cxlflash"
 #define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
 #define CXLFLASH_MAX_ADAPTERS	32
@@ -100,6 +102,19 @@ struct dev_dependent_vals {
 #define CXLFLASH_OCXL_DEV		0x0000000000000004ULL
 };
 
+static inline const struct cxlflash_backend_ops *
+cxlflash_assign_ops(struct dev_dependent_vals *ddv)
+{
+	const struct cxlflash_backend_ops *ops = NULL;
+
+	if (ddv->flags & CXLFLASH_OCXL_DEV)
+		ops = &cxlflash_ocxl_ops;
+	if (!(ddv->flags & CXLFLASH_OCXL_DEV))
+		ops = &cxlflash_cxl_ops;
+
+	return ops;
+}
+
 struct asyc_intr_info {
 	u64 status;
 	char *desc;
-- 
2.1.0
