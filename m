Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLlNG69JjzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 23:30:54 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 3 Jun 2016 07:30:52 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Simplify hugetlb unmap
In-Reply-To: <1464959359-7543-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464959359-7543-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 03 Jun 2016 19:00:33 +0530
Message-ID: <87bn3iwgau.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Andrew,

The updated version includes a build fix for [PATCH 2/3. I also dropped the
powerpc related changes from the series because that have dependencies
against other patches not yet merged upstream. I am adding the same
below for reference.

>From 1f0975adfd3138f3709b2dec8771065ddc38de40 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 10 May 2016 12:24:34 +0530
Subject: [PATCH 4/4] powerpc/mm/radix: Implement tlb mmu gather flush
 efficiently

Now that we track page size in mmu_gather, we can use address based
tlbie format when doing a tlb_flush(). We don't do this if we are
invalidating the full address space.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 +
 arch/powerpc/mm/tlb-radix.c                        | 73 +++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 3fa94fcac628..862c8fa50268 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -10,6 +10,8 @@ static inline int mmu_get_ap(int psize)
 	return mmu_psize_defs[psize].ap;
 }
 
+extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+					 unsigned long end, int psize);
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 231e3ed2e684..03e719ee6747 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -279,9 +279,80 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(radix__flush_tlb_range);
 
+static int radix_get_mmu_psize(int page_size)
+{
+	int psize;
+
+	if (page_size == (1UL << mmu_psize_defs[mmu_virtual_psize].shift))
+		psize = mmu_virtual_psize;
+	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_2M].shift))
+		psize = MMU_PAGE_2M;
+	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_1G].shift))
+		psize = MMU_PAGE_1G;
+	else
+		return -1;
+	return psize;
+}
 
 void radix__tlb_flush(struct mmu_gather *tlb)
 {
+	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
-	radix__flush_tlb_mm(mm);
+	int page_size = tlb->page_size;
+
+	psize = radix_get_mmu_psize(page_size);
+	/*
+	 * if page size is not something we understand, do a full mm flush
+	 */
+	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
+		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
+	else
+		radix__flush_tlb_mm(mm);
+}
+
+#define TLB_FLUSH_ALL -1UL
+/*
+ * Number of pages above which we will do a bcast tlbie. Just a
+ * number at this point copied from x86
+ */
+static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+
+void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	unsigned long pid;
+	unsigned long addr;
+	int local = mm_is_core_local(mm);
+	unsigned long ap = mmu_get_ap(psize);
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
+
+
+	preempt_disable();
+	pid = mm ? mm->context.id : 0;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto err_out;
+
+	if (end == TLB_FLUSH_ALL ||
+	    (end - start) > tlb_single_page_flush_ceiling * page_size) {
+		if (local)
+			_tlbiel_pid(pid, RIC_FLUSH_TLB);
+		else
+			_tlbie_pid(pid, RIC_FLUSH_TLB);
+		goto err_out;
+	}
+	for (addr = start; addr < end; addr += page_size) {
+
+		if (local)
+			_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+		else {
+			if (lock_tlbie)
+				raw_spin_lock(&native_tlbie_lock);
+			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+			if (lock_tlbie)
+				raw_spin_unlock(&native_tlbie_lock);
+		}
+	}
+err_out:
+	preempt_enable();
 }
-- 
2.7.4
