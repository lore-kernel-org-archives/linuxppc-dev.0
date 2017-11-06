Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6W0MwtzDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:30 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id a8so7381120pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 0/5] VA allocator fixes
Date: Mon,  6 Nov 2017 21:03:10 +1100
Message-Id: <20171106100315.29720-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Florian found a nasty corner case with the VA allocation logic
for crossing from 128TB to 512TB limit on hash, and made a
really superb report of the problem -- traces, reproducer recipes,
analysis, etc. which already mostly solved it.

The first patch in the series should solve Florian's particular
case, the next 3 are other issues with addr_limit. The last
patch is technically a cleanup but I think it's fairly important
in terms of understanding the code and also enabling some BUG
checks (when addr_limit == 0).

I have not tested these exactly on Florian's test case, but
some tests of my own behave better afterwards. Hopefully he has
time to re-test. Some careful review would be welcome too.

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/64s/hash: Fix 128TB-512TB virtual address boundary case
    allocation
  powerpc/64s/hash: Allow MAP_FIXED allocations to cross 128TB boundary
  powerpc/64s/hash: Fix fork() with 512TB process address space
  powerpc/64s/radix: Fix 128TB-512TB virtual address boundary case
    allocation
  powerpc/64s: mm_context.addr_limit is only used on hash

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
 arch/powerpc/include/asm/paca.h               |  2 +-
 arch/powerpc/kernel/asm-offsets.c             |  2 +-
 arch/powerpc/kernel/paca.c                    |  4 ++--
 arch/powerpc/kernel/setup-common.c            |  3 ++-
 arch/powerpc/mm/hugetlbpage-radix.c           | 14 +++++-------
 arch/powerpc/mm/mmap.c                        | 31 ++++++++++----------------
 arch/powerpc/mm/mmu_context_book3s64.c        |  8 +++----
 arch/powerpc/mm/slb_low.S                     |  2 +-
 arch/powerpc/mm/slice.c                       | 32 ++++++++++++++-------------
 11 files changed, 48 insertions(+), 54 deletions(-)

-- 
2.15.0
