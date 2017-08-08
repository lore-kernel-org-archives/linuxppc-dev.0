Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xRT7l4SCqzDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 19:07:47 +1000 (AEST)
Date: Tue, 8 Aug 2017 10:07:44 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-ID: <20170808090743.GA12887@arm.com>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2017 at 04:38:45PM -0400, Pavel Tatashin wrote:
> To optimize the performance of struct page initialization,
> vmemmap_populate() will no longer zero memory.
> 
> We must explicitly zero the memory that is allocated by vmemmap_populate()
> for kasan, as this memory does not go through struct page initialization
> path.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  arch/arm64/mm/kasan_init.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 81f03959a4ab..e78a9ecbb687 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -135,6 +135,41 @@ static void __init clear_pgds(unsigned long start,
>  		set_pgd(pgd_offset_k(start), __pgd(0));
>  }
>  
> +/*
> + * Memory that was allocated by vmemmap_populate is not zeroed, so we must
> + * zero it here explicitly.
> + */
> +static void
> +zero_vmemmap_populated_memory(void)
> +{
> +	struct memblock_region *reg;
> +	u64 start, end;
> +
> +	for_each_memblock(memory, reg) {
> +		start = __phys_to_virt(reg->base);
> +		end = __phys_to_virt(reg->base + reg->size);
> +
> +		if (start >= end)
> +			break;
> +
> +		start = (u64)kasan_mem_to_shadow((void *)start);
> +		end = (u64)kasan_mem_to_shadow((void *)end);
> +
> +		/* Round to the start end of the mapped pages */
> +		start = round_down(start, SWAPPER_BLOCK_SIZE);
> +		end = round_up(end, SWAPPER_BLOCK_SIZE);
> +		memset((void *)start, 0, end - start);
> +	}
> +
> +	start = (u64)kasan_mem_to_shadow(_text);
> +	end = (u64)kasan_mem_to_shadow(_end);
> +
> +	/* Round to the start end of the mapped pages */
> +	start = round_down(start, SWAPPER_BLOCK_SIZE);
> +	end = round_up(end, SWAPPER_BLOCK_SIZE);
> +	memset((void *)start, 0, end - start);
> +}

I can't help but think this would be an awful lot nicer if you made
vmemmap_alloc_block take extra GFP flags as a parameter. That way, we could
implement a version of vmemmap_populate that does the zeroing when we need
it, without having to duplicate a bunch of the code like this. I think it
would also be less error-prone, because you wouldn't have to do the
allocation and the zeroing in two separate steps.

Will
