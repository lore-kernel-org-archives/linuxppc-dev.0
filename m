Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG85fHDzDqq1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:16 +1100 (AEDT)
In-Reply-To: <20171107075309.20500-6-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,5/7] powerpc/64s/radix: Optimize flush_tlb_range
Message-Id: <3yblG84gfXz9t16@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-07 at 07:53:07 UTC, Nicholas Piggin wrote:
> Currently for radix, flush_tlb_range flushes the entire PID, because
> the Linux mm code does not tell us about page size here for THP vs
> regular pages. This is quite sub-optimal for small mremap / mprotect
> / change_protection.
> 
> So implement va range flushes with two flush passes, one for each
> page size (regular and THP). The second flush has an order of matnitude
> fewer tlbie instructions than the first, so it is a relatively small
> additional cost.
> 
> There is still room for improvement here with some changes to generic
> APIs, particularly if there are mostly THP pages to be invalidated,
> the small page flushes could be reduced.
> 
> Time to mprotect 1 page of memory (after mmap, touch):
> vanilla 2.9us   1.8us
> patched 1.2us   1.6us
> 
> Time to mprotect 30 pages of memory (after mmap, touch):
> vanilla 8.2us   7.2us
> patched 6.9us   17.9us
> 
> Time to mprotect 34 pages of memory (after mmap, touch):
> vanilla 9.1us   8.0us
> patched 9.0us   8.0us
> 
> 34 pages is the point at which the invalidation switches from va
> to entire PID, which tlbie can do in a single instruction. This is
> why in the case of 30 pages, the new code runs slower for this test.
> This is a deliberate tradeoff already present in the unmap and THP
> promotion code, the idea is that the benefit from avoiding flushing
> entire TLB for this PID on all threads in the system.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cbf09c837720f72f5e63ab7a2d331e

cheers
