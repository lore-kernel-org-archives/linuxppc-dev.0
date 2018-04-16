Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb8q0BnBzF1ql
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:32:58 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id l12so601339pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:32:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] powerpc/mm/radix: implement LPID based TLB flushes to
 be used by KVM
Date: Mon, 16 Apr 2018 14:32:37 +1000
Message-Id: <20180416043240.8796-3-npiggin@gmail.com>
In-Reply-To: <20180416043240.8796-1-npiggin@gmail.com>
References: <20180416043240.8796-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a local TLB flush for invalidating an LPID with variants for
process or partition scope. And a global TLB flush for invalidating
a partition scoped page of an LPID.

These will be used by KVM in subsequent patches.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../include/asm/book3s/64/tlbflush-radix.h    |   6 +
 arch/powerpc/mm/tlb-radix.c                   | 160 ++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 19b45ba6caf9..12c02c0e5a4b 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -51,4 +51,10 @@ extern void radix__flush_tlb_all(void);
 extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 					unsigned long address);
 
+extern void radix__flush_tlb_lpid_page(unsigned int lpid,
+					unsigned long addr,
+					unsigned long page_size);
+extern void radix__local_flush_tlb_lpid(unsigned int lpid);
+extern void radix__local_flush_tlb_lpid_guest(unsigned int lpid);
+
 #endif
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 2fba6170ab3f..c2b001dc4dd9 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -119,6 +119,39 @@ static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbiel_lpid(unsigned long lpid, int set,
+				unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = PPC_BIT(52); /* IS = 2 */
+	rb |= set << PPC_BITLSHIFT(51);
+	rs = 0;  /* LPID comes from LPIDR */
+	prs = 0; /* partition scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);
+}
+
+static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
+				unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = PPC_BIT(52); /* IS = 2 */
+	rb |= set << PPC_BITLSHIFT(51);
+	rs = 0;  /* LPID comes from LPIDR */
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);
+}
+
+
 static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 			       unsigned long ap, unsigned long ric)
 {
@@ -151,6 +184,22 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
+			      unsigned long ap, unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = lpid;
+	prs = 0; /* partition scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
+}
+
 static inline void fixup_tlbie(void)
 {
 	unsigned long pid = 0;
@@ -162,6 +211,16 @@ static inline void fixup_tlbie(void)
 	}
 }
 
+static inline void fixup_tlbie_lpid(unsigned long lpid)
+{
+	unsigned long va = ((1UL << 52) - 1);
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_BUG)) {
+		asm volatile("ptesync": : :"memory");
+		__tlbie_lpid_va(va, lpid, mmu_get_ap(MMU_PAGE_64K), RIC_FLUSH_TLB);
+	}
+}
+
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
@@ -215,6 +274,62 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
+static inline void _tlbiel_lpid(unsigned long lpid, unsigned long ric)
+{
+	int set;
+
+	VM_BUG_ON(mfspr(SPRN_LPID) != lpid);
+
+	asm volatile("ptesync": : :"memory");
+
+	/*
+	 * Flush the first set of the TLB, and if we're doing a RIC_FLUSH_ALL,
+	 * also flush the entire Page Walk Cache.
+	 */
+	__tlbiel_lpid(lpid, 0, ric);
+
+	/* For PWC, only one flush is needed */
+	if (ric == RIC_FLUSH_PWC) {
+		asm volatile("ptesync": : :"memory");
+		return;
+	}
+
+	/* For the remaining sets, just flush the TLB */
+	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
+		__tlbiel_lpid(lpid, set, RIC_FLUSH_TLB);
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
+static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
+{
+	int set;
+
+	VM_BUG_ON(mfspr(SPRN_LPID) != lpid);
+
+	asm volatile("ptesync": : :"memory");
+
+	/*
+	 * Flush the first set of the TLB, and if we're doing a RIC_FLUSH_ALL,
+	 * also flush the entire Page Walk Cache.
+	 */
+	__tlbiel_lpid_guest(lpid, 0, ric);
+
+	/* For PWC, only one flush is needed */
+	if (ric == RIC_FLUSH_PWC) {
+		asm volatile("ptesync": : :"memory");
+		return;
+	}
+
+	/* For the remaining sets, just flush the TLB */
+	for (set = 1; set < POWER9_TLB_SETS_RADIX ; set++)
+		__tlbiel_lpid_guest(lpid, set, RIC_FLUSH_TLB);
+
+	asm volatile("ptesync": : :"memory");
+}
+
+
 static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
@@ -269,6 +384,17 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
+static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
+			      unsigned long psize, unsigned long ric)
+{
+	unsigned long ap = mmu_get_ap(psize);
+
+	asm volatile("ptesync": : :"memory");
+	__tlbie_lpid_va(va, lpid, ap, ric);
+	fixup_tlbie_lpid(lpid);
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
 static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize, bool also_pwc)
@@ -535,6 +661,40 @@ static int radix_get_mmu_psize(int page_size)
 	return psize;
 }
 
+/*
+ * Flush partition scoped LPID address translation for all CPUs.
+ */
+void radix__flush_tlb_lpid_page(unsigned int lpid,
+					unsigned long addr,
+					unsigned long page_size)
+{
+	int psize = radix_get_mmu_psize(page_size);
+
+	_tlbie_lpid_va(addr, lpid, psize, RIC_FLUSH_TLB);
+}
+EXPORT_SYMBOL_GPL(radix__flush_tlb_lpid_page);
+
+/*
+ * Flush partition scoped translations from LPID (=LPIDR)
+ */
+void radix__local_flush_tlb_lpid(unsigned int lpid)
+{
+	_tlbiel_lpid(lpid, RIC_FLUSH_ALL);
+}
+EXPORT_SYMBOL_GPL(radix__local_flush_tlb_lpid);
+
+/*
+ * Flush process scoped translations from LPID (=LPIDR).
+ * Important difference, the guest normally manages its own translations,
+ * but some cases e.g., vCPU CPU migration require KVM to flush.
+ */
+void radix__local_flush_tlb_lpid_guest(unsigned int lpid)
+{
+	_tlbiel_lpid_guest(lpid, RIC_FLUSH_ALL);
+}
+EXPORT_SYMBOL_GPL(radix__local_flush_tlb_lpid_guest);
+
+
 static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize);
 
-- 
2.17.0
