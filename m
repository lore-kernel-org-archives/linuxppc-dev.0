Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqt4D3NzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:02 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:00 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6DBEB1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:14:06 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PvcR35782884
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PvME001790
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 41/65] powerpc/mm/radix: Add checks in slice code to catch
 radix usage
Date: Sun, 27 Mar 2016 13:53:49 +0530
Message-Id: <1459067053-10835-41-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Radix don't need slice support. Catch wrong usage of slice feature
with radix enabled

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
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
