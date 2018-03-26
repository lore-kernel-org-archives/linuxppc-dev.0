Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090616njfzF23C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:31:53 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGLMxe037581
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:31:51 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy1t28bef-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:31:51 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:31:50 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 10/41] cxlflash: Setup AFU PASID
Date: Mon, 26 Mar 2018 11:31:44 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081904-57820-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Per the OCXL specification, the maximum PASID supported by the AFU is
indicated by a field within the configuration space. Similar to acTags,
implementations can choose to use any sub-range of PASID within their
assigned range. For cxlflash, the entire range is used.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 3 +++
 drivers/scsi/cxlflash/ocxl_hw.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 105712b..44688af 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -118,6 +118,9 @@ static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 	dev_dbg(dev, "%s: acTag base=%d enabled=%d\n", __func__, base, count);
 	afu->afu_actag_base = base;
 	afu->afu_actag_enabled = count;
+	afu->max_pasid = 1 << acfg->pasid_supported_log;
+
+	ocxl_config_set_afu_pasid(pdev, pos, 0, acfg->pasid_supported_log);
 out:
 	return rc;
 }
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 21803b5..46de75b 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -25,5 +25,6 @@ struct ocxl_hw_afu {
 	int afu_actag_base;		/* AFU acTag base */
 	int afu_actag_enabled;		/* AFU acTag number enabled */
 
+	int max_pasid;			/* Maximum number of contexts */
 	bool is_present;		/* Function has AFUs defined */
 };
-- 
2.1.0
