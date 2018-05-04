Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKL5CHBzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:19:49 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id j11-v6so15861823pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:19:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/11] assortment of timer, watchdog, interrupt
Date: Sat,  5 May 2018 03:19:24 +1000
Message-Id: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are a bunch of small things I've built up from looking
through code trying to track down some rare irq latency issues.

None of them actually fix any long irq latencies, but they
hopefully make the code a bit neater, get rid of some small
glitches, increase watchdog coverage etc.

Ben spotted a bug with the first patch last time I posted,
that's fixed.

Thanks,
Nick


Nicholas Piggin (11):
  powerpc/64: irq_work avoid interrupt when called with hardware irqs
    enabled
  powerpc/pseries: put cede MSR[EE] check under IRQ_SOFT_MASK_DEBUG
  powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely
  powerpc/64s: micro-optimise __hard_irq_enable() for mtmsrd L=1 support
  powerpc/64: remove start_tb and accum_tb from thread_struct
  powerpc/pseries: lparcfg calculate PURR on demand
  powerpc: generic clockevents broadcast receiver call
    tick_receive_broadcast
  powerpc: allow soft-NMI watchdog to cover timer interrupts with large
    decrementers
  powerpc: move timer broadcast code under GENERIC_CLOCKEVENTS_BROADCAST
    ifdef
  powerpc: move a stray NMI IPI case under NMI_IPI ifdef
  powerpc/time: account broadcast timer event interrupts separately

 arch/powerpc/include/asm/hardirq.h        |   1 +
 arch/powerpc/include/asm/hw_irq.h         |  15 ++-
 arch/powerpc/include/asm/plpar_wrappers.h |   8 +-
 arch/powerpc/include/asm/processor.h      |   4 -
 arch/powerpc/include/asm/time.h           |   9 --
 arch/powerpc/kernel/entry_64.S            |   8 ++
 arch/powerpc/kernel/exceptions-64s.S      |   5 +-
 arch/powerpc/kernel/irq.c                 |  34 +++--
 arch/powerpc/kernel/process.c             |  18 ---
 arch/powerpc/kernel/smp.c                 |  14 ++-
 arch/powerpc/kernel/time.c                | 143 +++++++++++++---------
 arch/powerpc/platforms/pseries/lparcfg.c  |  18 +--
 12 files changed, 155 insertions(+), 122 deletions(-)

-- 
2.17.0
