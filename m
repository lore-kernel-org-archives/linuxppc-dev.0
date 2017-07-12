Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x72Jy5MNzzDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 01:03:46 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/hugetlb: fix page rights verification in gup_hugepte()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170712150342.136ED6A666@pc13941vm.idsi0.si.c-s.fr>
Date: Wed, 12 Jul 2017 17:03:42 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gup_hugepte() checks if pages are present and readable, and
when  'write' is set, also checks if the pages are writable.

Initially this was done by checking if _PAGE_PRESENT and
_PAGE_READ were set. In addition, _PAGE_WRITE was verified for write
accesses.

The problem is that we have to handle the three following cases:
1/ The target defines __PAGE_READ and __PAGE_WRITE
2/ The target defines __PAGE_RW
3/ The target defines __PAGE_RO

In case 1/, this is obvious
In case 2/, __PAGE_READ is defined as 0 and __PAGE_WRITE as __PAGE_RW
so it works as well.
But in case 3, __PAGE_RW is defined as 0, which means __PAGE_WRITE is 0
and then the test returns true (page writable) in all cases.

A first correction was attempted in commit 6b8cb66a6a7cc ("powerpc: Fix
usage of _PAGE_RO in hugepage"), but that fix is wrong:
instead of checking that the page is writable when write is requested,
it checks that the page is NOT writable when write is NOT requested.

This patch adds a new pte_read() helper to check whether a page is
readable or not. This avoids handling all possible cases in
gup_hugepte().

Then gup_hugepte() is modified to use pte_present(), pte_read()
and pte_write() instead of the raw flags.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++++
 arch/powerpc/include/asm/nohash/pgtable.h    |  1 +
 arch/powerpc/mm/hugetlbpage.c                | 15 +++------------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7fb755880409..2a67b861e6e1 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -301,6 +301,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
 
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
+static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c0737c86a362..83cb73c8c3bb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -409,6 +409,11 @@ static inline int pte_write(pte_t pte)
 	return __pte_write(pte) || pte_savedwrite(pte);
 }
 
+static inline int pte_read(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_READ));
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index e5805ad78e12..17989c3d9a24 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -14,6 +14,7 @@ static inline int pte_write(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO;
 }
+static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca397fe..1226932579a0 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -977,7 +977,6 @@ EXPORT_SYMBOL_GPL(__find_linux_pte_or_hugepte);
 int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
 {
-	unsigned long mask;
 	unsigned long pte_end;
 	struct page *head, *page;
 	pte_t pte;
@@ -988,18 +987,10 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_READ;
-
-	/*
-	 * On some CPUs like the 8xx, _PAGE_RW hence _PAGE_WRITE is defined
-	 * as 0 and _PAGE_RO has to be set when a page is not writable
-	 */
-	if (write)
-		mask |= _PAGE_WRITE;
-	else
-		mask |= _PAGE_RO;
 
-	if ((pte_val(pte) & mask) != mask)
+	if (!pte_present(pte) || !pte_read(pte))
+		return 0;
+	if (write && !pte_write(pte))
 		return 0;
 
 	/* hugepages are never "special" */
-- 
2.12.0
