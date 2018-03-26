Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40909K3YmbzF23w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:45 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGYaa2146373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy14r2gp7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:34:40 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 31/41] cxlflash: Introduce object handle fop
Date: Mon, 26 Mar 2018 11:34:35 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082075-58601-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OCXL requires that AFUs use an opaque object handle to represent
an AFU interrupt. The specification does not provide a common means
to communicate the object handle to the AFU - each AFU must define
this within the AFU specification. To support this model, the object
handle must be passed back to the core driver as it manages the AFU
specification (SISLite) for cxlflash. Note that for Power systems,
the object handle is the effective address of the trigger page.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/backend.h |  1 +
 drivers/scsi/cxlflash/cxl_hw.c  |  7 +++++++
 drivers/scsi/cxlflash/ocxl_hw.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/scsi/cxlflash/backend.h b/drivers/scsi/cxlflash/backend.h
index f675bcb..bcd8a6c 100644
--- a/drivers/scsi/cxlflash/backend.h
+++ b/drivers/scsi/cxlflash/backend.h
@@ -23,6 +23,7 @@ struct cxlflash_backend_ops {
 	int (*map_afu_irq)(void *ctx_cookie, int num, irq_handler_t handler,
 			   void *cookie, char *name);
 	void (*unmap_afu_irq)(void *ctx_cookie, int num, void *cookie);
+	u64 (*get_irq_objhndl)(void *ctx_cookie, int irq);
 	int (*start_context)(void *ctx_cookie);
 	int (*stop_context)(void *ctx_cookie);
 	int (*afu_reset)(void *ctx_cookie);
diff --git a/drivers/scsi/cxlflash/cxl_hw.c b/drivers/scsi/cxlflash/cxl_hw.c
index a1d6d12..b42da88 100644
--- a/drivers/scsi/cxlflash/cxl_hw.c
+++ b/drivers/scsi/cxlflash/cxl_hw.c
@@ -49,6 +49,12 @@ static void cxlflash_unmap_afu_irq(void *ctx_cookie, int num, void *cookie)
 	cxl_unmap_afu_irq(ctx_cookie, num, cookie);
 }
 
+static u64 cxlflash_get_irq_objhndl(void *ctx_cookie, int irq)
+{
+	/* Dummy fop for cxl */
+	return 0;
+}
+
 static int cxlflash_start_context(void *ctx_cookie)
 {
 	return cxl_start_context(ctx_cookie, 0, NULL);
@@ -153,6 +159,7 @@ const struct cxlflash_backend_ops cxlflash_cxl_ops = {
 	.process_element	= cxlflash_process_element,
 	.map_afu_irq		= cxlflash_map_afu_irq,
 	.unmap_afu_irq		= cxlflash_unmap_afu_irq,
+	.get_irq_objhndl	= cxlflash_get_irq_objhndl,
 	.start_context		= cxlflash_start_context,
 	.stop_context		= cxlflash_stop_context,
 	.afu_reset		= cxlflash_afu_reset,
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 4bbc1d1..f77f4d7 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -308,6 +308,23 @@ static void ocxlflash_unmap_afu_irq(void *ctx_cookie, int num, void *cookie)
 }
 
 /**
+ * ocxlflash_get_irq_objhndl() - get the object handle for an interrupt
+ * @ctx_cookie:	Context associated with the interrupt.
+ * @irq:	Interrupt number.
+ *
+ * Return: effective address of the mapped region
+ */
+static u64 ocxlflash_get_irq_objhndl(void *ctx_cookie, int irq)
+{
+	struct ocxlflash_context *ctx = ctx_cookie;
+
+	if (irq < 0 || irq >= ctx->num_irqs)
+		return 0;
+
+	return (__force u64)ctx->irqs[irq].vtrig;
+}
+
+/**
  * start_context() - local routine to start a context
  * @ctx:	Adapter context to be started.
  *
@@ -1301,6 +1318,7 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.process_element	= ocxlflash_process_element,
 	.map_afu_irq		= ocxlflash_map_afu_irq,
 	.unmap_afu_irq		= ocxlflash_unmap_afu_irq,
+	.get_irq_objhndl	= ocxlflash_get_irq_objhndl,
 	.start_context		= ocxlflash_start_context,
 	.stop_context		= ocxlflash_stop_context,
 	.set_master		= ocxlflash_set_master,
-- 
2.1.0
