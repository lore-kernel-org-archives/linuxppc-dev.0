Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40907N0zlLzF23q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:33:03 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGWJZR055222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:33:02 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy3nd2b7a-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:33:01 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:33:00 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 18/41] cxlflash: Support process specific mappings
Date: Mon, 26 Mar 2018 11:32:56 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081976-58117-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once the context is started, the assigned MMIO space can be mapped
and unmapped. Provide means to map and unmap the context MMIO space.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index b39a03d..73b0b10 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -151,6 +151,28 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 }
 
 /**
+ * ocxlflash_psa_map() - map the process specific MMIO space
+ * @ctx_cookie:	Adapter context for which the mapping needs to be done.
+ *
+ * Return: MMIO pointer of the mapped region
+ */
+static void __iomem *ocxlflash_psa_map(void *ctx_cookie)
+{
+	struct ocxlflash_context *ctx = ctx_cookie;
+
+	return ioremap(ctx->psn_phys, ctx->psn_size);
+}
+
+/**
+ * ocxlflash_psa_unmap() - unmap the process specific MMIO space
+ * @addr:	MMIO pointer to unmap.
+ */
+static void ocxlflash_psa_unmap(void __iomem *addr)
+{
+	iounmap(addr);
+}
+
+/**
  * ocxlflash_process_element() - get process element of the adapter context
  * @ctx_cookie:	Adapter context associated with the process element.
  *
@@ -618,6 +640,8 @@ static void *ocxlflash_fops_get_context(struct file *file)
 /* Backend ops to ocxlflash services */
 const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.module			= THIS_MODULE,
+	.psa_map		= ocxlflash_psa_map,
+	.psa_unmap		= ocxlflash_psa_unmap,
 	.process_element	= ocxlflash_process_element,
 	.start_context		= ocxlflash_start_context,
 	.set_master		= ocxlflash_set_master,
-- 
2.1.0
