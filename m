Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTQk2Xv6zF1jb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:23:42 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMKv4c141215
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:23:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga268hrew-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:23:40 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 17:23:38 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 07/38] cxlflash: Setup function acTag range
Date: Thu, 22 Feb 2018 16:23:31 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338211-52037-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OpenCXL specification supports distributing acTags amongst different
AFUs and functions on the link. The platform-specific acTag range for the
link is obtained using the OCXL provider services and then assigned to the
host function based on implementation. For cxlflash devices only a single
function per host is expected and thus the entire range is assigned.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 15 +++++++++++++++
 drivers/scsi/cxlflash/ocxl_hw.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index a349ec6..add2803 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -42,6 +42,7 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 {
 	struct ocxl_fn_config *fcfg = &afu->fcfg;
 	struct device *dev = &pdev->dev;
+	u16 base, enabled, supported;
 	int rc = 0;
 
 	/* Read DVSEC config of the function */
@@ -56,6 +57,20 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 	if (fcfg->max_afu_index != 0)
 		dev_warn(dev, "%s: Unexpected AFU index value %d\n",
 			 __func__, fcfg->max_afu_index);
+
+	rc = ocxl_config_get_actag_info(pdev, &base, &enabled, &supported);
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: ocxl_config_get_actag_info failed rc=%d\n",
+			__func__, rc);
+		goto out;
+	}
+
+	afu->fn_actag_base = base;
+	afu->fn_actag_enabled = enabled;
+
+	ocxl_config_set_actag(pdev, fcfg->dvsec_function_pos, base, enabled);
+	dev_dbg(dev, "%s: Function acTag range base=%u enabled=%u\n",
+		__func__, base, enabled);
 out:
 	return rc;
 }
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 9c1b5347..8c0a172 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -18,4 +18,7 @@ struct ocxl_hw_afu {
 	struct device *dev;		/* Generic device */
 
 	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
+
+	int fn_actag_base;		/* Function acTag base */
+	int fn_actag_enabled;		/* Function acTag number enabled */
 };
-- 
2.1.0
