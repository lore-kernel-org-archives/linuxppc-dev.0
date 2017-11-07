Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWMB83w4jzDrL6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 18:53:36 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p9so10377528pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 23:53:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 3/7] powerpc/64s/radix: optimize TLB range flush barriers
Date: Tue,  7 Nov 2017 18:53:05 +1100
Message-Id: <20171107075309.20500-4-npiggin@gmail.com>
In-Reply-To: <20171107075309.20500-1-npiggin@gmail.com>
References: <20171107075309.20500-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Short range flushes issue a sequences of tlbie(l) instructions for
individual effective addresses. These do not all require individual
barrier sequences, only one covering all tlbie(l) instructions.

Commit f7327e0ba3 ("powerpc/mm/radix: Remove unnecessary ptesync")
made a similar optimization for tlbiel for PID flushing.

For tlbie, the ISA says:

    The tlbsync instruction provides an ordering function for the
    effects of all tlbie instructions executed by the thread executing
    the tlbsync instruction, with respect to the memory barrier
    created by a subsequent ptesync instruction executed by the same
    thread.

Time to munmap 30 pages of memory (after mmap, touch):
         local   global
vanilla  10.9us  22.3us
patched   3.4us  14.4us

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 6e77ed2d7c6c..49e71c68f5b1 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -84,7 +84,7 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static inline void _tlbiel_va(unsigned long va, unsigned long pid,
+static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 			      unsigned long ap, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -95,14 +95,20 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
 
-	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	asm volatile("ptesync": : :"memory");
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
-static inline void _tlbie_va(unsigned long va, unsigned long pid,
+static inline void _tlbiel_va(unsigned long va, unsigned long pid,
+			      unsigned long ap, unsigned long ric)
+{
+	asm volatile("ptesync": : :"memory");
+	__tlbiel_va(va, pid, ap, ric);
+	asm volatile("ptesync": : :"memory");
+}
+
+static inline void __tlbie_va(unsigned long va, unsigned long pid,
 			     unsigned long ap, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -113,13 +119,20 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
 
-	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void _tlbie_va(unsigned long va, unsigned long pid,
+			     unsigned long ap, unsigned long ric)
+{
+	asm volatile("ptesync": : :"memory");
+	__tlbie_va(va, pid, ap, ric);
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
+
 /*
  * Base TLB flushing operations:
  *
@@ -341,13 +354,19 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		else
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
+
 	} else {
+		asm volatile("ptesync": : :"memory");
 		for (addr = start; addr < end; addr += page_size) {
 			if (local)
-				_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+				__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
 			else
-				_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+				__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
 		}
+		if (local)
+			asm volatile("ptesync": : :"memory");
+		else
+			asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 
 	preempt_enable();
@@ -380,6 +399,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		_tlbie_pid(pid, RIC_FLUSH_PWC);
 
 	/* Then iterate the pages */
+	asm volatile("ptesync": : :"memory");
 	end = addr + HPAGE_PMD_SIZE;
 	for (; addr < end; addr += PAGE_SIZE) {
 		if (local)
@@ -387,7 +407,10 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		else
 			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
 	}
-
+	if (local)
+		asm volatile("ptesync": : :"memory");
+	else
+		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	preempt_enable();
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.15.0
