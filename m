Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C67B1A0962
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 01:11:55 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:11:51 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C735938C8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:11:48 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6OFBmsL6160828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 15:11:48 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6OFBlG0032324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:11:48 -0400
Message-ID: <53D1222F.7010900@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2014 10:11:43 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc: implement vmemmap_list_free()
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
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
> This patch implements vmemmap_list_free() for vmemmap_free().
> 
> The freed entries will be removed from vmemmap_list, and form a freed list,
> with next as the header. The next position in the last allocated page is kept
> at the list tail.
> 
> When allocation, if there are freed entries left, get it from the freed list;
> if no freed entries left, get it like before from the last allocated pages.
> 
> With this change, realmode_pfn_to_page() also needs to be changed to walk
> all the entries in the vmemmap_list, as the virt_addr of the entries might not
> be stored in order anymore.
> 
> It helps to reuse the memory when continuous doing memory hot-plug/remove
> operations, but didn't reclaim the pages already allocated, so the memory usage
> will only increase, but won't exceed the value for the largest memory
> configuration.
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/init_64.c |   62 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index e3734ed..fa5d28b 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -226,14 +226,24 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
>  #endif /* CONFIG_PPC_BOOK3E */
>  
>  struct vmemmap_backing *vmemmap_list;
> +static struct vmemmap_backing *next;
> +static int num_left;
> +static int num_freed;
>  
>  static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
>  {
> -	static struct vmemmap_backing *next;
> -	static int num_left;
> +	struct vmemmap_backing *vmem_back;
> +	/* get from freed entries first */
> +	if (num_freed) {
> +		num_freed--;
> +		vmem_back = next;
> +		next = next->list;
> +
> +		return vmem_back;
> +	}
>  
>  	/* allocate a page when required and hand out chunks */
> -	if (!next || !num_left) {
> +	if (!num_left) {
>  		next = vmemmap_alloc_block(PAGE_SIZE, node);
>  		if (unlikely(!next)) {
>  			WARN_ON(1);
> @@ -266,6 +276,38 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>  	vmemmap_list = vmem_back;
>  }
>  
> +static unsigned long vmemmap_list_free(unsigned long start)
> +{
> +	struct vmemmap_backing *vmem_back, *vmem_back_prev;
> +
> +	vmem_back_prev = vmem_back = vmemmap_list;
> +
> +	/* look for it with prev pointer recorded */
> +	for (; vmem_back; vmem_back = vmem_back->list) {
> +		if (vmem_back->virt_addr == start)
> +			break;
> +		vmem_back_prev = vmem_back;
> +	}
> +
> +	if (unlikely(!vmem_back)) {
> +		WARN_ON(1);
> +		return 0;
> +	}
> +
> +	/* remove it from vmemmap_list */
> +	if (vmem_back == vmemmap_list) /* remove head */
> +		vmemmap_list = vmem_back->list;
> +	else
> +		vmem_back_prev->list = vmem_back->list;
> +
> +	/* next point to this freed entry */
> +	vmem_back->list = next;
> +	next = vmem_back;
> +	num_freed++;
> +
> +	return vmem_back->phys;
> +}
> +
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
> @@ -331,16 +373,16 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
>  		if (pg_va < vmem_back->virt_addr)
>  			continue;
>  
> -		/* Check that page struct is not split between real pages */
> -		if ((pg_va + sizeof(struct page)) >
> -				(vmem_back->virt_addr + page_size))
> -			return NULL;
> -
> -		page = (struct page *) (vmem_back->phys + pg_va -
> +		/* After vmemmap_list entry free is possible, need check all */
> +		if ((pg_va + sizeof(struct page)) <=
> +				(vmem_back->virt_addr + page_size)) {
> +			page = (struct page *) (vmem_back->phys + pg_va -
>  				vmem_back->virt_addr);
> -		return page;
> +			return page;
> +		}
>  	}
>  
> +	/* Probably that page struct is split between real pages */
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
> 
