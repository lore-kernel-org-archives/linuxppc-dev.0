Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pNTC2yCdzDrWN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 10:44:15 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id a14-v6so5409072pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 17:44:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 7/7] powerpc/64s/radix: avoid ptesync after set_pte and
 ptep_set_access_flags
Date: Sun, 20 May 2018 10:43:47 +1000
Message-Id: <20180520004347.19508-8-npiggin@gmail.com>
In-Reply-To: <20180520004347.19508-1-npiggin@gmail.com>
References: <20180520004347.19508-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ISA suggests ptesync after setting a pte, to prevent a table walk
initiated by a subsequent access from missing that store and causing a
spurious fault. This is an architectual allowance that allows an
implementation's page table walker to be incoherent with the store
queue.

However there is no correctness problem in taking a spurious fault in
userspace -- the kernel copes with these at any time, so the updated
pte will be found eventually. Spurious kernel faults on vmap memory
must be avoided, so a ptesync is put into flush_cache_vmap.

On POWER9 so far I have not found a measurable window where this can
result in more minor faults, so as an optimisation, remove the costly
ptesync from pte updates. If an implementation benefits from ptesync,
it would be better to add it back in update_mmu_cache, so it's not
done for things like fork(2).

fork --fork --exec benchmark improved 5.2% (12400->13100).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  2 --
 arch/powerpc/include/asm/cacheflush.h      | 13 +++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index ab4ed61a74fa..cc9437a542cc 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -210,7 +210,6 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 		__radix_pte_update(ptep, 0, new_pte);
 	} else
 		__radix_pte_update(ptep, 0, set);
-	asm volatile("ptesync" : : : "memory");
 }
 
 static inline int radix__pte_same(pte_t pte_a, pte_t pte_b)
@@ -227,7 +226,6 @@ static inline void radix__set_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, int percpu)
 {
 	*ptep = pte;
-	asm volatile("ptesync" : : : "memory");
 }
 
 static inline int radix__pmd_bad(pmd_t pmd)
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 11843e37d9cf..e9662648e72d 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -26,6 +26,19 @@
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
+#ifdef CONFIG_BOOK3S_64
+/*
+ * Book3s has no ptesync after setting a pte, so without this ptesync it's
+ * possible for a kernel virtual mapping access to return a spurious fault
+ * if it's accessed right after the pte is set. The page fault handler does
+ * not expect this type of fault. flush_cache_vmap is not exactly the right
+ * place to put this, but it seems to work well enough.
+ */
+#define flush_cache_vmap(start, end)		do { asm volatile("ptesync"); } while (0)
+#else
+#define flush_cache_vmap(start, end)		do { } while (0)
+#endif
+
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
-- 
2.17.0
