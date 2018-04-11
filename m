Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Lh6R2HPvzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 21:05:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: rashmica.g@gmail.com, benh@kernel.crashing.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mm/memtrace: Let the arch hotunplug code
 flush cache
In-Reply-To: <20180406052424.29841-2-bsingharora@gmail.com>
References: <20180406052424.29841-1-bsingharora@gmail.com>
 <20180406052424.29841-2-bsingharora@gmail.com>
Date: Wed, 11 Apr 2018 21:05:49 +1000
Message-ID: <87d0z6knoy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> Don't do this via custom code, instead now that we have support
> in the arch hotplug/hotunplug code, rely on those routines
> to do the right thing.
>
> Fixes: 9d5171a8f248 ("powerpc/powernv: Enable removal of memory for in memory tracing")

That's not really right.

This patch doesn't fix it, the previous patch did.

If I just backport this patch then it's still broken.

So I'll tag patch 1 with the above Fixes: tag and add stable, and then
this just becomes a cleanup.

OK?

cheers

> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index de470caf0784..fc222a0c2ac4 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -82,19 +82,6 @@ static const struct file_operations memtrace_fops = {
>  	.open	= simple_open,
>  };
>  
> -static void flush_memory_region(u64 base, u64 size)
> -{
> -	unsigned long line_size = ppc64_caches.l1d.size;
> -	u64 end = base + size;
> -	u64 addr;
> -
> -	base = round_down(base, line_size);
> -	end = round_up(end, line_size);
> -
> -	for (addr = base; addr < end; addr += line_size)
> -		asm volatile("dcbf 0,%0" : "=r" (addr) :: "memory");
> -}
> -
>  static int check_memblock_online(struct memory_block *mem, void *arg)
>  {
>  	if (mem->state != MEM_ONLINE)
> @@ -132,10 +119,6 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>  	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
>  			  change_memblock_state);
>  
> -	/* RCU grace period? */
> -	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT),
> -			    nr_pages << PAGE_SHIFT);
> -
>  	lock_device_hotplug();
>  	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
>  	unlock_device_hotplug();
> -- 
> 2.13.6
