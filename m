Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTVm1FTPzDrVg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:27:12 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMPdqn019842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:27:10 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga31w854v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:27:10 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:27:09 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 27/38] cxlflash: Support adapter context polling
Date: Thu, 22 Feb 2018 16:27:04 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338424-52759-1-git-send-email-ukrishn@linux.vnet.ibm.com>
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
---
 drivers/scsi/cxlflash/ocxl_hw.c | 57 +++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/cxlflash/ocxl_hw.h |  2 ++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 4ca4a72..3297934 100644
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
@@ -884,10 +886,57 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
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
@@ -925,8 +974,10 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
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
@@ -990,6 +1041,8 @@ static irqreturn_t ocxlflash_afu_irq(int irq, void *data)
 	set_bit(i - 1, &ctx->irq_bitmap);
 	ctx->pending_irq = true;
 	spin_unlock(&ctx->slock);
+
+	wake_up_all(&ctx->wq);
 out:
 	return IRQ_HANDLED;
 }
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index c7cbf67..bdf9422 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -55,6 +55,8 @@ struct ocxlflash_context {
 	u64 psn_size;			/* Process mapping size */
 
 	spinlock_t slock;		/* Protects irq/fault/event updates */
+	wait_queue_head_t wq;		/* Wait queue for poll and interrupts */
+
 	struct ocxlflash_irqs *irqs;	/* Pointer to array of structures */
 	int num_irqs;			/* Number of interrupts */
 	bool pending_irq;		/* Pending interrupt on the context */
-- 
2.1.0
