Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C89882C038A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:14:06 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 12:52:21 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q69D6AuJ57737266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:06:10 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q69DDxDE030028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:13:59 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 04/11] arch/powerpc: Rename va to vpn
Date: Mon,  9 Jul 2012 18:43:34 +0530
Message-Id: <1341839621-28332-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Rename the variable to better reflect the values. No functional change
in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h   |    2 +-
 arch/powerpc/include/asm/machdep.h      |    6 +--
 arch/powerpc/include/asm/mmu-hash64.h   |   23 ++++----
 arch/powerpc/include/asm/tlbflush.h     |    4 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c   |   15 +++---
 arch/powerpc/mm/hash_native_64.c        |   88 ++++++++++++++++---------------
 arch/powerpc/mm/hash_utils_64.c         |   22 ++++----
 arch/powerpc/mm/hugetlbpage-hash64.c    |   15 +++---
 arch/powerpc/mm/tlb_hash64.c            |   11 ++--
 arch/powerpc/platforms/cell/beat_htab.c |   45 ++++++++--------
 arch/powerpc/platforms/ps3/htab.c       |   22 ++++----
 arch/powerpc/platforms/pseries/lpar.c   |   60 +++++++++++----------
 12 files changed, 161 insertions(+), 152 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index f0e0c6a..7aefdb3 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -59,7 +59,7 @@ struct hpte_cache {
 	struct hlist_node list_vpte;
 	struct hlist_node list_vpte_long;
 	struct rcu_head rcu_head;
-	u64 host_va;
+	u64 host_vpn;
 	u64 pfn;
 	ulong slot;
 	struct kvmppc_pte pte;
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 42ce570..cd63f1a 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -34,19 +34,19 @@ struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
 	void            (*hpte_invalidate)(unsigned long slot,
-					   unsigned long va,
+					   unsigned long vpn,
 					   int psize, int ssize,
 					   int local);
 	long		(*hpte_updatepp)(unsigned long slot, 
 					 unsigned long newpp, 
-					 unsigned long va,
+					 unsigned long vpn,
 					 int psize, int ssize,
 					 int local);
 	void            (*hpte_updateboltedpp)(unsigned long newpp, 
 					       unsigned long ea,
 					       int psize, int ssize);
 	long		(*hpte_insert)(unsigned long hpte_group,
-				       unsigned long va,
+				       unsigned long vpn,
 				       unsigned long prpn,
 				       unsigned long rflags,
 				       unsigned long vflags,
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 1c984a6..a085de2 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -224,11 +224,11 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
  */
-static inline unsigned long hpte_encode_v(unsigned long va, int psize,
-					  int ssize)
+static inline unsigned long hpte_encode_v(unsigned long vpn,
+					  int psize, int ssize)
 {
 	unsigned long v;
-	v = hpte_encode_avpn(va, psize, ssize);
+	v = hpte_encode_avpn(vpn, psize, ssize);
 	if (psize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
 	return v;
@@ -257,8 +257,8 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
 /*
  * Build a VPN_SHIFT bit shifted va given VSID, EA and segment size.
  */
-static inline unsigned long hpt_vpn(unsigned long ea, unsigned long vsid,
-				   int ssize)
+static inline unsigned long hpt_vpn(unsigned long ea,
+				    unsigned long vsid, int ssize)
 {
 	unsigned long mask;
 	int s_shift = segment_shift(ssize);
@@ -270,9 +270,8 @@ static inline unsigned long hpt_vpn(unsigned long ea, unsigned long vsid,
 /*
  * This hashes a virtual address
  */
-
-static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
-				     int ssize)
+static inline unsigned long hpt_hash(unsigned long vpn,
+				     unsigned int shift, int ssize)
 {
 	int mask;
 	unsigned long hash, vsid;
@@ -281,13 +280,13 @@ static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
 
 	if (ssize == MMU_SEGSIZE_256M) {
 		mask = (1ul << (SID_SHIFT - VPN_SHIFT)) - 1;
-		hash = ((va >> (SID_SHIFT - VPN_SHIFT)) & 0x0000007fffffffff) ^
-			(((va & mask) >> (shift - VPN_SHIFT)) & 0xffff);
+		hash = ((vpn >> (SID_SHIFT - VPN_SHIFT)) & 0x0000007fffffffff) ^
+			(((vpn & mask) >> (shift - VPN_SHIFT)) & 0xffff);
 	} else {
 		mask = (1ul << (SID_SHIFT_1T - VPN_SHIFT)) - 1;
-		vsid = va >> (SID_SHIFT_1T - VPN_SHIFT);
+		vsid = vpn >> (SID_SHIFT_1T - VPN_SHIFT);
 		hash = (vsid & 0xffffff) ^ ((vsid << 25) & 0x7fffffffff) ^
-			(((va & mask) >> (shift - VPN_SHIFT)) & 0xfffffff);
+			(((vpn & mask) >> (shift - VPN_SHIFT)) & 0xfffffff);
 	}
 	return hash & 0x7fffffffffUL;
 }
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 81143fc..fc02d1d 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -95,7 +95,7 @@ struct ppc64_tlb_batch {
 	unsigned long		index;
 	struct mm_struct	*mm;
 	real_pte_t		pte[PPC64_TLB_BATCH_NR];
-	unsigned long		vaddr[PPC64_TLB_BATCH_NR];
+	unsigned long		vpn[PPC64_TLB_BATCH_NR];
 	unsigned int		psize;
 	int			ssize;
 };
@@ -127,7 +127,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
 
-extern void flush_hash_page(unsigned long va, real_pte_t pte, int psize,
+extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 9d184f1..f910e24 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -80,8 +80,9 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 
 int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 {
+	unsigned long vpn;
 	pfn_t hpaddr;
-	ulong hash, hpteg, va;
+	ulong hash, hpteg;
 	u64 vsid;
 	int ret;
 	int rflags = 0x192;
@@ -117,7 +118,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	}
 
 	vsid = map->host_vsid;
-	va = hpt_vpn(orig_pte->eaddr, vsid, MMU_SEGSIZE_256M);
+	vpn = hpt_vpn(orig_pte->eaddr, vsid, MMU_SEGSIZE_256M);
 
 	if (!orig_pte->may_write)
 		rflags |= HPTE_R_PP;
@@ -127,7 +128,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	if (!orig_pte->may_execute)
 		rflags |= HPTE_R_N;
 
-	hash = hpt_hash(va, PTE_SIZE, MMU_SEGSIZE_256M);
+	hash = hpt_hash(vpn, PTE_SIZE, MMU_SEGSIZE_256M);
 
 map_again:
 	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
@@ -139,7 +140,8 @@ map_again:
 			goto out;
 		}
 
-	ret = ppc_md.hpte_insert(hpteg, va, hpaddr, rflags, vflags, MMU_PAGE_4K, MMU_SEGSIZE_256M);
+	ret = ppc_md.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
+				 MMU_PAGE_4K, MMU_SEGSIZE_256M);
 
 	if (ret < 0) {
 		/* If we couldn't map a primary PTE, try a secondary */
@@ -150,7 +152,8 @@ map_again:
 	} else {
 		struct hpte_cache *pte = kvmppc_mmu_hpte_cache_next(vcpu);
 
-		trace_kvm_book3s_64_mmu_map(rflags, hpteg, va, hpaddr, orig_pte);
+		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
+					    vpn, hpaddr, orig_pte);
 
 		/* The ppc_md code may give us a secondary entry even though we
 		   asked for a primary. Fix up. */
@@ -160,7 +163,7 @@ map_again:
 		}
 
 		pte->slot = hpteg + (ret & 7);
-		pte->host_va = va;
+		pte->host_vpn = vpn;
 		pte->pte = *orig_pte;
 		pte->pfn = hpaddr >> PAGE_SHIFT;
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 308e29d..b019f2d 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -109,7 +109,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
 
 }
 
-static inline void tlbie(unsigned long va, int psize, int ssize, int local)
+static inline void tlbie(unsigned long vpn, int psize, int ssize, int local)
 {
 	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
@@ -120,10 +120,10 @@ static inline void tlbie(unsigned long va, int psize, int ssize, int local)
 		raw_spin_lock(&native_tlbie_lock);
 	asm volatile("ptesync": : :"memory");
 	if (use_local) {
-		__tlbiel(va, psize, ssize);
+		__tlbiel(vpn, psize, ssize);
 		asm volatile("ptesync": : :"memory");
 	} else {
-		__tlbie(va, psize, ssize);
+		__tlbie(vpn, psize, ssize);
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
@@ -149,7 +149,7 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
 
-static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 			unsigned long pa, unsigned long rflags,
 			unsigned long vflags, int psize, int ssize)
 {
@@ -158,9 +158,9 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
 	int i;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
-		DBG_LOW("    insert(group=%lx, va=%016lx, pa=%016lx,"
+		DBG_LOW("    insert(group=%lx, vpn=%016lx, pa=%016lx,"
 			" rflags=%lx, vflags=%lx, psize=%d)\n",
-			hpte_group, va, pa, rflags, vflags, psize);
+			hpte_group, vpn, pa, rflags, vflags, psize);
 	}
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
@@ -178,7 +178,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
-	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
@@ -240,17 +240,17 @@ static long native_hpte_remove(unsigned long hpte_group)
 }
 
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
-				 unsigned long va, int psize, int ssize,
+				 unsigned long vpn, int psize, int ssize,
 				 int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
 	int ret = 0;
 
-	want_v = hpte_encode_v(va, psize, ssize);
+	want_v = hpte_encode_v(vpn, psize, ssize);
 
-	DBG_LOW("    update(va=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
-		va, want_v & HPTE_V_AVPN, slot, newpp);
+	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
+		vpn, want_v & HPTE_V_AVPN, slot, newpp);
 
 	native_lock_hpte(hptep);
 
@@ -269,12 +269,12 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(va, psize, ssize, local);
+	tlbie(vpn, psize, ssize, local);
 
 	return ret;
 }
 
-static long native_hpte_find(unsigned long va, int psize, int ssize)
+static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 {
 	struct hash_pte *hptep;
 	unsigned long hash;
@@ -282,8 +282,8 @@ static long native_hpte_find(unsigned long va, int psize, int ssize)
 	long slot;
 	unsigned long want_v, hpte_v;
 
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_v(va, psize, ssize);
+	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
+	want_v = hpte_encode_v(vpn, psize, ssize);
 
 	/* Bolted mappings are only ever in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -310,14 +310,15 @@ static long native_hpte_find(unsigned long va, int psize, int ssize)
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 				       int psize, int ssize)
 {
-	unsigned long vsid, va;
+	unsigned long vpn;
+	unsigned long vsid;
 	long slot;
 	struct hash_pte *hptep;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_vpn(ea, vsid, ssize);
+	vpn = hpt_vpn(ea, vsid, ssize);
 
-	slot = native_hpte_find(va, psize, ssize);
+	slot = native_hpte_find(vpn, psize, ssize);
 	if (slot == -1)
 		panic("could not find page to bolt\n");
 	hptep = htab_address + slot;
@@ -327,10 +328,10 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 		(newpp & (HPTE_R_PP | HPTE_R_N));
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(va, psize, ssize, 0);
+	tlbie(vpn, psize, ssize, 0);
 }
 
-static void native_hpte_invalidate(unsigned long slot, unsigned long va,
+static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 				   int psize, int ssize, int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
@@ -340,9 +341,9 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 
 	local_irq_save(flags);
 
-	DBG_LOW("    invalidate(va=%016lx, hash: %lx)\n", va, slot);
+	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
-	want_v = hpte_encode_v(va, psize, ssize);
+	want_v = hpte_encode_v(vpn, psize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
@@ -354,7 +355,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 		hptep->v = 0;
 
 	/* Invalidate the TLB */
-	tlbie(va, psize, ssize, local);
+	tlbie(vpn, psize, ssize, local);
 
 	local_irq_restore(flags);
 }
@@ -364,7 +365,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
 
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
-			int *psize, int *ssize, unsigned long *va)
+			int *psize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
 	unsigned long hpte_r = hpte->r;
@@ -414,7 +415,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		*va = vsid << (SID_SHIFT - VPN_SHIFT) | seg_off >> VPN_SHIFT;
+		*vpn = vsid << (SID_SHIFT - VPN_SHIFT) | seg_off >> VPN_SHIFT;
 	case MMU_SEGSIZE_1T:
 		/* We only have 40 - 23 bits of seg_off in avpn */
 		seg_off = (avpn & 0x1ffff) << 23;
@@ -423,9 +424,9 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ (vsid << 25) ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		*va = vsid << (SID_SHIFT_1T - VPN_SHIFT) | seg_off >> VPN_SHIFT;
+		*vpn = vsid << (SID_SHIFT_1T - VPN_SHIFT) | seg_off >> VPN_SHIFT;
 	default:
-		*va = size = 0;
+		*vpn = size = 0;
 	}
 	*psize = size;
 }
@@ -440,7 +441,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
  */
 static void native_hpte_clear(void)
 {
-	unsigned long va = 0;
+	unsigned long vpn = 0;
 	unsigned long slot, slots, flags;
 	struct hash_pte *hptep = htab_address;
 	unsigned long hpte_v;
@@ -471,9 +472,9 @@ static void native_hpte_clear(void)
 		 * already hold the native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
-			hpte_decode(hptep, slot, &psize, &ssize, &va);
+			hpte_decode(hptep, slot, &psize, &ssize, &vpn);
 			hptep->v = 0;
-			__tlbie(va, psize, ssize);
+			__tlbie(vpn, psize, ssize);
 		}
 	}
 
@@ -488,7 +489,8 @@ static void native_hpte_clear(void)
  */
 static void native_flush_hash_range(unsigned long number, int local)
 {
-	unsigned long va, hash, index, hidx, shift, slot;
+	unsigned long vpn;
+	unsigned long hash, index, hidx, shift, slot;
 	struct hash_pte *hptep;
 	unsigned long hpte_v;
 	unsigned long want_v;
@@ -502,18 +504,18 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_save(flags);
 
 	for (i = 0; i < number; i++) {
-		va = batch->vaddr[i];
+		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-			hash = hpt_hash(va, shift, ssize);
+		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+			hash = hpt_hash(vpn, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
-			want_v = hpte_encode_v(va, psize, ssize);
+			want_v = hpte_encode_v(vpn, psize, ssize);
 			native_lock_hpte(hptep);
 			hpte_v = hptep->v;
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
@@ -528,12 +530,12 @@ static void native_flush_hash_range(unsigned long number, int local)
 	    mmu_psize_defs[psize].tlbiel && local) {
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
-			va = batch->vaddr[i];
+			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va, index,
-						    shift) {
-				__tlbiel(va, psize, ssize);
+			pte_iterate_hashed_subpages(pte, psize,
+						    vpn, index, shift) {
+				__tlbiel(vpn, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("ptesync":::"memory");
@@ -545,12 +547,12 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
-			va = batch->vaddr[i];
+			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va, index,
-						    shift) {
-				__tlbie(va, psize, ssize);
+			pte_iterate_hashed_subpages(pte, psize,
+						    vpn, index, shift) {
+				__tlbie(vpn, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 975c7d1..0d8c4b8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -192,18 +192,18 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	     vaddr += step, paddr += step) {
 		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
-		unsigned long va  = hpt_vpn(vaddr, vsid, ssize);
+		unsigned long vpn  = hpt_vpn(vaddr, vsid, ssize);
 		unsigned long tprot = prot;
 
 		/* Make kernel text executable */
 		if (overlaps_kernel_text(vaddr, vaddr + step))
 			tprot &= ~HPTE_R_N;
 
-		hash = hpt_hash(va, shift, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 		BUG_ON(!ppc_md.hpte_insert);
-		ret = ppc_md.hpte_insert(hpteg, va, paddr, tprot,
+		ret = ppc_md.hpte_insert(hpteg, vpn, paddr, tprot,
 					 HPTE_V_BOLTED, psize, ssize);
 
 		if (ret < 0)
@@ -1153,21 +1153,21 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int ssize,
+void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     int local)
 {
 	unsigned long hash, index, shift, hidx, slot;
 
-	DBG_LOW("flush_hash_page(va=%016lx)\n", va);
-	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-		hash = hpt_hash(va, shift, ssize);
+	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
+	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		hash = hpt_hash(vpn, shift, ssize);
 		hidx = __rpte_to_hidx(pte, index);
 		if (hidx & _PTEIDX_SECONDARY)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
-		ppc_md.hpte_invalidate(slot, va, psize, ssize, local);
+		ppc_md.hpte_invalidate(slot, vpn, psize, ssize, local);
 	} pte_iterate_hashed_end();
 }
 
@@ -1181,7 +1181,7 @@ void flush_hash_range(unsigned long number, int local)
 			&__get_cpu_var(ppc64_tlb_batch);
 
 		for (i = 0; i < number; i++)
-			flush_hash_page(batch->vaddr[i], batch->pte[i],
+			flush_hash_page(batch->vpn[i], batch->pte[i],
 					batch->psize, batch->ssize, local);
 	}
 }
@@ -1208,7 +1208,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hpteg;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
+	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 	unsigned long mode = htab_convert_pte_flags(PAGE_KERNEL);
 	int ret;
 
@@ -1229,7 +1229,7 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hidx, slot;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
+	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 
 	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
 	spin_lock(&linear_map_hash_lock);
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 1331403..cecad34 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -18,14 +18,15 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize)
 {
+	unsigned long vpn;
 	unsigned long old_pte, new_pte;
-	unsigned long va, rflags, pa, sz;
+	unsigned long rflags, pa, sz;
 	long slot;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
 	/* Search the Linux page table for a match with va */
-	va = hpt_vpn(ea, vsid, ssize);
+	vpn = hpt_vpn(ea, vsid, ssize);
 
 	/* At this point, we have a pte (old_pte) which can be used to build
 	 * or update an HPTE. There are 2 cases:
@@ -69,19 +70,19 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* There MIGHT be an HPTE for this pte */
 		unsigned long hash, slot;
 
-		hash = hpt_hash(va, shift, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
 		if (old_pte & _PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (old_pte & _PAGE_F_GIX) >> 12;
 
-		if (ppc_md.hpte_updatepp(slot, rflags, va, mmu_psize,
+		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
 					 ssize, local) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
 	if (likely(!(old_pte & _PAGE_HASHPTE))) {
-		unsigned long hash = hpt_hash(va, shift, ssize);
+		unsigned long hash = hpt_hash(vpn, shift, ssize);
 		unsigned long hpte_group;
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
@@ -101,14 +102,14 @@ repeat:
 				      _PAGE_COHERENT | _PAGE_GUARDED));
 
 		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags, 0,
+		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
 					  mmu_psize, ssize);
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL;
-			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
+			slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags,
 						  HPTE_V_SECONDARY,
 						  mmu_psize, ssize);
 			if (slot == -1) {
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 321c585..ae758b3 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -42,8 +42,9 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, unsigned long pte, int huge)
 {
+	unsigned long vpn;
 	struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);
-	unsigned long vsid, vaddr;
+	unsigned long vsid;
 	unsigned int psize;
 	int ssize;
 	real_pte_t rpte;
@@ -86,7 +87,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
 	}
-	vaddr = hpt_vpn(addr, vsid, ssize);
+	vpn = hpt_vpn(addr, vsid, ssize);
 	rpte = __real_pte(__pte(pte), ptep);
 
 	/*
@@ -96,7 +97,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * and decide to use local invalidates instead...
 	 */
 	if (!batch->active) {
-		flush_hash_page(vaddr, rpte, psize, ssize, 0);
+		flush_hash_page(vpn, rpte, psize, ssize, 0);
 		put_cpu_var(ppc64_tlb_batch);
 		return;
 	}
@@ -122,7 +123,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		batch->ssize = ssize;
 	}
 	batch->pte[i] = rpte;
-	batch->vaddr[i] = vaddr;
+	batch->vpn[i] = vpn;
 	batch->index = ++i;
 	if (i >= PPC64_TLB_BATCH_NR)
 		__flush_tlb_pending(batch);
@@ -146,7 +147,7 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 	if (cpumask_equal(mm_cpumask(batch->mm), tmp))
 		local = 1;
 	if (i == 1)
-		flush_hash_page(batch->vaddr[0], batch->pte[0],
+		flush_hash_page(batch->vpn[0], batch->pte[0],
 				batch->psize, batch->ssize, local);
 	else
 		flush_hash_range(i, local);
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index c8c7bf6..0f6f839 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -88,7 +88,7 @@ static inline unsigned int beat_read_mask(unsigned hpte_group)
 }
 
 static long beat_lpar_hpte_insert(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
+				  unsigned long vpn, unsigned long pa,
 				  unsigned long rflags, unsigned long vflags,
 				  int psize, int ssize)
 {
@@ -103,7 +103,7 @@ static long beat_lpar_hpte_insert(unsigned long hpte_group,
 			"rflags=%lx, vflags=%lx, psize=%d)\n",
 		hpte_group, va, pa, rflags, vflags, psize);
 
-	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
+	hpte_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M) |
 		vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
@@ -184,14 +184,14 @@ static void beat_lpar_hptab_clear(void)
  */
 static long beat_lpar_hpte_updatepp(unsigned long slot,
 				    unsigned long newpp,
-				    unsigned long va,
+				    unsigned long vpn,
 				    int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
 	u64 dummy0, dummy1;
 	unsigned long want_v;
 
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
 
 	DBG_LOW("    update: "
 		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
@@ -220,15 +220,15 @@ static long beat_lpar_hpte_updatepp(unsigned long slot,
 	return 0;
 }
 
-static long beat_lpar_hpte_find(unsigned long va, int psize)
+static long beat_lpar_hpte_find(unsigned long vpn, int psize)
 {
 	unsigned long hash;
 	unsigned long i, j;
 	long slot;
 	unsigned long want_v, hpte_v;
 
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift, MMU_SEGSIZE_256M);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
 
 	for (j = 0; j < 2; j++) {
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -255,14 +255,15 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 					  unsigned long ea,
 					  int psize, int ssize)
 {
-	unsigned long lpar_rc, slot, vsid, va;
+	unsigned long vpn;
+	unsigned long lpar_rc, slot, vsid;
 	u64 dummy0, dummy1;
 
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
-	va = hpt_vpn(ea, vsid, MMU_SEGSIZE_256M);
+	vpn = hpt_vpn(ea, vsid, MMU_SEGSIZE_256M);
 
 	raw_spin_lock(&beat_htab_lock);
-	slot = beat_lpar_hpte_find(va, psize);
+	slot = beat_lpar_hpte_find(vpn, psize);
 	BUG_ON(slot == -1);
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
@@ -272,7 +273,7 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 	BUG_ON(lpar_rc != 0);
 }
 
-static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
@@ -282,7 +283,7 @@ static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 
 	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
 		slot, va, psize, local);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
 
 	raw_spin_lock_irqsave(&beat_htab_lock, flags);
 	dummy1 = beat_lpar_hpte_getword0(slot);
@@ -311,7 +312,7 @@ void __init hpte_init_beat(void)
 }
 
 static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
-				  unsigned long va, unsigned long pa,
+				  unsigned long vpn, unsigned long pa,
 				  unsigned long rflags, unsigned long vflags,
 				  int psize, int ssize)
 {
@@ -322,11 +323,11 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
 		return -1;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+		DBG_LOW("hpte_insert(group=%lx, vpn=%016lx, pa=%016lx, "
 			"rflags=%lx, vflags=%lx, psize=%d)\n",
-		hpte_group, va, pa, rflags, vflags, psize);
+		hpte_group, vpn, pa, rflags, vflags, psize);
 
-	hpte_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M) |
+	hpte_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M) |
 		vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
@@ -364,14 +365,14 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
  */
 static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 				    unsigned long newpp,
-				    unsigned long va,
+				    unsigned long vpn,
 				    int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
 	unsigned long want_v;
 	unsigned long pss;
 
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
 	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
 
 	DBG_LOW("    update: "
@@ -392,16 +393,16 @@ static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 	return 0;
 }
 
-static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long va,
+static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long vpn,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
 	unsigned long pss;
 
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		slot, va, psize, local);
-	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
+	DBG_LOW("    inval : slot=%lx, vpn=%016lx, psize: %d, local: %d\n",
+		slot, vpn, psize, local);
+	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
 	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
 
 	lpar_rc = beat_invalidate_htab_entry3(0, slot, want_v, pss);
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 3124cf7..d00d7b0 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -43,7 +43,7 @@ enum ps3_lpar_vas_id {
 
 static DEFINE_SPINLOCK(ps3_htab_lock);
 
-static long ps3_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long ps3_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	unsigned long pa, unsigned long rflags, unsigned long vflags,
 	int psize, int ssize)
 {
@@ -61,7 +61,7 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long va,
 	 */
 	vflags &= ~HPTE_V_SECONDARY;
 
-	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(ps3_mm_phys_to_lpar(pa), psize) | rflags;
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
@@ -75,8 +75,8 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long va,
 
 	if (result) {
 		/* all entries bolted !*/
-		pr_info("%s:result=%d va=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
-			__func__, result, va, pa, hpte_group, hpte_v, hpte_r);
+		pr_info("%s:result=%d vpn=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
+			__func__, result, vpn, pa, hpte_group, hpte_v, hpte_r);
 		BUG();
 	}
 
@@ -107,7 +107,7 @@ static long ps3_hpte_remove(unsigned long hpte_group)
 }
 
 static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
-	unsigned long va, int psize, int ssize, int local)
+	unsigned long vpn, int psize, int ssize, int local)
 {
 	int result;
 	u64 hpte_v, want_v, hpte_rs;
@@ -115,7 +115,7 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	unsigned long flags;
 	long ret;
 
-	want_v = hpte_encode_v(va, psize, ssize);
+	want_v = hpte_encode_v(vpn, psize, ssize);
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
 
@@ -125,8 +125,8 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				       &hpte_rs);
 
 	if (result) {
-		pr_info("%s: res=%d read va=%lx slot=%lx psize=%d\n",
-			__func__, result, va, slot, psize);
+		pr_info("%s: res=%d read vpn=%lx slot=%lx psize=%d\n",
+			__func__, result, vpn, slot, psize);
 		BUG();
 	}
 
@@ -159,7 +159,7 @@ static void ps3_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	panic("ps3_hpte_updateboltedpp() not implemented");
 }
 
-static void ps3_hpte_invalidate(unsigned long slot, unsigned long va,
+static void ps3_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	int psize, int ssize, int local)
 {
 	unsigned long flags;
@@ -170,8 +170,8 @@ static void ps3_hpte_invalidate(unsigned long slot, unsigned long va,
 	result = lv1_write_htab_entry(PS3_LPAR_VAS_ID_CURRENT, slot, 0, 0);
 
 	if (result) {
-		pr_info("%s: res=%d va=%lx slot=%lx psize=%d\n",
-			__func__, result, va, slot, psize);
+		pr_info("%s: res=%d vpn=%lx slot=%lx psize=%d\n",
+			__func__, result, vpn, slot, psize);
 		BUG();
 	}
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 2127529..8308b25 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -108,9 +108,9 @@ void vpa_init(int cpu)
 }
 
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
- 			      unsigned long va, unsigned long pa,
- 			      unsigned long rflags, unsigned long vflags,
-			      int psize, int ssize)
+				     unsigned long vpn, unsigned long pa,
+				     unsigned long rflags, unsigned long vflags,
+				     int psize, int ssize)
 {
 	unsigned long lpar_rc;
 	unsigned long flags;
@@ -118,11 +118,11 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	unsigned long hpte_v, hpte_r;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		pr_devel("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			 "rflags=%lx, vflags=%lx, psize=%d)\n",
-			 hpte_group, va, pa, rflags, vflags, psize);
+		pr_devel("hpte_insert(group=%lx, vpn=%016lx, "
+			 "pa=%016lx, rflags=%lx, vflags=%lx, psize=%d)\n",
+			 hpte_group, vpn,  pa, rflags, vflags, psize);
 
-	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
@@ -234,14 +234,14 @@ static void pSeries_lpar_hptab_clear(void)
  */
 static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       unsigned long newpp,
-				       unsigned long va,
+				       unsigned long vpn,
 				       int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
 	unsigned long flags = (newpp & 7) | H_AVPN;
 	unsigned long want_v;
 
-	want_v = hpte_encode_avpn(va, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
@@ -279,15 +279,15 @@ static unsigned long pSeries_lpar_hpte_getword0(unsigned long slot)
 	return dword0;
 }
 
-static long pSeries_lpar_hpte_find(unsigned long va, int psize, int ssize)
+static long pSeries_lpar_hpte_find(unsigned long vpn, int psize, int ssize)
 {
 	unsigned long hash;
 	unsigned long i;
 	long slot;
 	unsigned long want_v, hpte_v;
 
-	hash = hpt_hash(va, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_avpn(va, psize, ssize);
+	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted entries are always in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -307,12 +307,13 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
 					     int psize, int ssize)
 {
-	unsigned long lpar_rc, slot, vsid, va, flags;
+	unsigned long vpn;
+	unsigned long lpar_rc, slot, vsid, flags;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_vpn(ea, vsid, ssize);
+	vpn = hpt_vpn(ea, vsid, ssize);
 
-	slot = pSeries_lpar_hpte_find(va, psize, ssize);
+	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 	BUG_ON(slot == -1);
 
 	flags = newpp & 7;
@@ -321,17 +322,17 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
-static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
+static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 					 int psize, int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	pr_devel("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		 slot, va, psize, local);
+	pr_devel("    inval : slot=%lx, vpn=%016lx, psize: %d, local: %d\n",
+		 slot, vpn, psize, local);
 
-	want_v = hpte_encode_avpn(va, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
 	if (lpar_rc == H_NOT_FOUND)
 		return;
@@ -342,15 +343,16 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 					   int psize, int ssize)
 {
-	unsigned long slot, vsid, va;
+	unsigned long vpn;
+	unsigned long slot, vsid;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_vpn(ea, vsid, ssize);
+	vpn = hpt_vpn(ea, vsid, ssize);
 
-	slot = pSeries_lpar_hpte_find(va, psize, ssize);
+	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 	BUG_ON(slot == -1);
 
-	pSeries_lpar_hpte_invalidate(slot, va, psize, ssize, 0);
+	pSeries_lpar_hpte_invalidate(slot, vpn, psize, ssize, 0);
 }
 
 /* Flag bits for H_BULK_REMOVE */
@@ -366,12 +368,12 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
  */
 static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 {
+	unsigned long vpn;
 	unsigned long i, pix, rc;
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[9];
-	unsigned long va;
 	unsigned long hash, index, shift, hidx, slot;
 	real_pte_t pte;
 	int psize, ssize;
@@ -383,21 +385,21 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	ssize = batch->ssize;
 	pix = 0;
 	for (i = 0; i < number; i++) {
-		va = batch->vaddr[i];
+		vpn = batch->vpn[i];
 		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
-			hash = hpt_hash(va, shift, ssize);
+		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+			hash = hpt_hash(vpn, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
-				pSeries_lpar_hpte_invalidate(slot, va, psize,
+				pSeries_lpar_hpte_invalidate(slot, vpn, psize,
 							     ssize, local);
 			} else {
 				param[pix] = HBR_REQUEST | HBR_AVPN | slot;
-				param[pix+1] = hpte_encode_avpn(va, psize,
+				param[pix+1] = hpte_encode_avpn(vpn, psize,
 								ssize);
 				pix += 2;
 				if (pix == 8) {
-- 
1.7.10
