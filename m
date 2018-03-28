Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BBdp2WgkzF2Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:30:05 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id p9-v6so1802766pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 08:30:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 0/3] powerpc tlbie reductions again
Date: Thu, 29 Mar 2018 01:29:48 +1000
Message-Id: <20180328152951.6422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Last time this came up, there was concern about whether we can trim
the mm cpumask, and what concurrency there is vs use_mm(). I've had
more of a look and still think this is okay. I haven't thought of a
good way to add debug checks to ensure it though.

When doing a parallel kernel build on a 2 socket P9 system, this
series causes tlbie (broadcast) to go from 1.37 million (22k/sec) to
181 thousand (3k/sec).

tlbiel (local) flushes increase from 20.2 to 23.7 million. Due to
requiring 128 tlbiel (vs 1 tlbie) to flush a PID, and also we set the
cutoff higher before we switch from va range to full PID flush, when
doing tlbiel.

End result performance was very little changed, very tiny improvement
maybe but well under 1%. Kernel compile mostly stays off the
interconnect, and this is a small system, and without nMMU
involvement. Any of these factors could make broadcast tlbie reduction
more important.

Remaining work - ensuring correctness of this stuff, implementations
for hash, understanding and testing nMMU cases better, using IPIs for
some/all types of invalidations, then possibly looking at doing
something more fancy with the PID allocator.

Nicholas Piggin (3):
  powerpc/64s: do not flush TLB when relaxing access
  powerpc/64s/radix: reset mm_cpumask for single thread process when
    possible
  powerpc/64s: always flush non-local CPUs from single threaded mms

 arch/powerpc/include/asm/mmu_context.h | 33 ++++++++++----
 arch/powerpc/include/asm/tlb.h         |  7 +++
 arch/powerpc/mm/pgtable-book3s64.c     |  1 -
 arch/powerpc/mm/pgtable.c              |  3 +-
 arch/powerpc/mm/tlb-radix.c            | 78 +++++++++++++++++++++++++---------
 5 files changed, 92 insertions(+), 30 deletions(-)

-- 
2.16.1
