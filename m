Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn94d29PQzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:06:09 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a70so18694597pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:06:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 00/13 v3] idle performance improvements
Date: Tue, 13 Jun 2017 23:05:44 +1000
Message-Id: <20170613130557.26315-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time, I accounted for the various comments
in reviews, most importantly fixed the miscalculation
of SRR1 bit for the wakeup-interrupt. Verified it does
the right thing and replays the right wakeup interrupt
(e.g., decrementer) from __replay_interrupt stepping
through the instructions in the simulator.

I've found that performance testing is a little difficult
because the ping-pong test cases must sometimes get into
synchronization and run concurrently without sleeping.
Looking at context switch rates in vmstat, I run the
context-switch ping-poing test with snooze idle disabled
on a POWER8, and the numbers before and after this series
are:

         different thread   different core
vanilla  600K/s             470K/s
patched  780K/s             550K/s

(these are 2x what's reported by context_switch selftest
because each step switches to and from idle thread)

It's still not a perfect measurement because if there is
some unwanted concurrency happening then you can get
different amount of userspace work per context switch,
but there seems to be a decent speedup here.

Thanks,
Nick

Nicholas Piggin (13):
  powerpc/64s: idle move soft interrupt mask logic into C code
  powerpc/64s: idle hotplug lazy-irq simplification
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
 arch/powerpc/include/asm/exception-64s.h |  13 +++
 arch/powerpc/include/asm/hw_irq.h        |   5 ++
 arch/powerpc/include/asm/machdep.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h    |   3 +
 arch/powerpc/include/asm/processor.h     |  10 +--
 arch/powerpc/kernel/asm-offsets.c        |   1 +
 arch/powerpc/kernel/exceptions-64s.S     |  38 +++++++--
 arch/powerpc/kernel/idle_book3s.S        | 135 +++++++++----------------------
 arch/powerpc/kernel/irq.c                |  62 +++++++++++++-
 arch/powerpc/kernel/process.c            |  12 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   8 +-
 arch/powerpc/platforms/powernv/idle.c    |  88 ++++++++++++++++++--
 arch/powerpc/platforms/powernv/smp.c     |  31 ++++---
 arch/powerpc/platforms/powernv/subcore.c |   3 +-
 drivers/cpuidle/cpuidle-powernv.c        |  37 +++++----
 drivers/cpuidle/cpuidle-pseries.c        |  22 +++--
 17 files changed, 315 insertions(+), 167 deletions(-)

-- 
2.11.0
