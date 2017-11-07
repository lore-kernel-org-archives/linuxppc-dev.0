Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWJnv6QVjzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 17:05:55 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id a8so9580661pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 22:05:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 0/7] powerpc/64s/radix TLB flush fixes and performance
 improvements
Date: Tue,  7 Nov 2017 17:05:36 +1100
Message-Id: <20171107060543.17309-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the v1/RFC, I pulled the first 2 fix patches into this series,
and rediffed to powerpc merge branch. Dropped the final 2 patches
which were not completely agreed upon and baked.

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/64s/radix: tlbie improve preempt handling
  powerpc/64s/radix: Fix process table entry cache invalidation
  powerpc/64s/radix: optimize TLB range flush barriers
  powerpc/64s/radix: Implement _tlbie(l)_va_range flush functions
  powerpc/64s/radix: Optimize flush_tlb_range
  powerpc/64s/radix: Introduce local single page ceiling for TLB range
    flush
  powerpc/64s/radix: Improve TLB flushing for page table freeing

 arch/powerpc/include/asm/mmu_context.h |   4 +
 arch/powerpc/mm/mmu_context_book3s64.c |  25 ++-
 arch/powerpc/mm/tlb-radix.c            | 318 ++++++++++++++++++++++++---------
 3 files changed, 256 insertions(+), 91 deletions(-)

-- 
2.15.0
