Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id 251812C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 01:48:08 +1100 (EST)
Date: Mon, 3 Feb 2014 14:47:57 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: thp: Fix crash on mremap
Message-ID: <20140203144757.GF5258@hercules>
References: <1390911423-4409-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390911423-4409-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 28, 2014 at 05:47:03PM +0530, Aneesh Kumar K.V wrote:
> This patch fix the below crash
> 
> NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
> LR [c0000000000439ac] .hash_page+0x18c/0x5e0
> ...
> Call Trace:
> [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
> [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
> [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
> 
> On ppc64 we use the pgtable for storing the hpte slot information and
> store address to the pgtable at a constant offset (PTRS_PER_PMD) from
> pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
> the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
> from new pmd.
> 
> We also want to move the withdraw and deposit before the set_pmd so
> that, when page fault find the pmd as trans huge we can be sure that
> pgtable can be located at the offset.
> 
> variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
> for 3.11 stable series
> 

Since both you and Benjamin Herrenschmidt claim this is good for stable, I
am queuing this variant for the 3.11 kernel.  Thanks a lot!

Cheers,
--
Luis

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/Kconfig                           |  3 +++
>  arch/powerpc/platforms/Kconfig.cputype |  1 +
>  mm/huge_memory.c                       | 12 ++++++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1feb169274fe..c5863b35d054 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -368,6 +368,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  config HAVE_ARCH_SOFT_DIRTY
>  	bool
>  
> +config ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
> +	bool
> +
>  config HAVE_MOD_ARCH_SPECIFIC
>  	bool
>  	help
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 47d9a03dd415..d11a34be018d 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -71,6 +71,7 @@ config PPC_BOOK3S_64
>  	select PPC_FPU
>  	select PPC_HAVE_PMU_SUPPORT
>  	select SYS_SUPPORTS_HUGETLBFS
> +	select ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
>  
>  config PPC_BOOK3E_64
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 12acb0ba7991..beaa7cc9de75 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1461,8 +1461,20 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
>  
>  	ret = __pmd_trans_huge_lock(old_pmd, vma);
>  	if (ret == 1) {
> +#ifdef CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
> +		pgtable_t pgtable;
> +#endif
>  		pmd = pmdp_get_and_clear(mm, old_addr, old_pmd);
>  		VM_BUG_ON(!pmd_none(*new_pmd));
> +#ifdef CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
> +		/*
> +		 * Archs like ppc64 use pgtable to store per pmd
> +		 * specific information. So when we switch the pmd,
> +		 * we should also withdraw and deposit the pgtable
> +		 */
> +		pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
> +		pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
> +#endif
>  		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
>  		spin_unlock(&mm->page_table_lock);
>  	}
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
