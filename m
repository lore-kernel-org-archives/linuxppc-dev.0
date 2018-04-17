Return-Path: <jrdr.linux@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QSrk4BbvzF21G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 00:52:03 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j11so5719170pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 07:52:02 -0700 (PDT)
Date: Tue, 17 Apr 2018 20:23:54 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 willy@infradead.org
Subject: [PATCH] misc: cxl: Change return type to vm_fault_t
Message-ID: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
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

previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
default value irrespective of vm_insert_pfn() return
value. This bug is fixed with new vmf_insert_pfn()
which will return VM_FAULT_ type based on err.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/misc/cxl/context.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 7ff315a..c6ec872 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -128,11 +128,12 @@ void cxl_context_set_mapping(struct cxl_context *ctx,
 	mutex_unlock(&ctx->mapping_lock);
 }

-static int cxl_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct cxl_context *ctx = vma->vm_file->private_data;
 	u64 area, offset;
+	vm_fault_t ret;

 	offset = vmf->pgoff << PAGE_SHIFT;

@@ -169,11 +170,11 @@ static int cxl_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}

-	vm_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
+	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);

 	mutex_unlock(&ctx->status_mutex);

-	return VM_FAULT_NOPAGE;
+	return ret;
 }

 static const struct vm_operations_struct cxl_mmap_vmops = {
--
1.9.1
