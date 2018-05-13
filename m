Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40k9cx4ZmpzF3Rc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 14:21:20 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id x145-v6so4046589pgx.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 21:21:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] powerpc/64s/radix pte manipulation optimisations
Date: Sun, 13 May 2018 14:21:03 +1000
Message-Id: <20180513042106.15470-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a few patches which I'm sure will cause a lot of concern, but
I think now is the time to have it out and really start optimising
these things as far as we can. Radix MMU has been stable for quite
some time, and distros have made releases with the more conservative
flushes and barriers and updates etc.

If we decide not to do any of these things, we can document why not
so it becomes easier to revisit.

With these patches, plus the TLB flush reduction patches earlier,
plus a few generic mm patches that I haven't posted yet, fork/exec
benchmark from selftests increases performance by 11%.

A test which mprotects 16GB of memory to readonly, then reads a byte
from each page, then protects read/write and updates a byte from each
page, then repeats, is more tha 2x faster. Mostly due to reduced TLB
flushing, barriers, and atomics from these two patch sets.

Nicholas Piggin (3):
  powerpc/64s/radix: make ptep_get_and_clear_full non-atomic for the
    full case
  powerpc/64s/radix: avoid ptesync after set_pte and
    ptep_set_access_flags
  powerpc/64s/radix: optimise pte_update

 arch/powerpc/include/asm/book3s/64/radix.h | 37 +++++++++-------------
 arch/powerpc/mm/mmu_context.c              |  6 ++--
 arch/powerpc/mm/tlb-radix.c                | 11 ++++++-
 3 files changed, 29 insertions(+), 25 deletions(-)

-- 
2.17.0
