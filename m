Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414h5P5wq0zF4MD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 17:16:41 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id e11-v6so11030165pgq.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:16:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 0/3] couple of TLB flush optimisations
Date: Tue, 12 Jun 2018 17:16:18 +1000
Message-Id: <20180612071621.26775-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm just looking around TLB flushing and noticed a few issues with
the core code. The first one seems pretty straightforward, unless I
missed something, but the TLB flush pattern after the revert seems
okay.

The second one might be a bit more interesting for other architectures
and the big comment in include/asm-generic/tlb.h and linked mail from
Linus gives some good context.

I suspect mmu notifiers should use this precise TLB range too, because
I don't see how they could care about the page table structure under
the mapping. Although I only use it in powerpc so far.

Comments?

Thanks,
Nick

Nicholas Piggin (3):
  Revert "mm: always flush VMA ranges affected by zap_page_range"
  mm: mmu_gather track of invalidated TLB ranges explicitly for more
    precise flushing
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/mm/tlb-radix.c |  7 +++++--
 include/asm-generic/tlb.h   | 27 +++++++++++++++++++++++++--
 mm/memory.c                 | 18 ++++--------------
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.17.0
