Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ9bz2ZKWzDrK5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 10:02:23 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so8864415pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:02:23 -0700 (PDT)
Subject: Re: [PATCH V2 3/5] powerpc/64/kexec: Fix MMU cleanup on radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <03ac98fb-8234-e286-f9a9-24343d9d55d6@gmail.com>
Date: Tue, 23 Aug 2016 10:02:15 +1000
MIME-Version: 1.0
In-Reply-To: <1471596759-3396-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/08/16 18:52, Aneesh Kumar K.V wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Just using the hash ops won't work anymore since radix will have
> NULL in there. Instead create an mmu_cleanup_all() function which
> will do the right thing based on the MMU mode.
> 
> For Radix, for now I clear UPRT and the PTCR, effectively switching
> back to Radix with no partition table setup.
> 
> Currently set it to NULL on BookE thought it might be a good idea
> to wipe the TLB there (Scott ?)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu-book3e.h  |  3 +++
>  arch/powerpc/include/asm/mmu.h         |  4 ++++
>  arch/powerpc/kernel/machine_kexec_64.c | 13 +++----------
>  arch/powerpc/mm/pgtable-book3s64.c     |  9 +++++++++
>  arch/powerpc/mm/pgtable-radix.c        | 12 ++++++++++++
>  5 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
> index cd4f04a74802..b62a8d43a06c 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -313,6 +313,9 @@ extern int book3e_htw_mode;
>   * return 1, indicating that the tlb requires preloading.
>   */
>  #define HUGETLB_NEED_PRELOAD
> +
> +#define mmu_cleanup_all NULL
> +
>  #endif
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index e2fb408f8398..79c989a05aa1 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -204,6 +204,10 @@ extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
>   * make it match the size our of bolted TLB area
>   */
>  extern u64 ppc64_rma_size;
> +
> +/* Cleanup function used by kexec */
> +extern void mmu_cleanup_all(void);
> +extern void radix__mmu_cleanup_all(void);
>  #endif /* CONFIG_PPC64 */
>  
>  struct mm_struct;
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 4c780a342282..8cbd870dd557 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -30,6 +30,7 @@
>  #include <asm/smp.h>
>  #include <asm/hw_breakpoint.h>
>  #include <asm/asm-prototypes.h>
> +#include <asm/firmware.h>
>  
>  #ifdef CONFIG_PPC_BOOK3E
>  int default_machine_kexec_prepare(struct kimage *image)
> @@ -55,9 +56,6 @@ int default_machine_kexec_prepare(struct kimage *image)
>  	const unsigned long *basep;
>  	const unsigned int *sizep;
>  
> -	if (!mmu_hash_ops.hpte_clear_all)
> -		return -ENOENT;
> -
>  	/*
>  	 * Since we use the kernel fault handlers and paging code to
>  	 * handle the virtual mode, we must make sure no destination
> @@ -379,13 +377,8 @@ void default_machine_kexec(struct kimage *image)
>  	 * a toc is easier in C, so pass in what we can.
>  	 */
>  	kexec_sequence(&kexec_stack, image->start, image,
> -			page_address(image->control_code_page),
> -#ifdef CONFIG_PPC_STD_MMU
> -			mmu_hash_ops.hpte_clear_all
> -#else
> -			NULL
> -#endif
> -	);
> +		       page_address(image->control_code_page),
> +		       mmu_cleanup_all);
>  	/* NOTREACHED */
>  }
>  
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 7328886bca4c..f4f437cbabf1 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -116,3 +116,12 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	return;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +/* For use by kexec */
> +void mmu_cleanup_all(void)
> +{
> +	if (radix_enabled())
> +		radix__mmu_cleanup_all();
> +	else if (mmu_hash_ops.hpte_clear_all)
> +		mmu_hash_ops.hpte_clear_all();
> +}
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 035a1a2b1002..790a1e1bb0e5 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -395,6 +395,18 @@ void radix__early_init_mmu_secondary(void)
>  	}
>  }
>  
> +void radix__mmu_cleanup_all(void)
> +{
> +	unsigned long lpcr;
> +
> +	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
> +		lpcr = mfspr(SPRN_LPCR);
> +		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);

I suspect the new kernel will do the right thing w.r.t LPCR


> +		mtspr(SPRN_PTCR, 0);

Do we care to free the partition_tb at this point? Probably not since
we are going to reboot soon, but I think it'll help with anyone (read
NMMU) holding stray references.

> +		radix__flush_tlb_all();
> +	}
> +}
> +
>  void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  				phys_addr_t first_memblock_size)
>  {
> 


Acked-by: Balbir Singh <bsingharora@gmail.com>
