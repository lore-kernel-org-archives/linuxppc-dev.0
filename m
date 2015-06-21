Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 809721A0170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 04:26:24 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sun, 21 Jun 2015 23:56:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E27B125804B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2015 23:58:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5LIQIV943122774
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2015 23:56:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5LIQIp3003024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2015 23:56:18 +0530
Subject: [PATCH] powerpc/powernv: Fix vma page prot flags in opal-prd driver
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Date: Sun, 21 Jun 2015 23:56:16 +0530
Message-ID: <20150621182616.9866.16633.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal-prd driver will mmap() firmware code/data area as private
mapping to prd user space daemon.  Write to this page will
trigger COW faults.  The new COW pages are normal kernel RAM
pages accounted by the kernel and are not special.

vma->vm_page_prot value will be used at page fault time
for the new COW pages, while pgprot_t value passed in
remap_pfn_range() is used for the initial page table entry.

Hence:
* Do not add _PAGE_SPECIAL in vma, but only for remap_pfn_range()
* Also remap_pfn_range() will add the _PAGE_SPECIAL flag using
  pte_mkspecial() call, hence no need to specify in the driver

This fix resolves the page accounting warning shown below:
BUG: Bad rss-counter state mm:c0000007d34ac600 idx:1 val:19

The above warning is triggered since _PAGE_SPECIAL was incorrectly
being set for the normal kernel COW pages.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-prd.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 46cb3fe..4ece8e4 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -112,6 +112,7 @@ static int opal_prd_open(struct inode *inode, struct file *file)
 static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	size_t addr, size;
+	pgprot_t page_prot;
 	int rc;
 
 	pr_devel("opal_prd_mmap(0x%016lx, 0x%016lx, 0x%lx, 0x%lx)\n",
@@ -125,13 +126,11 @@ static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!opal_prd_range_is_valid(addr, size))
 		return -EINVAL;
 
-	vma->vm_page_prot = __pgprot(pgprot_val(phys_mem_access_prot(file,
-						vma->vm_pgoff,
-						 size, vma->vm_page_prot))
-					| _PAGE_SPECIAL);
+	page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
+					 size, vma->vm_page_prot);
 
 	rc = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
-			vma->vm_page_prot);
+				page_prot);
 
 	return rc;
 }
