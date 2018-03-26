Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40905b6tLnzF22W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:31:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGLMxS037581
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:31:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy1t28awk-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:31:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:31:28 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 07/41] cxlflash: Setup function acTag range
Date: Mon, 26 Mar 2018 11:31:21 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081881-57709-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OCXL specification supports distributing acTags amongst different
AFUs and functions on the link. The platform-specific acTag range for the
link is obtained using the OCXL provider services and then assigned to the
host function based on implementation.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 15 +++++++++++++++
 drivers/scsi/cxlflash/ocxl_hw.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 85c0f84..7783842 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -42,6 +42,7 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 {
 	struct ocxl_fn_config *fcfg = &afu->fcfg;
 	struct device *dev = &pdev->dev;
+	u16 base, enabled, supported;
 	int rc = 0;
 
 	/* Read DVSEC config of the function */
@@ -59,6 +60,20 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 			dev_warn(dev, "%s: Unexpected AFU index value %d\n",
 				 __func__, fcfg->max_afu_index);
 	}
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
index 356a6a3..55e833cb 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -19,5 +19,8 @@ struct ocxl_hw_afu {
 
 	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
 
+	int fn_actag_base;		/* Function acTag base */
+	int fn_actag_enabled;		/* Function acTag number enabled */
+
 	bool is_present;		/* Function has AFUs defined */
 };
-- 
2.1.0
