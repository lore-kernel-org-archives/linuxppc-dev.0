Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWHDy52ctzDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:55:30 +1000 (AEST)
Date: Mon, 14 Aug 2017 15:55:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-ID: <20170814135525.GN19063@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let's CC Hpa on this one. I am still not sure it is correct. The full
series is here
http://lkml.kernel.org/r/1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com

On Mon 07-08-17 16:38:35, Pavel Tatashin wrote:
> Struct pages are initialized by going through __init_single_page(). Since
> the existing physical memory in memblock is represented in memblock.memory
> list, struct page for every page from this list goes through
> __init_single_page().
> 
> The second memblock list: memblock.reserved, manages the allocated memory.
> The memory that won't be available to kernel allocator. So, every page from
> this list goes through reserve_bootmem_region(), where certain struct page
> fields are set, the assumption being that the struct pages have been
> initialized beforehand.
> 
> In trim_low_memory_range() we unconditionally reserve memoryfrom PFN 0, but
> memblock.memory might start at a later PFN. For example, in QEMU,
> e820__memblock_setup() can use PFN 1 as the first PFN in memblock.memory,
> so PFN 0 is not on memblock.memory (and hence isn't initialized via
> __init_single_page) but is on memblock.reserved (and hence we set fields in
> the uninitialized struct page).
> 
> Currently, the struct page memory is always zeroed during allocation,
> which prevents this problem from being detected. But, if some asserts
> provided by CONFIG_DEBUG_VM_PGFLAGS are tighten, this problem may become
> visible in existing kernels.
> 
> In this patchset we will stop zeroing struct page memory during allocation.
> Therefore, this bug must be fixed in order to avoid random assert failures
> caused by CONFIG_DEBUG_VM_PGFLAGS triggers.
> 
> The fix is to reserve memory from the first existing PFN.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  arch/x86/kernel/setup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3486d0498800..489cdc141bcb 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -790,7 +790,10 @@ early_param("reservelow", parse_reservelow);
>  
>  static void __init trim_low_memory_range(void)
>  {
> -	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> +	unsigned long min_pfn = find_min_pfn_with_active_regions();
> +	phys_addr_t base = min_pfn << PAGE_SHIFT;
> +
> +	memblock_reserve(base, ALIGN(reserve_low, PAGE_SIZE));
>  }
>  	
>  /*
> -- 
> 2.14.0

-- 
Michal Hocko
SUSE Labs
