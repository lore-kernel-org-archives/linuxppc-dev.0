Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd5ZW1xhCzDqyR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:01:05 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id m88so12664645pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:01:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/4] interrupt tracing fixes
Date: Fri, 17 Nov 2017 02:00:48 +1000
Message-Id: <20171116160052.18672-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are a few loosely related fixes for interrupt tracing code
and irq state handling which eliminates local_irq_enable() when
already enabled, and local_irq_disable() when already disabled,
and also fixes an NMI re-entrancy bug in irq tracing that has
been crashing in the field when PMU interrupts (non-maskable) and
irq tracing runs together it's causing things to get into "impossible"
states.

I have only tested 64s, and don't know if patch 1 and 2 are right
on 64e or 32 so if anyone could take a look or test, that would
be good.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc: define __ARCH_IRQ_EXIT_IRQS_DISABLED
  powerpc/64: do not trace irqs-off at interrupt return to soft-disabled
    context
  cpuidle/powernv: avoid double irq enable coming out of idle
  cpuidle/powernv: avoid double irq enable coming out of idle

 arch/powerpc/include/asm/hardirq.h |  1 +
 arch/powerpc/kernel/entry_64.S     | 10 +++++++---
 drivers/cpuidle/cpuidle-powernv.c  |  2 ++
 drivers/cpuidle/cpuidle-pseries.c  |  6 ++++--
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.15.0
