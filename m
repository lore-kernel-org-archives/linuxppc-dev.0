Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65C83B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:49 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:38 +1000
Subject: [PATCH 1/20] powerpc/mm: Fix misplaced #endif in pgtable-ppc64-64k.h
Message-Id: <20090723055949.43B20DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A misplaced #endif causes more definitions than intended to be
protected by #ifndef __ASSEMBLY__. This breaks upcoming 64-bit
BookE support patch when using 64k pages.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-ppc64-64k.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64-64k.h	2009-07-22 11:45:34.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64-64k.h	2009-07-22 11:45:47.000000000 +1000
@@ -10,10 +10,10 @@
 #define PGD_INDEX_SIZE  4
 
 #ifndef __ASSEMBLY__
-
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+#endif	/* __ASSEMBLY__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
@@ -32,8 +32,6 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#endif	/* __ASSEMBLY__ */
-
 /* Bits to mask out from a PMD to get to the PTE page */
 #define PMD_MASKED_BITS		0x1ff
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
