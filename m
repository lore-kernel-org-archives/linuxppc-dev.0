Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40908j43l6zF1xf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:13 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGWqxt042580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy1qs8sbe-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:10 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:34:09 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 27/41] cxlflash: Support adapter context polling
Date: Mon, 26 Mar 2018 11:34:03 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082043-58452-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxlflash userspace API requires that users be able to poll the adapter
context for any pending events or interrupts from the AFU. Support polling
on various events by implementing the AFU poll fop using a waitqueue.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 57 +++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/cxlflash/ocxl_hw.h |  2 ++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 576a39e..655377d 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/poll.h>
 
 #include <misc/ocxl.h>
 
@@ -452,6 +453,7 @@ static void *ocxlflash_dev_context_init(struct pci_dev *pdev, void *afu_cookie)
 	}
 
 	spin_lock_init(&ctx->slock);
+	init_waitqueue_head(&ctx->wq);
 
 	ctx->pe = rc;
 	ctx->master = false;
@@ -892,10 +894,57 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
 	goto out;
 }
 
+/**
+ * ctx_event_pending() - check for any event pending on the context
+ * @ctx:	Context to be checked.
+ *
+ * Return: true if there is an event pending, false if none pending
+ */
+static inline bool ctx_event_pending(struct ocxlflash_context *ctx)
+{
+	if (ctx->pending_irq)
+		return true;
+
+	return false;
+}
+
+/**
+ * afu_poll() - poll the AFU for events on the context
+ * @file:	File associated with the adapter context.
+ * @poll:	Poll structure from the user.
+ *
+ * Return: poll mask
+ */
+static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
+{
+	struct ocxlflash_context *ctx = file->private_data;
+	struct device *dev = ctx->hw_afu->dev;
+	ulong lock_flags;
+	int mask = 0;
+
+	poll_wait(file, &ctx->wq, poll);
+
+	spin_lock_irqsave(&ctx->slock, lock_flags);
+	if (ctx_event_pending(ctx))
+		mask |= POLLIN | POLLRDNORM;
+	else
+		mask |= POLLERR;
+	spin_unlock_irqrestore(&ctx->slock, lock_flags);
+
+	dev_dbg(dev, "%s: Poll wait completed for pe %i mask %i\n",
+		__func__, ctx->pe, mask);
+
+	return mask;
+}
+
 static const struct file_operations ocxl_afu_fops = {
 	.owner		= THIS_MODULE,
+	.poll		= afu_poll,
 };
 
+#define PATCH_FOPS(NAME)						\
+	do { if (!fops->NAME) fops->NAME = ocxl_afu_fops.NAME; } while (0)
+
 /**
  * ocxlflash_get_fd() - get file descriptor for an adapter context
  * @ctx_cookie:	Adapter context.
@@ -933,8 +982,10 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
 	}
 	fdtmp = rc;
 
-	/* Use default ops if there is no fops */
-	if (!fops)
+	/* Patch the file ops that are not defined */
+	if (fops) {
+		PATCH_FOPS(poll);
+	} else /* Use default ops */
 		fops = (struct file_operations *)&ocxl_afu_fops;
 
 	name = kasprintf(GFP_KERNEL, "ocxlflash:%d", ctx->pe);
@@ -998,6 +1049,8 @@ static irqreturn_t ocxlflash_afu_irq(int irq, void *data)
 	set_bit(i - 1, &ctx->irq_bitmap);
 	ctx->pending_irq = true;
 	spin_unlock(&ctx->slock);
+
+	wake_up_all(&ctx->wq);
 out:
 	return IRQ_HANDLED;
 }
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 2eb5390..acd2801 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -56,6 +56,8 @@ struct ocxlflash_context {
 	u64 psn_size;			/* Process mapping size */
 
 	spinlock_t slock;		/* Protects irq/fault/event updates */
+	wait_queue_head_t wq;		/* Wait queue for poll and interrupts */
+
 	struct ocxlflash_irqs *irqs;	/* Pointer to array of structures */
 	int num_irqs;			/* Number of interrupts */
 	bool pending_irq;		/* Pending interrupt on the context */
-- 
2.1.0
