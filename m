Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblGC2sFvzDqpj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:19 +1100 (AEDT)
In-Reply-To: <20171107075309.20500-7-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 6/7] powerpc/64s/radix: Introduce local single page ceiling for TLB
 range flush
Message-Id: <3yblGB5wqFz9t1t@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-07 at 07:53:08 UTC, Nicholas Piggin wrote:
> The single page flush ceiling is the cut-off point at which we switch
> from invalidating individual pages, to invalidating the entire process
> address space in response to a range flush.
> 
> Introduce a local variant of this heuristic because local and global
> tlbie have significantly different properties:
> - Local tlbiel requires 128 instructions to invalidate a PID, global
>   tlbie only 1 instruction.
> - Global tlbie instructions are expensive broadcast operations.
> 
> The local ceiling has been made much higher, 2x the number of
> instructions required to invalidate the entire PID (i.e., 256 pages).
> 
>      Time to mprotect N pages of memory (after mmap, touch), local invalidate:
>      N           32     34      64     128     256     512
>      vanilla  7.4us  9.0us  14.6us  26.4us  50.2us  98.3us
>      patched  7.4us  7.8us  13.8us  26.4us  51.9us  98.3us
> 
> The behaviour of both is identical at N=32 and N=512. Between there,
> the vanilla kernel does a PID invalidate and the patched kernel does
> a va range invalidate.
> 
> At N=128, these require the same number of tlbiel instructions, so
> the patched version can be sen to be cheaper when < 128, and more
> expensive when > 128. However this does not well capture the cost
> of invalidated TLB.
> 
> The additional cost at 256 pages does not seem prohibitive. It may
> be the case that increasing the limit further would continue to be
> beneficial to avoid invalidating all of the process's TLB entries.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6f27951fdf84a6edca3ea14077268

cheers
