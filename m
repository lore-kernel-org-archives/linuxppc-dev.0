Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pNSw0Gl3zDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 10:43:59 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id a14-v6so5408919pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 17:43:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/7] Various TLB and PTE improvements
Date: Sun, 20 May 2018 10:43:40 +1000
Message-Id: <20180520004347.19508-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've posted most of these separately at one time or another but I
will send them as a series, there have been some bug fixes and
changelog and comment improvements, and got some more numbers.

Most of the patches are logically independent (except 2 and 3 AFAIKS).

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/64s/radix: do not flush TLB on spurious fault
  powerpc/64s/radix: reset mm_cpumask for single thread process when
    possible
  powerpc/64s/radix: make single threaded mms always flush all translations
    from non-local CPUs
  powerpc/64s/radix: make ptep_get_and_clear_full non-atomic for the
    full case
  powerpc/64s/radix: optimise pte_update
  powerpc/64s/radix: prefetch user address in update_mmu_cache
  powerpc/64s/radix: avoid ptesync after set_pte and
    ptep_set_access_flags

 arch/powerpc/include/asm/book3s/64/radix.h    | 37 ++++----
 arch/powerpc/include/asm/book3s/64/tlbflush.h | 12 ++-
 arch/powerpc/include/asm/cacheflush.h         | 13 +++
 arch/powerpc/include/asm/mmu_context.h        | 19 ++++
 arch/powerpc/include/asm/tlb.h                |  8 ++
 arch/powerpc/mm/mem.c                         |  4 +-
 arch/powerpc/mm/mmu_context.c                 |  6 +-
 arch/powerpc/mm/pgtable-book3s64.c            |  3 +-
 arch/powerpc/mm/tlb-radix.c                   | 89 ++++++++++++++-----
 9 files changed, 143 insertions(+), 48 deletions(-)

-- 
2.17.0
