Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2lJm3Y4yzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:33:28 +1000 (AEST)
Date: Wed, 12 Apr 2017 10:33:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH 4/9] powerpc/mm: Reshuffle vmemmap_free()
Message-ID: <20170412103327.3bfe4291@canb.auug.org.au>
In-Reply-To: <20170411174233.21902-5-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-5-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

On Wed, 12 Apr 2017 03:42:28 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index ec84b31c6c86..f8124edb6ffa 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -234,12 +234,15 @@ static unsigned long vmemmap_list_free(unsigned long start)
>  void __ref vmemmap_free(unsigned long start, unsigned long end)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
> +	unsigned long page_order = get_order(page_size);
>  
>  	start = _ALIGN_DOWN(start, page_size);
>  
>  	pr_debug("vmemmap_free %lx...%lx\n", start, end);
>  
>  	for (; start < end; start += page_size) {
> +		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);

The declaration of addr is below here and, even so, it would be
uninitialised ...

> +		unsigned int nr_pages;
>  		unsigned long addr;

-- 
Cheers,
Stephen Rothwell
