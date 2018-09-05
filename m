Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539v2RVbzF37D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:06 +1000 (AEST)
Message-Id: <0449b897017034a7f2935446266d8c82d02a9e78.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 06/17] powerpc/mm: use pte helpers in generic code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:37:03 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get rid of platform specific _PAGE_XXXX in powerpc code code and
use helpers instead.

mm/dump_linuxpagetables.c will be handled separately

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  9 +++------
 arch/powerpc/include/asm/nohash/32/pgtable.h | 13 +++++++++----
 arch/powerpc/include/asm/nohash/pgtable.h    |  3 +--
 arch/powerpc/mm/mem.c                        |  2 +-
 arch/powerpc/mm/pgtable.c                    | 19 ++++++-------------
 arch/powerpc/mm/pgtable_32.c                 | 26 ++++++++++++++------------
 arch/powerpc/mm/pgtable_64.c                 | 21 +++++++++++----------
 arch/powerpc/xmon/xmon.c                     | 12 +++++++-----
 8 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index daebb4cde626..90991dce63e9 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -318,17 +318,14 @@ static inline int pte_present(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 3be2109719ed..4fab3a7d764b 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -277,8 +277,12 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+	unsigned long clr = ~pte_val(pte_wrprotect(__pte(~0)));
+	unsigned long set = pte_val(pte_wrprotect(__pte(0)));
+
+	pte_update(ptep, clr, set);
 }
+
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
@@ -291,9 +295,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   unsigned long address,
 					   int psize)
 {
-	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
+	pte_t pte_set = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(0)))));
+	pte_t pte_clr = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(~0)))));
+	unsigned long set = pte_val(entry) & pte_val(pte_set);
+	unsigned long clr = ~pte_val(entry) & ~pte_val(pte_clr);
 
 	pte_update(ptep, clr, set);
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 49417b8b49e9..0c63d10b8631 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -32,8 +32,7 @@ static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PA
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+	return pte_present(pte) && !pte_user(pte);
 }
 
 static inline int pmd_protnone(pmd_t pmd)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c611..24b2ddba0d4d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -532,7 +532,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		access = 0UL;
 		break;
 	case 0x400:
-		access = _PAGE_EXEC;
+		access = pte_val(pte_mkexec(__pte(0)));
 		break;
 	default:
 		return;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 4f788f3762a9..8558f01ed5c8 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -44,20 +44,13 @@ static inline int is_exec_fault(void)
 static inline int pte_looks_normal(pte_t pte)
 {
 
-#if defined(CONFIG_PPC_BOOK3S_64)
-	if ((pte_val(pte) & (_PAGE_PRESENT | _PAGE_SPECIAL)) == _PAGE_PRESENT) {
+	if (pte_present(pte) && !pte_special(pte)) {
 		if (pte_ci(pte))
 			return 0;
 		if (pte_user(pte))
 			return 1;
 	}
 	return 0;
-#else
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER |
-		 _PAGE_PRIVILEGED)) ==
-		(_PAGE_PRESENT | _PAGE_USER);
-#endif
 }
 
 static struct page *maybe_pte_to_page(pte_t pte)
@@ -117,7 +110,7 @@ static pte_t set_pte_filter(pte_t pte)
 	struct page *pg;
 
 	/* No exec permission in the first place, move on */
-	if (!(pte_val(pte) & _PAGE_EXEC) || !pte_looks_normal(pte))
+	if (!pte_exec(pte) || !pte_looks_normal(pte))
 		return pte;
 
 	/* If you set _PAGE_EXEC on weird pages you're on your own */
@@ -137,7 +130,7 @@ static pte_t set_pte_filter(pte_t pte)
 	}
 
 	/* Else, we filter out _PAGE_EXEC */
-	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+	return pte_exprotect(pte);
 }
 
 static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
@@ -150,7 +143,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
 	 * we just bail out
 	 */
-	if (dirty || (pte_val(pte) & _PAGE_EXEC) || !is_exec_fault())
+	if (dirty || pte_exec(pte) || !is_exec_fault())
 		return pte;
 
 #ifdef CONFIG_DEBUG_VM
@@ -176,7 +169,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	set_bit(PG_arch_1, &pg->flags);
 
  bail:
-	return __pte(pte_val(pte) | _PAGE_EXEC);
+	return pte_mkexec(pte);
 }
 
 #endif /* CONFIG_PPC_BOOK3S */
@@ -195,7 +188,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
 
 	/* Add the pte bit when trying to set a pte */
-	pte = __pte(pte_val(pte) | _PAGE_PTE);
+	pte = pte_mkpte(pte);
 
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f983ffa24aa0..4ed4c663f77a 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -103,15 +103,17 @@ EXPORT_SYMBOL(ioremap_wt);
 void __iomem *
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
+	pte_t pte = __pte(flags);
+
 	/* writeable implies dirty for kernel addresses */
-	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
-		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_exprotect(pte);
+	pte = pte_mkprivileged(pte);
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, pte_val(pte), __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
@@ -128,14 +130,15 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	unsigned long v, i;
 	phys_addr_t p;
 	int err;
+	pte_t pte = __pte(flags);
 
 	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
+	if (!pte_present(pte))
+		pte = __pte(pte_val(pte) | pgprot_val(PAGE_KERNEL));
 
 	/* Non-cacheable page cannot be coherent */
-	if (flags & _PAGE_NO_CACHE)
-		flags &= ~_PAGE_COHERENT;
+	if (pte_ci(pte))
+		pte = pte_mknoncoherent(pte);
 
 	/*
 	 * Choose an address to map it to.
@@ -194,7 +197,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 
 	err = 0;
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_kernel_page(v+i, p+i, flags);
+		err = map_kernel_page(v + i, p + i, pte_val(pte));
 	if (err) {
 		if (slab_is_available())
 			vunmap((void *)v);
@@ -235,8 +238,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 		/* The PTE should never be already set nor present in the
 		 * hash table
 		 */
-		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
-		       flags);
+		BUG_ON((pte_present(*pg) | pte_hashpte(*pg)) && flags);
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
 						     __pgprot(flags)));
 	}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 53e9eeecd5d4..3fff1c21b65d 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -117,10 +117,11 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 			    unsigned long flags)
 {
 	unsigned long i;
+	pte_t pte = __pte(flags);
 
 	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
+	if (!pte_present(pte))
+		pte = __pte(pte_val(pte) | pgprot_val(PAGE_KERNEL));
 
 	/* We don't support the 4K PFN hack with ioremap */
 	if (flags & H_PAGE_4K_PFN)
@@ -131,7 +132,7 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 	WARN_ON(size & ~PAGE_MASK);
 
 	for (i = 0; i < size; i += PAGE_SIZE)
-		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
+		if (map_kernel_page((unsigned long)ea + i, pa + i, pte_val(pte)))
 			return NULL;
 
 	return (void __iomem *)ea;
@@ -225,23 +226,23 @@ void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
+	pte_t pte = __pte(flags);
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_EXEC leak out */
-	flags &= ~_PAGE_EXEC;
+	pte = pte_exprotect(pte);
 	/*
 	 * Force kernel mapping.
 	 */
-	flags &= ~_PAGE_USER;
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_mkprivileged(pte);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
+		return ppc_md.ioremap(addr, size, pte_val(pte), caller);
+	return __ioremap_caller(addr, size, pte_val(pte), caller);
 }
 
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4264aedc7775..f65f2f38c441 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2988,15 +2988,17 @@ static void show_task(struct task_struct *tsk)
 #ifdef CONFIG_PPC_BOOK3S_64
 void format_pte(void *ptep, unsigned long pte)
 {
+	pte_t entry = __pte(pte);
+
 	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);
 	printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
 
 	printf("Flags = %s%s%s%s%s\n",
-	       (pte & _PAGE_ACCESSED) ? "Accessed " : "",
-	       (pte & _PAGE_DIRTY)    ? "Dirty " : "",
-	       (pte & _PAGE_READ)     ? "Read " : "",
-	       (pte & _PAGE_WRITE)    ? "Write " : "",
-	       (pte & _PAGE_EXEC)     ? "Exec " : "");
+	       pte_young(entry) ? "Accessed " : "",
+	       pte_dirty(entry) ? "Dirty " : "",
+	       pte_read(entry)  ? "Read " : "",
+	       pte_write(entry) ? "Write " : "",
+	       pte_exec(entry)  ? "Exec " : "");
 }
 
 static void show_pte(unsigned long addr)
-- 
2.13.3
