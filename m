Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPJ5rH9zDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:37:56 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T7HS076028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vrtceq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:55 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:37:54 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 09/17] powerpc/mm/hash: VSID 0 is no more an invalid VSID
Date: Wed, 22 Mar 2017 09:06:55 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is now used by linear mapped region of the kernel. User space still
should not see a VSID 0. But having that VSID check confuse the reader.
Remove the same and convert the error checking to be based on addr value

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  6 ------
 arch/powerpc/mm/hash_utils_64.c               | 19 +++++++------------
 arch/powerpc/mm/pgtable-hash64.c              |  1 -
 arch/powerpc/mm/tlb_hash64.c                  |  1 -
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 3897d30820b0..078d7bf93a69 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -673,12 +673,6 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 	unsigned long vsid_bits;
 	unsigned long protovsid;
 
-	/*
-	 * Bad address. We return VSID 0 for that
-	 */
-	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
-		return 0;
-
 	if (!mmu_has_feature(MMU_FTR_68_BIT_VA))
 		va_bits = 65;
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 6922a8d267cc..04523052ad8e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1222,6 +1222,13 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		ea, access, trap);
 	trace_hash_fault(ea, access, trap);
 
+	/* Bad address. */
+	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE) {
+		DBG_LOW("Bad address!\n");
+		rc = 1;
+		goto bail;
+	}
+
 	/* Get region & vsid */
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
@@ -1252,12 +1259,6 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	}
 	DBG_LOW(" mm=%p, mm->pgdir=%p, vsid=%016lx\n", mm, mm->pgd, vsid);
 
-	/* Bad address. */
-	if (!vsid) {
-		DBG_LOW("Bad address!\n");
-		rc = 1;
-		goto bail;
-	}
 	/* Get pgdir */
 	pgdir = mm->pgd;
 	if (pgdir == NULL) {
@@ -1500,8 +1501,6 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	/* Get VSID */
 	ssize = user_segment_size(ea);
 	vsid = get_vsid(mm->context.id, ea, ssize);
-	if (!vsid)
-		return;
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
@@ -1746,10 +1745,6 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 
 	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
 
-	/* Don't create HPTE entries for bad address */
-	if (!vsid)
-		return;
-
 	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr), mode,
 				    HPTE_V_BOLTED,
 				    mmu_linear_psize, mmu_kernel_ssize);
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 8b85a14b08ea..ddfeb141af29 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -263,7 +263,6 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	if (!is_kernel_addr(addr)) {
 		ssize = user_segment_size(addr);
 		vsid = get_vsid(mm->context.id, addr, ssize);
-		WARN_ON(vsid == 0);
 	} else {
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 4517aa43a8b1..d8fa336bf05d 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -87,7 +87,6 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
 	}
-	WARN_ON(vsid == 0);
 	vpn = hpt_vpn(addr, vsid, ssize);
 	rpte = __real_pte(__pte(pte), ptep);
 
-- 
2.7.4
