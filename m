Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTXp1rWxzDr8c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:28:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMSu1O042315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:28:56 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ga5t5swb7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:28:53 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:28:51 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 38/38] cxlflash: Enable OpenCXL operations
Date: Thu, 22 Feb 2018 16:28:45 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338525-53157-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit enables the OpenCXL operations for the OpenCXL devices.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 9 +++++++--
 drivers/scsi/cxlflash/main.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 8c55fcd..42a95b7 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3168,7 +3168,8 @@ static struct dev_dependent_vals dev_corsa_vals = { CXLFLASH_MAX_SECTORS,
 static struct dev_dependent_vals dev_flash_gt_vals = { CXLFLASH_MAX_SECTORS,
 					CXLFLASH_NOTIFY_SHUTDOWN };
 static struct dev_dependent_vals dev_briard_vals = { CXLFLASH_MAX_SECTORS,
-					CXLFLASH_NOTIFY_SHUTDOWN };
+					(CXLFLASH_NOTIFY_SHUTDOWN |
+					CXLFLASH_OCXL_DEV) };
 
 /*
  * PCI device binding table
@@ -3679,9 +3680,13 @@ static int cxlflash_probe(struct pci_dev *pdev,
 
 	cfg->init_state = INIT_STATE_NONE;
 	cfg->dev = pdev;
-	cfg->ops = &cxlflash_cxl_ops;
 	cfg->cxl_fops = cxlflash_cxl_fops;
 
+	if (ddv->flags & CXLFLASH_OCXL_DEV)
+		cfg->ops = &cxlflash_ocxl_ops;
+	else
+		cfg->ops = &cxlflash_cxl_ops;
+
 	/*
 	 * Promoted LUNs move to the top of the LUN table. The rest stay on
 	 * the bottom half. The bottom half grows from the end (index = 255),
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index ba0108a..6f1be62 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -97,6 +97,7 @@ struct dev_dependent_vals {
 	u64 flags;
 #define CXLFLASH_NOTIFY_SHUTDOWN	0x0000000000000001ULL
 #define CXLFLASH_WWPN_VPD_REQUIRED	0x0000000000000002ULL
+#define CXLFLASH_OCXL_DEV		0x0000000000000004ULL
 };
 
 struct asyc_intr_info {
-- 
2.1.0
