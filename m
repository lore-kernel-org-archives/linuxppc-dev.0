Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22D131A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 15:18:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 29 Jun 2015 15:18:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D1B143578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 15:18:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5T5Ibl51835300
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 15:18:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5T5ID9Z008547
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 15:18:13 +1000
Subject: [RESEND PATCH] powerpc/powernv: Fix vma page prot flags in opal-prd
 driver
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Date: Mon, 29 Jun 2015 10:47:55 +0530
Message-ID: <20150629051150.17663.63753.stgit@drishya>
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

Resending the patch for inclusion until we have a working solution
without PAGE_SPECIAL.

Kindly queue this patch to fix the mmap issue in opal-prd driver.
The next version/fix with vm_insert_page() will replace this code.
There is no API change on the driver side and hence no side effects of
including this fix until a better solution is available.

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
