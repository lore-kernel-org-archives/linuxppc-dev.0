Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x22b.google.com (mail-pl0-x22b.google.com
 [IPv6:2607:f8b0:400e:c01::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcw55pb9zF1Gj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:25:25 +1100 (AEDT)
Received: by mail-pl0-x22b.google.com with SMTP id f23-v6so11826427plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:25:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/10] powerpc/mm/slice: improve slice speed and stack use
Date: Tue,  6 Mar 2018 23:24:57 +1000
Message-Id: <20180306132507.10649-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since this was last posted, it's been ported on top of Christophe's
8xx slice implementation that is merged in powerpc next, also taken
into account some feedback and bugs from Aneesh and Christophe --
thanks.

A few significant changes, first is refactoring slice_set_user_psize,
which makes it more obvious how the slice state is initialized, which
makes it easier to reason about using dynamic high slice size limits I
think.

Second is a significant change to how the slice masks are kept. No
longer are they bolted on the side and hit with a big recalculation
call that redoes everything whenever something changes. Now they are
just maintained as part of slice conversion.

This now passes vm selftests including the 128TB boundary case tests.
I also added a process microbenchmark and redid benchmarks and stack
measurements.

Overall on POWER8, this series increases vfork+exec+exit
microbenchmark rate by 15.6%, and mmap+munmap rate by 81%. Slice
code/data size is reduced by 1kB, and max stack overhead through
slice_get_unmapped_area call goes rom 992 to 448 bytes. The cost is
288 bytes added to the mm_context_t per mm for the slice masks on
Book3S.

Thanks,
Nick

Nicholas Piggin (10):
  selftests/powerpc: add process creation benchmark
  powerpc/mm/slice: Simplify and optimise slice context initialisation
  powerpc/mm/slice: tidy lpsizes and hpsizes update loops
  powerpc/mm/slice: pass pointers to struct slice_mask where possible
  powerpc/mm/slice: implement a slice mask cache
  powerpc/mm/slice: implement slice_check_range_fits
  powerpc/mm/slice: Switch to 3-operand slice bitops helpers
  powerpc/mm/slice: Use const pointers to cached slice masks where
    possible
  powerpc/mm/slice: use the dynamic high slice size to limit bitmap
    operations
  powerpc/mm/slice: remove radix calls to the slice code

 arch/powerpc/include/asm/book3s/64/mmu.h           |  18 +
 arch/powerpc/include/asm/hugetlb.h                 |   9 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  14 +
 arch/powerpc/include/asm/slice.h                   |   8 +-
 arch/powerpc/mm/hugetlbpage.c                      |   5 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |   9 +-
 arch/powerpc/mm/mmu_context_nohash.c               |   5 +-
 arch/powerpc/mm/slice.c                            | 458 +++++++++++----------
 .../selftests/powerpc/benchmarks/.gitignore        |   2 +
 .../testing/selftests/powerpc/benchmarks/Makefile  |   8 +-
 .../selftests/powerpc/benchmarks/exec_target.c     |   5 +
 tools/testing/selftests/powerpc/benchmarks/fork.c  | 339 +++++++++++++++
 12 files changed, 632 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/exec_target.c
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/fork.c

-- 
2.16.1
