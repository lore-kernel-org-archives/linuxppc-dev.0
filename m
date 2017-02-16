Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPQ0x22rszDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 05:39:13 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e4so2165573pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:39:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH 0/5] power saving wakeup changes for POWER9 MCE
Date: Fri, 17 Feb 2017 04:38:56 +1000
Message-Id: <20170216183901.28611-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is not a bare minimum fix to get the MCE power saving wakeup
working for POWER9, but I had a couple of other things it ended on
top of which made things a bit simpler.

RFC only at this stage because it needs a bit more testing. It
seems to work in simulator though when constructing an MCE from
power save wakeup (whereas it crashes with mainline).

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/64s: move remaining system reset idle code into idle_book3s.S
  powerpc/64: stop using bit in HSPRG0 to test winkle
  powerpc/64s: use alternative feature patching
  powerpc/64s: consolidate pnv_restore_hyp_resource into
    pnv_powersave_wakeup
  powerpc/64s: fix POWER9 machine check handler from stop state

 arch/powerpc/include/asm/exception-64s.h |  18 +----
 arch/powerpc/kernel/exceptions-64s.S     | 116 +++++++++++--------------------
 arch/powerpc/kernel/idle_book3s.S        |  76 ++++++++++----------
 arch/powerpc/platforms/powernv/idle.c    |  13 ----
 4 files changed, 81 insertions(+), 142 deletions(-)

-- 
2.11.0
