Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqxFb6LRzzDqSX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:24:19 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QMOHkZ012687
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:24:17 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcp5pk18t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:24:17 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 17:24:09 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v2 30/38] cxlflash: Support file descriptor mapping
Date: Mon, 26 Feb 2018 16:24:04 -0600
In-Reply-To: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519683844-17835-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxlflash core fop API requires a way to invoke the fault and release
handlers of underlying transports using their native file-based APIs. This
provides the core with the ability to insert selectively itself into the
processing stream of these operations for cleanup. Implement these two
fops to map and release when requested.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 226fd6b..cb1becd 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1259,6 +1259,30 @@ static int ocxlflash_start_work(void *ctx_cookie, u64 num_irqs)
 		afu_unmap_irq(0, ctx, i, ctx);
 	free_afu_irqs(ctx);
 	goto out;
+};
+
+/**
+ * ocxlflash_fd_mmap() - mmap handler for adapter file descriptor
+ * @file:	File installed with adapter file descriptor.
+ * @vma:	VM area associated with mapping.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_fd_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return afu_mmap(file, vma);
+}
+
+/**
+ * ocxlflash_fd_release() - release the context associated with the file
+ * @inode:	File inode pointer.
+ * @file:	File associated with the adapter context.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_fd_release(struct inode *inode, struct file *file)
+{
+	return afu_release(inode, file);
 }
 
 /* Backend ops to ocxlflash services */
@@ -1284,4 +1308,6 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.get_fd			= ocxlflash_get_fd,
 	.fops_get_context	= ocxlflash_fops_get_context,
 	.start_work		= ocxlflash_start_work,
+	.fd_mmap		= ocxlflash_fd_mmap,
+	.fd_release		= ocxlflash_fd_release,
 };
-- 
2.1.0
