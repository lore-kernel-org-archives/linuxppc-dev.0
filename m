Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTVB4dY5zF1d8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:26:42 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMO1PO124043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:26:40 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ga5mra88n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:26:39 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:26:39 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 23/38] cxlflash: Support process element lifecycle
Date: Thu, 22 Feb 2018 16:26:33 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338393-52615-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As part of the context lifecycle, the associated process element within
the Shared Process Area (SPA) of the link must be updated. Each process
is defined by various parameters (pid, tid, PASID mm) that are stored in
the SPA upon starting a context and invalidated when a context is stopped.

Use the OCXL provider services to configure the SPA with the appropriate
data that is unique to the process when starting a context. Initially only
kernel contexts are supported and therefore these process values are not
applicable. Note that the OCXL service used has an optional callback for
translation fault error notification. While not used here, it will be
expanded in a future commit.

Also add a service to stop a context by terminating the corresponding
PASID and remove the process element from the SPA.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 52 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 74447f8..1dd679d 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -189,7 +189,7 @@ static int ocxlflash_process_element(void *ctx_cookie)
  * start_context() - local routine to start a context
  * @ctx:	Adapter context to be started.
  *
- * Assign the context specific MMIO space.
+ * Assign the context specific MMIO space, add and enable the PE.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -197,7 +197,10 @@ static int start_context(struct ocxlflash_context *ctx)
 {
 	struct ocxl_hw_afu *afu = ctx->hw_afu;
 	struct ocxl_afu_config *acfg = &afu->acfg;
+	void *link_token = afu->link_token;
+	struct device *dev = afu->dev;
 	bool master = ctx->master;
+	int rc = 0;
 
 	if (master) {
 		ctx->psn_size = acfg->global_mmio_size;
@@ -207,7 +210,16 @@ static int start_context(struct ocxlflash_context *ctx)
 		ctx->psn_phys = afu->ppmmio_phys + (ctx->pe * ctx->psn_size);
 	}
 
-	return 0;
+
+	/* pid, tid, amr and mm are zeroes/NULL for a kernel context */
+	rc = ocxl_link_add_pe(link_token, ctx->pe, 0, 0, 0, NULL, NULL, NULL);
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: ocxl_link_add_pe failed rc=%d\n",
+			__func__, rc);
+		goto out;
+	}
+out:
+	return rc;
 }
 
 /**
@@ -224,6 +236,41 @@ static int ocxlflash_start_context(void *ctx_cookie)
 }
 
 /**
+ * ocxlflash_stop_context() - stop a context
+ * @ctx_cookie:	Adapter context to be stopped.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_stop_context(void *ctx_cookie)
+{
+	struct ocxlflash_context *ctx = ctx_cookie;
+	struct ocxl_hw_afu *afu = ctx->hw_afu;
+	struct ocxl_afu_config *acfg = &afu->acfg;
+	struct pci_dev *pdev = afu->pdev;
+	struct device *dev = afu->dev;
+	int rc;
+
+	rc = ocxl_config_terminate_pasid(pdev, acfg->dvsec_afu_control_pos,
+					 ctx->pe);
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: ocxl_config_terminate_pasid failed rc=%d\n",
+			__func__, rc);
+		/* If EBUSY, PE could be referenced in future by the AFU */
+		if (rc == -EBUSY)
+			goto out;
+	}
+
+	rc = ocxl_link_remove_pe(afu->link_token, ctx->pe);
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: ocxl_link_remove_pe failed rc=%d\n",
+			__func__, rc);
+		goto out;
+	}
+out:
+	return rc;
+}
+
+/**
  * ocxlflash_set_master() - sets the context as master
  * @ctx_cookie:	Adapter context to set as master.
  */
@@ -688,6 +735,7 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.psa_unmap		= ocxlflash_psa_unmap,
 	.process_element	= ocxlflash_process_element,
 	.start_context		= ocxlflash_start_context,
+	.stop_context		= ocxlflash_stop_context,
 	.set_master		= ocxlflash_set_master,
 	.get_context		= ocxlflash_get_context,
 	.dev_context_init	= ocxlflash_dev_context_init,
-- 
2.1.0
