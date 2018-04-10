Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6Rs2NcpzF1x1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:48:57 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id o16so8203303pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:48:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/5] powerpc/64s/mm: Implement LPID based TLB flushes to
 be used by KVM
Date: Tue, 10 Apr 2018 22:48:38 +1000
Message-Id: <20180410124842.30184-2-npiggin@gmail.com>
In-Reply-To: <20180410124842.30184-1-npiggin@gmail.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implent local TLB flush for entire LPID, for hash and radix, and
a global TLB flush for a partition scoped page in an LPID, for
radix.

These will be used by KVM in subsequent patches.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../include/asm/book3s/64/tlbflush-hash.h     |  2 +
 .../include/asm/book3s/64/tlbflush-radix.h    |  5 ++
 arch/powerpc/mm/hash_native_64.c              |  8 ++
 arch/powerpc/mm/tlb-radix.c                   | 87 +++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 64d02a704bcb..8b328fd87722 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -53,6 +53,8 @@ static inline void arch_leave_lazy_mmu_mode(void)
 
 extern void hash__tlbiel_all(unsigned int action);
 
+extern void hash__local_flush_tlb_lpid(unsigned int lpid);
+
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, unsigned long flags);
 extern void flush_hash_range(unsigned long number, int local);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 19b45ba6caf9..2ddaadf3e9ea 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -51,4 +51,9 @@ extern void radix__flush_tlb_all(void);
 extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 					unsigned long address);
 
+extern void radix__flush_tlb_lpid_page(unsigned int lpid,
+					unsigned long addr,
+					unsigned long page_size);
+extern void radix__local_flush_tlb_lpid(unsigned int lpid);
+
 #endif
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 1d049c78c82a..2f02cd780c19 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -294,6 +294,14 @@ static inline void tlbie(unsigned long vpn, int psize, int apsize,
 		raw_spin_unlock(&native_tlbie_lock);
 }
 
+void hash__local_flush_tlb_lpid(unsigned int lpid)
+{
+	VM_BUG_ON(mfspr(SPRN_LPID) != lpid);
+
+	hash__tlbiel_all(TLB_INVAL_SCOPE_LPID);
+}
+EXPORT_SYMBOL_GPL(hash__local_flush_tlb_lpid);
+
 static inline void native_lock_hpte(struct hash_pte *hptep)
 {
 	unsigned long *word = (unsigned long *)&hptep->v;
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 2fba6170ab3f..f246fb0ac049 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -119,6 +119,22 @@ static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
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
 static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 			       unsigned long ap, unsigned long ric)
 {
@@ -151,6 +167,22 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
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
@@ -215,6 +247,34 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
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
 static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
@@ -269,6 +329,17 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
+static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
+			      unsigned long psize, unsigned long ric)
+{
+	unsigned long ap = mmu_get_ap(psize);
+
+	asm volatile("ptesync": : :"memory");
+	__tlbie_lpid_va(va, lpid, ap, ric);
+	fixup_tlbie();
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
 static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize, bool also_pwc)
@@ -535,6 +606,22 @@ static int radix_get_mmu_psize(int page_size)
 	return psize;
 }
 
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
+void radix__local_flush_tlb_lpid(unsigned int lpid)
+{
+	_tlbiel_lpid(lpid, RIC_FLUSH_ALL);
+}
+EXPORT_SYMBOL_GPL(radix__local_flush_tlb_lpid);
+
 static void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize);
 
-- 
2.17.0
