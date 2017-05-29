Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc1206fMMzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:08 +1000 (AEST)
Message-Id: <8bcba44d31778772e1046302036d618dd7b67729.1496070452.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/7] powerpc/mm: declare some local functions static
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:32:04 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_pteptr() and __mapin_ram_chunk() are only used locally,
so define them static

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 3 ---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 3 ---
 arch/powerpc/mm/pgtable_32.c                 | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7fb755880409..17c8766777f1 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -294,9 +294,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
-		      pmd_t **pmdp);
-
 int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
 
 /* Generic accessors to PTE bits */
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 91314268f04f..589206bf0358 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -337,9 +337,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
-		      pmd_t **pmdp);
-
 int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 46b02fe33864..d151779621fb 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -243,7 +243,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 /*
  * Map in a chunk of physical memory starting at start.
  */
-void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
+static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 {
 	unsigned long v, s, f;
 	phys_addr_t p;
@@ -295,7 +295,7 @@ void __init mapin_ram(void)
  * Returns true (1) if PTE was found, zero otherwise.  The pointer to
  * the PTE pointer is unmodified if PTE is not found.
  */
-int
+static int
 get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
 {
         pgd_t	*pgd;
-- 
2.12.0
