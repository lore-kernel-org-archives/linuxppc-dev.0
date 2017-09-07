Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3MK63d4zDrWM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:13 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id d8so5054775pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 0/8] Further radix TLB flush optimisations
Date: Fri,  8 Sep 2017 00:51:40 +1000
Message-Id: <20170907145148.24398-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a bit more TLB flush work that mostly attempt to
improve range flushes by reducing barriers, and reducing
the cases we resort to flushing the entire PID.

I haven't done much benchmarking to get good numbers yet
for the exact heuristics settings, just interested in
comments for the overall idea.

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/64s/radix: Fix theoretical process table entry cache
    invalidation
  powerpc/64s/radix: tlbie improve preempt handling
  powerpc/64s/radix: optimize TLB range flush barriers
  powerpc/64s/radix: Implement _tlbie(l)_va_range flush functions
  powerpc/64s/radix: Introduce local single page ceiling for TLB range
    flush
  powerpc/64s/radix: Optimize flush_tlb_range
  powerpc/64s/radix: Improve TLB flushing for unmaps that free a page
    table
  powerpc/64s/radix: Only flush local TLB for spurious fault flushes

 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   7 +-
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  11 +
 arch/powerpc/include/asm/mmu_context.h             |   4 +
 arch/powerpc/mm/mmu_context_book3s64.c             |  23 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   5 +-
 arch/powerpc/mm/pgtable.c                          |   2 +-
 arch/powerpc/mm/tlb-radix.c                        | 263 +++++++++++++++------
 7 files changed, 234 insertions(+), 81 deletions(-)

-- 
2.13.3
