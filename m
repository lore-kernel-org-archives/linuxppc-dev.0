Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539n527RzF1nv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:00 +1000 (AEST)
Message-Id: <b19dcca52787042f833e261dc4b829c21f52cd49.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 03/17] powerpc/mm: dont't use _PAGE_EXEC in book3s/32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:36:57 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

book3s/32 doesn't define _PAGE_EXEC, so no need to use it.

All other platforms define _PAGE_EXEC so no need to check
it is not NUL when not book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/mm/pgtable.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 751cf931bb3f..b6d3b25d255c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -234,7 +234,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   int psize)
 {
 	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
 	pte_update(ptep, clr, set);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d71c7777669c..4f788f3762a9 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -73,7 +73,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
 	return page;
 }
 
-#if defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0
+#ifdef CONFIG_PPC_BOOK3S
 
 /* Server-style MMU handles coherency when hashing if HW exec permission
  * is supposed per page (currently 64-bit only). If not, then, we always
@@ -106,7 +106,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return pte;
 }
 
-#else /* defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0 */
+#else /* CONFIG_PPC_BOOK3S */
 
 /* Embedded type MMU with HW exec support. This is a bit more complicated
  * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
@@ -179,7 +179,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return __pte(pte_val(pte) | _PAGE_EXEC);
 }
 
-#endif /* !(defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0) */
+#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * set_pte stores a linux PTE into the linux page table.
-- 
2.13.3
