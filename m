Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40908r6t8QzDrNC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:20 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGOgL6082331
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:18 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy3883q3k-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:18 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:34:17 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 28/41] cxlflash: Support adapter context reading
Date: Mon, 26 Mar 2018 11:34:12 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082052-58489-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxlflash userspace API requires that users be able to read the adapter
context for any pending events or interrupts from the AFU. Support reading
various events by implementing the AFU read fop to copy out event data.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 94 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 655377d..f531403 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -17,9 +17,12 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/poll.h>
+#include <linux/sched/signal.h>
 
 #include <misc/ocxl.h>
 
+#include <uapi/misc/cxl.h>
+
 #include "backend.h"
 #include "ocxl_hw.h"
 
@@ -937,9 +940,99 @@ static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 	return mask;
 }
 
+/**
+ * afu_read() - perform a read on the context for any event
+ * @file:	File associated with the adapter context.
+ * @buf:	Buffer to receive the data.
+ * @count:	Size of buffer (maximum bytes that can be read).
+ * @off:	Offset.
+ *
+ * Return: size of the data read on success, -errno on failure
+ */
+static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
+			loff_t *off)
+{
+	struct ocxlflash_context *ctx = file->private_data;
+	struct device *dev = ctx->hw_afu->dev;
+	struct cxl_event event;
+	ulong lock_flags;
+	ssize_t esize;
+	ssize_t rc;
+	int bit;
+	DEFINE_WAIT(event_wait);
+
+	if (*off != 0) {
+		dev_err(dev, "%s: Non-zero offset not supported, off=%lld\n",
+			__func__, *off);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	spin_lock_irqsave(&ctx->slock, lock_flags);
+
+	for (;;) {
+		prepare_to_wait(&ctx->wq, &event_wait, TASK_INTERRUPTIBLE);
+
+		if (ctx_event_pending(ctx))
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			dev_err(dev, "%s: File cannot be blocked on I/O\n",
+				__func__);
+			rc = -EAGAIN;
+			goto err;
+		}
+
+		if (signal_pending(current)) {
+			dev_err(dev, "%s: Signal pending on the process\n",
+				__func__);
+			rc = -ERESTARTSYS;
+			goto err;
+		}
+
+		spin_unlock_irqrestore(&ctx->slock, lock_flags);
+		schedule();
+		spin_lock_irqsave(&ctx->slock, lock_flags);
+	}
+
+	finish_wait(&ctx->wq, &event_wait);
+
+	memset(&event, 0, sizeof(event));
+	event.header.process_element = ctx->pe;
+	event.header.size = sizeof(struct cxl_event_header);
+	if (ctx->pending_irq) {
+		esize = sizeof(struct cxl_event_afu_interrupt);
+		event.header.size += esize;
+		event.header.type = CXL_EVENT_AFU_INTERRUPT;
+
+		bit = find_first_bit(&ctx->irq_bitmap, ctx->num_irqs);
+		clear_bit(bit, &ctx->irq_bitmap);
+		event.irq.irq = bit + 1;
+		if (bitmap_empty(&ctx->irq_bitmap, ctx->num_irqs))
+			ctx->pending_irq = false;
+	}
+
+	spin_unlock_irqrestore(&ctx->slock, lock_flags);
+
+	if (copy_to_user(buf, &event, event.header.size)) {
+		dev_err(dev, "%s: copy_to_user failed\n", __func__);
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = event.header.size;
+out:
+	return rc;
+err:
+	finish_wait(&ctx->wq, &event_wait);
+	spin_unlock_irqrestore(&ctx->slock, lock_flags);
+	goto out;
+}
+
 static const struct file_operations ocxl_afu_fops = {
 	.owner		= THIS_MODULE,
 	.poll		= afu_poll,
+	.read		= afu_read,
 };
 
 #define PATCH_FOPS(NAME)						\
@@ -985,6 +1078,7 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
 	/* Patch the file ops that are not defined */
 	if (fops) {
 		PATCH_FOPS(poll);
+		PATCH_FOPS(read);
 	} else /* Use default ops */
 		fops = (struct file_operations *)&ocxl_afu_fops;
 
-- 
2.1.0
