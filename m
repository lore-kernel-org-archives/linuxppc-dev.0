Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdkHJ6Qq7zDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 15:34:04 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE4XjKE112437
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:34:02 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27arrpxhe3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:34:02 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 21:34:01 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fix panic on boot with 4K page size
Date: Wed, 14 Dec 2016 10:03:49 +0530
Message-Id: <20161214043349.23677-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For transparent hugepage config, we need to use double the size
of the pmd. Hence we should use PMD_CACHE_INDEX when allocating
pagetable cache. For all configs other than book3s 64k this value
is same as PMD_INDEX_SIZE. With 4k, since we don't support
transparent hugepage in hash mode, we can use PMD_INDEX_SIZE even
though CONFIG_TRANSPARENT_HUGEPAGE is defined. With book3s 4k
THP is only supported in radix mode.

Fixes:"powerpc: port 64 bits pgtable_cache to 32 bits"

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 4 ++--
 arch/powerpc/mm/init-common.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f61cad3de4e6..e95148c72916 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -33,9 +33,9 @@
 				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&  !defined(CONFIG_PPC_4K_PAGES)
 /*
- * only with hash we need to use the second half of pmd page table
+ * only with hash 64k we need to use the second half of pmd page table
  * to store pointer to deposited pgtable_t
  */
 #define H_PMD_CACHE_INDEX	(H_PMD_INDEX_SIZE + 1)
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index a175cd82ae8c..e733cf4d3401 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -88,7 +88,7 @@ void pgtable_cache_init(void)
 {
 	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
 
-	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
+	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
 		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
 	/*
 	 * In all current configs, when the PUD index exists it's the
@@ -100,7 +100,7 @@ void pgtable_cache_init(void)
 
 	if (!PGT_CACHE(PGD_INDEX_SIZE))
 		panic("Couldn't allocate pgd cache");
-	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
+	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
 		panic("Couldn't allocate pmd pgtable caches");
 	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
 		panic("Couldn't allocate pud pgtable caches");
-- 
2.10.2
