Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGMN32ltzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:39:59 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id 67so8867701itx.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:39:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [RFC][PATCH 00/14] syscall, context switch, idle performance stuff
Date: Fri,  2 Jun 2017 17:39:32 +1000
Message-Id: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm sitting on a few performance improvements that I'm hoping to
try get polished up enough to merge, but it's taking a while, so
I juts post them out for review because I think most are at the
stage where they are good enough to start getting some reviews on.

After this series, light weight context switch (yield, threads,
same CPU) improves about 10% on my POWER8 (2.1m -> 2.3m per second
with powernv_defconfig and tick based time accounting).

Ping-pong context switches improve similarly, particularly when
you force them to go to nap. I'm still gathering up numbers. I
haven't been able to get POWER9 numbers yet.

Thanks,
Nick

Nicholas Piggin (14):
  powerpc/64s: optimize hypercall/syscall
  powerpc/64: syscall avoid restore_math call if possible
  powerpc/64s: idle move soft interrupt mask logic into C code
  powerpc/64s: process interrupts from system reset wakeup
  powerpc/64s: msgclr when handling doorbell exceptions
  powerpc/64s: branch to idle handler with virtual mode offset
  powerpc/64s: idle avoid SRR usage in idle sleep/wake paths
  powerpc/64s: idle set polling before enabling irqs
  powerpc/64s: idle read mostly for common globals
  powerpc/64: CTRL[RUN] run-latch setting optimisation
  powerpc/64s: idle no memory barrier after break from idle
  powerpc/64s: Leave IRQs hard enabled over context switch for radix
  powerpc/64: context switch can avoid reservation clear
  powerpc/64: context switch additional hwsync can be avoided

 arch/powerpc/include/asm/barrier.h       |   4 +
 arch/powerpc/include/asm/dbell.h         |  13 +++
 arch/powerpc/include/asm/exception-64s.h |  17 ++-
 arch/powerpc/include/asm/hw_irq.h        |   1 +
 arch/powerpc/include/asm/machdep.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h    |   3 +
 arch/powerpc/include/asm/processor.h     |   8 +-
 arch/powerpc/kernel/asm-offsets.c        |   1 +
 arch/powerpc/kernel/entry_64.S           |  94 +++++++++------
 arch/powerpc/kernel/exceptions-64s.S     | 191 ++++++++++++++++++++++++-------
 arch/powerpc/kernel/idle_book3s.S        | 135 ++++++----------------
 arch/powerpc/kernel/process.c            |  30 +++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   8 +-
 arch/powerpc/platforms/powernv/idle.c    | 122 ++++++++++++++++++--
 arch/powerpc/platforms/powernv/subcore.c |   3 +-
 drivers/cpuidle/cpuidle-powernv.c        |  37 +++---
 drivers/cpuidle/cpuidle-pseries.c        |  22 ++--
 kernel/sched/core.c                      |   9 ++
 18 files changed, 469 insertions(+), 230 deletions(-)

-- 
2.11.0
