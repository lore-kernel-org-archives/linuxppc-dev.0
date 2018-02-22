Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTVL3MybzF1c1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:26:50 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMOn6X017038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:26:48 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga2nns19t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:26:48 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:26:47 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 24/38] cxlflash: Support AFU interrupt management
Date: Thu, 22 Feb 2018 16:26:41 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338401-52651-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support to allocate and free AFU interrupts using the OCXL provider
services. The trigger page returned upon successful allocation will be
mapped and exposed to the cxlflash core in a future commit.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 104 ++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/cxlflash/ocxl_hw.h |  10 ++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 1dd679d..acba10f 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -385,6 +385,108 @@ static ssize_t ocxlflash_read_adapter_vpd(struct pci_dev *pdev, void *buf,
 }
 
 /**
+ * free_afu_irqs() - internal service to free interrupts
+ * @ctx:	Adapter context.
+ */
+static void free_afu_irqs(struct ocxlflash_context *ctx)
+{
+	struct ocxl_hw_afu *afu = ctx->hw_afu;
+	struct device *dev = afu->dev;
+	int i;
+
+	if (!ctx->irqs) {
+		dev_err(dev, "%s: Interrupts not allocated\n", __func__);
+		return;
+	}
+
+	for (i = ctx->num_irqs; i >= 0; i--)
+		ocxl_link_free_irq(afu->link_token, ctx->irqs[i].hwirq);
+
+	kfree(ctx->irqs);
+	ctx->irqs = NULL;
+}
+
+/**
+ * alloc_afu_irqs() - internal service to allocate interrupts
+ * @ctx:	Context associated with the request.
+ * @num:	Number of interrupts requested.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int alloc_afu_irqs(struct ocxlflash_context *ctx, int num)
+{
+	struct ocxl_hw_afu *afu = ctx->hw_afu;
+	struct device *dev = afu->dev;
+	struct ocxlflash_irqs *irqs;
+	u64 addr;
+	int rc = 0;
+	int hwirq;
+	int i;
+
+	if (ctx->irqs) {
+		dev_err(dev, "%s: Interrupts already allocated\n", __func__);
+		rc = -EEXIST;
+		goto out;
+	}
+
+	if (num > OCXL_MAX_IRQS) {
+		dev_err(dev, "%s: Too many interrupts num=%d\n", __func__, num);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	irqs = kcalloc(num, sizeof(*irqs), GFP_KERNEL);
+	if (unlikely(!irqs)) {
+		dev_err(dev, "%s: Context irqs allocation failed\n", __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < num; i++) {
+		rc = ocxl_link_irq_alloc(afu->link_token, &hwirq, &addr);
+		if (unlikely(rc)) {
+			dev_err(dev, "%s: ocxl_link_irq_alloc failed rc=%d\n",
+				__func__, rc);
+			goto err;
+		}
+
+		irqs[i].hwirq = hwirq;
+		irqs[i].ptrig = addr;
+	}
+
+	ctx->irqs = irqs;
+	ctx->num_irqs = num;
+out:
+	return rc;
+err:
+	for (i = i-1; i >= 0; i--)
+		ocxl_link_free_irq(afu->link_token, irqs[i].hwirq);
+	kfree(irqs);
+	goto out;
+}
+
+/**
+ * ocxlflash_allocate_afu_irqs() - allocates the requested number of interrupts
+ * @ctx_cookie:	Context associated with the request.
+ * @num:	Number of interrupts requested.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_allocate_afu_irqs(void *ctx_cookie, int num)
+{
+	return alloc_afu_irqs(ctx_cookie, num);
+}
+
+/**
+ * ocxlflash_free_afu_irqs() - frees the interrupts of an adapter context
+ * @ctx_cookie:	Adapter context.
+ */
+static void ocxlflash_free_afu_irqs(void *ctx_cookie)
+{
+	free_afu_irqs(ctx_cookie);
+}
+
+/**
  * ocxlflash_unconfig_afu() - unconfigure the AFU
  * @afu: AFU associated with the host.
  */
@@ -742,6 +844,8 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.release_context	= ocxlflash_release_context,
 	.perst_reloads_same_image = ocxlflash_perst_reloads_same_image,
 	.read_adapter_vpd	= ocxlflash_read_adapter_vpd,
+	.allocate_afu_irqs	= ocxlflash_allocate_afu_irqs,
+	.free_afu_irqs		= ocxlflash_free_afu_irqs,
 	.create_afu		= ocxlflash_create_afu,
 	.destroy_afu		= ocxlflash_destroy_afu,
 	.get_fd			= ocxlflash_get_fd,
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 77c2550..c889368 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -12,6 +12,13 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define OCXL_MAX_IRQS	4	/* Max interrupts per process */
+
+struct ocxlflash_irqs {
+	int hwirq;
+	u64 ptrig;
+};
+
 /* OpenCXL hardware AFU associated with the host */
 struct ocxl_hw_afu {
 	struct ocxlflash_context *ocxl_ctx; /* Host context */
@@ -44,4 +51,7 @@ struct ocxlflash_context {
 
 	phys_addr_t psn_phys;		/* Process mapping */
 	u64 psn_size;			/* Process mapping size */
+
+	struct ocxlflash_irqs *irqs;	/* Pointer to array of structures */
+	int num_irqs;			/* Number of interrupts */
 };
-- 
2.1.0
