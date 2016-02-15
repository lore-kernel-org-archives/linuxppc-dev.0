Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 277C01A004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 13:44:48 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id w128so6307020pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 18:44:48 -0800 (PST)
Message-ID: <1455504278.16012.18.camel@gmail.com>
Subject: Re: [PATCH V3] powerpc/mm: Fix Multi hit ERAT cause by recent THP
 update
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Date: Mon, 15 Feb 2016 13:44:38 +1100
In-Reply-To: <1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-09 at 06:50 +0530, Aneesh Kumar K.V wrote:
> 
> Also make sure we wait for irq disable section in other cpus to finish
> before flipping a huge pte entry with a regular pmd entry. Code paths
> like find_linux_pte_or_hugepte depend on irq disable to get
> a stable pte_t pointer. A parallel thp split need to make sure we
> don't convert a pmd pte to a regular pmd entry without waiting for the
> irq disable section to finish.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++++
>  arch/powerpc/mm/pgtable_64.c                 | 35
> +++++++++++++++++++++++++++-
>  include/asm-generic/pgtable.h                |  8 +++++++
>  mm/huge_memory.c                             |  1 +
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 8d1c41d28318..ac07a30a7934 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -281,6 +281,10 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct
> mm_struct *mm, pmd_t *pmdp);
>  extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long
> address,
>  			    pmd_t *pmdp);
>  
> +#define __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
> +extern void pmdp_huge_split_prepare(struct vm_area_struct *vma,
> +				    unsigned long address, pmd_t *pmdp);
> +
>  #define pmd_move_must_withdraw pmd_move_must_withdraw
>  struct spinlock;
>  static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 3124a20d0fab..c8a00da39969 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -646,6 +646,30 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct
> *mm, pmd_t *pmdp)
>  	return pgtable;
>  }
>  
> +void pmdp_huge_split_prepare(struct vm_area_struct *vma,
> +			     unsigned long address, pmd_t *pmdp)
> +{
> +	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	BUG_ON(REGION_ID(address) != USER_REGION_ID);
> +#endif
> +	/*
> +	 * We can't mark the pmd none here, because that will cause a race
> +	 * against exit_mmap. We need to continue mark pmd TRANS HUGE, while
> +	 * we spilt, but at the same time we wan't rest of the ppc64 code
> +	 * not to insert hash pte on this, because we will be modifying
> +	 * the deposited pgtable in the caller of this function. Hence
> +	 * clear the _PAGE_USER so that we move the fault handling to
> +	 * higher level function and that will serialize against ptl.
> +	 * We need to flush existing hash pte entries here even though,
> +	 * the translation is still valid, because we will withdraw
> +	 * pgtable_t after this.
> +	 */
> +	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_USER, 0);

Can this break any checks for _PAGE_USER? From other paths?

> +}
> +
> +
>  /*
>   * set a new huge pmd. We should not be called for updating
>   * an existing pmd entry. That should go via pmd_hugepage_update.
> @@ -663,10 +687,19 @@ void set_pmd_at(struct mm_struct *mm, unsigned long
> addr,
>  	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
>  }
>  
> +/*
> + * We use this to invalidate a pmdp entry before switching from a
> + * hugepte to regular pmd entry.
> + */
>  void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  		     pmd_t *pmdp)
>  {
> -	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
> +	pmd_hugepage_update(vma->vm_mm, address, pmdp, ~0UL, 0);
> +	/*
> +	 * This ensures that generic code that rely on IRQ disabling
> +	 * to prevent a parallel THP split work as expected.
> +	 */
> +	kick_all_cpus_sync();

Seems expensive, anyway I think the right should do something like or a wrapper
for it

on_each_cpu_mask(mm_cpumask(vma->vm_mm), do_nothing, NULL, 1);

do_nothing is not exported, but that can be fixed :)

Balbir Singh
