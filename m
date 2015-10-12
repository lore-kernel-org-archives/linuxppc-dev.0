Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 851C91A025F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 20:35:55 +1100 (AEDT)
Message-ID: <1444642554.31951.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: use memblock_is_memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Scott Wood
 <scottwood@freescale.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2015 20:35:54 +1100
In-Reply-To: <1444415430-25827-1-git-send-email-kuleshovmail@gmail.com>
References: <1444415430-25827-1-git-send-email-kuleshovmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-10-10 at 00:30 +0600, Alexander Kuleshov wrote:
> The <linux/memblock.h> provides memblock_is_memory() function that
> tries to find a given physical address in the memblock.memory.regions.
> Let's use this function instead of direct coding of the same functionality.

Are you sure it implements exactly the same logic?

> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 22d94c3..85b462b 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -82,11 +82,9 @@ int page_is_ram(unsigned long pfn)
>  	return pfn < max_pfn;
>  #else
>  	unsigned long paddr = (pfn << PAGE_SHIFT);
> -	struct memblock_region *reg;
> 
> -	for_each_memblock(memory, reg)
> -		if (paddr >= reg->base && paddr < (reg->base + reg->size))
> -			return 1;
> +	if (memblock_is_memory(paddr))
> +		return 1;
>  	return 0;

Why not just return memblock_is_memory(paddr) ?

cheers
