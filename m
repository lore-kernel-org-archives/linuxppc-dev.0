Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2cZ5rCRzF2KC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:28:30 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id 9-v6so1218625ple.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:28:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/5] remove PURR read from context switch and timer
Date: Wed, 28 Mar 2018 19:28:14 +1000
Message-Id: <20180328092819.27015-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And some associated cleanups to the timer code as a result

Nicholas Piggin (5):
  powerpc/64: remove start_tb and accum_tb from thread_struct
  powerpc/pseries: lparcfg calculate PURR on demand
  powerpc: clockevents broadcast receiver use
    tick_receive_broadcast
  powerpc: move timer broadcast code under GENERIC_CLOCKEVENTS_BROADCAST
    ifdef
  powerpc: move a stray NMI IPI case under NMI_IPI ifdef

 arch/powerpc/include/asm/hw_irq.h        |  1 +
 arch/powerpc/include/asm/processor.h     |  4 --
 arch/powerpc/include/asm/time.h          |  9 ---
 arch/powerpc/kernel/process.c            | 18 ------
 arch/powerpc/kernel/smp.c                | 14 ++++-
 arch/powerpc/kernel/time.c               | 94 ++++++++++++++------------------
 arch/powerpc/platforms/pseries/lparcfg.c | 18 +++---
 7 files changed, 64 insertions(+), 94 deletions(-)

-- 
2.16.1
