Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKmW642rzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:46:51 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id y69so13295687pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:46:51 -0700 (PDT)
Subject: Re: [PATCH V2 34/68] powerpc/mm/radix: Add radix callback for vmemmap
 and map_kernel page
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-35-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718D9C0.2060403@gmail.com>
Date: Thu, 21 Apr 2016 23:46:40 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-35-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 12 ++++++++++++
>  arch/powerpc/include/asm/book3s/64/radix.h   |  6 ++++++
>  arch/powerpc/mm/pgtable-radix.c              | 20 ++++++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 623911ed64e9..c16037116625 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -725,6 +725,13 @@ void pgtable_cache_init(void);
>  static inline int map_kernel_page(unsigned long ea, unsigned long pa,
>  				  unsigned long flags)
>  {
> +	if (radix_enabled()) {
> +#if defined(CONFIG_PPC_RADIX_MMU) && defined(DEBUG_VM)
Do you need the defined(CONFIG_PPC_RADIX_MMU) is radix_enabled() not sufficient?

> +		unsigned long page_size = 1 << mmu_psize_defs[mmu_io_psize].shift;
> +		WARN((page_size != PAGE_SIZE), "I/O page size != PAGE_SIZE");
> +#endif
> +		return map_radix_kernel_page(ea, pa, __pgprot(flags), PAGE_SIZE);
> +	}
>  	return hlmap_kernel_page(ea, pa, flags);
>  }
>  
> @@ -732,6 +739,8 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
>  						   unsigned long page_size,
>  						   unsigned long phys)
>  {
> +	if (radix_enabled())
> +		return rvmemmap_create_mapping(start, page_size, phys);
>  	return hlvmemmap_create_mapping(start, page_size, phys);
>  }
>  
> @@ -739,6 +748,9 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
>  static inline void vmemmap_remove_mapping(unsigned long start,
>  					  unsigned long page_size)
>  {
> +
> +	if (radix_enabled())
> +		return rvmemmap_remove_mapping(start, page_size);
>  	return hlvmemmap_remove_mapping(start, page_size);
>  }
>  #endif
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 806dc2195f85..040c4a56d07b 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -133,6 +133,12 @@ static inline int rpmd_trans_huge(pmd_t pmd)
>  
>  #endif
>  
> +extern int __meminit rvmemmap_create_mapping(unsigned long start,
> +					     unsigned long page_size,
> +					     unsigned long phys);
> +extern void rvmemmap_remove_mapping(unsigned long start,
> +				    unsigned long page_size);
> +
>  extern int map_radix_kernel_page(unsigned long ea, unsigned long pa,
>  				 pgprot_t flags, unsigned int psz);
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 5737769469b3..a5d0ae5630b3 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -342,3 +342,23 @@ void rsetup_initial_memory_limit(phys_addr_t first_memblock_base,
>  	/* Finally limit subsequent allocations */
>  	memblock_set_current_limit(first_memblock_base + first_memblock_size);
>  }
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +int __meminit rvmemmap_create_mapping(unsigned long start,
> +				      unsigned long page_size,
> +				      unsigned long phys)
> +{
> +	/* Create a PTE encoding */
> +	unsigned long flags = _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_KERNEL_RW;
> +
> +	BUG_ON(map_radix_kernel_page(start, phys, __pgprot(flags), page_size));
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +void rvmemmap_remove_mapping(unsigned long start, unsigned long page_size)
> +{
> +	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */

You mean x86/x86_64? Are we going to not remove this entry from the kernel page table?
Will we leave this around?

> +}
> +#endif
> +#endif
> 
