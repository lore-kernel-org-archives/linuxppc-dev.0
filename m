Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090903QhmzF1wc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:28 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QG5TCE027296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:26 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy42u954b-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:26 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:34:25 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 29/41] cxlflash: Support adapter context mmap and release
Date: Mon, 26 Mar 2018 11:34:20 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082060-58527-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxlflash userspace API requires that users be able to mmap and release
the adapter context. Support mapping by implementing the AFU mmap fop to
map the context MMIO space and install the corresponding page table entry
upon page fault. Similarly, implement the AFU release fop to terminate and
clean up the context when invoked.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index f531403..8a9f2f4 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1029,10 +1029,80 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	goto out;
 }
 
+/**
+ * afu_release() - release and free the context
+ * @inode:	File inode pointer.
+ * @file:	File associated with the context.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int afu_release(struct inode *inode, struct file *file)
+{
+	struct ocxlflash_context *ctx = file->private_data;
+	int i;
+
+	/* Unmap and free the interrupts associated with the context */
+	for (i = ctx->num_irqs; i >= 0; i--)
+		afu_unmap_irq(0, ctx, i, ctx);
+	free_afu_irqs(ctx);
+
+	return ocxlflash_release_context(ctx);
+}
+
+/**
+ * ocxlflash_mmap_fault() - mmap fault handler
+ * @vmf:	VM fault associated with current fault.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_mmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ocxlflash_context *ctx = vma->vm_file->private_data;
+	u64 mmio_area, offset;
+
+	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= ctx->psn_size)
+		return VM_FAULT_SIGBUS;
+
+	mmio_area = ctx->psn_phys;
+	mmio_area += offset;
+
+	vm_insert_pfn(vma, vmf->address, mmio_area >> PAGE_SHIFT);
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct ocxlflash_vmops = {
+	.fault = ocxlflash_mmap_fault,
+};
+
+/**
+ * afu_mmap() - map the fault handler operations
+ * @file:	File associated with the context.
+ * @vma:	VM area associated with mapping.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int afu_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct ocxlflash_context *ctx = file->private_data;
+
+	if ((vma_pages(vma) + vma->vm_pgoff) >
+	    (ctx->psn_size >> PAGE_SHIFT))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops = &ocxlflash_vmops;
+	return 0;
+}
+
 static const struct file_operations ocxl_afu_fops = {
 	.owner		= THIS_MODULE,
 	.poll		= afu_poll,
 	.read		= afu_read,
+	.release	= afu_release,
+	.mmap		= afu_mmap,
 };
 
 #define PATCH_FOPS(NAME)						\
@@ -1079,6 +1149,8 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
 	if (fops) {
 		PATCH_FOPS(poll);
 		PATCH_FOPS(read);
+		PATCH_FOPS(release);
+		PATCH_FOPS(mmap);
 	} else /* Use default ops */
 		fops = (struct file_operations *)&ocxl_afu_fops;
 
-- 
2.1.0
