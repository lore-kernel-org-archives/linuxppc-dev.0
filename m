Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 627441A009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6D8B13578055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gGTM30736392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6fp9O014500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:41:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 09/31] powerpc/mm: Don't use pte_val as lvalue
Date: Mon, 21 Sep 2015 12:10:36 +0530
Message-Id: <1442817658-2588-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also convert few #define to static inline in this patch for better
type checking

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/pgtable.h | 112 ++++++++++++++++++++----------
 arch/powerpc/include/asm/page.h           |  10 ++-
 arch/powerpc/include/asm/pgtable-book3e.h |  68 ++++++++++++------
 3 files changed, 133 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index 87333618af3b..e156a6c9d84c 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -12,9 +12,9 @@
 
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
-static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
-static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
+static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
+static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
+static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
@@ -47,36 +47,61 @@ static inline int pte_present(pte_t pte)
  * Even if PTEs can be unsigned long long, a PFN is always an unsigned
  * long for now.
  */
-static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
 	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
-		     pgprot_val(pgprot)); }
-static inline unsigned long pte_pfn(pte_t pte)	{
-	return pte_val(pte) >> PTE_RPN_SHIFT; }
+		     pgprot_val(pgprot));
+}
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return pte_val(pte) >> PTE_RPN_SHIFT;
+}
 
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	pte_val(pte) &= ~_PAGE_RW;
+	return __pte(pte_val(pte) & ~_PAGE_RW);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
 	return pte;
 }
-static inline pte_t pte_mkclean(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
-static inline pte_t pte_mkold(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) {
-	pte_val(pte) |= _PAGE_RW; return pte; }
-static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
-static inline pte_t pte_mkyoung(pte_t pte) {
-	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkspecial(pte_t pte) {
-	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
-static inline pte_t pte_mkhuge(pte_t pte) {
-	return pte; }
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
-	return pte;
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
 
 
@@ -159,22 +184,39 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU)
 
-#define pgprot_noncached(prot)	  (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
-				            _PAGE_NO_CACHE | _PAGE_GUARDED))
+static inline pgprot_t pgprot_noncached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE | _PAGE_GUARDED);
+}
 
-#define pgprot_noncached_wc(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
-				            _PAGE_NO_CACHE))
+static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE);
+}
 
-#define pgprot_cached(prot)       (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
-				            _PAGE_COHERENT))
+static inline pgprot_t pgprot_cached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT);
+}
 
-#define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
-				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT | _PAGE_WRITETHRU);
+}
 
-#define pgprot_cached_noncoherent(prot) \
-		(__pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL))
+static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
+}
 
-#define pgprot_writecombine pgprot_noncached_wc
+static inline pgprot_t pgprot_writecombine(pgprot_t prot)
+{
+	return pgprot_noncached_wc(prot);
+}
 
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6e976e..f5cd68581bc4 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -283,8 +283,11 @@ extern long long virt_phys_offset;
 
 /* PTE level */
 typedef struct { pte_basic_t pte; } pte_t;
-#define pte_val(x)	((x).pte)
 #define __pte(x)	((pte_t) { (x) })
+static inline pte_basic_t pte_val(pte_t x)
+{
+	return x.pte;
+}
 
 /* 64k pages additionally define a bigger "real PTE" type that gathers
  * the "second half" part of the PTE for pseudo 64k pages
@@ -326,8 +329,11 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  */
 
 typedef pte_basic_t pte_t;
-#define pte_val(x)	(x)
 #define __pte(x)	(x)
+static inline pte_basic_t pte_val(pte_t pte)
+{
+	return pte;
+}
 
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
 typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
diff --git a/arch/powerpc/include/asm/pgtable-book3e.h b/arch/powerpc/include/asm/pgtable-book3e.h
index a3221cff2e31..20451f03df8f 100644
--- a/arch/powerpc/include/asm/pgtable-book3e.h
+++ b/arch/powerpc/include/asm/pgtable-book3e.h
@@ -56,30 +56,58 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE);
-	pte_val(pte) |= _PAGE_RO; return pte; }
-static inline pte_t pte_mkclean(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
-static inline pte_t pte_mkold(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_RO;
-	pte_val(pte) |= _PAGE_RW; return pte; }
-static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
-static inline pte_t pte_mkyoung(pte_t pte) {
-	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkspecial(pte_t pte) {
-	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
-static inline pte_t pte_mkhuge(pte_t pte) {
-	return pte; }
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
+	ptev |= _PAGE_RO;
+	return __pte(ptev);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~_PAGE_RO;
+	ptev |= _PAGE_RW;
+	return __pte(pte);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+static inline pte_t pte_mkhuge(pte_t pte)
 {
-	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
 	return pte;
 }
 
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
 
 /* Insert a PTE, top-level function is out of line. It uses an inline
  * low level function in the respective pgtable-* files
-- 
2.5.0
