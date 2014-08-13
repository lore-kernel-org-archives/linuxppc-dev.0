Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10A161A004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:22 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 17:02:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DAB422BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7D72wLp15335454
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7D72Ihc005997
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:19 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2 2/8] powerpc: thp: don't recompute vsid and ssize in loop
 on invalidate
Date: Wed, 13 Aug 2014 12:31:58 +0530
Message-Id: <1407913324-8062-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The segment identifier and segment size will remain the same in
the loop, So we can compute it outside. We also change the
hugepage_invalidate interface so that we can use it the later patch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h    |  6 +++---
 arch/powerpc/mm/hash_native_64.c      | 19 +++++--------------
 arch/powerpc/mm/pgtable_64.c          | 24 ++++++++++++------------
 arch/powerpc/platforms/pseries/lpar.c | 20 ++++++--------------
 4 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 44e90516519b..b125ceab149c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -57,10 +57,10 @@ struct machdep_calls {
 	void            (*hpte_removebolted)(unsigned long ea,
 					     int psize, int ssize);
 	void		(*flush_hash_range)(unsigned long number, int local);
-	void		(*hugepage_invalidate)(struct mm_struct *mm,
+	void		(*hugepage_invalidate)(unsigned long vsid,
+					       unsigned long addr,
 					       unsigned char *hpte_slot_array,
-					       unsigned long addr, int psize);
-
+					       int psize, int ssize);
 	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index cf1d325eae8b..fb89d7695a9a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -412,18 +412,18 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	local_irq_restore(flags);
 }
 
-static void native_hugepage_invalidate(struct mm_struct *mm,
+static void native_hugepage_invalidate(unsigned long vsid,
+				       unsigned long addr,
 				       unsigned char *hpte_slot_array,
-				       unsigned long addr, int psize)
+				       int psize, int ssize)
 {
-	int ssize = 0, i;
-	int lock_tlbie;
+	int i, lock_tlbie;
 	struct hash_pte *hptep;
 	int actual_psize = MMU_PAGE_16M;
 	unsigned int max_hpte_count, valid;
 	unsigned long flags, s_addr = addr;
 	unsigned long hpte_v, want_v, shift;
-	unsigned long hidx, vpn = 0, vsid, hash, slot;
+	unsigned long hidx, vpn = 0, hash, slot;
 
 	shift = mmu_psize_defs[psize].shift;
 	max_hpte_count = 1U << (PMD_SHIFT - shift);
@@ -437,15 +437,6 @@ static void native_hugepage_invalidate(struct mm_struct *mm,
 
 		/* get the vpn */
 		addr = s_addr + (i * (1ul << shift));
-		if (!is_kernel_addr(addr)) {
-			ssize = user_segment_size(addr);
-			vsid = get_vsid(mm->context.id, addr, ssize);
-			WARN_ON(vsid == 0);
-		} else {
-			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
-			ssize = mmu_kernel_ssize;
-		}
-
 		vpn = hpt_vpn(addr, vsid, ssize);
 		hash = hpt_hash(vpn, shift, ssize);
 		if (hidx & _PTEIDX_SECONDARY)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3b3c4d34c7a0..5039f3b04d6e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -745,12 +745,21 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	if (!hpte_slot_array)
 		return;
 
-	/* get the base page size */
+	/* get the base page size,vsid and segment size */
 	psize = get_slice_psize(mm, s_addr);
+	if (!is_kernel_addr(s_addr)) {
+		ssize = user_segment_size(s_addr);
+		vsid = get_vsid(mm->context.id, s_addr, ssize);
+		WARN_ON(vsid == 0);
+	} else {
+		vsid = get_kernel_vsid(s_addr, mmu_kernel_ssize);
+		ssize = mmu_kernel_ssize;
+	}
 
 	if (ppc_md.hugepage_invalidate)
-		return ppc_md.hugepage_invalidate(mm, hpte_slot_array,
-						  s_addr, psize);
+		return ppc_md.hugepage_invalidate(vsid, s_addr,
+						  hpte_slot_array,
+						  psize, ssize);
 	/*
 	 * No bluk hpte removal support, invalidate each entry
 	 */
@@ -768,15 +777,6 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 
 		/* get the vpn */
 		addr = s_addr + (i * (1ul << shift));
-		if (!is_kernel_addr(addr)) {
-			ssize = user_segment_size(addr);
-			vsid = get_vsid(mm->context.id, addr, ssize);
-			WARN_ON(vsid == 0);
-		} else {
-			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
-			ssize = mmu_kernel_ssize;
-		}
-
 		vpn = hpt_vpn(addr, vsid, ssize);
 		hash = hpt_hash(vpn, shift, ssize);
 		if (hidx & _PTEIDX_SECONDARY)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index fbfcef514aa7..34e64237fff9 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -431,16 +431,17 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
 
-static void pSeries_lpar_hugepage_invalidate(struct mm_struct *mm,
-				       unsigned char *hpte_slot_array,
-				       unsigned long addr, int psize)
+static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
+					     unsigned long addr,
+					     unsigned char *hpte_slot_array,
+					     int psize, int ssize)
 {
-	int ssize = 0, i, index = 0;
+	int i, index = 0;
 	unsigned long s_addr = addr;
 	unsigned int max_hpte_count, valid;
 	unsigned long vpn_array[PPC64_HUGE_HPTE_BATCH];
 	unsigned long slot_array[PPC64_HUGE_HPTE_BATCH];
-	unsigned long shift, hidx, vpn = 0, vsid, hash, slot;
+	unsigned long shift, hidx, vpn = 0, hash, slot;
 
 	shift = mmu_psize_defs[psize].shift;
 	max_hpte_count = 1U << (PMD_SHIFT - shift);
@@ -453,15 +454,6 @@ static void pSeries_lpar_hugepage_invalidate(struct mm_struct *mm,
 
 		/* get the vpn */
 		addr = s_addr + (i * (1ul << shift));
-		if (!is_kernel_addr(addr)) {
-			ssize = user_segment_size(addr);
-			vsid = get_vsid(mm->context.id, addr, ssize);
-			WARN_ON(vsid == 0);
-		} else {
-			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
-			ssize = mmu_kernel_ssize;
-		}
-
 		vpn = hpt_vpn(addr, vsid, ssize);
 		hash = hpt_hash(vpn, shift, ssize);
 		if (hidx & _PTEIDX_SECONDARY)
-- 
1.9.1
