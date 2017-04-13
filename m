Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3rDs0ZPwzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 05:18:52 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DJ96Gx040757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:18:44 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t19ypswu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:18:44 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 15:18:43 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: Use mm->task_size for boundary checking
 instead of addr_limit
Date: Fri, 14 Apr 2017 00:48:21 +0530
Message-Id: <1492111101-12127-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't init addr_limit correctly for 32 bit applications. So default to using
mm->task_size for boundary condition checking. We use addr_limit to only control
free space search. This makes sure that we do the right thing with 32 bit
applications.

We should consolidate the usage of TASK_SIZE/mm->task_size and
mm->context.addr_limit later.

Partially reverts: fbfef9027c2a7ad (powerpc/mm: Switch some TASK_SIZE checks to use
mm_context addr_limit)

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage-radix.c | 4 ++--
 arch/powerpc/mm/mmap.c              | 8 ++++----
 arch/powerpc/mm/slice.c             | 4 ++--
 arch/powerpc/mm/subpage-prot.c      | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 0aa9cade422f..6575b9aabef4 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -55,7 +55,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > mm->context.addr_limit)
+	if (len > mm->task_size)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -67,7 +67,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (mm->context.addr_limit - len >= addr &&
+		if (mm->task_size - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 355b6fe8a1e6..82fc5762f971 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -101,7 +101,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		     mm->context.addr_limit != TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
-	if (len > mm->context.addr_limit - mmap_min_addr)
+	if (len > mm->task_size - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -110,7 +110,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (mm->context.addr_limit - len >= addr && addr >= mmap_min_addr &&
+		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -145,7 +145,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 		mm->context.addr_limit = TASK_SIZE;
 
 	/* requested length too big for entire address space */
-	if (len > mm->context.addr_limit - mmap_min_addr)
+	if (len > mm->task_size - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -155,7 +155,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (mm->context.addr_limit - len >= addr && addr >= mmap_min_addr &&
+		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 2d2d9760d057..966b9fccfa66 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -292,8 +292,8 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 		 * Check if we need to reduce the range, or if we can
 		 * extend it to cover the next available slice.
 		 */
-		if (addr >= mm->context.addr_limit)
-			addr = mm->context.addr_limit;
+		if (addr >= high_limit)
+			addr = high_limit;
 		else if (slice_scan_available(addr, available, 1, &next_end)) {
 			addr = next_end;
 			goto next_slice;
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index a409f78d206b..e94fbd4c8845 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -197,8 +197,8 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 
 	/* Check parameters */
 	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
-	    addr >= mm->context.addr_limit || len >= mm->context.addr_limit ||
-	    addr + len > mm->context.addr_limit)
+	    addr >= mm->task_size || len >= mm->task_size ||
+	    addr + len > mm->task_size)
 		return -EINVAL;
 
 	if (is_hugepage_only_range(mm, addr, len))
-- 
2.7.4
