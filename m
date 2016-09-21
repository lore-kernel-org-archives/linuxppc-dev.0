Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfMwF3rkNzDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 00:49:33 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64: get rid of MIN_HUGEPTE_SHIFT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160921144928.4EB431A2455@localhost.localdomain>
Date: Wed, 21 Sep 2016 16:49:27 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MIN_HUGEPTE_SHIFT hasn't been used since commit d1837cba5d5d5
("powerpc/mm: Cleanup initialization of hugepages on powerpc")

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h     | 3 ---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 3 ---
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h  | 3 ---
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 1af837c..1c64bc6 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -16,9 +16,6 @@
 #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
 
-/* With 4k base page size, hugepage PTEs go at the PMD level */
-#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
-
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
 			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 5aae4f5..f3dd21e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -6,9 +6,6 @@
 #define H_PUD_INDEX_SIZE  5
 #define H_PGD_INDEX_SIZE  12
 
-/* With 4k base page size, hugepage PTEs go at the PMD level */
-#define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
-
 #define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
 #define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
 /*
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index fc7d517..d0db987 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -27,9 +27,6 @@
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
-/* With 4k base page size, hugepage PTEs go at the PMD level */
-#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
-
 /* PUD_SHIFT determines what a third-level page table entry can map */
 #define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
 #define PUD_SIZE	(1UL << PUD_SHIFT)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index 9083245..55b28ef 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -31,9 +31,6 @@
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
-/* With 4k base page size, hugepage PTEs go at the PMD level */
-#define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
-
 /* PMD_SHIFT determines what a second-level page table entry can map */
 #define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
-- 
2.1.0
