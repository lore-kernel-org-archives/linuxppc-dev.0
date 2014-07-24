Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27C451A0A64
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 01:12:53 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 09:12:51 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2A9141FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 09:12:49 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6OFCnK2786858
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 17:12:49 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s6OFGwVK009584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 09:16:59 -0600
Message-ID: <53D12270.6090507@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2014 10:12:48 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc: implement vmemmap_free()
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1402475019-19699-3-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-3-git-send-email-zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2014 03:23 AM, Li Zhong wrote:
> vmemmap_free() does the opposite of vmemap_populate().
> This patch also puts vmemmap_free() and vmemmap_list_free() into
>  CONFIG_MEMMORY_HOTPLUG.
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/init_64.c |   85 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 64 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 69203c8..4963790 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -298,6 +298,37 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>  	vmemmap_list = vmem_back;
>  }
>  
> +int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
> +{
> +	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
> +
> +	/* Align to the page size of the linear mapping. */
> +	start = _ALIGN_DOWN(start, page_size);
> +
> +	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
> +
> +	for (; start < end; start += page_size) {
> +		void *p;
> +
> +		if (vmemmap_populated(start, page_size))
> +			continue;
> +
> +		p = vmemmap_alloc_block(page_size, node);
> +		if (!p)
> +			return -ENOMEM;
> +
> +		vmemmap_list_populate(__pa(p), start, node);
> +
> +		pr_debug("      * %016lx..%016lx allocated at %p\n",
> +			 start, start + page_size, p);
> +
> +		vmemmap_create_mapping(start, page_size, __pa(p));
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static unsigned long vmemmap_list_free(unsigned long start)
>  {
>  	struct vmemmap_backing *vmem_back, *vmem_back_prev;
> @@ -330,40 +361,52 @@ static unsigned long vmemmap_list_free(unsigned long start)
>  	return vmem_back->phys;
>  }
>  
> -int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
> +void __ref vmemmap_free(unsigned long start, unsigned long end)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
>  
> -	/* Align to the page size of the linear mapping. */
>  	start = _ALIGN_DOWN(start, page_size);
>  
> -	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
> +	pr_debug("vmemmap_free %lx...%lx\n", start, end);
>  
>  	for (; start < end; start += page_size) {
> -		void *p;
> +		unsigned long addr;
>  
> +		/*
> +		 * the section has already be marked as invalid, so
> +		 * vmemmap_populated() true means some other sections still
> +		 * in this page, so skip it.
> +		 */
>  		if (vmemmap_populated(start, page_size))
>  			continue;
>  
> -		p = vmemmap_alloc_block(page_size, node);
> -		if (!p)
> -			return -ENOMEM;
> -
> -		vmemmap_list_populate(__pa(p), start, node);
> -
> -		pr_debug("      * %016lx..%016lx allocated at %p\n",
> -			 start, start + page_size, p);
> -
> -		vmemmap_create_mapping(start, page_size, __pa(p));
> +		addr = vmemmap_list_free(start);
> +		if (addr) {
> +			struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
> +
> +			if (PageReserved(page)) {
> +				/* allocated from bootmem */
> +				if (page_size < PAGE_SIZE) {
> +					/*
> +					 * this shouldn't happen, but if it is
> +					 * the case, leave the memory there
> +					 */
> +					WARN_ON_ONCE(1);
> +				} else {
> +					unsigned int nr_pages =
> +						1 << get_order(page_size);
> +					while (nr_pages--)
> +						free_reserved_page(page++);
> +				}
> +			} else
> +				free_pages((unsigned long)(__va(addr)),
> +							get_order(page_size));
> +
> +			vmemmap_remove_mapping(start, page_size);
> +		}
>  	}
> -
> -	return 0;
> -}
> -
> -void vmemmap_free(unsigned long start, unsigned long end)
> -{
>  }
> -
> +#endif
>  void register_page_bootmem_memmap(unsigned long section_nr,
>  				  struct page *start_page, unsigned long size)
>  {
> 
