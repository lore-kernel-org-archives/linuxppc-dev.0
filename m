Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqZ5z6T6GzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:59:19 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 17:59:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F997357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:59:15 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K7x7M716974072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:59:15 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K7wgAN008024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:58:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mike Marciniszyn <infinipath@intel.com>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org
Subject: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
Date: Wed, 20 Apr 2016 03:58:17 -0400
Message-Id: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver was requesting for a writethrough mapping. But with thoses
flags we will end up with a SAO mapping because we now have memory
conherence always enabled. ie, the existing mapping will end up with
a WIMG value 0b1110 which is Strong Access Order.

Update this to use cache inhibitted guarded mapping

Cc: Mike Marciniszyn <infinipath@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from v1:
* resend because V1 never reached mailing list.

NOTE: This is only compile tested and I am also not sure why ppc64 needs special handling.
We need this patch because the series at http://mid.gmane.org/1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
will drop _PAGE_WRITETHRU

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
