Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C987C1A0A37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 01:12:26 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 09:12:23 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8036838C804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:12:20 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6OFCKF61507778
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 15:12:20 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6OFCJKp003889
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:12:20 -0400
Message-ID: <53D1224F.2050406@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2014 10:12:15 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] powerpc: implement vmemmap_remove_mapping() for BOOK3S
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1402475019-19699-2-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-2-git-send-email-zhong@linux.vnet.ibm.com>
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
> This is to be called in vmemmap_free(), leave the implementation on BOOK3E 
> empty as before.
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/hash_utils_64.c |    2 +-
>  arch/powerpc/mm/init_64.c       |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 88fdd9d..25d9d66 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -243,7 +243,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -static int htab_remove_mapping(unsigned long vstart, unsigned long vend,
> +int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  		      int psize, int ssize)
>  {
>  	unsigned long vaddr;
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index fa5d28b..69203c8 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -212,6 +212,13 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
>  	for (i = 0; i < page_size; i += PAGE_SIZE)
>  		BUG_ON(map_kernel_page(start + i, phys, flags));
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void vmemmap_remove_mapping(unsigned long start,
> +				   unsigned long page_size)
> +{
> +}
> +#endif
>  #else /* CONFIG_PPC_BOOK3E */
>  static void __meminit vmemmap_create_mapping(unsigned long start,
>  					     unsigned long page_size,
> @@ -223,6 +230,21 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
>  					mmu_kernel_ssize);
>  	BUG_ON(mapped < 0);
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +extern int htab_remove_mapping(unsigned long vstart, unsigned long vend,
> +			int psize, int ssize);
> +
> +static void vmemmap_remove_mapping(unsigned long start,
> +				   unsigned long page_size)
> +{
> +	int mapped = htab_remove_mapping(start, start + page_size,
> +					 mmu_vmemmap_psize,
> +					 mmu_kernel_ssize);
> +	BUG_ON(mapped < 0);
> +}
> +#endif
> +
>  #endif /* CONFIG_PPC_BOOK3E */
>  
>  struct vmemmap_backing *vmemmap_list;
> 
