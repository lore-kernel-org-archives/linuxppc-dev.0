Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyM3KmdzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 46/70] powerpc/mm/radix: Add checks in slice code to catch
 radix usage
Date: Fri, 29 Apr 2016 23:26:09 +1000
Message-Id: <1461936393-10131-46-git-send-email-mpe@ellerman.id.au>
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

Radix doesn't need slice support. Catch incorrect usage of slice code
when radix is enabled.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slice.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ee21b8699cee..2b27458902ee 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -395,6 +395,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
+	VM_BUG_ON(radix_enabled());
 
 	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
 	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
@@ -568,6 +569,16 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 	unsigned char *hpsizes;
 	int index, mask_index;
 
+	/*
+	 * Radix doesn't use slice, but can get enabled along with MMU_SLICE
+	 */
+	if (radix_enabled()) {
+#ifdef CONFIG_PPC_64K_PAGES
+		return MMU_PAGE_64K;
+#else
+		return MMU_PAGE_4K;
+#endif
+	}
 	if (addr < SLICE_LOW_TOP) {
 		u64 lpsizes;
 		lpsizes = mm->context.low_slices_psize;
@@ -605,6 +616,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 
 	slice_dbg("slice_set_user_psize(mm=%p, psize=%d)\n", mm, psize);
 
+	VM_BUG_ON(radix_enabled());
 	spin_lock_irqsave(&slice_convert_lock, flags);
 
 	old_psize = mm->context.user_psize;
@@ -649,6 +661,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 {
 	struct slice_mask mask = slice_range_to_mask(start, len);
 
+	VM_BUG_ON(radix_enabled());
 	slice_convert(mm, mask, psize);
 }
 
@@ -678,6 +691,9 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	struct slice_mask mask, available;
 	unsigned int psize = mm->context.user_psize;
 
+	if (radix_enabled())
+		return 0;
+
 	mask = slice_range_to_mask(addr, len);
 	available = slice_mask_for_size(mm, psize);
 #ifdef CONFIG_PPC_64K_PAGES
-- 
2.5.0
