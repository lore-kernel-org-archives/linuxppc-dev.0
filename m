Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E98F1A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3EC962CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2TQsE53739618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2T1S9009119
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:01 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 28/31] powerpc/mm: Move WIMG update to helper.
Date: Wed, 30 Sep 2015 07:57:21 +0530
Message-Id: <1443580044-30659-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only difference here is, we apply the WIMG mapping early, so rflags
passed to updatepp will also be changed.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c          |  5 -----
 arch/powerpc/mm/hash64_64k.c         | 10 ----------
 arch/powerpc/mm/hash_utils_64.c      | 13 ++++++++++++-
 arch/powerpc/mm/hugepage-hash64.c    |  7 -------
 arch/powerpc/mm/hugetlbpage-hash64.c |  8 --------
 5 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 7749857f6ced..42af2d3a8b63 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -54,11 +54,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * need to add in 0x1 if it's a read-only user page
 	 */
 	rflags = htab_convert_pte_flags(new_pte);
-	/*
-	 * Add in WIMG bits
-	 */
-	rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				_PAGE_COHERENT | _PAGE_GUARDED));
 
 	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index c30635d27c0f..0f5f3fc4923e 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -77,11 +77,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	subpg_pte = new_pte & ~subpg_prot;
 	rflags = htab_convert_pte_flags(subpg_pte);
-	/*
-	 * Add in WIMG bits
-	 */
-	rflags |= (subpg_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				_PAGE_COHERENT | _PAGE_GUARDED));
 
 	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
@@ -249,11 +244,6 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 					  old_pte, new_pte));
 
 	rflags = htab_convert_pte_flags(new_pte);
-	/*
-	 * Add in WIMG bits
-	 */
-	rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				_PAGE_COHERENT | _PAGE_GUARDED));
 
 	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 444c42eabfdf..b5c24455715e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -182,7 +182,18 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	/*
 	 * Always add "C" bit for perf. Memory coherence is always enabled
 	 */
-	return rflags | HPTE_R_C | HPTE_R_M;
+	rflags |=  HPTE_R_C | HPTE_R_M;
+	/*
+	 * Add in WIG bits
+	 */
+	if (pteflags & _PAGE_WRITETHRU)
+		rflags |= HPTE_R_W;
+	if (pteflags & _PAGE_NO_CACHE)
+		rflags |= HPTE_R_I;
+	if (pteflags & _PAGE_GUARDED)
+		rflags |= HPTE_R_G;
+
+	return rflags;
 }
 
 int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 91fcac6f989d..1f666de0110a 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -120,13 +120,6 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
 		new_pmd |= _PAGE_HASHPTE;
 
-		/* Add in WIMG bits */
-		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				      _PAGE_GUARDED));
-		/*
-		 * enable the memory coherence always
-		 */
-		rflags |= HPTE_R_M;
 repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 304c8520506e..0734e4daffef 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -91,14 +91,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* clear HPTE slot informations in new PTE */
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
 
-		/* Add in WIMG bits */
-		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
-				      _PAGE_COHERENT | _PAGE_GUARDED));
-		/*
-		 * enable the memory coherence always
-		 */
-		rflags |= HPTE_R_M;
-
 		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
 					     mmu_psize, ssize);
 
-- 
2.5.0
