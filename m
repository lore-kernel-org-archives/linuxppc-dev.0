Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v83Y2bN0zDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:42:16 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id z4-v6so1519250pgv.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 02:42:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 0/5] rewriting SLB miss handler in C
Date: Mon, 20 Aug 2018 19:41:55 +1000
Message-Id: <20180820094200.13003-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'd like to rewrite the SLB miss handlers in C for maintainability
and ability to more easily extend the code.

I have not benchmarked it yet but obviously setting up the stack
and going to C code rather than carefully hand optimised assembly
is likely to slow down SLB misses by a reasonable amount. So I've
started looked at a few basic optimisations we can make to justify
this change. There is still more that can be done, but SLB misses
have been reduced significantly, and with more tuning and optimization
I think we could bring it down quite a bit more.

I'm trying to get the first patch solid, and it is the big change so
would really appreciate review and commets on that. Other patches are
not quite polished but comments would still be welcome on those (keep
in mind they are obviously not all polished).

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/64s/hash: convert SLB miss handlers to C
  powerpc/64s/hash: remove user SLB data from the paca
  powerpc/64s/hash: remove the first vmalloc segment from the bolted SLB
  powerpc/64s/hash: Add SLB allocation bitmaps
  powerpc/64s/hash: Add a SLB preload cache

 arch/powerpc/include/asm/asm-prototypes.h     |   2 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   3 +-
 arch/powerpc/include/asm/paca.h               |  19 +-
 arch/powerpc/include/asm/thread_info.h        |   4 +
 arch/powerpc/kernel/asm-offsets.c             |   9 -
 arch/powerpc/kernel/exceptions-64s.S          | 200 ++-------
 arch/powerpc/kernel/paca.c                    |  21 -
 arch/powerpc/kernel/process.c                 |   6 +
 arch/powerpc/mm/Makefile                      |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |  46 +--
 arch/powerpc/mm/mmu_context.c                 |   3 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |  10 +-
 arch/powerpc/mm/slb.c                         | 382 +++++++++++-------
 arch/powerpc/mm/slb_low.S                     | 338 ----------------
 arch/powerpc/mm/slice.c                       |  29 +-
 arch/powerpc/xmon/xmon.c                      |   2 +-
 16 files changed, 328 insertions(+), 748 deletions(-)
 delete mode 100644 arch/powerpc/mm/slb_low.S

-- 
2.17.0
