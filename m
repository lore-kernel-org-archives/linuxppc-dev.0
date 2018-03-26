Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40909v1NwszF23w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:35:14 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGOrSC083325
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy3883r4a-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:12 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:35:12 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 36/41] cxlflash: Register for translation errors
Date: Mon, 26 Mar 2018 11:35:07 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082107-58787-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While enabling a context on the link, a predefined callback can be
registered with the OCXL provider services to be notified on translation
errors. These errors can in turn be passed back to the user on a read
operation.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 31 +++++++++++++++++++++++++++++--
 drivers/scsi/cxlflash/ocxl_hw.h |  4 ++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 89d3d89..5b5565d 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -335,6 +335,25 @@ static u64 ocxlflash_get_irq_objhndl(void *ctx_cookie, int irq)
 }
 
 /**
+ * ocxlflash_xsl_fault() - callback when translation error is triggered
+ * @data:	Private data provided at callback registration, the context.
+ * @addr:	Address that triggered the error.
+ * @dsisr:	Value of dsisr register.
+ */
+static void ocxlflash_xsl_fault(void *data, u64 addr, u64 dsisr)
+{
+	struct ocxlflash_context *ctx = data;
+
+	spin_lock(&ctx->slock);
+	ctx->fault_addr = addr;
+	ctx->fault_dsisr = dsisr;
+	ctx->pending_fault = true;
+	spin_unlock(&ctx->slock);
+
+	wake_up_all(&ctx->wq);
+}
+
+/**
  * start_context() - local routine to start a context
  * @ctx:	Adapter context to be started.
  *
@@ -378,7 +397,8 @@ static int start_context(struct ocxlflash_context *ctx)
 		mm = current->mm;
 	}
 
-	rc = ocxl_link_add_pe(link_token, ctx->pe, pid, 0, 0, mm, NULL, NULL);
+	rc = ocxl_link_add_pe(link_token, ctx->pe, pid, 0, 0, mm,
+			      ocxlflash_xsl_fault, ctx);
 	if (unlikely(rc)) {
 		dev_err(dev, "%s: ocxl_link_add_pe failed rc=%d\n",
 			__func__, rc);
@@ -512,6 +532,7 @@ static void *ocxlflash_dev_context_init(struct pci_dev *pdev, void *afu_cookie)
 	ctx->hw_afu = afu;
 	ctx->irq_bitmap = 0;
 	ctx->pending_irq = false;
+	ctx->pending_fault = false;
 out:
 	return ctx;
 err2:
@@ -965,7 +986,7 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
  */
 static inline bool ctx_event_pending(struct ocxlflash_context *ctx)
 {
-	if (ctx->pending_irq)
+	if (ctx->pending_irq || ctx->pending_fault)
 		return true;
 
 	return false;
@@ -1070,6 +1091,12 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		event.irq.irq = bit + 1;
 		if (bitmap_empty(&ctx->irq_bitmap, ctx->num_irqs))
 			ctx->pending_irq = false;
+	} else if (ctx->pending_fault) {
+		event.header.size += sizeof(struct cxl_event_data_storage);
+		event.header.type = CXL_EVENT_DATA_STORAGE;
+		event.fault.addr = ctx->fault_addr;
+		event.fault.dsisr = ctx->fault_dsisr;
+		ctx->pending_fault = false;
 	}
 
 	spin_unlock_irqrestore(&ctx->slock, lock_flags);
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 1829e55..9270d35 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -70,4 +70,8 @@ struct ocxlflash_context {
 	int num_irqs;			/* Number of interrupts */
 	bool pending_irq;		/* Pending interrupt on the context */
 	ulong irq_bitmap;		/* Bits indicating pending irq num */
+
+	u64 fault_addr;			/* Address that triggered the fault */
+	u64 fault_dsisr;		/* Value of dsisr register at fault */
+	bool pending_fault;		/* Pending translation fault */
 };
-- 
2.1.0
