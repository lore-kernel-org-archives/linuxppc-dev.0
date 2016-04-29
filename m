Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxd6pHdzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 04/70] powerpc/mm: Add pte_xchg() helper
Date: Fri, 29 Apr 2016 23:25:27 +1000
Message-Id: <1461936393-10131-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have five locations in 64-bit hash MMU code that do a cmpxchg() of a
PTE. Currently doing it inline OK, but in a future patch we will be
converting the PTEs to __be64 in some configs. In that case we will need
casts at every cmpxchg() site in order to keep sparse happy.

So move the logic into a helper, this is a reasonably nice cleanup on
its own.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  5 +----
 arch/powerpc/include/asm/pgtable-types.h | 12 ++++++++++++
 arch/powerpc/mm/hash64_4k.c              |  4 ++--
 arch/powerpc/mm/hash64_64k.c             |  7 +++----
 arch/powerpc/mm/hugetlbpage-hash64.c     |  4 ++--
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 7529aab068f5..42da513fec2d 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -319,11 +319,8 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 		if (writing && pte_write(old_pte))
 			new_pte = pte_mkdirty(new_pte);
 
-		if (pte_val(old_pte) == __cmpxchg_u64((unsigned long *)ptep,
-						      pte_val(old_pte),
-						      pte_val(new_pte))) {
+		if (pte_xchg(ptep, old_pte, new_pte))
 			break;
-		}
 	}
 	return new_pte;
 }
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 1464e74178d8..e7f4f3e0fcde 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -54,4 +54,16 @@ typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
 #endif
+
+#ifdef CONFIG_PPC_STD_MMU_64
+#include <asm/cmpxchg.h>
+
+static inline bool pte_xchg(pte_t *ptep, pte_t old, pte_t new)
+{
+	unsigned long *p = (unsigned long *)ptep;
+
+	return pte_val(old) == __cmpxchg_u64(p, pte_val(old), pte_val(new));
+}
+#endif
+
 #endif /* _ASM_POWERPC_PGTABLE_TYPES_H */
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 47d1b26effc6..dbd3133a8562 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -47,8 +47,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+
 	/*
 	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
 	 * need to add in 0x1 if it's a read-only user page
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b2d659cf51c6..6fbf983b3ae5 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -79,8 +79,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+
 	/*
 	 * Handle the subpage protection bits
 	 */
@@ -254,8 +254,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	rflags = htab_convert_pte_flags(new_pte);
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 8555fce902fe..9c0518761279 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -57,8 +57,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					 old_pte, new_pte));
+	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+
 	rflags = htab_convert_pte_flags(new_pte);
 
 	sz = ((1UL) << shift);
-- 
2.5.0
