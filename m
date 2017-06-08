Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8zf3mlvzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:26 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f27so5592019pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 00/14] idle performance improvements
Date: Fri,  9 Jun 2017 01:50:59 +1000
Message-Id: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches improve performance of idle sleep and wake. The
first patches rework the lazy-irq handling of idle code a bit
to make it simpler first.

Any review would be welcome. I've tested this with some
performance and simple correctness tests on POWER8, POWER9,
and with KVM on POWER8, so it's about ready to review now
I hope.

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
 arch/powerpc/include/asm/hw_irq.h        |   1 +
 arch/powerpc/include/asm/machdep.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h    |   3 +
 arch/powerpc/include/asm/processor.h     |  10 +--
 arch/powerpc/kernel/asm-offsets.c        |   1 +
 arch/powerpc/kernel/exceptions-64s.S     |  62 ++++++++++++--
 arch/powerpc/kernel/idle_book3s.S        | 137 +++++++++----------------------
 arch/powerpc/kernel/irq.c                |   3 +-
 arch/powerpc/kernel/process.c            |  12 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   8 +-
 arch/powerpc/platforms/powernv/idle.c    | 104 +++++++++++++++++++----
 arch/powerpc/platforms/powernv/smp.c     |  31 ++++---
 arch/powerpc/platforms/powernv/subcore.c |   3 +-
 drivers/cpuidle/cpuidle-powernv.c        |  37 +++++----
 drivers/cpuidle/cpuidle-pseries.c        |  22 +++--
 17 files changed, 288 insertions(+), 177 deletions(-)

-- 
2.11.0
