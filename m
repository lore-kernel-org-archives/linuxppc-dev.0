Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblGD14pczDqpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:20 +1100 (AEDT)
In-Reply-To: <20171107075309.20500-8-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 7/7] powerpc/64s/radix: Improve TLB flushing for page table freeing
Message-Id: <3yblGC6FSSz9sPs@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-07 at 07:53:09 UTC, Nicholas Piggin wrote:
> Unmaps that free page tables always flush the entire PID, which is
> sub-optimal. Provide TLB range flushing with an additional PWC flush
> that can be use for va range invalidations with PWC flush.
> 
>      Time to munmap N pages of memory including last level page table
>      teardown (after mmap, touch), local invalidate:
>      N           1       2      4      8     16     32     64
>      vanilla  3.2us  3.3us  3.4us  3.6us  4.1us  5.2us  7.2us
>      patched  1.4us  1.5us  1.7us  1.9us  2.6us  3.7us  6.2us
> 
>      Global invalidate:
>      N           1       2      4      8     16      32     64
>      vanilla  2.2us  2.3us  2.4us  2.6us  3.2us   4.1us  6.2us
>      patched  2.1us  2.5us  3.4us  5.2us  8.7us  15.7us  6.2us
> 
> Local invalidates get much better across the board. Global ones have
> the same issue where multiple tlbies for va flush do get slower than
> the single tlbie to invalidate the PID. None of this test captures
> the TLB benefits of avoiding killing everything.
> 
> Global gets worse, but it is brought in to line with global invalidate
> for munmap()s that do not free page tables.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0b2f5a8a792755c88bd786f89712a9

cheers
