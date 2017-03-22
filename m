Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPl4c01zDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:38:19 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3TDJm103484
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:17 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vptsbe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:17 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:38:15 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 15/17] powerpc/mm: Switch TASK_SIZE check to use
 mm->task_size
Date: Wed, 22 Mar 2017 09:07:01 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage-radix.c |  4 ++--
 arch/powerpc/mm/mmap.c              | 12 ++++++------
 arch/powerpc/mm/slice.c             |  6 +++---
 arch/powerpc/mm/subpage-prot.c      |  3 ++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 35254a678456..686cfe8e664b 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -52,7 +52,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > TASK_SIZE)
+	if (len > mm->task_size)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -64,7 +64,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (mm->task_size - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index a5d9ef59debe..bce788a41bc3 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -97,7 +97,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info;
 
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mm->task_size - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -106,7 +106,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -114,7 +114,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.high_limit = mm->task_size;
 	info.align_mask = 0;
 	return vm_unmapped_area(&info);
 }
@@ -132,7 +132,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	struct vm_unmapped_area_info info;
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mm->task_size - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -142,7 +142,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -164,7 +164,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
+		info.high_limit = mm->task_size;
 		addr = vm_unmapped_area(&info);
 	}
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 217638846053..6d214786a2df 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -277,7 +277,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 	info.align_offset = 0;
 
 	addr = TASK_UNMAPPED_BASE;
-	while (addr < TASK_SIZE) {
+	while (addr < mm->task_size) {
 		info.low_limit = addr;
 		if (!slice_scan_available(addr, available, 1, &addr))
 			continue;
@@ -289,8 +289,8 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 		 * Check if we need to reduce the range, or if we can
 		 * extend it to cover the next available slice.
 		 */
-		if (addr >= TASK_SIZE)
-			addr = TASK_SIZE;
+		if (addr >= mm->task_size)
+			addr = mm->task_size;
 		else if (slice_scan_available(addr, available, 1, &next_end)) {
 			addr = next_end;
 			goto next_slice;
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 94210940112f..e94fbd4c8845 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -197,7 +197,8 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 
 	/* Check parameters */
 	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
-	    addr >= TASK_SIZE || len >= TASK_SIZE || addr + len > TASK_SIZE)
+	    addr >= mm->task_size || len >= mm->task_size ||
+	    addr + len > mm->task_size)
 		return -EINVAL;
 
 	if (is_hugepage_only_range(mm, addr, len))
-- 
2.7.4
