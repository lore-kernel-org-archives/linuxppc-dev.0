Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXqqt34YxzDr62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 04:27:53 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id x7so4739172pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:27:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 0/5] powerpc VA allocator fixes for 512TB support
Date: Fri, 10 Nov 2017 04:27:35 +1100
Message-Id: <20171109172740.19681-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After clarifying the intended semantics, the previous patch series
went the wrong way with MAP_FIXED handling, so I fixed that.

This series is not quite ready for merge. I prefer to see what x86
does exactly because it also has some fixes to make. But time is
becoming short before 4.14, so I'd like to get some more review and
testing so we can be ready.

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/64s/hash: Fix 128TB-512TB virtual address boundary case
    allocation
  powerpc/64s/hash: Fix fork() with 512TB process address space
  powerpc/64s/hash: Allow MAP_FIXED allocations to cross 128TB boundary
  powerpc/64s/radix: Fix 128TB-512TB virtual address boundary case
    allocation
  powerpc/64s: mm_context.addr_limit is only used on hash

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
 arch/powerpc/include/asm/paca.h               |  2 +-
 arch/powerpc/kernel/asm-offsets.c             |  2 +-
 arch/powerpc/kernel/paca.c                    |  4 +-
 arch/powerpc/kernel/setup-common.c            |  3 +-
 arch/powerpc/mm/hugetlbpage-radix.c           | 20 +++++----
 arch/powerpc/mm/mmap.c                        | 49 ++++++++++-----------
 arch/powerpc/mm/mmu_context_book3s64.c        |  8 ++--
 arch/powerpc/mm/slb_low.S                     |  2 +-
 arch/powerpc/mm/slice.c                       | 62 +++++++++++++--------------
 11 files changed, 79 insertions(+), 77 deletions(-)

-- 
2.15.0
