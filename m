Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sHFT1tfXzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:59:08 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id k2-v6so1126019pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 10:59:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 0/7] Various TLB and PTE improvements
Date: Fri, 25 May 2018 03:58:46 +1000
Message-Id: <20180524175853.19695-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:
- Fixed compile error on ppc32
- Significantly reworked mm_cpumask reset patch to restore the
  lazy PID context switch optimisation, and not over-flush the
  local CPU when flushing remotes (using IPIs).
- Moved mm_cpumask reset patch to the end of the series.

Nicholas Piggin (7):
  powerpc/64s/radix: do not flush TLB when relaxing access
  powerpc/64s/radix: do not flush TLB on spurious fault
  powerpc/64s/radix: make ptep_get_and_clear_full non-atomic for the
    full case
  powerpc/64s/radix: prefetch user address in update_mmu_cache
  powerpc/64s/radix: avoid ptesync after set_pte and
    ptep_set_access_flags
  powerpc/64s/radix: optimise pte_update
  powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask

 arch/powerpc/include/asm/book3s/64/radix.h    |  37 ++--
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  12 +-
 arch/powerpc/include/asm/cacheflush.h         |  13 ++
 arch/powerpc/include/asm/tlb.h                |  13 ++
 arch/powerpc/mm/mem.c                         |   4 +-
 arch/powerpc/mm/mmu_context.c                 |   6 +-
 arch/powerpc/mm/pgtable-book3s64.c            |  13 +-
 arch/powerpc/mm/pgtable.c                     |  25 ++-
 arch/powerpc/mm/tlb-radix.c                   | 159 +++++++++++++++---
 9 files changed, 222 insertions(+), 60 deletions(-)

-- 
2.17.0
