Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqxCL4sK5zF1Vm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:22:22 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QMJHei018569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:22:20 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcp1wkmvq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:22:20 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 15:22:19 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v2 15/38] cxlflash: Support image reload policy modification
Date: Mon, 26 Feb 2018 16:22:14 -0600
In-Reply-To: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519683734-17294-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a PERST, the AFU image can be reloaded or left intact. Provide means to
set this image reload policy.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 13 +++++++++++++
 drivers/scsi/cxlflash/ocxl_hw.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index cdb1385..7717a63 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -252,6 +252,18 @@ static int ocxlflash_release_context(void *ctx_cookie)
 }
 
 /**
+ * ocxlflash_perst_reloads_same_image() - sets the image reload policy
+ * @afu_cookie:	Hardware AFU associated with the host.
+ * @image:	Whether to load the same image on PERST.
+ */
+static void ocxlflash_perst_reloads_same_image(void *afu_cookie, bool image)
+{
+	struct ocxl_hw_afu *afu = afu_cookie;
+
+	afu->perst_same_image = image;
+}
+
+/**
  * ocxlflash_destroy_afu() - destroy the AFU structure
  * @afu_cookie:	AFU to be freed.
  */
@@ -493,6 +505,7 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.get_context		= ocxlflash_get_context,
 	.dev_context_init	= ocxlflash_dev_context_init,
 	.release_context	= ocxlflash_release_context,
+	.perst_reloads_same_image = ocxlflash_perst_reloads_same_image,
 	.create_afu		= ocxlflash_create_afu,
 	.destroy_afu		= ocxlflash_destroy_afu,
 	.get_fd			= ocxlflash_get_fd,
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 7abc532..fd1a8df 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -17,6 +17,7 @@ struct ocxl_hw_afu {
 	struct ocxlflash_context *ocxl_ctx; /* Host context */
 	struct pci_dev *pdev;		/* PCI device */
 	struct device *dev;		/* Generic device */
+	bool perst_same_image;		/* Same image loaded on perst */
 
 	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
 	struct ocxl_afu_config acfg;	/* AFU configuration data */
-- 
2.1.0
