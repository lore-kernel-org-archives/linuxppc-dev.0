Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3Mr1X0bzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:40 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a2so4610220pfj.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 7/8] powerpc/64s/radix: Improve TLB flushing for unmaps
 that free a page table
Date: Fri,  8 Sep 2017 00:51:47 +1000
Message-Id: <20170907145148.24398-8-npiggin@gmail.com>
In-Reply-To: <20170907145148.24398-1-npiggin@gmail.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unmaps that free page tables always flush the PID, which is sub
optimal. Allow those to do TLB range flushes with separate PWC flush.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 51 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 1b0cac656680..7452e1f4aa3c 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -351,23 +351,35 @@ static int radix_get_mmu_psize(int page_size)
 	return psize;
 }
 
+static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize);
+
 void radix__tlb_flush(struct mmu_gather *tlb)
 {
 	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
 	int page_size = tlb->page_size;
 
-	psize = radix_get_mmu_psize(page_size);
 	/*
 	 * if page size is not something we understand, do a full mm flush
 	 */
-	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
-		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
-	else if (tlb->need_flush_all) {
-		tlb->need_flush_all = 0;
+	if (tlb->fullmm) {
 		radix__flush_all_mm(mm);
-	} else
-		radix__flush_tlb_mm(mm);
+	} else if ( (psize = radix_get_mmu_psize(page_size)) == -1) {
+		if (!tlb->need_flush_all)
+			radix__flush_tlb_mm(mm);
+		else
+			radix__flush_all_mm(mm);
+	} else {
+		unsigned long start = tlb->start;
+		unsigned long end = tlb->end;
+
+		if (!tlb->need_flush_all)
+			radix__flush_tlb_range_psize(mm, start, end, psize);
+		else
+			radix__flush_tlb_pwc_range_psize(mm, start, end, psize);
+	}
+	tlb->need_flush_all = 0;
 }
 
 #define TLB_FLUSH_ALL -1UL
@@ -384,8 +396,9 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
-bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
-				  unsigned long end, int psize)
+static bool __radix__flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				int psize, bool also_pwc)
 {
 	unsigned long pid;
 	unsigned int page_shift = mmu_psize_defs[psize].shift;
@@ -401,17 +414,21 @@ bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
 					tlb_local_single_page_flush_ceiling) {
 			full = true;
-			_tlbiel_pid(pid, RIC_FLUSH_TLB);
+			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		} else {
 			_tlbiel_va_range(start, end, pid, page_size, psize);
+			if (also_pwc)
+				_tlbiel_pid(pid, RIC_FLUSH_PWC);
 		}
 	} else {
 		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
 					tlb_single_page_flush_ceiling) {
 			full = true;
-			_tlbie_pid(pid, RIC_FLUSH_TLB);
+			_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		} else {
 			_tlbie_va_range(start, end, pid, page_size, psize);
+			if (also_pwc)
+				_tlbie_pid(pid, RIC_FLUSH_PWC);
 		}
 	}
 	preempt_enable();
@@ -419,6 +436,18 @@ bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 	return full;
 }
 
+bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	return __radix__flush_tlb_range_psize(mm, start, end, psize, false);
+}
+
+static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	__radix__flush_tlb_range_psize(mm, start, end, psize, true);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
-- 
2.13.3
