Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 33C85DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 14:25:36 +1100 (EST)
Date: Thu, 03 Apr 2008 12:22:18 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: yhlu.kernel@gmail.com
Subject: Re: [PATCH] mm: make mem_map allocation continuous v2.
In-Reply-To: <200804021830.24563.yhlu.kernel@gmail.com>
References: <86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
	<200804021830.24563.yhlu.kernel@gmail.com>
Message-Id: <20080403122051.D1EC.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Looks good to me. And ia64 boots up with this patch too.
Thanks.

Acked-by: Yasunori Goto <y-goto@jp.fujitsu.com>


> 
> vmemmap allocation current got
>  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001400000 on node 0
>  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001800000 on node 0
>  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001c00000 on node 0
>  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810002000000 on node 0
>  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002400000 on node 0
> ...
> 
> there is 2M hole between them.
> 
> the rootcause is that usemap (24 bytes) will be allocated after every 2M
> mem_map. and it will push next vmemmap (2M) to next align (2M).
> 
> solution:
> try to allocate mem_map continously.
> 
> after patch, will get
>  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001400000 on node 0
>  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
>  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001800000 on node 0
>  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001a00000 on node 0
>  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810001c00000 on node 0
> ...
> and usemap will share in page because of they are allocated continuously too.
> sparse_early_usemap_alloc: usemap = ffff810024e00000 size = 24
> sparse_early_usemap_alloc: usemap = ffff810024e00080 size = 24
> sparse_early_usemap_alloc: usemap = ffff810024e00100 size = 24
> sparse_early_usemap_alloc: usemap = ffff810024e00180 size = 24
> ...
> 
> so we make the bootmem allocation more compact and use less memory for usemap.
> 
> for power pc
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> >  You have to call sparse_init_one_section() on each pmap and usemap
> >  as we allocate - since valid_section() depends on it (which is needed
> >  by vmemmap_populate() to check if the section is populated or not).
> >  On ppc, we need to call htab_bolted_mapping() on each section and
> >  we need to skip existing sections.
> 
> so try to allocate usemap at first altogether.
> 
> v2 replace:
> 	[PATCH] mm: make mem_map allocation continuous.
> 	[PATCH] mm: allocate section_map for sparse_init
> 	[PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
> 
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6a43c0..2881222 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -294,22 +294,48 @@ void __init sparse_init(void)
>  	unsigned long pnum;
>  	struct page *map;
>  	unsigned long *usemap;
> +	unsigned long **usemap_map;
> +	int size;
> +
> +	/*
> +	 * map is using big page (aka 2M in x86 64 bit)
> +	 * usemap is less one page (aka 24 bytes)
> +	 * so alloc 2M (with 2M align) and 24 bytes in turn will
> +	 * make next 2M slip to one more 2M later.
> +	 * then in big system, the memory will have a lot of holes...
> +	 * here try to allocate 2M pages continously.
> +	 *
> +	 * powerpc need to call sparse_init_one_section right after each
> +	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
> +	 */
> +	size = sizeof(unsigned long *) * NR_MEM_SECTIONS;
> +	usemap_map = alloc_bootmem(size);
> +	if (!usemap_map)
> +		panic("can not allocate usemap_map\n");
>  
>  	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
>  		if (!present_section_nr(pnum))
>  			continue;
> +		usemap_map[pnum] = sparse_early_usemap_alloc(pnum);
> +	}
>  
> -		map = sparse_early_mem_map_alloc(pnum);
> -		if (!map)
> +	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
> +		if (!present_section_nr(pnum))
>  			continue;
>  
> -		usemap = sparse_early_usemap_alloc(pnum);
> +		usemap = usemap_map[pnum];
>  		if (!usemap)
>  			continue;
>  
> +		map = sparse_early_mem_map_alloc(pnum);
> +		if (!map)
> +			continue;
> +
>  		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
>  								usemap);
>  	}
> +
> +	free_bootmem(__pa(usemap_map), size);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Yasunori Goto 
