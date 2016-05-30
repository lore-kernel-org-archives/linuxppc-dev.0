Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ99r1hGDzDqPF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:42:55 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 May 2016 02:42:53 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for book3s
 64
In-Reply-To: <20160530090833.4400ac83@kryten>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
 <20160530090833.4400ac83@kryten>
Date: Mon, 30 May 2016 14:12:45 +0530
Message-ID: <87shx00we2.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> Hi Ben,
>
>> That is surprising, do we have any idea what specifically increases
>> the overhead so significantly ? Does gcc know about ldbrx/stdbrx ? I
>> notice in our io.h for example we still do manual ld/std + swap
>> because old processors didn't know these, we should fix that for
>> CONFIG_POWER8 (or is it POWER7 that brought these ?).
>
> The futex issue seems to be __get_user_pages_fast():
>
>         ld      r11,0(r6)
>         ...
>         rldicl  r8,r11,32,32
>         rotlwi  r28,r11,24
>         rlwimi  r28,r11,8,8,15
>         rotlwi  r6,r8,24
>         rlwimi  r28,r11,8,24,31
>         rlwimi  r6,r8,8,8,15
>         rlwimi  r6,r8,8,24,31
>         rldicr  r28,r28,32,31
>         or      r28,r28,r6
>         cmpdi   cr7,r28,0
>         beq     cr7,2428
>
> That's a whole lot of work just to check if a pte is zero. I assume
> the reason gcc can't replace this with a byte reversed load is that
> we access the pte via the READ_ONCE() macro.
>
> I see the same issue in unmap_page_range(), __hash_page_64K(),
> handle_mm_fault().
>
> The other issue I see is when we access a pte via larx/stcx, and then
> we have no choice but to byte swap it manually. I see that in
> __hash_page_64K():
>
>         rldicl  r28,r30,32,32
>         rotlwi  r0,r30,24
>         rlwimi  r0,r30,8,8,15
>         rotlwi  r10,r28,24
>         rlwimi  r0,r30,8,24,31
>         rlwimi  r10,r28,8,8,15
>         rlwimi  r10,r28,8,24,31
>         rldicr  r0,r0,32,31
>         or      r0,r0,r10
>         hwsync
>         ldarx   r12,0,r6
>         cmpd    r12,r11 
>         bne-    c00000000004fad0
>         stdcx.  r0,0,r6 
>         bne-    c00000000004fab8
>         hwsync
>

Can you try the below patch. __get_user_pages_fast still does the endian
conversion because of usages like is_hugepd(__hugepd(pgd_val(pgd)) in
generic code.

commit 0dda5aab70a4d74374013597f77c20e78e452d6b
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Mon May 30 13:46:24 2016 +0530

    powerpc/mm: use _raw variant of page table accessors
    
    This switch few page table accessor to use the __raw variant and does
    the native to big endian conversion of constants. This helps in
    generating better code. We still have usages like
    is_hugepd(__hugepd(pgd_val(pgd))) which still does the endian conversion
    of page table values. Will get that in the next patch
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 71e9abced493..9db83b4e017d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -11,7 +11,7 @@ static inline int pmd_huge(pmd_t pmd)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pmd_val(pmd) & _PAGE_PTE);
+		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 
@@ -21,7 +21,7 @@ static inline int pud_huge(pud_t pud)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pud_val(pud) & _PAGE_PTE);
+		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 
@@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pgd_val(pgd) & _PAGE_PTE);
+		return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 #define pgd_huge pgd_huge
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index cb2d0a5fa3f8..0d2845b44763 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -15,7 +15,7 @@ static inline int pmd_huge(pmd_t pmd)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pmd_val(pmd) & _PAGE_PTE);
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline int pud_huge(pud_t pud)
@@ -23,7 +23,7 @@ static inline int pud_huge(pud_t pud)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pud_val(pud) & _PAGE_PTE);
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline int pgd_huge(pgd_t pgd)
@@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pgd_val(pgd) & _PAGE_PTE);
+	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 }
 #define pgd_huge pgd_huge
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index cfd114bf8992..e52ff00a23c6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -317,7 +317,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
@@ -335,8 +335,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
@@ -345,7 +344,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
@@ -364,17 +363,35 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 {
 	pte_update(mm, addr, ptep, ~0UL, 0, 0);
 }
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
-static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
-static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
-static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
+
+static inline int pte_write(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_WRITE));
+}
+
+static inline int pte_dirty(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DIRTY));
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_ACCESSED));
+}
+
+static inline int pte_special(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SPECIAL));
+}
+
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline bool pte_soft_dirty(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SOFT_DIRTY));
 }
+
 static inline pte_t pte_mksoft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
@@ -401,7 +418,7 @@ static inline int pte_protnone(pte_t pte)
 
 static inline int pte_present(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_PRESENT);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
 }
 /*
  * Conversion functions: convert a page and protection to a page entry,
@@ -473,7 +490,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 static inline bool pte_user(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+	return !(pte_raw(pte) & cpu_to_be64(_PAGE_PRIVILEGED));
 }
 
 /* Encode and de-code a swap entry */
@@ -516,10 +533,12 @@ static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
 }
+
 static inline bool pte_swp_soft_dirty(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SWP_SOFT_DIRTY));
 }
+
 static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
@@ -646,8 +665,15 @@ static inline void pud_clear(pud_t *pudp)
 	*pudp = __pud(0);
 }
 
-#define pud_none(pud)		(!pud_val(pud))
-#define pud_present(pud)	(pud_val(pud) != 0)
+static inline int pud_none(pud_t pud)
+{
+	return !pud_raw(pud);
+}
+
+static inline int pud_present(pud_t pud)
+{
+	return !pud_none(pud);
+}
 
 extern struct page *pud_page(pud_t pud);
 extern struct page *pmd_page(pmd_t pmd);
@@ -681,8 +707,15 @@ static inline void pgd_clear(pgd_t *pgdp)
 	*pgdp = __pgd(0);
 }
 
-#define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_present(pgd)	(!pgd_none(pgd))
+static inline int pgd_none(pgd_t pgd)
+{
+	return !pgd_raw(pgd);
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return !pgd_none(pgd);
+}
 
 static inline pte_t pgd_pte(pgd_t pgd)
 {
@@ -849,7 +882,7 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 
 static inline int pmd_large(pmd_t pmd)
 {
-	return !!(pmd_val(pmd) & _PAGE_PTE);
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
@@ -865,7 +898,7 @@ static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
@@ -876,7 +909,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
 {
 
-	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
+	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index e2bf208605b1..be6afef39344 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -41,6 +41,12 @@ static inline unsigned long pud_val(pud_t x)
 {
 	return be64_to_cpu(x.pud);
 }
+
+static inline __be64 pud_raw(pud_t x)
+{
+	return x.pud;
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
@@ -52,6 +58,11 @@ static inline unsigned long pgd_val(pgd_t x)
 	return be64_to_cpu(x.pgd);
 }
 
+static inline __be64 pgd_raw(pgd_t x)
+{
+	return x.pgd;
+}
+
 /* Page protection bits */
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
