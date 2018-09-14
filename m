Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BfcX303JzF3Wt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:08 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id x17-v6so4479637pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 00/12] SLB miss conversion to C, and SLB optimisations
Date: Sat, 15 Sep 2018 01:30:44 +1000
Message-Id: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a repost of the SLB conversion to C, no real change since last
post. But given that slows down the SLB miss handler, I promised some
optimisations could be made to mitigate that.

The two main optimisations after the C conversion are the SLB alloation
bitmaps, and the preload cache.

Thanks,
Nick

Nicholas Piggin (12):
  powerpc/64s/hash: Fix stab_rr off by one initialization
  powerpc/64s/hash: avoid the POWER5 < DD2.1 slb invalidate workaround
    on POWER8/9
  powerpc/64s/hash: move POWER5 < DD2.1 slbie workaround where it is
    needed
  powerpc/64s/hash: remove the vmalloc segment from the bolted SLB
  powerpc/64s/hash: Use POWER6 SLBIA IH=1 variant in switch_slb
  powerpc/64s/hash: Use POWER9 SLBIA IH=3 variant in switch_slb
  powerpc/64s/hash: convert SLB miss handlers to C
  powerpc/64s/hash: remove user SLB data from the paca
  powerpc/64s/hash: SLB allocation status bitmaps
  powerpc/64s: xmon do not dump hash fields when using radix mode
  powerpc/64s/hash: provide arch_setup_exec hooks for hash slice setup
  powerpc/64s/hash: Add a SLB preload cache

 arch/powerpc/include/asm/asm-prototypes.h     |   2 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   5 +-
 arch/powerpc/include/asm/exception-64s.h      |   8 -
 arch/powerpc/include/asm/paca.h               |  19 +-
 arch/powerpc/include/asm/processor.h          |   1 +
 arch/powerpc/include/asm/slice.h              |   1 +
 arch/powerpc/include/asm/thread_info.h        |  11 +
 arch/powerpc/kernel/asm-offsets.c             |  11 +-
 arch/powerpc/kernel/entry_64.S                |   2 +
 arch/powerpc/kernel/exceptions-64s.S          | 202 ++----
 arch/powerpc/kernel/paca.c                    |  21 -
 arch/powerpc/kernel/process.c                 |  16 +
 arch/powerpc/mm/Makefile                      |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |  46 +-
 arch/powerpc/mm/mmu_context.c                 |   3 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |   9 +
 arch/powerpc/mm/slb.c                         | 596 ++++++++++++------
 arch/powerpc/mm/slb_low.S                     | 335 ----------
 arch/powerpc/mm/slice.c                       |  43 +-
 arch/powerpc/xmon/xmon.c                      |  37 +-
 20 files changed, 540 insertions(+), 830 deletions(-)
 delete mode 100644 arch/powerpc/mm/slb_low.S

-- 
2.18.0
