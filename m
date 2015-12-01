Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C52C81A0E35
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:19 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8E1CE3940067
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bEZh9830874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bDDN022182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:14 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 20/35] powerpc/mm: Don't track subpage valid bit in pte_t
Date: Tue,  1 Dec 2015 09:06:45 +0530
Message-Id: <1448941020-15168-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This free up 11 bits in pte_t. In the later patch we also change
the pte_t format so that we can start supporting migration pte
at pmd level. We now track 4k subpage valid bit as below

If we have _PAGE_COMBO set, we override the _PAGE_F_GIX_SHIFT
and _PAGE_F_SECOND. Together we have 4 bits, each of them
used to indicate whether any of the 4 4k subpage in that group
is valid. ie,

[ group 1 bit ]   [ group 2 bit ]  ..... [ group 4 ]
[ subpage 1 - 4]  [ subpage 5- 8]  ..... [ subpage 13 - 16]

We still track each 4k subpage slot number and secondary hash
information in the second half of pgtable_t. Removing the subpage
tracking have some significant overhead on aim9 and ebizzy benchmark and
to support THP with 4K subpage, we do need a pgtable_t of 4096 bytes.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 10 +-------
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 35 ++++++---------------------
 arch/powerpc/include/asm/book3s/64/hash.h     | 10 ++++----
 arch/powerpc/mm/hash64_64k.c                  | 34 ++++++++++++++++++++++++--
 arch/powerpc/mm/hash_low_64.S                 |  6 +----
 arch/powerpc/mm/hugetlbpage-hash64.c          |  5 +---
 arch/powerpc/mm/pgtable_64.c                  |  2 +-
 7 files changed, 48 insertions(+), 54 deletions(-)

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
index ee073822145d..a268416ca4a4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -31,33 +31,13 @@
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
+#define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
+#define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
+/*
+ * Used to track subpage group valid if _PAGE_COMBO is set
+ * This overloads _PAGE_F_GIX and _PAGE_F_SECOND
  */
-#define _PAGE_F_SECOND  0x00008000 /* full page: hidx bits */
-#define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
+#define _PAGE_COMBO_VALID	(_PAGE_F_GIX | _PAGE_F_SECOND)
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)
@@ -103,8 +83,7 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 }
 
 #define __rpte_to_pte(r)	((r).pte)
-#define __rpte_sub_valid(rpte, index) \
-	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
+extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 /*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 48237e66e823..2f2034621a69 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -81,7 +81,12 @@
 #define _PAGE_DIRTY		0x0080 /* C: page changed */
 #define _PAGE_ACCESSED		0x0100 /* R: page referenced */
 #define _PAGE_RW		0x0200 /* software: user write access allowed */
+#define _PAGE_HASHPTE		0x0400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY		0x0800 /* software: PTE & hash are busy */
+#define _PAGE_F_GIX		0x7000 /* full page: hidx bits */
+#define _PAGE_F_GIX_SHIFT	12
+#define _PAGE_F_SECOND		0x8000 /* Whether to use secondary hash or not */
+#define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 /* No separate kernel read-only */
 #define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
@@ -210,11 +215,6 @@
 
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
-/*
- * We save the slot number & secondary bit in the second half of the
- * PTE page. We use the 8 bytes per each pte entry.
- */
-#define PTE_PAGE_HIDX_OFFSET (PTRS_PER_PTE * 8)
 
 #ifndef __ASSEMBLY__
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 9ffeae2cbb57..f1b86ba63430 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -15,6 +15,35 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
+/*
+ * index from 0 - 15
+ */
+bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
+{
+	unsigned long g_idx;
+	unsigned long ptev = pte_val(rpte.pte);
+
+	g_idx = (ptev & _PAGE_COMBO_VALID) >> _PAGE_F_GIX_SHIFT;
+	index = index >> 2;
+	if (g_idx & (0x1 << index))
+		return true;
+	else
+		return false;
+}
+/*
+ * index from 0 - 15
+ */
+static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
+{
+	unsigned long g_idx;
+
+	if (!(ptev & _PAGE_COMBO))
+		return ptev;
+	index = index >> 2;
+	g_idx = 0x1 << index;
+
+	return ptev | (g_idx << _PAGE_F_GIX_SHIFT);
+}
 
 int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
@@ -102,7 +131,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	if (!(old_pte & _PAGE_COMBO)) {
 		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
-		old_pte &= ~_PAGE_HPTE_SUB;
+		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
 		goto htab_insert_hpte;
 	}
 	/*
@@ -192,7 +221,8 @@ repeat:
 	/* __real_pte use pte_val() any idea why ? FIXME!! */
 	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
 	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
-	new_pte |= (_PAGE_HPTE_SUB0 >> subpg_index);
+	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
+	new_pte |=  _PAGE_HASHPTE;
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
