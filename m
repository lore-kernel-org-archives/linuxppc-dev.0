Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94F852C04C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:52 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:01:05 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C44422CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265wDBB53870802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:58:13 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266Am8C014554
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:49 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 08/26] powerpc: Clarify __pgtable_cache_add by renaming
 shift to index
Date: Wed,  6 Mar 2013 11:40:09 +0530
Message-Id: <1362550227-575-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

With table_size as second argument, first argument of the function
is not the shift value, but rather index into the array. Rename the
variable to clarify the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    2 +-
 arch/powerpc/mm/init_64.c                |   16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index d51d893..658ba7c 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -338,7 +338,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
-extern void __pgtable_cache_add(unsigned shift, unsigned long table_size,
+extern void __pgtable_cache_add(unsigned index, unsigned long table_size,
 				void (*ctor)(void *));
 void pgtable_cache_init(void);
 static inline void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d6df419..2e09ec1 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -100,7 +100,7 @@ struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void __pgtable_cache_add(unsigned int shift, unsigned long table_size,
+void __pgtable_cache_add(unsigned int index, unsigned long table_size,
 			 void (*ctor)(void *))
 {
 	char *name;
@@ -110,8 +110,8 @@ void __pgtable_cache_add(unsigned int shift, unsigned long table_size,
 	 * the index size in the low bits.  Table alignment must be
 	 * big enough to fit it.
 	 *
-	 * Likewise, hugeapge pagetable pointers contain a (different)
-	 * shift value in the low bits.  All tables must be aligned so
+	 * Likewise, hugepage pagetable pointers contain a (different)
+	 * huge page size in the low bits.  All tables must be aligned so
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
@@ -121,17 +121,17 @@ void __pgtable_cache_add(unsigned int shift, unsigned long table_size,
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
 	 * constant expression, so so much for that. */
 	BUG_ON(!is_power_of_2(minalign));
-	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
+	BUG_ON((index < 1) || (index > MAX_PGTABLE_INDEX_SIZE));
 
-	if (PGT_CACHE(shift))
+	if (PGT_CACHE(index))
 		return; /* Already have a cache of this size */
 
 	align = max_t(unsigned long, align, minalign);
-	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
+	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", index);
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
-	PGT_CACHE(shift) = new;
+	PGT_CACHE(index) = new;
 
-	pr_debug("Allocated pgtable cache for order %d\n", shift);
+	pr_debug("Allocated pgtable cache for order %d\n", index);
 }
 
 
-- 
1.7.10
