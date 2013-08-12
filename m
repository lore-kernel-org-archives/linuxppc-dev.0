Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08C6C2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 10:19:33 +1000 (EST)
Message-ID: <1376266763.32100.144.camel@pasglop>
Subject: Re: [PATCH 2/2] Register bootmem pages at boot on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 10:19:23 +1000
In-Reply-To: <52050B80.8010602@linux.vnet.ibm.com>
References: <52050ACE.4090001@linux.vnet.ibm.com>
 <52050B80.8010602@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-09 at 10:32 -0500, Nathan Fontenot wrote:

> +void register_page_bootmem_memmap(unsigned long section_nr,
> +				  struct page *start_page, unsigned long size)
> +{
> +	WARN_ONCE(1, KERN_INFO
> +		  "Sparse Vmemmap not fully supported for bootmem info nodes\n");
> +}
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */

But SPARSEMEM_VMEMMAP is our default on ppc64 pseries ... and you are
select'ing the new option, so it looks like we are missing something
here...

Can you tell me a bit more, the above makes me nervous...

Cheers,
Ben.

> Index: powerpc/arch/powerpc/mm/mem.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/mm/mem.c
> +++ powerpc/arch/powerpc/mm/mem.c
> @@ -297,12 +297,21 @@ void __init paging_init(void)
>  }
>  #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
> 
> +static void __init register_page_bootmem_info(void)
> +{
> +	int i;
> +
> +	for_each_online_node(i)
> +		register_page_bootmem_info_node(NODE_DATA(i));
> +}
> +
>  void __init mem_init(void)
>  {
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(0);
>  #endif
> 
> +	register_page_bootmem_info();
>  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>  	set_max_mapnr(max_pfn);
>  	free_all_bootmem();
> Index: powerpc/mm/Kconfig
> ===================================================================
> --- powerpc.orig/mm/Kconfig
> +++ powerpc/mm/Kconfig
> @@ -183,7 +183,7 @@ config MEMORY_HOTPLUG_SPARSE
>  config MEMORY_HOTREMOVE
>  	bool "Allow for memory hot remove"
>  	select MEMORY_ISOLATION
> -	select HAVE_BOOTMEM_INFO_NODE if X86_64
> +	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
>  	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
>  	depends on MIGRATION
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
