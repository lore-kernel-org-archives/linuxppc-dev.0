Return-Path: <kirill@shutemov.name>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjLNm2TgkzDrPs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:51:02 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id s29so9327499lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 03:51:01 -0700 (PDT)
Date: Mon, 26 Sep 2016 13:50:54 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] powerpc/mm: THP page cache support
Message-ID: <20160926105054.GA16074@node.shutemov.name>
References: <1474560160-7327-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474560160-7327-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2016 at 09:32:40PM +0530, Aneesh Kumar K.V wrote:
> Update arch hook in the generic THP page cache code, that will
> deposit and withdarw preallocated page table. Archs like ppc64 use
> this preallocated table to store the hash pte slot information.
> 
> This is an RFC patch and I am sharing this early to get feedback on the
> approach taken. I have used stress-ng mmap-file operation and that
> resulted in some thp_file_mmap as show below.
> 
> [/mnt/stress]$ grep thp_file /proc/vmstat
> thp_file_alloc 25403
> thp_file_mapped 16967
> [/mnt/stress]$
> 
> I did observe wrong nr_ptes count once. I need to recreate the problem
> again.

I don't see anything that could cause that.

The patch looks good to me (apart from nr_ptes issue). Few minor nitpicks
below.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  3 ++
>  include/asm-generic/pgtable.h                |  8 +++-
>  mm/Kconfig                                   |  6 +--
>  mm/huge_memory.c                             | 19 +++++++++-
>  mm/khugepaged.c                              | 21 ++++++++++-
>  mm/memory.c                                  | 56 +++++++++++++++++++++++-----
>  6 files changed, 93 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 263bf39ced40..1f45b06ce78e 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1017,6 +1017,9 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>  	 */
>  	return true;
>  }
> +
> +#define arch_needs_pgtable_deposit() (true)
> +
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index d4458b6dbfb4..0d1e400e82a2 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -660,11 +660,17 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
>  	/*
>  	 * With split pmd lock we also need to move preallocated
>  	 * PTE page table if new_pmd is on different PMD page table.
> +	 *
> +	 * We also don't deposit and withdraw tables for file pages.
>  	 */
> -	return new_pmd_ptl != old_pmd_ptl;
> +	return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
>  }
>  #endif
>  
> +#ifndef arch_needs_pgtable_deposit
> +#define arch_needs_pgtable_deposit() (false)
> +#endif
> +
>  /*
>   * This function is meant to be used by sites walking pagetables with
>   * the mmap_sem hold in read mode to protect against MADV_DONTNEED and
> diff --git a/mm/Kconfig b/mm/Kconfig
> index be0ee11fa0d9..0a279d399722 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -447,13 +447,9 @@ choice
>  	  benefit.
>  endchoice
>  
> -#
> -# We don't deposit page tables on file THP mapping,
> -# but Power makes use of them to address MMU quirk.
> -#
>  config	TRANSPARENT_HUGE_PAGECACHE
>  	def_bool y
> -	depends on TRANSPARENT_HUGEPAGE && !PPC
> +	depends on TRANSPARENT_HUGEPAGE
>  
>  #
>  # UP and nommu archs use km based percpu allocator
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a6abd76baa72..37176f455d16 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1320,6 +1320,14 @@ out_unlocked:
>  	return ret;
>  }
>  
> +void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)

static?

> +{
> +	pgtable_t pgtable;
> +	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
> +	pte_free(mm, pgtable);
> +	atomic_long_dec(&mm->nr_ptes);
> +}
> +
>  int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 pmd_t *pmd, unsigned long addr)
>  {
> @@ -1359,6 +1367,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			atomic_long_dec(&tlb->mm->nr_ptes);
>  			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>  		} else {
> +			if (arch_needs_pgtable_deposit())

Just hide the arch_needs_pgtable_deposit() check in zap_deposited_table().

> +				zap_deposited_table(tlb->mm, pmd);
>  			add_mm_counter(tlb->mm, MM_FILEPAGES, -HPAGE_PMD_NR);
>  		}
>  		spin_unlock(ptl);
-- 
 Kirill A. Shutemov
