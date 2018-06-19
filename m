Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419P952vS7zF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:21:13 +1000 (AEST)
In-Reply-To: <20180615013837.21710-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush miss
 problem with THP
Message-Id: <419P951xwlz9s5c@ozlabs.org>
Date: Wed, 20 Jun 2018 09:21:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-15 at 01:38:37 UTC, Nicholas Piggin wrote:
> The patch 99baac21e4 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss
> problem") added a force flush mode to the mmu_gather flush, which
> unconditionally flushes the entire address range being invalidated
> (even if actual ptes only covered a smaller range), to solve a problem
> with concurrent threads invalidating the same PTEs causing them to
> miss TLBs that need flushing.
> 
> This does not work with powerpc that invalidates mmu_gather batches
> according to page size. Have powerpc flush all possible page sizes in
> the range if it encounters this concurrency condition.
> 
> Patch 4647706ebe ("mm: always flush VMA ranges affected by
> zap_page_range") does add a TLB flush for all page sizes on powerpc for
> the zap_page_range case, but that is to be removed and replaced with
> the mmu_gather flush to avoid redundant flushing. It is also thought to
> not cover other obscure race conditions:
> 
> https://lkml.kernel.org/r/BD3A0EBE-ECF4-41D4-87FA-C755EA9AB6BD@gmail.com
> 
> Hash does not have a problem because it invalidates TLBs inside the
> page table locks.
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/02390f66bd2362df114a0a0770d80e

cheers
