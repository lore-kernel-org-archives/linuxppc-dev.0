Return-Path: <pbadari@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CA18DDF6B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 09:50:58 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m32MoteR030284
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 18:50:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m32MotQi196166
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 16:50:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m32MosZa004977
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 16:50:55 -0600
Subject: Re: [PATCH] mm: allocate usemap at first instead of mem_map in
	sparse_init
From: Badari Pulavarty <pbadari@us.ibm.com>
To: yhlu.kernel@gmail.com
In-Reply-To: <200804021525.48799.yhlu.kernel@gmail.com>
References: <200804021525.48799.yhlu.kernel@gmail.com>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 15:51:25 -0800
Message-Id: <1207180285.30407.45.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
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

On Wed, 2008-04-02 at 15:25 -0700, Yinghai Lu wrote:
> [PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
> so try to allocate usemap at first altogether.
> 
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index d3cb085..782ebe5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -294,7 +294,7 @@ void __init sparse_init(void)
>  	unsigned long pnum;
>  	struct page *map;
>  	unsigned long *usemap;
> -	struct page **section_map;
> +	unsigned long **usemap_map;
>  	int size;
>  	int node;
> 
> @@ -305,27 +305,31 @@ void __init sparse_init(void)
>  	 * make next 2M slip to one more 2M later.
>  	 * then in big system, the memmory will have a lot hole...
>  	 * here try to allocate 2M pages continously.

Comments are x86-64 specific. On ppc its 16MB chunks :(

> +	 *
> +	 * powerpc hope to sparse_init_one_section right after each
> +	 * sparse_early_mem_map_alloc, so allocate usemap_map
> +	 * at first.
>  	 */
> -	size = sizeof(struct page *) * NR_MEM_SECTIONS;
> -	section_map = alloc_bootmem(size);
> -	if (!section_map)
> -		panic("can not allocate section_map\n");
> +	size = sizeof(unsigned long *) * NR_MEM_SECTIONS;
> +	usemap_map = alloc_bootmem(size);
> +	if (!usemap_map)
> +		panic("can not allocate usemap_map\n");
> 
>  	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
>  		if (!present_section_nr(pnum))
>  			continue;
> -		section_map[pnum] = sparse_early_mem_map_alloc(pnum);
> +		usemap_map[pnum] = sparse_early_usemap_alloc(pnum);
>  	}
> 
>  	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
>  		if (!present_section_nr(pnum))
>  			continue;
> 
> -		map = section_map[pnum];
> +		map = sparse_early_mem_map_alloc(pnum);
>  		if (!map)
>  			 continue;
> 
> -		usemap = sparse_early_usemap_alloc(pnum);
> +		usemap = usemap_map[pnum];
>  		if (!usemap)
>  			continue;

You may want to move this check before doing sparse_early_mem_map_alloc
(). We are also not handling errors properly (freeing up the unused
map or usemap) if we "continue". I know the original code is this way,
but you touched it last :)

> 
> @@ -333,7 +337,7 @@ void __init sparse_init(void)
>  								usemap);
>  	}
> 
> -	free_bootmem(__pa(section_map), size);
> +	free_bootmem(__pa(usemap_map), size);
>  }
> 
>  #ifdef CONFIG_MEMORY_HOTPLUG

Tested and boots my machine fine.

Acked-by: Badari Pulavarty <pbadari@us.ibm.com>

Thanks,
Badari
