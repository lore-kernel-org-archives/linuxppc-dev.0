Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrJkT5zxfzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:00:01 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id y69so12972110pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:00:01 -0700 (PDT)
Subject: Re: [PATCH V2 33/68] powerpc/mm: Abstraction for vmemmap and
 map_kernel_page
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-34-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718CEBD.4010602@gmail.com>
Date: Thu, 21 Apr 2016 22:59:41 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-34-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h    |  8 ++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 20 ++++++++++++++++++++
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  7 +++++++
>  arch/powerpc/mm/init_64.c                    |  5 -----
>  arch/powerpc/mm/mmu_decl.h                   |  5 -----
>  arch/powerpc/mm/pgtable-hash64.c             | 12 ++++++------
>  6 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 958491f59c2a..43bd7d15f41e 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -197,6 +197,14 @@ static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +
> +extern int hlmap_kernel_page(unsigned long ea, unsigned long pa,
> +			     unsigned long flags);
> +extern int __meminit hlvmemmap_create_mapping(unsigned long start,
> +					      unsigned long page_size,
> +					      unsigned long phys);
> +extern void hlvmemmap_remove_mapping(unsigned long start,
> +				     unsigned long page_size);
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 5bd2ab4fbbc8..623911ed64e9 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -722,6 +722,26 @@ extern struct page *pgd_page(pgd_t pgd);
>  void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>  void pgtable_cache_init(void);
>  
> +static inline int map_kernel_page(unsigned long ea, unsigned long pa,
> +				  unsigned long flags)
> +{
> +	return hlmap_kernel_page(ea, pa, flags);
> +}
> +
> +static inline int __meminit vmemmap_create_mapping(unsigned long start,
> +						   unsigned long page_size,
> +						   unsigned long phys)
> +{
> +	return hlvmemmap_create_mapping(start, page_size, phys);
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static inline void vmemmap_remove_mapping(unsigned long start,
> +					  unsigned long page_size)
> +{
> +	return hlvmemmap_remove_mapping(start, page_size);
> +}
> +#endif

No if (radix_enabled()) for these functions?

>  struct page *realmode_pfn_to_page(unsigned long pfn);
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index 10debb93c4a4..f143d6fb3576 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -362,6 +362,13 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
>  
>  void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>  void pgtable_cache_init(void);
> +extern int map_kernel_page(unsigned long ea, unsigned long pa,
> +			   unsigned long flags);
> +extern int __meminit vmemmap_create_mapping(unsigned long start,
> +					    unsigned long page_size,
> +					    unsigned long phys);
> +extern void vmemmap_remove_mapping(unsigned long start,
> +				   unsigned long page_size);
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 09ca65e55b58..33709bdb0419 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -240,9 +240,6 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>  	vmemmap_list = vmem_back;
>  }
>  
> -extern int __meminit vmemmap_create_mapping(unsigned long start,
> -					    unsigned long page_size,
> -					    unsigned long phys);
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
> @@ -281,8 +278,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -extern void vmemmap_remove_mapping(unsigned long start,
> -				   unsigned long page_size);
>  static unsigned long vmemmap_list_free(unsigned long start)
>  {
>  	struct vmemmap_backing *vmem_back, *vmem_back_prev;
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index bfb7c0bcabd5..6af65327c993 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -108,11 +108,6 @@ extern unsigned long Hash_size, Hash_mask;
>  
>  #endif /* CONFIG_PPC32 */
>  
> -#ifdef CONFIG_PPC64
> -extern int map_kernel_page(unsigned long ea, unsigned long pa,
> -			   unsigned long flags);
> -#endif /* CONFIG_PPC64 */
> -
>  extern unsigned long ioremap_bot;
>  extern unsigned long __max_low_memory;
>  extern phys_addr_t __initial_memory_limit_addr;
> diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
> index 183f80a528ba..b926b0a4ae0c 100644
> --- a/arch/powerpc/mm/pgtable-hash64.c
> +++ b/arch/powerpc/mm/pgtable-hash64.c
> @@ -26,9 +26,9 @@
>   * On hash-based CPUs, the vmemmap is bolted in the hash table.
>   *
>   */
> -int __meminit vmemmap_create_mapping(unsigned long start,
> -				     unsigned long page_size,
> -				     unsigned long phys)
> +int __meminit hlvmemmap_create_mapping(unsigned long start,
> +				       unsigned long page_size,
> +				       unsigned long phys)
>  {
>  	int rc = htab_bolt_mapping(start, start + page_size, phys,
>  				   pgprot_val(PAGE_KERNEL),
> @@ -43,8 +43,8 @@ int __meminit vmemmap_create_mapping(unsigned long start,
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void vmemmap_remove_mapping(unsigned long start,
> -			    unsigned long page_size)
> +void hlvmemmap_remove_mapping(unsigned long start,
> +			      unsigned long page_size)
>  {
>  	int rc = htab_remove_mapping(start, start + page_size,
>  				     mmu_vmemmap_psize,
> @@ -60,7 +60,7 @@ void vmemmap_remove_mapping(unsigned long start,
>   * map_kernel_page adds an entry to the ioremap page table
>   * and adds an entry to the HPT, possibly bolting it
>   */
> -int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
> +int hlmap_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
>  {
>  	pgd_t *pgdp;
>  	pud_t *pudp;
> 
