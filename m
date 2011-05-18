Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FAB6B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:05:16 +1000 (EST)
Date: Wed, 18 May 2011 16:04:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 1/7] powerpc/mm: 64-bit 4k: use page-sized PMDs
Message-ID: <20110518210453.GA29500@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows a virtual page table to be used at the PMD rather than
the PTE level.

Rather than adjust the constant in pgd_index() (or ignore it, as
too-large values don't hurt as long as overly large addresses aren't
passed in), go back to using PTRS_PER_PGD.  The overflow comment seems to
apply to a very old implementation of free_pgtables that used pgd_index()
(unfortunately the commit message, if you seek it out in the historic
tree, doesn't mention any details about the overflow).  The existing
value was numerically indentical to the old 4K-page PTRS_PER_PGD, so
using it shouldn't produce an overflow where it's not otherwise possible.

Also get rid of the incorrect comment at the top of pgtable-ppc64-4k.h.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/pgtable-ppc64-4k.h |   12 ++++--------
 arch/powerpc/include/asm/pgtable-ppc64.h    |    3 +--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 6eefdcf..194005e 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -1,14 +1,10 @@
 #ifndef _ASM_POWERPC_PGTABLE_PPC64_4K_H
 #define _ASM_POWERPC_PGTABLE_PPC64_4K_H
-/*
- * Entries per page directory level.  The PTE level must use a 64b record
- * for each page table entry.  The PMD and PGD level use a 32b record for
- * each entry by assuming that each entry is page aligned.
- */
+
 #define PTE_INDEX_SIZE  9
-#define PMD_INDEX_SIZE  7
+#define PMD_INDEX_SIZE  9
 #define PUD_INDEX_SIZE  7
-#define PGD_INDEX_SIZE  9
+#define PGD_INDEX_SIZE  7
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
@@ -19,7 +15,7 @@
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PUD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 /* PMD_SHIFT determines what a second-level page table entry can map */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 2b09cd5..8bd1cd9 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -181,8 +181,7 @@
  * Find an entry in a page-table-directory.  We combine the address region
  * (the high order N bits) and the pgd portion of the address.
  */
-/* to avoid overflow in free_pgtables we don't use PTRS_PER_PGD here */
-#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & 0x1ff)
+#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
 
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-- 
1.7.4.1
