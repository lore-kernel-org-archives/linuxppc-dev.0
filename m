Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDJ65S7lzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:37:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDMP043690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:37:08 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 245hgabm2b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:37:08 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:37:07 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 04/13] powerpc/mm/radix: Implement tlb mmu gather
 flush efficiently
Date: Wed, 13 Jul 2016 15:06:35 +0530
In-Reply-To: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402604-5130-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we track page size in mmu_gather, we can use address based
tlbie format when doing a tlb_flush(). We don't do this if we are
invalidating the full address space.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 +
 arch/powerpc/mm/tlb-radix.c                        | 59 +++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 00703e7e4c94..7ee9a195fa9c 100644
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
index e1f22700fb16..6de05c59b375 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -299,8 +299,65 @@ static int radix_get_mmu_psize(int page_size)
 
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
 
 void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
-- 
2.7.4
