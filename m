Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rG1nLYzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:41:49 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h75so6053022pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:41:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/6] watchdog and NMI IPI locking improvements
Date: Wed,  9 Aug 2017 22:41:20 +1000
Message-Id: <20170809124126.28907-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It was noticed that the watchdog was causing hangs and lockups in
some cases, hammering on the watchdog lock, so I've found a few
other improvements and bugs. Thanks to Paulus for finding the problem
and fixing the lock primitives (I fixed it a bit differently but the
idea is his).

Thanks,
Nick

Nicholas Piggin (6):
  powerpc: NMI IPI improve lock primitive
  powerpc/watchdog: Improve watchdog lock primitive
  powerpc/watchdog: Moderate touch_nmi_watchdog overhead
  powerpc/watchdog: Fix final-check recovered case
  powerpc/watchdog: Fix marking of stuck CPUs
  powerpc/watchdog: add locking around init/exit functions

 arch/powerpc/kernel/smp.c      |  6 +++---
 arch/powerpc/kernel/watchdog.c | 49 +++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.13.3
