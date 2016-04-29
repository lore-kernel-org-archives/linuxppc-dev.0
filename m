Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyN6sDxzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 48/70] powerpc/mm/radix: Pick the address layout for radix
 config
Date: Fri, 29 Apr 2016 23:26:11 +1000
Message-Id: <1461936393-10131-48-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Hash needs special get_unmapped_area() handling because of limitations
around base page size, so we have to set HAVE_ARCH_UNMAPPED_AREA.

With radix we don't have such restrictions, so we could use the generic
code. But because we've set HAVE_ARCH_UNMAPPED_AREA (for hash), we have
to re-implement the same logic as the generic code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/mmap.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 30611f832923..2f1e44362198 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -27,6 +27,8 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/elf-randomize.h>
+#include <linux/security.h>
+#include <linux/mman.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -79,6 +81,111 @@ static inline unsigned long mmap_base(unsigned long rnd)
 	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
 }
 
+#ifdef CONFIG_PPC_RADIX_MMU
+/*
+ * Same function as generic code used only for radix, because we don't need to overload
+ * the generic one. But we will have to duplicate, because hash select
+ * HAVE_ARCH_UNMAPPED_AREA
+ */
+static unsigned long
+radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct vm_unmapped_area_info info;
+
+	if (len > TASK_SIZE - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = 0;
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long
+radix__arch_get_unmapped_area_topdown(struct file *filp,
+				     const unsigned long addr0,
+				     const unsigned long len,
+				     const unsigned long pgoff,
+				     const unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = addr0;
+	struct vm_unmapped_area_info info;
+
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	/* requesting a specific address */
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+				(!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.high_limit = mm->mmap_base;
+	info.align_mask = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (addr & ~PAGE_MASK) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+static void radix__arch_pick_mmap_layout(struct mm_struct *mm,
+					unsigned long random_factor)
+{
+	if (mmap_is_legacy()) {
+		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->get_unmapped_area = radix__arch_get_unmapped_area;
+	} else {
+		mm->mmap_base = mmap_base(random_factor);
+		mm->get_unmapped_area = radix__arch_get_unmapped_area_topdown;
+	}
+}
+#else
+/* dummy */
+extern void radix__arch_pick_mmap_layout(struct mm_struct *mm,
+					unsigned long random_factor);
+#endif
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
@@ -90,6 +197,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	if (current->flags & PF_RANDOMIZE)
 		random_factor = arch_mmap_rnd();
 
+	if (radix_enabled())
+		return radix__arch_pick_mmap_layout(mm, random_factor);
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
-- 
2.5.0
