Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4205sW1ddPzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:20:47 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h69-v6so572632pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:20:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] mm: dirty/accessed pte optimisations
Date: Tue, 28 Aug 2018 21:20:31 +1000
Message-Id: <20180828112034.30875-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are some patches that didn't get much comment last time. It
looks like x86 might benefit too though, so that might get people
interested. 

I improved changelogs and added some comments, but no real logic
changes.

I hope I didn't get the x86 numbers wrong, they're more significant
than I expected so it could quite well be a problem with my test
(corrections welcome). Any data from other archs would be interesting
too.

Andrew perhaps if there aren't objections these could go in mm for
a while. 

Thanks,
Nick


Nicholas Piggin (3):
  mm/cow: don't bother write protectig already write-protected huge
    pages
  mm/cow: optimise pte dirty/accessed bits handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 mm/huge_memory.c | 24 +++++++++++++++---------
 mm/memory.c      | 18 ++++++++++--------
 mm/vmscan.c      |  8 ++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.18.0
