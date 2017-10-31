Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR20Z5YRVzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:45:18 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b192so13850871pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 23:45:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/7] powerpc/64s/radix TLB flush performance improvements
Date: Tue, 31 Oct 2017 16:44:57 +1000
Message-Id: <20171031064504.25245-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a random mix of performance improvements for radix TLB flushing
code. The main aims are to reduce the amount of translation that gets
invalidated, and to reduce global flushes where we can do local.

To that end, a parallel kernel compile benchmark using powerpc:tlbie
tracepoint shows a reduction in tlbie instructions from about 290,000
to 80,000, and a reduction in tlbiel instructions from 49,500,000 to
15,000,000. Looks great, but unfortunately does not translate to a
statistically significant performance improvement! The needle on TLB
misses does not move much, I suspect because a lot of the flushing is
done a startup and shutdown, and because a significant cost of TLB
flushing itself is in the barriers.

I have some microbenchmarks in the individual patches, and should
start looking around for some more interesting workloads. I think
most of this series is pretty obviously the right thing to do though.

This goes on top of the 3 radix TLB fixes I sent out earlier.

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/64s/radix: optimize TLB range flush barriers
  powerpc/64s/radix: Implement _tlbie(l)_va_range flush functions
  powerpc/64s/radix: Optimize flush_tlb_range
  powerpc/64s/radix: Introduce local single page ceiling for TLB range
    flush
  powerpc/64s/radix: Improve TLB flushing for page table freeing
  powerpc/64s/radix: reset mm_cpumask for single thread process when
    possible
  powerpc/64s/radix: Only flush local TLB for spurious fault flushes

 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   5 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  11 +
 arch/powerpc/include/asm/mmu_context.h             |  19 ++
 arch/powerpc/mm/pgtable-book3s64.c                 |   5 +-
 arch/powerpc/mm/pgtable.c                          |   2 +-
 arch/powerpc/mm/tlb-radix.c                        | 363 ++++++++++++++++-----
 6 files changed, 325 insertions(+), 80 deletions(-)

-- 
2.15.0.rc2
