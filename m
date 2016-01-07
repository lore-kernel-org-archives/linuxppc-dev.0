Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B94371A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 20:15:04 +1100 (AEDT)
Date: Thu, 7 Jan 2016 20:15:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20160107201503.6d5ec159@canb.auug.org.au>
In-Reply-To: <20151218163351.5bfd2def@canb.auug.org.au>
References: <20151218163351.5bfd2def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On Fri, 18 Dec 2015 16:33:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   arch/powerpc/include/asm/pgtable.h
> 
> between commit:
> 
>   ee4889c7bc2a ("powerpc/mm: Don't have generic headers introduce functions touching pte bits")
> 
> from the powerpc tree and commit:
> 
>   e0e8474c0d55 ("mm, dax, gpu: convert vm_insert_mixed to pfn_t")
> 
> from the akpm-current tree.
> 
> I fixed it up (the code being changed was moved from this file - I added
> the fix up patch below) and can carry the fix as necessary (no action
> is required).
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 18 Dec 2015 16:30:47 +1100
> Subject: [PATCH] mm, dax, gpu: merge fix for convert vm_insert_mixed to pfn_t
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 1 +
>  arch/powerpc/include/asm/book3s/64/hash.h    | 1 +
>  arch/powerpc/include/asm/nohash/pgtable.h    | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 38b33dcfcc9d..3ed3303c1295 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -313,6 +313,7 @@ static inline int pte_present(pte_t pte)
>   * Even if PTEs can be unsigned long long, a PFN is always an unsigned
>   * long for now.
>   */
> +#define pfn_pte pfn_pte
>  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
>  {
>  	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 9e861b4378bd..6ab967d0da00 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -410,6 +410,7 @@ static inline int pte_present(pte_t pte)
>   * Even if PTEs can be unsigned long long, a PFN is always an unsigned
>   * long for now.
>   */
> +#define pfn_pte pfn_pte
>  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
>  {
>  	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 1263c22d60d8..11e3767216c0 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -49,6 +49,7 @@ static inline int pte_present(pte_t pte)
>   * Even if PTEs can be unsigned long long, a PFN is always an unsigned
>   * long for now.
>   */
> +#define pfn_pte pfn_pte
>  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
>  	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
>  		     pgprot_val(pgprot)); }
> -- 
> 2.6.2

This merge fix up patch now looks like this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Dec 2015 16:50:42 +1100
Subject: [PATCH] merge fix for "powerpc, thp: remove infrastructure for handling splitting PMDs"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 12 ------------
 arch/powerpc/include/asm/book3s/64/hash.h     | 11 +++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  4 ----
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 9e55e3b1fef0..849bbec80f7b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -256,13 +256,6 @@ static inline int pmd_trans_huge(pmd_t pmd)
 		  (_PAGE_PTE | _PAGE_THP_HUGE));
 }
 
-static inline int pmd_trans_splitting(pmd_t pmd)
-{
-	if (pmd_trans_huge(pmd))
-		return pmd_val(pmd) & _PAGE_SPLITTING;
-	return 0;
-}
-
 static inline int pmd_large(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_PTE);
@@ -273,11 +266,6 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
 }
 
-static inline pmd_t pmd_mksplitting(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
-}
-
 #define __HAVE_ARCH_PMD_SAME
 static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9e861b4378bd..b6827603e613 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -36,11 +36,6 @@
 #define _PAGE_SOFT_DIRTY	0x20000 /* software: software dirty tracking */
 
 /*
- * THP pages can't be special. So use the _PAGE_SPECIAL
- */
-#define _PAGE_SPLITTING _PAGE_SPECIAL
-
-/*
  * We need to differentiate between explicit huge page and THP huge
  * page, since THP huge page also need to track real subpage details
  */
@@ -49,9 +44,9 @@
 /*
  * set of bits not changed in pmd_modify.
  */
-#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
-			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE | _PAGE_PTE | _PAGE_SOFT_DIRTY)
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+			 _PAGE_ACCESSED | _PAGE_THP_HUGE | _PAGE_PTE | \
+			 _PAGE_SOFT_DIRTY)
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 03c1a5a21c0c..04022fad3708 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -258,10 +258,6 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 extern pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 				     unsigned long addr, pmd_t *pmdp);
 
-#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
-extern void pmdp_splitting_flush(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp);
-
 extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 #define pmdp_collapse_flush pmdp_collapse_flush


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
