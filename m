Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgc9n4ZRSzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 19:05:01 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id k3so2644302pav.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Apr 2016 02:05:01 -0700 (PDT)
Subject: Re: [PATCH 02/10] mm/hugetlb: Add PGD based implementation awareness
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-3-git-send-email-khandual@linux.vnet.ibm.com>
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570622B4.5020407@gmail.com>
Date: Thu, 7 Apr 2016 19:04:52 +1000
MIME-Version: 1.0
In-Reply-To: <1460007464-26726-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/04/16 15:37, Anshuman Khandual wrote:
> Currently the config ARCH_WANT_GENERAL_HUGETLB enabled functions like
> 'huge_pte_alloc' and 'huge_pte_offset' dont take into account HugeTLB
> page implementation at the PGD level. This is also true for functions
> like 'follow_page_mask' which is called from move_pages() system call.
> This lack of PGD level huge page support prohibits some architectures
> to use these generic HugeTLB functions.
> 

>From what I know of move_pages(), it will always call follow_page_mask()
with FOLL_GET (I could be wrong here) and the implementation below
returns NULL for follow_huge_pgd().

> This change adds the required PGD based implementation awareness and
> with that, more architectures like POWER which implements 16GB pages
> at the PGD level along with the 16MB pages at the PMD level can now
> use ARCH_WANT_GENERAL_HUGETLB config option.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/gup.c                |  6 ++++++
>  mm/hugetlb.c            | 20 ++++++++++++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 7d953c2..71832e1 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -115,6 +115,8 @@ struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  				pmd_t *pmd, int flags);
>  struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  				pud_t *pud, int flags);
> +struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
> +				pgd_t *pgd, int flags);
>  int pmd_huge(pmd_t pmd);
>  int pud_huge(pud_t pmd);
>  unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> @@ -143,6 +145,7 @@ static inline void hugetlb_show_meminfo(void)
>  }
>  #define follow_huge_pmd(mm, addr, pmd, flags)	NULL
>  #define follow_huge_pud(mm, addr, pud, flags)	NULL
> +#define follow_huge_pgd(mm, addr, pgd, flags)	NULL
>  #define prepare_hugepage_range(file, addr, len)	(-EINVAL)
>  #define pmd_huge(x)	0
>  #define pud_huge(x)	0
> diff --git a/mm/gup.c b/mm/gup.c
> index fb87aea..9bac78c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -234,6 +234,12 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
>  	pgd = pgd_offset(mm, address);
>  	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
>  		return no_page_table(vma, flags);
> +	if (pgd_huge(*pgd) && vma->vm_flags & VM_HUGETLB) {
> +		page = follow_huge_pgd(mm, address, pgd, flags);
> +		if (page)
> +			return page;
> +		return no_page_table(vma, flags);
This will return NULL as well?
> +	}
>  
>  	pud = pud_offset(pgd, address);
>  	if (pud_none(*pud))
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 19d0d08..5ea3158 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4250,6 +4250,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  	pte_t *pte = NULL;
>  
>  	pgd = pgd_offset(mm, addr);
> +	if (sz == PGDIR_SIZE) {
> +		pte = (pte_t *)pgd;
> +		goto huge_pgd;
> +	}
> +

No allocation for a pgd slot - right?

>  	pud = pud_alloc(mm, pgd, addr);
>  	if (pud) {
>  		if (sz == PUD_SIZE) {
> @@ -4262,6 +4267,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  				pte = (pte_t *)pmd_alloc(mm, pud, addr);
>  		}
>  	}
> +
> +huge_pgd:
>  	BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
>  
>  	return pte;
> @@ -4275,6 +4282,8 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>  
>  	pgd = pgd_offset(mm, addr);
>  	if (pgd_present(*pgd)) {
> +		if (pgd_huge(*pgd))
> +			return (pte_t *)pgd;
>  		pud = pud_offset(pgd, addr);
>  		if (pud_present(*pud)) {
>  			if (pud_huge(*pud))
> @@ -4343,6 +4352,17 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
>  }
>  
> +struct page * __weak
> +follow_huge_pgd(struct mm_struct *mm, unsigned long address,
> +		pgd_t *pgd, int flags)
> +{
> +	if (flags & FOLL_GET)
> +		return NULL;
> +
> +	return pte_page(*(pte_t *)pgd) +
> +				((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> +}
> +
>  #ifdef CONFIG_MEMORY_FAILURE
>  
>  /*
> 
