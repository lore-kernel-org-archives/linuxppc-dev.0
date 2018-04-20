Return-Path: <jrdr.linux@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SNDR6SQVzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 03:30:47 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y69so4594405pfb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 10:30:47 -0700 (PDT)
Date: Fri, 20 Apr 2018 23:02:39 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: willy@infradead.org, jk@ozlabs.org, arnd@arndb.de,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
Message-ID: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
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

Reference id -> 1c8f422059ae ("mm: change return type to
vm_fault_t")

We are fixing a minor bug, that the error from vm_insert_
pfn() was being ignored and the effect of this is likely
to be only felt in OOM situations.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 469bdd0..43e7b93 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -232,12 +232,13 @@ static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
 	return size;
 }
 
-static int
+static vm_fault_t
 spufs_mem_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct spu_context *ctx	= vma->vm_file->private_data;
 	unsigned long pfn, offset;
+	vm_fault_t ret;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= LS_SIZE)
@@ -256,11 +257,11 @@ static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
 		vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
 		pfn = (ctx->spu->local_store_phys + offset) >> PAGE_SHIFT;
 	}
-	vm_insert_pfn(vma, vmf->address, pfn);
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
 
 	spu_release(ctx);
 
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 static int spufs_mem_mmap_access(struct vm_area_struct *vma,
@@ -312,13 +313,14 @@ static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 	.mmap			= spufs_mem_mmap,
 };
 
-static int spufs_ps_fault(struct vm_fault *vmf,
+static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 				    unsigned long ps_offs,
 				    unsigned long ps_size)
 {
 	struct spu_context *ctx = vmf->vma->vm_file->private_data;
 	unsigned long area, offset = vmf->pgoff << PAGE_SHIFT;
-	int ret = 0;
+	int err = 0;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 
 	spu_context_nospu_trace(spufs_ps_fault__enter, ctx);
 
@@ -349,25 +351,26 @@ static int spufs_ps_fault(struct vm_fault *vmf,
 	if (ctx->state == SPU_STATE_SAVED) {
 		up_read(&current->mm->mmap_sem);
 		spu_context_nospu_trace(spufs_ps_fault__sleep, ctx);
-		ret = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
+		err = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
 		spu_context_trace(spufs_ps_fault__wake, ctx, ctx->spu);
 		down_read(&current->mm->mmap_sem);
 	} else {
 		area = ctx->spu->problem_phys + ps_offs;
-		vm_insert_pfn(vmf->vma, vmf->address, (area + offset) >> PAGE_SHIFT);
+		ret = vmf_insert_pfn(vmf->vma, vmf->address,
+				(area + offset) >> PAGE_SHIFT);
 		spu_context_trace(spufs_ps_fault__insert, ctx, ctx->spu);
 	}
 
-	if (!ret)
+	if (!err)
 		spu_release(ctx);
 
 refault:
 	put_spu_context(ctx);
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 #if SPUFS_MMAP_4K
-static int spufs_cntl_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t spufs_cntl_mmap_fault(struct vm_fault *vmf)
 {
 	return spufs_ps_fault(vmf, 0x4000, SPUFS_CNTL_MAP_SIZE);
 }
@@ -1040,7 +1043,7 @@ static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
 	return 4;
 }
 
-static int
+static vm_fault_t
 spufs_signal1_mmap_fault(struct vm_fault *vmf)
 {
 #if SPUFS_SIGNAL_MAP_SIZE == 0x1000
@@ -1178,7 +1181,7 @@ static ssize_t spufs_signal2_write(struct file *file, const char __user *buf,
 }
 
 #if SPUFS_MMAP_4K
-static int
+static vm_fault_t
 spufs_signal2_mmap_fault(struct vm_fault *vmf)
 {
 #if SPUFS_SIGNAL_MAP_SIZE == 0x1000
@@ -1307,7 +1310,7 @@ static u64 spufs_signal2_type_get(struct spu_context *ctx)
 		       spufs_signal2_type_set, "%llu\n", SPU_ATTR_ACQUIRE);
 
 #if SPUFS_MMAP_4K
-static int
+static vm_fault_t
 spufs_mss_mmap_fault(struct vm_fault *vmf)
 {
 	return spufs_ps_fault(vmf, 0x0000, SPUFS_MSS_MAP_SIZE);
@@ -1369,7 +1372,7 @@ static int spufs_mss_open(struct inode *inode, struct file *file)
 	.llseek  = no_llseek,
 };
 
-static int
+static vm_fault_t
 spufs_psmap_mmap_fault(struct vm_fault *vmf)
 {
 	return spufs_ps_fault(vmf, 0x0000, SPUFS_PS_MAP_SIZE);
@@ -1429,7 +1432,7 @@ static int spufs_psmap_open(struct inode *inode, struct file *file)
 
 
 #if SPUFS_MMAP_4K
-static int
+static vm_fault_t
 spufs_mfc_mmap_fault(struct vm_fault *vmf)
 {
 	return spufs_ps_fault(vmf, 0x3000, SPUFS_MFC_MAP_SIZE);
-- 
1.9.1
