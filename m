Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 040DC1A0215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 96C202BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:45 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gcTg41549886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:47 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6gDIU015321
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 22/31] powerpc/mm: Don't track subpage valid bit in pte_t
Date: Mon, 21 Sep 2015 12:10:49 +0530
Message-Id: <1442817658-2588-23-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This free up 11 bits in pte_t. In the later patch we also change
the pte_t format so that we can start supporting migration pte
at pmd level.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 10 +--------
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 29 ++-------------------------
 arch/powerpc/include/asm/book3s/64/hash.h     |  4 ++++
 arch/powerpc/mm/hash64_64k.c                  |  4 ++--
 arch/powerpc/mm/hash_low_64.S                 |  6 +-----
 arch/powerpc/mm/hugetlbpage-hash64.c          |  5 +----
 arch/powerpc/mm/pgtable_64.c                  |  2 +-
 7 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 537eacecf6e9..75e8b9326e4b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -47,17 +47,9 @@
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0
 
-/* PTE bits */
-#define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
-#define _PAGE_SECONDARY 0x8000 /* software: HPTE is in secondary group */
-#define _PAGE_GROUP_IX  0x7000 /* software: HPTE index within group */
-#define _PAGE_F_SECOND  _PAGE_SECONDARY
-#define _PAGE_F_GIX     _PAGE_GROUP_IX
-#define _PAGE_SPECIAL	0x10000 /* software: special page */
-
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
-			 _PAGE_SECONDARY | _PAGE_GROUP_IX)
+			 _PAGE_F_SECOND | _PAGE_F_GIX)
 
 /* shift to put page number into pte */
 #define PTE_RPN_SHIFT	(17)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index dafc2f31c843..b363d73ca225 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -31,33 +31,8 @@
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0x1ff
 
-/* Additional PTE bits (don't change without checking asm in hash_low.S) */
-#define _PAGE_SPECIAL	0x00000400 /* software: special page */
-#define _PAGE_HPTE_SUB	0x0ffff000 /* combo only: sub pages HPTE bits */
-#define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
-#define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
-#define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
-
-/* For 64K page, we don't have a separate _PAGE_HASHPTE bit. Instead,
- * we set that to be the whole sub-bits mask. The C code will only
- * test this, so a multi-bit mask will work. For combo pages, this
- * is equivalent as effectively, the old _PAGE_HASHPTE was an OR of
- * all the sub bits. For real 64k pages, we now have the assembly set
- * _PAGE_HPTE_SUB0 in addition to setting the HIDX bits which overlap
- * that mask. This is fine as long as the HIDX bits are never set on
- * a PTE that isn't hashed, which is the case today.
- *
- * A little nit is for the huge page C code, which does the hashing
- * in C, we need to provide which bit to use.
- */
-#define _PAGE_HASHPTE	_PAGE_HPTE_SUB
-
-/* Note the full page bits must be in the same location as for normal
- * 4k pages as the same assembly will be used to insert 64K pages
- * whether the kernel has CONFIG_PPC_64K_PAGES or not
- */
-#define _PAGE_F_SECOND  0x00008000 /* full page: hidx bits */
-#define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
+#define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
+#define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 32a1f94201d0..f377757d2cbf 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -83,7 +83,11 @@
 #define _PAGE_DIRTY		0x0080 /* C: page changed */
 #define _PAGE_ACCESSED		0x0100 /* R: page referenced */
 #define _PAGE_RW		0x0200 /* software: user write access allowed */
+#define _PAGE_HASHPTE		0x0400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY		0x0800 /* software: PTE & hash are busy */
+#define _PAGE_F_GIX		0x7000 /* full page: hidx bits */
+#define _PAGE_F_SECOND		0x8000 /* Whether to use secondary hash or not */
+#define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 /* No separate kernel read-only */
 #define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index a21bf836ad95..7e1359e008b4 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -127,7 +127,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	if (!(old_pte & _PAGE_COMBO)) {
 		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
-		old_pte &= ~_PAGE_HPTE_SUB;
+		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
 		goto htab_insert_hpte;
 	}
 	/*
@@ -214,7 +214,7 @@ repeat:
 	 * nobody is undating hidx.
 	 */
 	rpte.hidx[subpg_index] = (unsigned char)(slot << 4 | 0x1 << 3);
-	new_pte |= _PAGE_HPTE_SUB0;
+	new_pte |= _PAGE_HASHPTE;
 	/*
 	 * check __real_pte for details on matching smp_rmb()
 	 */
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 6b4d4c1d0628..359839a57f26 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -285,7 +285,7 @@ htab_modify_pte:
 
 	/* Secondary group ? if yes, get a inverted hash value */
 	mr	r5,r28
-	andi.	r0,r31,_PAGE_SECONDARY
+	andi.	r0,r31,_PAGE_F_SECOND
 	beq	1f
 	not	r5,r5
 1:
@@ -473,11 +473,7 @@ ht64_insert_pte:
 	lis	r0,_PAGE_HPTEFLAGS@h
 	ori	r0,r0,_PAGE_HPTEFLAGS@l
 	andc	r30,r30,r0
-#ifdef CONFIG_PPC_64K_PAGES
-	oris	r30,r30,_PAGE_HPTE_SUB0@h
-#else
 	ori	r30,r30,_PAGE_HASHPTE
-#endif
 	/* Phyical address in r5 */
 	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
 	sldi	r5,r5,PAGE_SHIFT
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index d94b1af53a93..7584e8445512 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -91,11 +91,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 
 		/* clear HPTE slot informations in new PTE */
-#ifdef CONFIG_PPC_64K_PAGES
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
-#else
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
-#endif
+
 		/* Add in WIMG bits */
 		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index d692ae31cfc7..3967e3cce03e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -625,7 +625,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 	"1:	ldarx	%0,0,%3\n\
 		andi.	%1,%0,%6\n\
 		bne-	1b \n\
-		ori	%1,%0,%4 \n\
+		oris	%1,%0,%4@h \n\
 		stdcx.	%1,0,%3 \n\
 		bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
-- 
2.5.0
