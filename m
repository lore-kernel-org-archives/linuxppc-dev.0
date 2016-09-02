Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQctl3vNVzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 21:52:31 +1000 (AEST)
Date: Fri, 2 Sep 2016 21:50:55 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 3/3] powerpc/mm: Speed up computation of base and actual page
 size for a HPTE
Message-ID: <20160902115055.GC12433@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces a 2-D search through an array with a simple 8-bit table
lookup for determining the actual and/or base page size for a HPT entry.

The encoding in the second doubleword of the HPTE is designed to encode
the actual and base page sizes without using any more bits than would be
needed for a 4k page number, by using between 1 and 8 low-order bits of
the RPN (real page number) field to encode the page sizes.  A single
"large page" bit in the first doubleword indicates that these low-order
bits are to be interpreted like this.

We can determine the page sizes by using the low-order 8 bits of the RPN
to look up a 256-entry table.  For actual page sizes less than 1MB, some
of the upper bits of these 8 bits are going to be real address bits, but
we can cope with that by replicating the entries for those smaller page
sizes.

While we're at it, let's move the hpte_page_size() and hpte_base_page_size()
functions from a KVM-specific header to a header for 64-bit HPT systems,
since this computation doesn't have anything specifically to do with KVM.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 37 ++++++++++++
 arch/powerpc/include/asm/kvm_book3s_64.h      | 87 +++------------------------
 arch/powerpc/include/asm/mmu.h                |  1 +
 arch/powerpc/mm/hash_native_64.c              | 42 +------------
 arch/powerpc/mm/hash_utils_64.c               | 37 ++++++++++++
 5 files changed, 84 insertions(+), 120 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 287a656..e407af2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -245,6 +245,43 @@ static inline int segment_shift(int ssize)
 }
 
 /*
+ * This array is indexed by the LP field of the HPTE second dword.
+ * Since this field may contain some RPN bits, some entries are
+ * replicated so that we get the same value irrespective of RPN.
+ * The top 4 bits are the page size index (MMU_PAGE_*) for the
+ * actual page size, the bottom 4 bits are the base page size.
+ */
+extern u8 hpte_page_sizes[1 << LP_BITS];
+
+static inline unsigned long __hpte_page_size(unsigned long h, unsigned long l,
+					     bool is_base_size)
+{
+	unsigned int i, lp;
+
+	if (!(h & HPTE_V_LARGE))
+		return 1ul << 12;
+
+	/* Look at the 8 bit LP value */
+	lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
+	i = hpte_page_sizes[lp];
+	if (!i)
+		return 0;
+	if (!is_base_size)
+		i >>= 4;
+	return 1ul << mmu_psize_defs[i & 0xf].shift;
+}
+
+static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
+{
+	return __hpte_page_size(h, l, 0);
+}
+
+static inline unsigned long hpte_base_page_size(unsigned long h, unsigned long l)
+{
+	return __hpte_page_size(h, l, 1);
+}
+
+/*
  * The current system page and segment sizes
  */
 extern int mmu_kernel_ssize;
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 88d17b4..4ffd5a1 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -20,6 +20,8 @@
 #ifndef __ASM_KVM_BOOK3S_64_H__
 #define __ASM_KVM_BOOK3S_64_H__
 
+#include <asm/book3s/64/mmu-hash.h>
+
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 static inline struct kvmppc_book3s_shadow_vcpu *svcpu_get(struct kvm_vcpu *vcpu)
 {
@@ -97,56 +99,20 @@ static inline void __unlock_hpte(__be64 *hpte, unsigned long hpte_v)
 	hpte[0] = cpu_to_be64(hpte_v);
 }
 
-static inline int __hpte_actual_psize(unsigned int lp, int psize)
-{
-	int i, shift;
-	unsigned int mask;
-
-	/* start from 1 ignoring MMU_PAGE_4K */
-	for (i = 1; i < MMU_PAGE_COUNT; i++) {
-
-		/* invalid penc */
-		if (mmu_psize_defs[psize].penc[i] == -1)
-			continue;
-		/*
-		 * encoding bits per actual page size
-		 *        PTE LP     actual page size
-		 *    rrrr rrrz		>=8KB
-		 *    rrrr rrzz		>=16KB
-		 *    rrrr rzzz		>=32KB
-		 *    rrrr zzzz		>=64KB
-		 * .......
-		 */
-		shift = mmu_psize_defs[i].shift - LP_SHIFT;
-		if (shift > LP_BITS)
-			shift = LP_BITS;
-		mask = (1 << shift) - 1;
-		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
-			return i;
-	}
-	return -1;
-}
-
 static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 					     unsigned long pte_index)
 {
-	int b_psize = MMU_PAGE_4K, a_psize = MMU_PAGE_4K;
+	int i, b_psize = MMU_PAGE_4K, a_psize = MMU_PAGE_4K;
 	unsigned int penc;
 	unsigned long rb = 0, va_low, sllp;
 	unsigned int lp = (r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
 
 	if (v & HPTE_V_LARGE) {
-		for (b_psize = 0; b_psize < MMU_PAGE_COUNT; b_psize++) {
-
-			/* valid entries have a shift value */
-			if (!mmu_psize_defs[b_psize].shift)
-				continue;
-
-			a_psize = __hpte_actual_psize(lp, b_psize);
-			if (a_psize != -1)
-				break;
-		}
+		i = hpte_page_sizes[lp];
+		b_psize = i & 0xf;
+		a_psize = i >> 4;
 	}
+
 	/*
 	 * Ignore the top 14 bits of va
 	 * v have top two bits covering segment size, hence move
@@ -215,45 +181,6 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	return rb;
 }
 
-static inline unsigned long __hpte_page_size(unsigned long h, unsigned long l,
-					     bool is_base_size)
-{
-
-	int size, a_psize;
-	/* Look at the 8 bit LP value */
-	unsigned int lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
-
-	/* only handle 4k, 64k and 16M pages for now */
-	if (!(h & HPTE_V_LARGE))
-		return 1ul << 12;
-	else {
-		for (size = 0; size < MMU_PAGE_COUNT; size++) {
-			/* valid entries have a shift value */
-			if (!mmu_psize_defs[size].shift)
-				continue;
-
-			a_psize = __hpte_actual_psize(lp, size);
-			if (a_psize != -1) {
-				if (is_base_size)
-					return 1ul << mmu_psize_defs[size].shift;
-				return 1ul << mmu_psize_defs[a_psize].shift;
-			}
-		}
-
-	}
-	return 0;
-}
-
-static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
-{
-	return __hpte_page_size(h, l, 0);
-}
-
-static inline unsigned long hpte_base_page_size(unsigned long h, unsigned long l)
-{
-	return __hpte_page_size(h, l, 1);
-}
-
 static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
 {
 	return ((ptel & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e2fb408..b78e8d3 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -271,6 +271,7 @@ static inline bool early_radix_enabled(void)
 #define MMU_PAGE_16G	13
 #define MMU_PAGE_64G	14
 
+/* N.B. we need to change the type of hpte_page_sizes if this gets to be > 16 */
 #define MMU_PAGE_COUNT	15
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 0e4e965..83ddc0e 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -493,36 +493,6 @@ static void native_hugepage_invalidate(unsigned long vsid,
 }
 #endif
 
-static inline int __hpte_actual_psize(unsigned int lp, int psize)
-{
-	int i, shift;
-	unsigned int mask;
-
-	/* start from 1 ignoring MMU_PAGE_4K */
-	for (i = 1; i < MMU_PAGE_COUNT; i++) {
-
-		/* invalid penc */
-		if (mmu_psize_defs[psize].penc[i] == -1)
-			continue;
-		/*
-		 * encoding bits per actual page size
-		 *        PTE LP     actual page size
-		 *    rrrr rrrz		>=8KB
-		 *    rrrr rrzz		>=16KB
-		 *    rrrr rzzz		>=32KB
-		 *    rrrr zzzz		>=64KB
-		 * .......
-		 */
-		shift = mmu_psize_defs[i].shift - LP_SHIFT;
-		if (shift > LP_BITS)
-			shift = LP_BITS;
-		mask = (1 << shift) - 1;
-		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
-			return i;
-	}
-	return -1;
-}
-
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
@@ -538,16 +508,8 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 		size   = MMU_PAGE_4K;
 		a_size = MMU_PAGE_4K;
 	} else {
-		for (size = 0; size < MMU_PAGE_COUNT; size++) {
-
-			/* valid entries have a shift value */
-			if (!mmu_psize_defs[size].shift)
-				continue;
-
-			a_size = __hpte_actual_psize(lp, size);
-			if (a_size != -1)
-				break;
-		}
+		size = hpte_page_sizes[lp] & 0xf;
+		a_size = hpte_page_sizes[lp] >> 4;
 	}
 	/* This works for all page sizes, and for 256M and 1T segments */
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..e4ec99c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -93,6 +93,9 @@ static unsigned long _SDR1;
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 EXPORT_SYMBOL_GPL(mmu_psize_defs);
 
+u8 hpte_page_sizes[1 << LP_BITS];
+EXPORT_SYMBOL_GPL(hpte_page_sizes);
+
 struct hash_pte *htab_address;
 unsigned long htab_size_bytes;
 unsigned long htab_hash_mask;
@@ -564,8 +567,42 @@ static void __init htab_scan_page_sizes(void)
 #endif /* CONFIG_HUGETLB_PAGE */
 }
 
+/*
+ * Fill in the hpte_page_sizes[] array.
+ * We go through the mmu_psize_defs[] array looking for all the
+ * supported base/actual page size combinations.  Each combination
+ * has a unique pagesize encoding (penc) value in the low bits of
+ * the LP field of the HPTE.  For actual page sizes less than 1MB,
+ * some of the upper LP bits are used for RPN bits, meaning that
+ * we need to fill in several entries in hpte_page_sizes[].
+ */
+static void init_hpte_page_sizes(void)
+{
+	long int ap, bp;
+	long int shift, penc;
+
+	for (bp = 0; bp < MMU_PAGE_COUNT; ++bp) {
+		if (!mmu_psize_defs[bp].shift)
+			continue;	/* not a supported page size */
+		for (ap = bp; ap < MMU_PAGE_COUNT; ++ap) {
+			penc = mmu_psize_defs[bp].penc[ap];
+			if (penc == -1)
+				continue;
+			shift = mmu_psize_defs[ap].shift - LP_SHIFT;
+			if (shift <= 0)
+				continue;	/* should never happen */
+			while (penc < (1 << LP_BITS)) {
+				hpte_page_sizes[penc] = (ap << 4) | bp;
+				penc += 1 << shift;
+			}
+		}
+	}
+}
+
 static void __init htab_init_page_sizes(void)
 {
+	init_hpte_page_sizes();
+
 	if (!debug_pagealloc_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
-- 
2.7.4
