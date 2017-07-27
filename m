Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBlM13RMzDrKt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:54:55 +1000 (AEST)
Date: Thu, 27 Jul 2017 14:54:49 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] powerpc/mm: update pmdp_invalidate to return old
 pmd value
Message-ID: <20170727125449.GB27766@dhcp22.suse.cz>
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EMISSING_CHANGELOG

besides that no user actually uses the return value. Please fold this
into the patch which uses the new functionality.

On Thu 27-07-17 14:07:54, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
>  arch/powerpc/mm/pgtable-book3s64.c           | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 41d484ac0822..ece6912fae8e 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1119,8 +1119,8 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
>  }
>  
>  #define __HAVE_ARCH_PMDP_INVALIDATE
> -extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> -			    pmd_t *pmdp);
> +extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +			     pmd_t *pmdp);
>  
>  #define __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
>  static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 3b65917785a5..0bb7f824ecdd 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -90,16 +90,19 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
>   * We use this to invalidate a pmdp entry before switching from a
>   * hugepte to regular pmd entry.
>   */
> -void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> -		     pmd_t *pmdp)
> +pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +		      pmd_t *pmdp)
>  {
> -	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
> +	unsigned long old_pmd;
> +
> +	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	/*
>  	 * This ensures that generic code that rely on IRQ disabling
>  	 * to prevent a parallel THP split work as expected.
>  	 */
>  	serialize_against_pte_lookup(vma->vm_mm);
> +	return __pmd(old_pmd);
>  }
>  
>  static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
> -- 
> 2.13.3
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Michal Hocko
SUSE Labs
