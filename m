Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG31xsFzDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:11 +1100 (AEDT)
In-Reply-To: <20171107075309.20500-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,3/7] powerpc/64s/radix: optimize TLB range flush barriers
Message-Id: <3yblG26llnz9sRg@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-07 at 07:53:05 UTC, Nicholas Piggin wrote:
> Short range flushes issue a sequences of tlbie(l) instructions for
> individual effective addresses. These do not all require individual
> barrier sequences, only one covering all tlbie(l) instructions.
> 
> Commit f7327e0ba3 ("powerpc/mm/radix: Remove unnecessary ptesync")
> made a similar optimization for tlbiel for PID flushing.
> 
> For tlbie, the ISA says:
> 
>     The tlbsync instruction provides an ordering function for the
>     effects of all tlbie instructions executed by the thread executing
>     the tlbsync instruction, with respect to the memory barrier
>     created by a subsequent ptesync instruction executed by the same
>     thread.
> 
> Time to munmap 30 pages of memory (after mmap, touch):
>          local   global
> vanilla  10.9us  22.3us
> patched   3.4us  14.4us
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/14001c60939a754717893672209160

cheers
