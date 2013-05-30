Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72CC42C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 02:10:23 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 30 May 2013 21:36:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 32472E004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 21:42:59 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4UGA9dK10813722
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 21:40:09 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4UGAHHI017615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 02:10:17 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, Hugh Dickins <hughd@google.com>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
In-Reply-To: <87vc60na89.fsf@linux.vnet.ibm.com>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
Date: Thu, 30 May 2013 21:40:14 +0530
Message-ID: <87sj14mot5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Benjamin Herrenschmidt <benh@au1.ibm.com> writes:
>
>> On Wed, 2013-05-29 at 22:47 -0700, Hugh Dickins wrote:
>>> Running my favourite swapping load (repeated make -j20 kernel builds
>>> in tmpfs in parallel with repeated make -j20 kernel builds in ext4 on
>>> loop on tmpfs file, all limited by mem=700M and swap 1.5G) on 3.10-rc
>>> on PowerMac G5, the test dies with corrupted usermem after a few hours.
>>> 
>>> Variously, segmentation fault or Binutils assertion fail or gcc Internal
>>> error in either or both builds: usually signs of swapping or TLB flushing
>>> gone wrong.  Sometimes the tmpfs build breaks first, sometimes the ext4 on
>>> loop on tmpfs, so at least it looks unrelated to loop.  No problem on x86.
>>> 
>>> This is 64-bit kernel but 4k pages and old SuSE 11.1 32-bit userspace.
>>> 
>>> I've just finished a manual bisection on arch/powerpc/mm (which might
>>> have been a wrong guess, but has paid off): the first bad commit is
>>> 7e74c3921ad9610c0b49f28b8fc69f7480505841
>>> "powerpc: Fix hpte_decode to use the correct decoding for page sizes".
>>
>> Ok, I have other reasons to think is wrong. I debugged a case last week
>> where after kexec we still had stale TLB entries, due to the TLB cleanup
>> not working.
>>
>> Thanks for doing that bisection ! I'll investigate ASAP (though it will
>> probably have to wait for tomorrow unless Paul beats me to it)
>>
>>> I don't know if it's actually swapping to swap that's triggering the
>>> problem, or a more general page reclaim or TLB flush problem.  I hit
>>> it originally when trying to test Mel Gorman's pagevec series on top
>>> of 3.10-rc; and though I then reproduced it without that series, it
>>> did seem to take much longer: so I have been applying Mel's series to
>>> speed up each step of the bisection.  But if I went back again, might
>>> find it was just chance that I hit it sooner with Mel's series than
>>> without.  So, you're probably safe to ignore that detail, but I
>>> mention it just in case it turns out to have some relevance.
>>> 
>>> Something else peculiar that I've been doing in these runs, may or may
>>> not be relevant: I've been running swapon and swapoff repeatedly in the
>>> background, so that we're doing swapoff even while busy building.
>>> 
>>> I probably can't go into much more detail on the test (it's hard
>>> to get the balance right, to be swapping rather than OOMing or just
>>> running without reclaim), but can test any patches you'd like me to
>>> try (though it may take 24 hours for me to report back usefully).
>>
>> I think it's just failing to invalidate the TLB properly. At least one
>> bug I can spot just looking at it:
>>
>> static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
>> 				   int psize, int ssize, int local)
>>
>>    .../...
>>
>> 	native_lock_hpte(hptep);
>> 	hpte_v = hptep->v;
>>
>> 	actual_psize = hpte_actual_psize(hptep, psize);
>> 	if (actual_psize < 0) {
>> 		native_unlock_hpte(hptep);
>> 		local_irq_restore(flags);
>> 		return;
>> 	}
>>
>> That's wrong. We must still perform the TLB invalidation even if the
>> hash PTE is empty.
>>
>> In fact, Aneesh, this is a problem with MPSS for your THP work, I just
>> thought about it.
>>
>> The reason is that if a hash bucket gets full, we "evict" a more/less
>> random entry from it. When we do that we don't invalidate the TLB
>> (hpte_remove) because we assume the old translation is still technically
>> "valid".
>>
>
> Hmm that is correct, I missed that. But to do a tlb invalidate we need
> both base and actual page size. One of the reason i didn't update the
> hpte_invalidate callback to take both the page sizes was because, PAPR
> didn't need that for invalidate (H_REMOVE). hpte_remove did result in a
> tlb invalidate there. 
>
>
>> However that means that an hpte_invalidate *must* invalidate the TLB
>> later on even if it's not hitting the right entry in the hash.
>>
>> However, I can see why that cannot work with THP/MPSS since you have no
>> way to know the page size from the PTE anymore....
>>
>> So my question is, apart from hpte_decode used by kexec, which I will
>> fix by just blowing the whole TLB when not running phyp, why do you need
>> the "actual" size in invalidate and updatepp ? You really can't rely on
>> the size passed by the upper layers ?
>
> So for upstream I have below which should address the
> above. Meanwhile I will see what the impact would be to do a tlb
> invalidate in hpte_remove, so that we can keep both lpar and native
> changes similar.
>

How about the below ?

commit 9f70fd8cfeb7fca33ef8453197b76df46c860b52
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Thu May 30 20:09:58 2013 +0530

    powerpc/mm: Always invalidate tlb on hpte invalidate and update
    
    If a hash bucket gets full, we "evict" a more/less random entry from it.
    When we do that we don't invalidate the TLB (hpte_remove) because we assume
    the old translation is still technically "valid". This implies that when
    we are invalidating or updating pte, even if HPTE entry is not valid
    we should do a tlb invalidate.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 92386fc..801e3c6 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -36,13 +36,13 @@ struct machdep_calls {
 #ifdef CONFIG_PPC64
 	void            (*hpte_invalidate)(unsigned long slot,
 					   unsigned long vpn,
-					   int psize, int ssize,
-					   int local);
+					   int bpsize, int apsize,
+					   int ssize, int local);
 	long		(*hpte_updatepp)(unsigned long slot, 
 					 unsigned long newpp, 
 					 unsigned long vpn,
-					 int psize, int ssize,
-					 int local);
+					 int bpsize, int apsize,
+					 int ssize, int local);
 	void            (*hpte_updateboltedpp)(unsigned long newpp, 
 					       unsigned long ea,
 					       int psize, int ssize);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 3a9a1ac..176d3fd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -34,7 +34,7 @@
 void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	ppc_md.hpte_invalidate(pte->slot, pte->host_vpn,
-			       MMU_PAGE_4K, MMU_SEGSIZE_256M,
+			       MMU_PAGE_4K, MMU_PAGE_4K, MMU_SEGSIZE_256M,
 			       false);
 }
 
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 0e980ac..d3cbda6 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -289,9 +289,10 @@ htab_modify_pte:
 
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* vpn */
-	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
+	li	r6,MMU_PAGE_4K		/* base page size */
+	li	r7,MMU_PAGE_4K		/* actual page size */
+	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* Patched by htab_finish_init() */
 
@@ -649,9 +650,10 @@ htab_modify_pte:
 
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* vpn */
-	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
+	li	r6,MMU_PAGE_4K		/* base page size */
+	li	r7,MMU_PAGE_4K		/* actual page size */
+	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -937,9 +939,10 @@ ht64_modify_pte:
 
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* vpn */
-	li	r6,MMU_PAGE_64K
-	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
+	li	r6,MMU_PAGE_64K		/* base page size */
+	li	r7,MMU_PAGE_64K		/* actual page size */
+	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(ht64_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6a2aead..121c8ef 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -273,61 +273,15 @@ static long native_hpte_remove(unsigned long hpte_group)
 	return i;
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
-static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
-{
-	/* Look at the 8 bit LP value */
-	unsigned int lp = (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
-
-	if (!(hptep->v & HPTE_V_VALID))
-		return -1;
-
-	/* First check if it is large page */
-	if (!(hptep->v & HPTE_V_LARGE))
-		return MMU_PAGE_4K;
-
-	return __hpte_actual_psize(lp, psize);
-}
-
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
-				 unsigned long vpn, int psize, int ssize,
-				 int local)
+				 unsigned long vpn, int bpsize,
+				 int apsize, int ssize, int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
 	int ret = 0;
-	int actual_psize;
 
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
@@ -335,13 +289,14 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_lock_hpte(hptep);
 
 	hpte_v = hptep->v;
-	actual_psize = hpte_actual_psize(hptep, psize);
-	if (actual_psize < 0) {
-		native_unlock_hpte(hptep);
-		return -1;
-	}
-	/* Even if we miss, we need to invalidate the TLB */
-	if (!HPTE_V_COMPARE(hpte_v, want_v)) {
+	/*
+	 * We need to invalidate the TLB always because hpte_remove doesn't do
+	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
+	 * random entry from it. When we do that we don't invalidate the TLB
+	 * (hpte_remove) because we assume the old translation is still technically
+	 * "valid".
+	 */
+	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID)) {
 		DBG_LOW(" -> miss\n");
 		ret = -1;
 	} else {
@@ -353,7 +308,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(vpn, psize, actual_psize, ssize, local);
+	tlbie(vpn, bpsize, apsize, ssize, local);
 
 	return ret;
 }
@@ -394,7 +349,6 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 				       int psize, int ssize)
 {
-	int actual_psize;
 	unsigned long vpn;
 	unsigned long vsid;
 	long slot;
@@ -407,54 +361,82 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	if (slot == -1)
 		panic("could not find page to bolt\n");
 	hptep = htab_address + slot;
-	actual_psize = hpte_actual_psize(hptep, psize);
-	if (actual_psize < 0)
-		return;
 
 	/* Update the HPTE */
 	hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
 		(newpp & (HPTE_R_PP | HPTE_R_N));
-
-	/* Ensure it is out of the tlb too. */
-	tlbie(vpn, psize, actual_psize, ssize, 0);
+	/*
+	 * Ensure it is out of the tlb too. Bolted entries base and
+	 * actual page size will be same.
+	 */
+	tlbie(vpn, psize, psize, ssize, 0);
 }
 
 static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
-				   int psize, int ssize, int local)
+				   int bpsize, int apsize, int ssize, int local)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v;
 	unsigned long want_v;
 	unsigned long flags;
-	int actual_psize;
 
 	local_irq_save(flags);
 
 	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
-	actual_psize = hpte_actual_psize(hptep, psize);
-	if (actual_psize < 0) {
-		native_unlock_hpte(hptep);
-		local_irq_restore(flags);
-		return;
-	}
-	/* Even if we miss, we need to invalidate the TLB */
-	if (!HPTE_V_COMPARE(hpte_v, want_v))
+	/*
+	 * We need to invalidate the TLB always because hpte_remove doesn't do
+	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
+	 * random entry from it. When we do that we don't invalidate the TLB
+	 * (hpte_remove) because we assume the old translation is still technically
+	 * "valid".
+	 */
+	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
 		native_unlock_hpte(hptep);
 	else
 		/* Invalidate the hpte. NOTE: this also unlocks it */
 		hptep->v = 0;
 
 	/* Invalidate the TLB */
-	tlbie(vpn, psize, actual_psize, ssize, local);
+	tlbie(vpn, bpsize, apsize, ssize, local);
 
 	local_irq_restore(flags);
 }
 
+static inline int __hpte_actual_psize(unsigned int lp, int psize)
+{
+	int i, shift;
+	unsigned int mask;
+
+	/* start from 1 ignoring MMU_PAGE_4K */
+	for (i = 1; i < MMU_PAGE_COUNT; i++) {
+
+		/* invalid penc */
+		if (mmu_psize_defs[psize].penc[i] == -1)
+			continue;
+		/*
+		 * encoding bits per actual page size
+		 *        PTE LP     actual page size
+		 *    rrrr rrrz		>=8KB
+		 *    rrrr rrzz		>=16KB
+		 *    rrrr rzzz		>=32KB
+		 *    rrrr zzzz		>=64KB
+		 * .......
+		 */
+		shift = mmu_psize_defs[i].shift - LP_SHIFT;
+		if (shift > LP_BITS)
+			shift = LP_BITS;
+		mask = (1 << shift) - 1;
+		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
+			return i;
+	}
+	return -1;
+}
+
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index e303a6d..2f47080 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1232,7 +1232,11 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
-		ppc_md.hpte_invalidate(slot, vpn, psize, ssize, local);
+		/*
+		 * We use same base page size and actual psize, because we don't
+		 * use these functions for hugepage
+		 */
+		ppc_md.hpte_invalidate(slot, vpn, psize, psize, ssize, local);
 	} pte_iterate_hashed_end();
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -1365,7 +1369,8 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 		hash = ~hash;
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	slot += hidx & _PTEIDX_GROUP_IX;
-	ppc_md.hpte_invalidate(slot, vpn, mmu_linear_psize, mmu_kernel_ssize, 0);
+	ppc_md.hpte_invalidate(slot, vpn, mmu_linear_psize, mmu_linear_psize,
+			       mmu_kernel_ssize, 0);
 }
 
 void kernel_map_pages(struct page *page, int numpages, int enable)
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 0f1d94a..0b7fb67 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -81,7 +81,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot += (old_pte & _PAGE_F_GIX) >> 12;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
-					 ssize, local) == -1)
+					 mmu_psize, ssize, local) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index 246e1d8..c34ee4e 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -185,7 +185,8 @@ static void beat_lpar_hptab_clear(void)
 static long beat_lpar_hpte_updatepp(unsigned long slot,
 				    unsigned long newpp,
 				    unsigned long vpn,
-				    int psize, int ssize, int local)
+				    int psize, int apsize,
+				    int ssize, int local)
 {
 	unsigned long lpar_rc;
 	u64 dummy0, dummy1;
@@ -274,7 +275,8 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 }
 
 static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
-					 int psize, int ssize, int local)
+				      int psize, int apsize,
+				      int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
@@ -364,9 +366,10 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
  * already zero.  For now I am paranoid.
  */
 static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
-				    unsigned long newpp,
-				    unsigned long vpn,
-				    int psize, int ssize, int local)
+				       unsigned long newpp,
+				       unsigned long vpn,
+				       int psize, int apsize,
+				       int ssize, int local)
 {
 	unsigned long lpar_rc;
 	unsigned long want_v;
@@ -394,7 +397,8 @@ static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 }
 
 static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long vpn,
-					 int psize, int ssize, int local)
+					 int psize, int apsize,
+					 int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 177a2f7..3e270e3 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -109,7 +109,8 @@ static long ps3_hpte_remove(unsigned long hpte_group)
 }
 
 static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
-	unsigned long vpn, int psize, int ssize, int local)
+			      unsigned long vpn, int psize, int apsize,
+			      int ssize, int local)
 {
 	int result;
 	u64 hpte_v, want_v, hpte_rs;
@@ -162,7 +163,7 @@ static void ps3_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 }
 
 static void ps3_hpte_invalidate(unsigned long slot, unsigned long vpn,
-	int psize, int ssize, int local)
+				int psize, int apsize, int ssize, int local)
 {
 	unsigned long flags;
 	int result;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6d62072..ca45c8f 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -240,7 +240,8 @@ static void pSeries_lpar_hptab_clear(void)
 static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       unsigned long newpp,
 				       unsigned long vpn,
-				       int psize, int ssize, int local)
+				       int psize, int apsize,
+				       int ssize, int local)
 {
 	unsigned long lpar_rc;
 	unsigned long flags = (newpp & 7) | H_AVPN;
@@ -328,7 +329,8 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 }
 
 static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
-					 int psize, int ssize, int local)
+					 int psize, int apsize,
+					 int ssize, int local)
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
@@ -356,8 +358,10 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 
 	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 	BUG_ON(slot == -1);
-
-	pSeries_lpar_hpte_invalidate(slot, vpn, psize, ssize, 0);
+	/*
+	 * lpar doesn't use the passed actual page size
+	 */
+	pSeries_lpar_hpte_invalidate(slot, vpn, psize, 0, ssize, 0);
 }
 
 /* Flag bits for H_BULK_REMOVE */
@@ -400,8 +404,11 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
+				/*
+				 * lpar doesn't use the passed actual page size
+				 */
 				pSeries_lpar_hpte_invalidate(slot, vpn, psize,
-							     ssize, local);
+							     0, ssize, local);
 			} else {
 				param[pix] = HBR_REQUEST | HBR_AVPN | slot;
 				param[pix+1] = hpte_encode_avpn(vpn, psize,
