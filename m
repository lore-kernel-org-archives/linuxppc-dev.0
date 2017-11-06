Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6n292MzDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:44 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id l24so7802244pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 4/5] powerpc/64s/radix: Fix 128TB-512TB virtual address
 boundary case allocation
Date: Mon,  6 Nov 2017 21:03:14 +1100
Message-Id: <20171106100315.29720-5-npiggin@gmail.com>
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix VA space allocations test addresses against mm->task_size which is
512TB, even in cases where the intention is to limit allocation to below
128TB.

This results in mmap with a hint address below 128TB but address + length
above 128TB succeeding when it should fail (as hash does after the
previous patch).

Set the high address limit to be considered up front, and base subsequent
allocation checks on that consistently.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/hugetlbpage-radix.c | 13 +++++++------
 arch/powerpc/mm/mmap.c              | 27 ++++++++++++++-------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index a12e86395025..9c6a411e9c85 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -48,14 +48,18 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct hstate *h = hstate_file(file);
+	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
 	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
+	if (addr > high_limit)
+		high_limit = TASK_SIZE;
+
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > mm->task_size)
+	if (len > high_limit)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -67,7 +71,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (mm->task_size - len >= addr &&
+		if (high_limit - len >= addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
@@ -78,12 +82,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = current->mm->mmap_base;
+	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
 
-	if (addr > DEFAULT_MAP_WINDOW)
-		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
-
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 5d78b193fec4..e6cb3b3f7e93 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -106,13 +106,17 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
 	if (unlikely(addr > mm->context.addr_limit &&
 		     mm->context.addr_limit != TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
-	if (len > mm->task_size - mmap_min_addr)
+	if (addr > high_limit)
+		high_limit = TASK_SIZE;
+
+	if (len > high_limit - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -121,7 +125,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
+		if (high_limit - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
@@ -129,13 +133,9 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
+	info.high_limit = high_limit;
 	info.align_mask = 0;
 
-	if (unlikely(addr > DEFAULT_MAP_WINDOW))
-		info.high_limit = mm->context.addr_limit;
-	else
-		info.high_limit = DEFAULT_MAP_WINDOW;
-
 	return vm_unmapped_area(&info);
 }
 
@@ -149,14 +149,18 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
+	unsigned long high_limit = DEFAULT_MAP_WINDOW;
 	struct vm_unmapped_area_info info;
 
 	if (unlikely(addr > mm->context.addr_limit &&
 		     mm->context.addr_limit != TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
+	if (addr > high_limit)
+		high_limit = TASK_SIZE;
+
 	/* requested length too big for entire address space */
-	if (len > mm->task_size - mmap_min_addr)
+	if (len > high_limit - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -166,7 +170,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
+		if (high_limit - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
@@ -174,12 +178,9 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = mm->mmap_base;
+	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
 	info.align_mask = 0;
 
-	if (addr > DEFAULT_MAP_WINDOW)
-		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
-
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
 		return addr;
-- 
2.15.0
