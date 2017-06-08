Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsJt5Xp2zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:05:18 +1000 (AEST)
In-Reply-To: <1496744637-24585-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [v2] powerpc/numa: Fix percpu allocations to be NUMA aware
Message-Id: <3wjsJt29cNz9sD5@ozlabs.org>
Date: Thu,  8 Jun 2017 14:05:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-06 at 10:23:57 UTC, Michael Ellerman wrote:
> In commit 8c272261194d ("powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID"), we
> switched to the generic implementation of cpu_to_node(), which uses a percpu
> variable to hold the NUMA node for each CPU.
> 
> Unfortunately we neglected to notice that we use cpu_to_node() in the allocation
> of our percpu areas, leading to a chicken and egg problem. In practice what
> happens is when we are setting up the percpu areas, cpu_to_node() reports that
> all CPUs are on node 0, so we allocate all percpu areas on node 0.
> 
> This is visible in the dmesg output, as all pcpu allocs being in group 0:
> 
>   pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
>   pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
>   pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
>   pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31
>   pcpu-alloc: [0] 32 33 34 35 [0] 36 37 38 39
>   pcpu-alloc: [0] 40 41 42 43 [0] 44 45 46 47
> 
> To fix it we need an early_cpu_to_node() which can run prior to percpu being
> setup. We already have the numa_cpu_lookup_table we can use, so just plumb it
> in. With the patch dmesg output shows two groups, 0 and 1:
> 
>   pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
>   pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
>   pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
>   pcpu-alloc: [1] 24 25 26 27 [1] 28 29 30 31
>   pcpu-alloc: [1] 32 33 34 35 [1] 36 37 38 39
>   pcpu-alloc: [1] 40 41 42 43 [1] 44 45 46 47
> 
> We can also check the data_offset in the paca of various CPUs, with the fix we
> see:
> 
>   CPU 0:  data_offset = 0x0ffe8b0000
>   CPU 24: data_offset = 0x1ffe5b0000
> 
> And we can see from dmesg that CPU 24 has an allocation on node 1:
> 
>   node   0: [mem 0x0000000000000000-0x0000000fffffffff]
>   node   1: [mem 0x0000001000000000-0x0000001fffffffff]
> 
> Cc: stable@vger.kernel.org # v3.16+
> Fixes: 8c272261194d ("powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/ba4a648f12f4cd0a8003dd229b6ca8

cheers
