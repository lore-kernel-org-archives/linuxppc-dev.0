Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bV1SLwzF1sR
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:22 +1100 (AEDT)
In-Reply-To: <20180331115138.5731-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64e: Fix oops due to deferral of paca allocation
Message-Id: <40D0bQ264Xz9s3x@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-03-31 at 11:51:38 UTC, Michael Ellerman wrote:
> On 64-bit Book3E systems, in setup_tlb_core_data() we reference other
> CPUs pacas. But in commit 59f577743d71 ("powerpc/64: Defer paca
> allocation until memory topology is discovered") the allocation of
> non-boot-CPU pacas was deferred until later in boot.
> 
> This leads to an oops:
> 
>   CPU maps initialized for 1 thread per core
>   Unable to handle kernel paging request for data at address 0x8888888888888918
>   Faulting instruction address: 0xc000000000e2f0d0
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   NIP .setup_tlb_core_data+0xdc/0x160
>   Call Trace:
>     .setup_tlb_core_data+0x5c/0x160 (unreliable)
>     .setup_arch+0x80/0x348
>     .start_kernel+0x7c/0x598
>     start_here_common+0x1c/0x40
> 
> Luckily setup_tlb_core_data() is called immediately prior to
> smp_setup_pacas(). So simply switching their order is sufficient to
> fix the oops and seems unlikely to have any other unwanted side
> effects.
> 
> Fixes: 59f577743d71 ("powerpc/64: Defer paca allocation until memory topology is discovered")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1d0afc0d5a7c281f8ced3bd39f61f3

cheers
