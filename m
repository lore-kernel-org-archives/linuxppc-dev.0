Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94E0F2C0622
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:50 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:05:57 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D1463357802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r266Aile4522336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:44 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266AkGq014511
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:47 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 07/26] powerpc: Add size argument to pgtable_cache_add
Date: Wed,  6 Mar 2013 11:40:08 +0530
Message-Id: <1362550227-575-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We will use this later with THP changes to request for pmd table of double the size.
THP code does PTE page allocation along with large page request and deposit them
for later use. This is to ensure that we won't have any failures when we split
huge pages to regular pages.

On powerpc we want to use the deposited PTE page for storing hash pte slot and
secondary bit information for the HPTEs. Hence we save them in the second half
of the pmd table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    7 ++++++-
 arch/powerpc/mm/init_64.c                |    4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 0182c20..d51d893 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -338,8 +338,13 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+extern void __pgtable_cache_add(unsigned shift, unsigned long table_size,
+				void (*ctor)(void *));
 void pgtable_cache_init(void);
+static inline void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+{
+	return __pgtable_cache_add(shift, sizeof(void *) << shift, ctor);
+}
 
 /*
  * find_linux_pte returns the address of a linux pte for a given
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 95a4529..d6df419 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -100,10 +100,10 @@ struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void __pgtable_cache_add(unsigned int shift, unsigned long table_size,
+			 void (*ctor)(void *))
 {
 	char *name;
-	unsigned long table_size = sizeof(void *) << shift;
 	unsigned long align = table_size;
 
 	/* When batching pgtable pointers for RCU freeing, we store
-- 
1.7.10
