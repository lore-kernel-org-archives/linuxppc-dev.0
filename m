Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y0Gq07xjzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:01:38 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id z1-v6so4126768pgv.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 03:01:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v4 0/7] Various TLB and PTE improvements
Date: Fri,  1 Jun 2018 20:01:14 +1000
Message-Id: <20180601100121.393-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:
- Rebased on top of Aneesh's series "[PATCH V2 1/4] powerpc/mm/hugetlb:
  Update huge_ptep_set_access_flags to call __ptep_set_access_flags"

Thanks,
Nick

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

 arch/powerpc/include/asm/book3s/64/radix.h    |  54 +++---
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  12 +-
 arch/powerpc/include/asm/cacheflush.h         |  13 ++
 arch/powerpc/include/asm/tlb.h                |  13 ++
 arch/powerpc/mm/mem.c                         |   4 +-
 arch/powerpc/mm/mmu_context.c                 |   6 +-
 arch/powerpc/mm/pgtable-book3s64.c            |   3 +-
 arch/powerpc/mm/pgtable-radix.c               |   9 +-
 arch/powerpc/mm/tlb-radix.c                   | 159 +++++++++++++++---
 9 files changed, 217 insertions(+), 56 deletions(-)

-- 
2.17.0
