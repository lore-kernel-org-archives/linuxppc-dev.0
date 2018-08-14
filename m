Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qbGx1QF3zF1R0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2018 00:54:47 +1000 (AEST)
Message-Id: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/4] powerpc/mm: enable the use of page table cache of
 order 0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Aug 2018 14:54:42 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hugepages uses a cache of order 0. Lets allow page tables
of order 0 in the common part in order to avoid open coding
in hugetlb

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 5 +----
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 5 +----
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 5 +----
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 5 +----
 arch/powerpc/mm/init-common.c                | 6 +++---
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 82e44b1a00ae..96138ab3ddd6 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -25,10 +25,7 @@
 extern void __bad_pte(pmd_t *pmd);
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 391ed2c3b697..bfed4cf3b2f3 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -37,10 +37,7 @@ extern struct vmemmap_backing *vmemmap_list;
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 8825953c225b..6fbbb90043c0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -25,10 +25,7 @@
 extern void __bad_pte(pmd_t *pmd);
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index e2d62d033708..e95eb499a174 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -36,10 +36,7 @@ extern struct vmemmap_backing *vmemmap_list;
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..41190f2b60c2 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -40,7 +40,7 @@ static void pmd_ctor(void *addr)
 	memset(addr, 0, PMD_TABLE_SIZE);
 }
 
-struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
+struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE + 1];
 EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 
 /*
@@ -71,7 +71,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
 	 * constant expression, so so much for that. */
 	BUG_ON(!is_power_of_2(minalign));
-	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 
 	if (PGT_CACHE(shift))
 		return; /* Already have a cache of this size */
@@ -83,7 +83,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 		panic("Could not allocate pgtable cache for order %d", shift);
 
 	kfree(name);
-	pgtable_cache[shift - 1] = new;
+	pgtable_cache[shift] = new;
 
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
-- 
2.13.3
