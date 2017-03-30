Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3GB01mMzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 18/19] powerpc/mm: Switch some TASK_SIZE checks to use
 mm_context addr_limit
Date: Thu, 30 Mar 2017 23:04:06 +1100
Message-Id: <1490875447-4016-18-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hugetlbpage-radix.c |  4 ++--
 arch/powerpc/mm/mmap.c              | 12 ++++++------
 arch/powerpc/mm/slice.c             |  6 +++---
 arch/powerpc/mm/subpage-prot.c      |  3 ++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 35254a678456..95207c117b82 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -52,7 +52,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > TASK_SIZE)
+	if (len > mm->context.addr_limit)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -64,7 +64,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (mm->context.addr_limit - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index a5d9ef59debe..6e9fead92969 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -97,7 +97,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info;
 
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mm->context.addr_limit - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -106,7 +106,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mm->context.addr_limit - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -114,7 +114,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.high_limit = mm->context.addr_limit;
 	info.align_mask = 0;
 	return vm_unmapped_area(&info);
 }
@@ -132,7 +132,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	struct vm_unmapped_area_info info;
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mm->context.addr_limit - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -142,7 +142,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mm->context.addr_limit - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -164,7 +164,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
+		info.high_limit = mm->context.addr_limit;
 		addr = vm_unmapped_area(&info);
 	}
 
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index a79a20d4cf99..bf41825054d0 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -277,7 +277,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 	info.align_offset = 0;
 
 	addr = TASK_UNMAPPED_BASE;
-	while (addr < TASK_SIZE) {
+	while (addr < mm->context.addr_limit) {
 		info.low_limit = addr;
 		if (!slice_scan_available(addr, available, 1, &addr))
 			continue;
@@ -289,8 +289,8 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 		 * Check if we need to reduce the range, or if we can
 		 * extend it to cover the next available slice.
 		 */
-		if (addr >= TASK_SIZE)
-			addr = TASK_SIZE;
+		if (addr >= mm->context.addr_limit)
+			addr = mm->context.addr_limit;
 		else if (slice_scan_available(addr, available, 1, &next_end)) {
 			addr = next_end;
 			goto next_slice;
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 94210940112f..a409f78d206b 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -197,7 +197,8 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 
 	/* Check parameters */
 	if ((addr & ~PAGE_MASK) || (len & ~PAGE_MASK) ||
-	    addr >= TASK_SIZE || len >= TASK_SIZE || addr + len > TASK_SIZE)
+	    addr >= mm->context.addr_limit || len >= mm->context.addr_limit ||
+	    addr + len > mm->context.addr_limit)
 		return -EINVAL;
 
 	if (is_hugepage_only_range(mm, addr, len))
-- 
2.7.4
