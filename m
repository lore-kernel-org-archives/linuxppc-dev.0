Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D11191A19C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:25 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E81BB3940057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:18 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bGLw9830880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:16 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bEmM022316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:15 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 25/35] powerpc/mm: Add helper for converting pte bit to
 hpte bits
Date: Tue,  1 Dec 2015 09:06:50 +0530
Message-Id: <1448941020-15168-26-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of open coding it in multiple code paths, export the helper
and add more documentation. Also make sure we don't make assumption
regarding pte bit position

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |  1 +
 arch/powerpc/mm/hash64_4k.c               | 13 +-----------
 arch/powerpc/mm/hash64_64k.c              | 35 +++----------------------------
 arch/powerpc/mm/hash_utils_64.c           | 22 ++++++++++++-------
 arch/powerpc/mm/hugepage-hash64.c         | 13 +-----------
 arch/powerpc/mm/hugetlbpage-hash64.c      |  4 +---
 6 files changed, 21 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index e4ea9d73a541..9c212449b2e8 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -236,6 +236,7 @@ extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
 					 pmd_t *pmdp,
 					 unsigned long clr,
 					 unsigned long set);
+extern unsigned long htab_convert_pte_flags(unsigned long pteflags);
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long addr,
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 3b49c6f18741..ee863137035a 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -53,18 +53,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
 	 * need to add in 0x1 if it's a read-only user page
 	 */
-	rflags = new_pte & _PAGE_USER;
-	if ((new_pte & _PAGE_USER) && !((new_pte & _PAGE_RW) &&
-					(new_pte & _PAGE_DIRTY)))
-		rflags |= 0x1;
-	/*
-	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
-	 */
-	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	/*
-	 * Always add C and Memory coherence bit
-	 */
-	rflags |= HPTE_R_C | HPTE_R_M;
+	rflags = htab_convert_pte_flags(new_pte);
 	/*
 	 * Add in WIMG bits
 	 */
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index fc0898eb309d..b14280e9d850 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -85,22 +85,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * Handle the subpage protection bits
 	 */
 	subpg_pte = new_pte & ~subpg_prot;
-	/*
-	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
-	 * need to add in 0x1 if it's a read-only user page
-	 */
-	rflags = subpg_pte & _PAGE_USER;
-	if ((subpg_pte & _PAGE_USER) && !((subpg_pte & _PAGE_RW) &&
-					(subpg_pte & _PAGE_DIRTY)))
-		rflags |= 0x1;
-	/*
-	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
-	 */
-	rflags |= ((subpg_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	/*
-	 * Always add C and Memory coherence bit
-	 */
-	rflags |= HPTE_R_C | HPTE_R_M;
+	rflags = htab_convert_pte_flags(subpg_pte);
 	/*
 	 * Add in WIMG bits
 	 */
@@ -271,22 +256,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
 					  old_pte, new_pte));
-	/*
-	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
-	 * need to add in 0x1 if it's a read-only user page
-	 */
-	rflags = new_pte & _PAGE_USER;
-	if ((new_pte & _PAGE_USER) && !((new_pte & _PAGE_RW) &&
-					(new_pte & _PAGE_DIRTY)))
-		rflags |= 0x1;
-	/*
-	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
-	 */
-	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	/*
-	 * Always add C and Memory coherence bit
-	 */
-	rflags |= HPTE_R_C | HPTE_R_M;
+
+	rflags = htab_convert_pte_flags(new_pte);
 	/*
 	 * Add in WIMG bits
 	 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 04d549527eaa..3b5e547b965d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -159,20 +159,26 @@ static struct mmu_psize_def mmu_psize_defaults_gp[] = {
 	},
 };
 
-static unsigned long htab_convert_pte_flags(unsigned long pteflags)
+unsigned long htab_convert_pte_flags(unsigned long pteflags)
 {
-	unsigned long rflags = pteflags & 0x1fa;
+	unsigned long rflags = 0;
 
 	/* _PAGE_EXEC -> NOEXEC */
 	if ((pteflags & _PAGE_EXEC) == 0)
 		rflags |= HPTE_R_N;
-
-	/* PP bits. PAGE_USER is already PP bit 0x2, so we only
-	 * need to add in 0x1 if it's a read-only user page
+	/*
+	 * PP bits:
+	 * Linux use slb key 0 for kernel and 1 for user.
+	 * kernel areas are mapped by PP bits 00
+	 * and and there is no kernel RO (_PAGE_KERNEL_RO).
+	 * User area mapped by 0x2 and read only use by
+	 * 0x3.
 	 */
-	if ((pteflags & _PAGE_USER) && !((pteflags & _PAGE_RW) &&
-					 (pteflags & _PAGE_DIRTY)))
-		rflags |= 1;
+	if (pteflags & _PAGE_USER) {
+		rflags |= 0x2;
+		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
+			rflags |= 0x1;
+	}
 	/*
 	 * Always add "C" bit for perf. Memory coherence is always enabled
 	 */
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 4d87122cf6a7..91fcac6f989d 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -54,18 +54,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 			new_pmd |= _PAGE_DIRTY;
 	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
 					  old_pmd, new_pmd));
-	/*
-	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
-	 * need to add in 0x1 if it's a read-only user page
-	 */
-	rflags = new_pmd & _PAGE_USER;
-	if ((new_pmd & _PAGE_USER) && !((new_pmd & _PAGE_RW) &&
-					   (new_pmd & _PAGE_DIRTY)))
-		rflags |= 0x1;
-	/*
-	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
-	 */
-	rflags |= ((new_pmd & _PAGE_EXEC) ? 0 : HPTE_R_N);
+	rflags = htab_convert_pte_flags(new_pmd);
 
 #if 0
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 7584e8445512..304c8520506e 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -59,10 +59,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			new_pte |= _PAGE_DIRTY;
 	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
 					 old_pte, new_pte));
+	rflags = htab_convert_pte_flags(new_pte);
 
-	rflags = 0x2 | (!(new_pte & _PAGE_RW));
-	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
-	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
 	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
-- 
2.5.0
