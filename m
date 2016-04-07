Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgcfv6N9PzDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 19:26:47 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q129so6669934pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Apr 2016 02:26:47 -0700 (PDT)
Subject: Re: [PATCH 03/10] mm/hugetlb: Protect follow_huge_(pud|pgd) functions
 from race
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-4-git-send-email-khandual@linux.vnet.ibm.com>
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570627C9.5030105@gmail.com>
Date: Thu, 7 Apr 2016 19:26:33 +1000
MIME-Version: 1.0
In-Reply-To: <1460007464-26726-4-git-send-email-khandual@linux.vnet.ibm.com>
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
> follow_huge_(pmd|pud|pgd) functions are used to walk the page table and
> fetch the page struct during 'follow_page_mask' call. There are possible
> race conditions faced by these functions which arise out of simultaneous
> calls of move_pages() and freeing of huge pages. This was fixed partly
> by the previous commit e66f17ff7177 ("mm/hugetlb: take page table lock
> in follow_huge_pmd()") for only PMD based huge pages.
> 
> After implementing similar logic, functions like follow_huge_(pud|pgd)
> are now safe from above mentioned race conditions and also can support
> FOLL_GET. Generic version of the function 'follow_huge_addr' has been
> left as it is and its upto the architecture to decide on it.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  include/linux/mm.h | 33 +++++++++++++++++++++++++++
>  mm/hugetlb.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ffcff53..734182a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1751,6 +1751,19 @@ static inline void pgtable_page_dtor(struct page *page)
>  		NULL: pte_offset_kernel(pmd, address))
>  
>  #if USE_SPLIT_PMD_PTLOCKS

Do we still use USE_SPLIT_PMD_PTLOCKS? I think its good enough. with pgd's
we are likely to use the same locks and the split nature may not be really
split.

> +static struct page *pgd_to_page(pgd_t *pgd)
> +{
> +	unsigned long mask = ~(PTRS_PER_PGD * sizeof(pgd_t) - 1);
> +
> +	return virt_to_page((void *)((unsigned long) pgd & mask));
> +}
> +
> +static struct page *pud_to_page(pud_t *pud)
> +{
> +	unsigned long mask = ~(PTRS_PER_PUD * sizeof(pud_t) - 1);
> +
> +	return virt_to_page((void *)((unsigned long) pud & mask));
> +}
>  
>  static struct page *pmd_to_page(pmd_t *pmd)
>  {
> @@ -1758,6 +1771,16 @@ static struct page *pmd_to_page(pmd_t *pmd)
>  	return virt_to_page((void *)((unsigned long) pmd & mask));
>  }
>  
> +static inline spinlock_t *pgd_lockptr(struct mm_struct *mm, pgd_t *pgd)
> +{
> +	return ptlock_ptr(pgd_to_page(pgd));
> +}
> +
> +static inline spinlock_t *pud_lockptr(struct mm_struct *mm, pud_t *pud)
> +{
> +	return ptlock_ptr(pud_to_page(pud));
> +}
> +
>  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
>  	return ptlock_ptr(pmd_to_page(pmd));
> @@ -1783,6 +1806,16 @@ static inline void pgtable_pmd_page_dtor(struct page *page)
>  
>  #else
>  
> +static inline spinlock_t *pgd_lockptr(struct mm_struct *mm, pgd_t *pgd)
> +{
> +	return &mm->page_table_lock;
> +}
> +
> +static inline spinlock_t *pud_lockptr(struct mm_struct *mm, pud_t *pud)
> +{
> +	return &mm->page_table_lock;
> +}
> +
>  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
>  	return &mm->page_table_lock;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ea3158..e84e479 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4346,21 +4346,70 @@ struct page * __weak
>  follow_huge_pud(struct mm_struct *mm, unsigned long address,
>  		pud_t *pud, int flags)
>  {
> -	if (flags & FOLL_GET)
> -		return NULL;
> -
> -	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +retry:
> +	ptl = pud_lockptr(mm, pud);
> +	spin_lock(ptl);
> +	/*
> +	 * make sure that the address range covered by this pud is not
> +	 * unmapped from other threads.
> +	 */
> +	if (!pud_huge(*pud))
> +		goto out;
> +	if (pud_present(*pud)) {
> +		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> +		if (flags & FOLL_GET)
> +			get_page(page);
> +	} else {
> +		if (is_hugetlb_entry_migration(huge_ptep_get((pte_t *)pud))) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait(mm, (pte_t *)pud, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>  
>  struct page * __weak
>  follow_huge_pgd(struct mm_struct *mm, unsigned long address,
>  		pgd_t *pgd, int flags)
>  {
> -	if (flags & FOLL_GET)
> -		return NULL;
> -
> -	return pte_page(*(pte_t *)pgd) +
> -				((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +retry:
> +	ptl = pgd_lockptr(mm, pgd);
> +	spin_lock(ptl);
> +	/*
> +	 * make sure that the address range covered by this pgd is not
> +	 * unmapped from other threads.
> +	 */
> +	if (!pgd_huge(*pgd))
> +		goto out;
> +	if (pgd_present(*pgd)) {
> +		page = pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> +		if (flags & FOLL_GET)
> +			get_page(page);
> +	} else {
> +		if (is_hugetlb_entry_migration(huge_ptep_get((pte_t *)pgd))) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait(mm, (pte_t *)pgd, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>  
>  #ifdef CONFIG_MEMORY_FAILURE
> 


Balbir
