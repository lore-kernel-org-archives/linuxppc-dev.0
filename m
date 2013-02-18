Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AB462C02B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:47 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:56:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7DAA3E005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:59:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASaT033423508
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASZmJ001020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:35 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 05/17] powerpc: Add size argument to pgtable_cache_add
Date: Mon, 18 Feb 2013 15:58:03 +0530
Message-Id: <1361183295-6958-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We will use this later with THP changes. With THP we want to create PMD with
twice the size. The second half will be used to depoist pgtable, which will
carry the hpte hash index value

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    7 ++++++-
 arch/powerpc/mm/init_64.c                |   16 ++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 0182c20..658ba7c 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -338,8 +338,13 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+extern void __pgtable_cache_add(unsigned index, unsigned long table_size,
+				void (*ctor)(void *));
 void pgtable_cache_init(void);
+static inline void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+{
+	return __pgtable_cache_add(shift, sizeof(void *) << shift, ctor);
+}
 
 /*
  * find_linux_pte returns the address of a linux pte for a given
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 95a4529..b378438 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -100,10 +100,10 @@ struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void __pgtable_cache_add(unsigned int index, unsigned long table_size,
+			 void (*ctor)(void *))
 {
 	char *name;
-	unsigned long table_size = sizeof(void *) << shift;
 	unsigned long align = table_size;
 
 	/* When batching pgtable pointers for RCU freeing, we store
@@ -111,7 +111,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	 * big enough to fit it.
 	 *
 	 * Likewise, hugeapge pagetable pointers contain a (different)
-	 * shift value in the low bits.  All tables must be aligned so
+	 * huge page size in the low bits.  All tables must be aligned so
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
@@ -121,17 +121,17 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
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
