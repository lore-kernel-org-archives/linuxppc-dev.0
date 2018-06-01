Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80b3BhszDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:50 +1000 (AEST)
Message-Id: <9c7961bea4a07b1d8203bb164333772c6ec1cf0e.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 11/14] powerpc/nohash: fix hash related comments in
 pgtable.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:47 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ----
 arch/powerpc/include/asm/nohash/64/pgtable.h | 18 ++++--------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b2d0f3d0b097..a70f7bf2248f 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -223,10 +223,6 @@ static inline unsigned long long pte_update(pte_t *p,
 }
 #endif /* CONFIG_PTE_64BIT */
 
-/*
- * 2.6 calls this without flushing the TLB entry; this is wrong
- * for our hash-based implementation, we fix that up here.
- */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index b90256f74cc8..bf04176dbef1 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -3,7 +3,7 @@
 #define _ASM_POWERPC_NOHASH_64_PGTABLE_H
 /*
  * This file contains the functions and defines necessary to modify and use
- * the ppc64 hashed page table.
+ * the ppc64 non-hashed page table.
  */
 
 #include <asm/nohash/64/pgtable-4k.h>
@@ -38,7 +38,7 @@
 
 /*
  * The vmalloc space starts at the beginning of that region, and
- * occupies half of it on hash CPUs and a quarter of it on Book3E
+ * occupies a quarter of it on Book3E
  * (we keep a quarter for the virtual memmap)
  */
 #define VMALLOC_START	KERN_VIRT_START
@@ -78,7 +78,7 @@
 
 /*
  * Defines the address of the vmemap area, in its own region on
- * hash table CPUs and after the vmalloc space on Book3E
+ * after the vmalloc space on Book3E
  */
 #define VMEMMAP_BASE		VMALLOC_END
 #define VMEMMAP_END		KERN_IO_START
@@ -248,14 +248,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
 }
 
-/*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty. The generic routines only flush if the
- * entry was young or dirty which is not good enough.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
@@ -279,9 +271,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 }
 
 
-/* Set the dirty and/or accessed bits atomically in a linux PTE, this
- * function doesn't need to flush the hash entry
- */
+/* Set the dirty and/or accessed bits atomically in a linux PTE */
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
 					   pte_t *ptep, pte_t entry,
 					   unsigned long address)
-- 
2.13.3
