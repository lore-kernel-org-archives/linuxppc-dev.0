Return-Path: <jrdr.linux@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414PgV5DBCzF3RT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 06:26:43 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so4564156plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 13:26:43 -0700 (PDT)
Date: Tue, 12 Jun 2018 01:59:04 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: willy@infradead.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
Subject: [PATCH] misc: ocxl: Change return type for fault handler
Message-ID: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

There is an existing bug when vm_insert_pfn() can return
ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
default. The new inline vmf_insert_pfn() has removed
this inefficiency by returning correct vm_fault_ type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/misc/ocxl/context.c | 22 +++++++++++-----------
 drivers/misc/ocxl/sysfs.c   |  5 ++---
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 909e880..98daf91 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -83,7 +83,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 	return rc;
 }
 
-static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
+static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
 {
 	u64 trigger_addr;
@@ -92,15 +92,15 @@ static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 	if (!trigger_addr)
 		return VM_FAULT_SIGBUS;
 
-	vm_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
 }
 
-static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
+static vm_fault_t map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
 {
 	u64 pp_mmio_addr;
 	int pasid_off;
+	vm_fault_t ret;
 
 	if (offset >= ctx->afu->config.pp_mmio_stride)
 		return VM_FAULT_SIGBUS;
@@ -118,27 +118,27 @@ static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
 		pasid_off * ctx->afu->config.pp_mmio_stride +
 		offset;
 
-	vm_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
+	ret = vmf_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
 	mutex_unlock(&ctx->status_mutex);
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
-static int ocxl_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ocxl_context *ctx = vma->vm_file->private_data;
 	u64 offset;
-	int rc;
+	vm_fault_t ret;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
 	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
 		ctx->pasid, vmf->address, offset);
 
 	if (offset < ctx->afu->irq_base_offset)
-		rc = map_pp_mmio(vma, vmf->address, offset, ctx);
+		ret = map_pp_mmio(vma, vmf->address, offset, ctx);
 	else
-		rc = map_afu_irq(vma, vmf->address, offset, ctx);
-	return rc;
+		ret = map_afu_irq(vma, vmf->address, offset, ctx);
+	return ret;
 }
 
 static const struct vm_operations_struct ocxl_vmops = {
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index d9753a1..0ab1fd1 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -64,7 +64,7 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static int global_mmio_fault(struct vm_fault *vmf)
+static vm_fault_t global_mmio_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ocxl_afu *afu = vma->vm_private_data;
@@ -75,8 +75,7 @@ static int global_mmio_fault(struct vm_fault *vmf)
 
 	offset = vmf->pgoff;
 	offset += (afu->global_mmio_start >> PAGE_SHIFT);
-	vm_insert_pfn(vma, vmf->address, offset);
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address, offset);
 }
 
 static const struct vm_operations_struct global_mmio_vmops = {
-- 
1.9.1
