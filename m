Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqr040mzzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:08 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:06 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 162603E40030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:05 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8Q58m40894492
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:26:05 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Q2CU029160
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 43/65] powerpc/mm/radix: Pick the address layout for radix
 config
Date: Sun, 27 Mar 2016 13:53:51 +0530
Message-Id: <1459067053-10835-43-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is same as the generic code, but then we have to duplicate
because we need to enable enable this along with hash which set
HAVE_ARCH_UNMAPPED_AREA. Hash need special get_unmapped_area handling
because of limitations around base page size. With radix we don't have
such restrictions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmap.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 0f0502e12f6c..001997c7299b 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -26,6 +26,8 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/security.h>
+#include <linux/mman.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -78,6 +80,111 @@ static inline unsigned long mmap_base(unsigned long rnd)
 	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
 }
 
+#ifdef CONFIG_PPC_RADIX_MMU
+/*
+ * Same function as generic code used only for radix, because we don't need to overload
+ * the generic one. But we will have to duplicate, because hash select
+ * HAVE_ARCH_UNMAPPED_AREA
+ */
+static unsigned long
+arch_radix_get_unmapped_area(struct file *filp, unsigned long addr,
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
+arch_radix_get_unmapped_area_topdown(struct file *filp,
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
+static void arch_pick_radix_mmap_layout(struct mm_struct *mm,
+					unsigned long random_factor)
+{
+	if (mmap_is_legacy()) {
+		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->get_unmapped_area = arch_radix_get_unmapped_area;
+	} else {
+		mm->mmap_base = mmap_base(random_factor);
+		mm->get_unmapped_area = arch_radix_get_unmapped_area_topdown;
+	}
+}
+#else
+/* dummy */
+extern void arch_pick_radix_mmap_layout(struct mm_struct *mm,
+					unsigned long random_factor);
+#endif
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
@@ -89,6 +196,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	if (current->flags & PF_RANDOMIZE)
 		random_factor = arch_mmap_rnd();
 
+	if (radix_enabled())
+		return arch_pick_radix_mmap_layout(mm, random_factor);
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
-- 
2.5.0
