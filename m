Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3C2BBjzDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:51 +1000 (AEST)
In-Reply-To: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/mm: Check memblock_add against MAX_PHYSMEM_BITS
 range
Message-Id: <41Zg3B6ywcz9s1x@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-21 at 08:31:57 UTC, "Aneesh Kumar K.V" wrote:
> With SPARSEMEM config enabled, we make sure that we don't add sections beyond
> MAX_PHYSMEM_BITS range. This results in not building vmemmap mapping for
> range beyond max range. But our memblock layer looks the device tree and create
> mapping for the full memory range. Prevent this by checking against
> MAX_PHSYSMEM_BITS when doing memblock_add.
> 
> We don't do similar check for memeblock_reserve_range. If reserve range is beyond
> MAX_PHYSMEM_BITS we expect that to be configured with 'nomap'. Any other
> reserved range should come from existing memblock ranges which we already
> filtered while adding.
> 
> This avoids crash as below when running on a system with system ram config above
> MAX_PHSYSMEM_BITS
> 
>  Unable to handle kernel paging request for data at address 0xc00a001000000440
>  Faulting instruction address: 0xc000000001034118
>  cpu 0x0: Vector: 300 (Data Access) at [c00000000124fb30]
>      pc: c000000001034118: __free_pages_bootmem+0xc0/0x1c0
>      lr: c00000000103b258: free_all_bootmem+0x19c/0x22c
>      sp: c00000000124fdb0
>     msr: 9000000002001033
>     dar: c00a001000000440
>   dsisr: 40000000
>    current = 0xc00000000120dd00
>    paca    = 0xc000000001f60000^I irqmask: 0x03^I irq_happened: 0x01
>      pid   = 0, comm = swapper
>  [c00000000124fe20] c00000000103b258 free_all_bootmem+0x19c/0x22c
>  [c00000000124fee0] c000000001010a68 mem_init+0x3c/0x5c
>  [c00000000124ff00] c00000000100401c start_kernel+0x298/0x5e4
>  [c00000000124ff90] c00000000000b57c start_here_common+0x1c/0x520
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6aba0c84ec474534bbae3675e95464

cheers
