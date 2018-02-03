Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYPnl0R3TzDr6n
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 17:58:18 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id b25so18475729pfd.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 22:58:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s/radix: remove unused flush_tlb_lpid variants
Date: Sat,  3 Feb 2018 16:58:06 +1000
Message-Id: <20180203065806.5751-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These were intended for use by KVM, but it has its own LPID
flushing code and never used these.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 --
 arch/powerpc/mm/tlb-radix.c                        | 40 ----------------------
 2 files changed, 43 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 8eea90f80e45..19b45ba6caf9 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -47,9 +47,6 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
 #endif
 extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 extern void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr);
-extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
-				     unsigned long page_size);
-extern void radix__flush_tlb_lpid(unsigned long lpid);
 extern void radix__flush_tlb_all(void);
 extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 					unsigned long address);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 71d1b19ad1c0..8ce858ec59e1 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -603,46 +603,6 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
-			      unsigned long page_size)
-{
-	unsigned long rb,rs,prs,r;
-	unsigned long ap;
-	unsigned long ric = RIC_FLUSH_TLB;
-
-	ap = mmu_get_ap(radix_get_mmu_psize(page_size));
-	rb = gpa & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = lpid & ((1UL << 32) - 1);
-	prs = 0; /* process scoped */
-	r = 1;   /* raidx format */
-
-	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
-}
-EXPORT_SYMBOL(radix__flush_tlb_lpid_va);
-
-void radix__flush_tlb_lpid(unsigned long lpid)
-{
-	unsigned long rb,rs,prs,r;
-	unsigned long ric = RIC_FLUSH_ALL;
-
-	rb = 0x2 << PPC_BITLSHIFT(53); /* IS = 2 */
-	rs = lpid & ((1UL << 32) - 1);
-	prs = 0; /* partition scoped */
-	r = 1;   /* raidx format */
-
-	asm volatile("ptesync": : :"memory");
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
-}
-EXPORT_SYMBOL(radix__flush_tlb_lpid);
-
 void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
-- 
2.15.1
