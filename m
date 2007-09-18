Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BD101DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 17:25:23 +1000 (EST)
Date: Tue, 18 Sep 2007 17:22:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/2] [POWERPC] Size swapper_pg_dir correctly
Message-Id: <20070918172259.dc4172b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson pointed out that swapper_pg_dir actually need to be
PGD_TABLE_SIZE bytes long not PAGE_SIZE.  This actually saves 64k in
the bss for a kernel ppc64_defconfig built with CONFIG_PPC_64K_PAGES.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/asm-offsets.c |    4 ++++
 arch/powerpc/kernel/head_64.S     |    2 +-
 include/asm-powerpc/pgtable-4k.h  |    2 ++
 include/asm-powerpc/pgtable-64k.h |    2 ++
 4 files changed, 9 insertions(+), 1 deletions(-)

Boot tested on a POWER5+ with 4K and 64K pages.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a408053..0ae5d57 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -320,5 +320,9 @@ int main(void)
 	DEFINE(VMALLOC_START_ESID, GET_ESID(VMALLOC_START));
 	DEFINE(VMALLOC_START_VSID, KERNEL_VSID(VMALLOC_START));
 #endif
+
+#ifdef CONFIG_PPC64
+	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
+#endif
 	return 0;
 }
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f4ae82e..384cc75 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1539,4 +1539,4 @@ empty_zero_page:
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PAGE_SIZE
+	.space	PGD_TABLE_SIZE
diff --git a/include/asm-powerpc/pgtable-4k.h b/include/asm-powerpc/pgtable-4k.h
index add5481..818e2ab 100644
--- a/include/asm-powerpc/pgtable-4k.h
+++ b/include/asm-powerpc/pgtable-4k.h
@@ -10,10 +10,12 @@
 #define PUD_INDEX_SIZE  7
 #define PGD_INDEX_SIZE  9
 
+#ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+#endif	/* __ASSEMBLY__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
diff --git a/include/asm-powerpc/pgtable-64k.h b/include/asm-powerpc/pgtable-64k.h
index 33ae901..bd54b77 100644
--- a/include/asm-powerpc/pgtable-64k.h
+++ b/include/asm-powerpc/pgtable-64k.h
@@ -9,9 +9,11 @@
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE  4
 
+#ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+#endif	/* __ASSEMBLY__ */
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-- 
1.5.3.1
