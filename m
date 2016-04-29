Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxb60TNzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 01/70] IB/qib: Use cache inhibitted and guarded mapping on
 powerpc
Date: Fri, 29 Apr 2016 23:25:24 +1000
Message-Id: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The driver was requesting for a writethrough mapping. But with those
flags we will end up with an SAO mapping because we now have memory
conherence always enabled. ie, the existing mapping will end up with a
WIMG value 0b1110 which is Strong Access Order.

Update this to use cache inhibitted guarded mapping.

Cc: Doug Ledford <dledford@redhat.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 5 +----
 drivers/infiniband/hw/qib/qib_pcie.c     | 6 ------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index e449e394963f..a3d593f546ec 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -822,10 +822,7 @@ static int mmap_piobufs(struct vm_area_struct *vma,
 	phys = dd->physaddr + piobufs;
 
 #if defined(__powerpc__)
-	/* There isn't a generic way to specify writethrough mappings */
-	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
-	pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
-	pgprot_val(vma->vm_page_prot) &= ~_PAGE_GUARDED;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
 
 	/*
diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 4758a3801ae8..6abe1c621aa4 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -144,13 +144,7 @@ int qib_pcie_ddinit(struct qib_devdata *dd, struct pci_dev *pdev,
 	addr = pci_resource_start(pdev, 0);
 	len = pci_resource_len(pdev, 0);
 
-#if defined(__powerpc__)
-	/* There isn't a generic way to specify writethrough mappings */
-	dd->kregbase = __ioremap(addr, len, _PAGE_NO_CACHE | _PAGE_WRITETHRU);
-#else
 	dd->kregbase = ioremap_nocache(addr, len);
-#endif
-
 	if (!dd->kregbase)
 		return -ENOMEM;
 
-- 
2.5.0
