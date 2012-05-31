Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D70DB7020
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 05:51:55 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 31 May 2012 19:41:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4VJiead65011938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:44:40 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4VJpqg5018268
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:51:53 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [Early RFC 2/6] arch/powerpc: Convert virtual address to a struct
Date: Fri,  1 Jun 2012 01:20:37 +0530
Message-Id: <1338493841-9926-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is in preparation to the conversion of 64 bit powerpc virtual address
to the max 78 bits. Later patch will switch struct virt_addr to a struct
of virtual segment id and segment offset.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h   |    2 +-
 arch/powerpc/include/asm/machdep.h      |    6 +--
 arch/powerpc/include/asm/mmu-hash64.h   |   24 ++++++----
 arch/powerpc/include/asm/tlbflush.h     |    4 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c   |    3 +-
 arch/powerpc/mm/hash_native_64.c        |   76 +++++++++++++++++--------------
 arch/powerpc/mm/hash_utils_64.c         |   12 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c    |    3 +-
 arch/powerpc/mm/tlb_hash64.c            |    3 +-
 arch/powerpc/platforms/cell/beat_htab.c |   17 +++----
 arch/powerpc/platforms/ps3/htab.c       |    6 +--
 arch/powerpc/platforms/pseries/lpar.c   |   30 ++++++------
 12 files changed, 103 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index fd07f43..374b75d 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -59,7 +59,7 @@ struct hpte_cache {
 	struct hlist_node list_vpte;
 	struct hlist_node list_vpte_long;
 	struct rcu_head rcu_head;
-	u64 host_va;
+	struct virt_addr host_va;
 	u64 pfn;
 	ulong slot;
 	struct kvmppc_pte pte;
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 42ce570..b34d0a9 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -34,19 +34,19 @@ struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
 	void            (*hpte_invalidate)(unsigned long slot,
-					   unsigned long va,
+					   struct virt_addr va,
 					   int psize, int ssize,
 					   int local);
 	long		(*hpte_updatepp)(unsigned long slot, 
 					 unsigned long newpp, 
-					 unsigned long va,
+					 struct virt_addr va,
 					 int psize, int ssize,
 					 int local);
 	void            (*hpte_updateboltedpp)(unsigned long newpp, 
 					       unsigned long ea,
 					       int psize, int ssize);
 	long		(*hpte_insert)(unsigned long hpte_group,
-				       unsigned long va,
+				       struct virt_addr va,
 				       unsigned long prpn,
 				       unsigned long rflags,
 				       unsigned long vflags,
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 1c65a59..5ff936b 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -143,6 +143,10 @@ struct mmu_psize_def
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
 };
 
+struct virt_addr {
+	unsigned long addr;
+};
+
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -183,11 +187,11 @@ extern int mmu_ci_restrictions;
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
  */
-static inline unsigned long hpte_encode_v(unsigned long va, int psize,
+static inline unsigned long hpte_encode_v(struct virt_addr va, int psize,
 					  int ssize)
 {
 	unsigned long v;
-	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
+	v = (va.addr >> 23) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
 	if (psize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
@@ -218,28 +222,30 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
 /*
  * Build a VA given VSID, EA and segment size
  */
-static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
+static inline struct virt_addr hpt_va(unsigned long ea, unsigned long vsid,
 				   int ssize)
 {
+	struct virt_addr va;
 	if (ssize == MMU_SEGSIZE_256M)
-		return (vsid << 28) | (ea & 0xfffffffUL);
-	return (vsid << 40) | (ea & 0xffffffffffUL);
+		va.addr = (vsid << 28) | (ea & 0xfffffffUL);
+	va.addr = (vsid << 40) | (ea & 0xffffffffffUL);
+	return va;
 }
 
 /*
  * This hashes a virtual address
  */
 
-static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
+static inline unsigned long hpt_hash(struct virt_addr va, unsigned int shift,
 				     int ssize)
 {
 	unsigned long hash, vsid;
 
 	if (ssize == MMU_SEGSIZE_256M) {
-		hash = (va >> 28) ^ ((va & 0x0fffffffUL) >> shift);
+		hash = (va.addr >> 28) ^ ((va.addr & 0x0fffffffUL) >> shift);
 	} else {
-		vsid = va >> 40;
-		hash = vsid ^ (vsid << 25) ^ ((va & 0xffffffffffUL) >> shift);
+		vsid = va.addr >> 40;
+		hash = vsid ^ (vsid << 25) ^ ((va.addr & 0xffffffffffUL) >> shift);
 	}
 	return hash & 0x7fffffffffUL;
 }
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 81143fc..2c8ad50 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -95,7 +95,7 @@ struct ppc64_tlb_batch {
 	unsigned long		index;
 	struct mm_struct	*mm;
 	real_pte_t		pte[PPC64_TLB_BATCH_NR];
-	unsigned long		vaddr[PPC64_TLB_BATCH_NR];
+	struct virt_addr	vaddr[PPC64_TLB_BATCH_NR];
 	unsigned int		psize;
 	int			ssize;
 };
@@ -127,7 +127,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
 
-extern void flush_hash_page(unsigned long va, real_pte_t pte, int psize,
+extern void flush_hash_page(struct virt_addr va, real_pte_t pte, int psize,
 			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 10fc8ec..933b117 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -80,8 +80,9 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 
 int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 {
+	struct virt_addr va;
 	pfn_t hpaddr;
-	ulong hash, hpteg, va;
+	ulong hash, hpteg;
 	u64 vsid;
 	int ret;
 	int rflags = 0x192;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 90039bc..cab3892 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -39,62 +39,67 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long va, int psize, int ssize)
+/* Verify docs says 14 .. 14+i bits */
+static inline void __tlbie(struct virt_addr va, int psize, int ssize)
 {
+	unsigned long vaddr = va.addr;
 	unsigned int penc;
 
+	vaddr &= ~(0xffffULL << 48);
+
 	/* clear top 16 bits, non SLS segment */
-	va &= ~(0xffffULL << 48);
+	vaddr &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-		va &= ~0xffful;
-		va |= ssize << 8;
+		vaddr &= ~0xffful;
+		vaddr |= ssize << 8;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
-			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
+			     : : "r" (vaddr), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	default:
 		penc = mmu_psize_defs[psize].penc;
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= penc << 12;
-		va |= ssize << 8;
-		va |= 1; /* L */
+		vaddr &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		vaddr |= penc << 12;
+		vaddr |= ssize << 8;
+		vaddr |= 1; /* L */
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
-			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
+			     : : "r" (vaddr), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	}
 }
 
-static inline void __tlbiel(unsigned long va, int psize, int ssize)
+/* Verify docs says 14 .. 14+i bits */
+static inline void __tlbiel(struct virt_addr va, int psize, int ssize)
 {
+	unsigned long vaddr = va.addr;
 	unsigned int penc;
 
-	/* clear top 16 bits, non SLS segment */
-	va &= ~(0xffffULL << 48);
+	vaddr &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-		va &= ~0xffful;
-		va |= ssize << 8;
+		vaddr &= ~0xffful;
+		vaddr |= ssize << 8;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
-			     : : "r"(va) : "memory");
+			     : : "r"(vaddr) : "memory");
 		break;
 	default:
 		penc = mmu_psize_defs[psize].penc;
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= penc << 12;
-		va |= ssize << 8;
-		va |= 1; /* L */
+		vaddr &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		vaddr |= penc << 12;
+		vaddr |= ssize << 8;
+		vaddr |= 1; /* L */
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
-			     : : "r"(va) : "memory");
+			     : : "r"(vaddr) : "memory");
 		break;
 	}
 
 }
 
-static inline void tlbie(unsigned long va, int psize, int ssize, int local)
+static inline void tlbie(struct virt_addr va, int psize, int ssize, int local)
 {
 	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
@@ -134,7 +139,7 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
 
-static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long native_hpte_insert(unsigned long hpte_group, struct virt_addr va,
 			unsigned long pa, unsigned long rflags,
 			unsigned long vflags, int psize, int ssize)
 {
@@ -225,7 +230,7 @@ static long native_hpte_remove(unsigned long hpte_group)
 }
 
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
-				 unsigned long va, int psize, int ssize,
+				 struct virt_addr va, int psize, int ssize,
 				 int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
@@ -259,7 +264,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	return ret;
 }
 
-static long native_hpte_find(unsigned long va, int psize, int ssize)
+static long native_hpte_find(struct virt_addr va, int psize, int ssize)
 {
 	struct hash_pte *hptep;
 	unsigned long hash;
@@ -295,7 +300,8 @@ static long native_hpte_find(unsigned long va, int psize, int ssize)
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 				       int psize, int ssize)
 {
-	unsigned long vsid, va;
+	struct virt_addr va;
+	unsigned long vsid;
 	long slot;
 	struct hash_pte *hptep;
 
@@ -315,7 +321,7 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	tlbie(va, psize, ssize, 0);
 }
 
-static void native_hpte_invalidate(unsigned long slot, unsigned long va,
+static void native_hpte_invalidate(unsigned long slot, struct virt_addr va,
 				   int psize, int ssize, int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
@@ -349,7 +355,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
 
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
-			int *psize, int *ssize, unsigned long *va)
+			int *psize, int *ssize, struct virt_addr *va)
 {
 	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
@@ -403,7 +409,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 		avpn |= (vpi << mmu_psize_defs[size].shift);
 	}
 
-	*va = avpn;
+	va->addr = avpn;
 	*psize = size;
 	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 }
@@ -418,9 +424,10 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
  */
 static void native_hpte_clear(void)
 {
+	struct virt_addr va;
 	unsigned long slot, slots, flags;
 	struct hash_pte *hptep = htab_address;
-	unsigned long hpte_v, va;
+	unsigned long hpte_v;
 	unsigned long pteg_count;
 	int psize, ssize;
 
@@ -465,7 +472,8 @@ static void native_hpte_clear(void)
  */
 static void native_flush_hash_range(unsigned long number, int local)
 {
-	unsigned long va, hash, index, hidx, shift, slot;
+	struct virt_addr va;
+	unsigned long hash, index, hidx, shift, slot;
 	struct hash_pte *hptep;
 	unsigned long hpte_v;
 	unsigned long want_v;
@@ -482,7 +490,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		va = batch->vaddr[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
+		pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
 			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
@@ -508,7 +516,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			va = batch->vaddr[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va, index,
+			pte_iterate_hashed_subpages(pte, psize, va.addr, index,
 						    shift) {
 				__tlbiel(va, psize, ssize);
 			} pte_iterate_hashed_end();
@@ -525,7 +533,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			va = batch->vaddr[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va, index,
+			pte_iterate_hashed_subpages(pte, psize, va.addr, index,
 						    shift) {
 				__tlbie(va, psize, ssize);
 			} pte_iterate_hashed_end();
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 377e5cb..2429d53 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -192,7 +192,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	     vaddr += step, paddr += step) {
 		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
-		unsigned long va = hpt_va(vaddr, vsid, ssize);
+		struct virt_addr va = hpt_va(vaddr, vsid, ssize);
 		unsigned long tprot = prot;
 
 		/* Make kernel text executable */
@@ -1153,13 +1153,13 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int ssize,
+void flush_hash_page(struct virt_addr va, real_pte_t pte, int psize, int ssize,
 		     int local)
 {
 	unsigned long hash, index, shift, hidx, slot;
 
-	DBG_LOW("flush_hash_page(va=%016lx)\n", va);
-	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
+	DBG_LOW("flush_hash_page(va=%016lx)\n", va.addr);
+	pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
 		hash = hpt_hash(va, shift, ssize);
 		hidx = __rpte_to_hidx(pte, index);
 		if (hidx & _PTEIDX_SECONDARY)
@@ -1208,7 +1208,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hpteg;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
+	struct virt_addr va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
 	unsigned long mode = htab_convert_pte_flags(PAGE_KERNEL);
 	int ret;
 
@@ -1229,7 +1229,7 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hidx, slot;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
+	struct virt_addr va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
 
 	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
 	spin_lock(&linear_map_hash_lock);
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index cc5c273..47b4ed0 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -18,8 +18,9 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize)
 {
+	struct virt_addr va;
 	unsigned long old_pte, new_pte;
-	unsigned long va, rflags, pa, sz;
+	unsigned long rflags, pa, sz;
 	long slot;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 31f1820..b830466 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -42,8 +42,9 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, unsigned long pte, int huge)
 {
+	struct virt_addr vaddr;
 	struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);
-	unsigned long vsid, vaddr;
+	unsigned long vsid;
 	unsigned int psize;
 	int ssize;
 	real_pte_t rpte;
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index b83077e..a2dfc22 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -88,7 +88,7 @@ static inline unsigned int beat_read_mask(unsigned hpte_group)
 }
 
 static long beat_lpar_hpte_insert(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
+				  struct virt_addr va, unsigned long pa,
 				  unsigned long rflags, unsigned long vflags,
 				  int psize, int ssize)
 {
@@ -184,7 +184,7 @@ static void beat_lpar_hptab_clear(void)
  */
 static long beat_lpar_hpte_updatepp(unsigned long slot,
 				    unsigned long newpp,
-				    unsigned long va,
+				    struct virt_addr va,
 				    int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
@@ -220,7 +220,7 @@ static long beat_lpar_hpte_updatepp(unsigned long slot,
 	return 0;
 }
 
-static long beat_lpar_hpte_find(unsigned long va, int psize)
+static long beat_lpar_hpte_find(struct virt_addr va, int psize)
 {
 	unsigned long hash;
 	unsigned long i, j;
@@ -255,7 +255,8 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 					  unsigned long ea,
 					  int psize, int ssize)
 {
-	unsigned long lpar_rc, slot, vsid, va;
+	struct virt_addr va;
+	unsigned long lpar_rc, slot, vsid;
 	u64 dummy0, dummy1;
 
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
@@ -272,7 +273,7 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 	BUG_ON(lpar_rc != 0);
 }
 
-static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+static void beat_lpar_hpte_invalidate(unsigned long slot, struct virt_addr va,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
@@ -311,7 +312,7 @@ void __init hpte_init_beat(void)
 }
 
 static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
+				  struct virt_addr va, unsigned long pa,
 				  unsigned long rflags, unsigned long vflags,
 				  int psize, int ssize)
 {
@@ -364,7 +365,7 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
  */
 static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 				    unsigned long newpp,
-				    unsigned long va,
+				    struct virt_addr va,
 				    int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
@@ -392,7 +393,7 @@ static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 	return 0;
 }
 
-static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long va,
+static void beat_lpar_hpte_invalidate_v3(unsigned long slot, struct virt_addr va,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 3124cf7..6e27576 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -43,7 +43,7 @@ enum ps3_lpar_vas_id {
 
 static DEFINE_SPINLOCK(ps3_htab_lock);
 
-static long ps3_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long ps3_hpte_insert(unsigned long hpte_group, struct virt_addr va,
 	unsigned long pa, unsigned long rflags, unsigned long vflags,
 	int psize, int ssize)
 {
@@ -107,7 +107,7 @@ static long ps3_hpte_remove(unsigned long hpte_group)
 }
 
 static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
-	unsigned long va, int psize, int ssize, int local)
+	struct virt_addr va, int psize, int ssize, int local)
 {
 	int result;
 	u64 hpte_v, want_v, hpte_rs;
@@ -159,7 +159,7 @@ static void ps3_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	panic("ps3_hpte_updateboltedpp() not implemented");
 }
 
-static void ps3_hpte_invalidate(unsigned long slot, unsigned long va,
+static void ps3_hpte_invalidate(unsigned long slot, struct virt_addr va,
 	int psize, int ssize, int local)
 {
 	unsigned long flags;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5f3ef87..b4e9641 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -108,9 +108,9 @@ void vpa_init(int cpu)
 }
 
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
- 			      unsigned long va, unsigned long pa,
- 			      unsigned long rflags, unsigned long vflags,
-			      int psize, int ssize)
+				     struct virt_addr va, unsigned long pa,
+				     unsigned long rflags, unsigned long vflags,
+				     int psize, int ssize)
 {
 	unsigned long lpar_rc;
 	unsigned long flags;
@@ -120,7 +120,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	if (!(vflags & HPTE_V_BOLTED))
 		pr_devel("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
 			 "rflags=%lx, vflags=%lx, psize=%d)\n",
-			 hpte_group, va, pa, rflags, vflags, psize);
+			 hpte_group, va.addr, pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
@@ -231,12 +231,12 @@ static void pSeries_lpar_hptab_clear(void)
  * for use when we want to match an existing PTE.  The bottom 7 bits
  * of the returned value are zero.
  */
-static inline unsigned long hpte_encode_avpn(unsigned long va, int psize,
+static inline unsigned long hpte_encode_avpn(struct virt_addr va, int psize,
 					     int ssize)
 {
 	unsigned long v;
 
-	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
+	v = (va.addr >> 23) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
 	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
@@ -250,7 +250,7 @@ static inline unsigned long hpte_encode_avpn(unsigned long va, int psize,
  */
 static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       unsigned long newpp,
-				       unsigned long va,
+				       struct virt_addr va,
 				       int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
@@ -295,7 +295,7 @@ static unsigned long pSeries_lpar_hpte_getword0(unsigned long slot)
 	return dword0;
 }
 
-static long pSeries_lpar_hpte_find(unsigned long va, int psize, int ssize)
+static long pSeries_lpar_hpte_find(struct virt_addr va, int psize, int ssize)
 {
 	unsigned long hash;
 	unsigned long i;
@@ -323,7 +323,8 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
 					     int psize, int ssize)
 {
-	unsigned long lpar_rc, slot, vsid, va, flags;
+	struct virt_addr va;
+	unsigned long lpar_rc, slot, vsid, flags;
 
 	vsid = get_kernel_vsid(ea, ssize);
 	va = hpt_va(ea, vsid, ssize);
@@ -337,7 +338,7 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
-static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+static void pSeries_lpar_hpte_invalidate(unsigned long slot, struct virt_addr va,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
@@ -345,7 +346,7 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 	unsigned long dummy1, dummy2;
 
 	pr_devel("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		 slot, va, psize, local);
+		 slot, va.addr, psize, local);
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
@@ -358,7 +359,8 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 					   int psize, int ssize)
 {
-	unsigned long slot, vsid, va;
+	struct virt_addr va;
+	unsigned long slot, vsid;
 
 	vsid = get_kernel_vsid(ea, ssize);
 	va = hpt_va(ea, vsid, ssize);
@@ -382,12 +384,12 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
  */
 static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 {
+	struct virt_addr va;
 	unsigned long i, pix, rc;
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[9];
-	unsigned long va;
 	unsigned long hash, index, shift, hidx, slot;
 	real_pte_t pte;
 	int psize, ssize;
@@ -401,7 +403,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	for (i = 0; i < number; i++) {
 		va = batch->vaddr[i];
 		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
+		pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
 			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
-- 
1.7.10
