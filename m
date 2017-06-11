Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wlrPj2S46zDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 19:31:21 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y7so13352463pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 02:31:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 00/14 v2] idle performance improvements
Date: Sun, 11 Jun 2017 19:30:48 +1000
Message-Id: <20170611093102.2025-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I rebased this on the powerpc next tree.

A couple of things are changed since last post:

- Patch 1 now properly accounts for the fact the powernv idle
  wakeups do not re-enable interrupts until the cpuidle driver
  enables them. This was not quite right in the previous patch
  (and prep_irq_for_idle() is not quite right for that case so
  a new primitive has to be introduced).

- Patch to replace interrupts from system reset wakeup changed
  rather than replaying directly, it just marks the IRQ in the
  lazy pending bit and it will get replayed at the right time
  when irqs are re-enabled.

Thanks,
Nick

Nicholas Piggin (14):
  powerpc/64s: idle move soft interrupt mask logic into C code
  powerpc/64s: idle hotplug lazy-irq simplification
  powerpc/64s: idle provide a default idle for POWER9
  powerpc/64s: idle process interrupts from system reset wakeup
  powerpc/64s: msgclr when handling doorbell exceptions
  powerpc/64s: interrupt replay balance the return branch predictor
  powerpc/64s: idle branch to handler with virtual mode offset
  powerpc/64s: idle avoid SRR usage in idle sleep/wake paths
  powerpc/64s: idle hmi wakeup is unlikely
  powerpc/64s: cpuidle set polling before enabling irqs
  powerpc/64s: cpuidle read mostly for common globals
  powerpc/64s: cpuidle no memory barrier after break from idle
  powerpc/64: runlatch CTRL[RUN] set optimisation
  powerpc/64s: idle runlatch switch is done with MSR[EE]=0

 arch/powerpc/include/asm/dbell.h         |  13 +++
 arch/powerpc/include/asm/exception-64s.h |  17 +++-
 arch/powerpc/include/asm/hw_irq.h        |   5 ++
 arch/powerpc/include/asm/machdep.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h    |   3 +
 arch/powerpc/include/asm/processor.h     |  10 +--
 arch/powerpc/kernel/asm-offsets.c        |   1 +
 arch/powerpc/kernel/exceptions-64s.S     |  33 ++++++--
 arch/powerpc/kernel/idle_book3s.S        | 135 +++++++++----------------------
 arch/powerpc/kernel/irq.c                |  58 ++++++++++++-
 arch/powerpc/kernel/process.c            |  12 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   8 +-
 arch/powerpc/platforms/powernv/idle.c    |  90 +++++++++++++++++++--
 arch/powerpc/platforms/powernv/smp.c     |  31 ++++---
 arch/powerpc/platforms/powernv/subcore.c |   3 +-
 drivers/cpuidle/cpuidle-powernv.c        |  37 +++++----
 drivers/cpuidle/cpuidle-pseries.c        |  22 +++--
 17 files changed, 309 insertions(+), 170 deletions(-)

-- 
2.11.0
