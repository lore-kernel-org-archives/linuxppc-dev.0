Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRTZS6psRzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 11:27:43 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s75so661460pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:27:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/watchdog: improve watchdog comments
Date: Wed,  1 Nov 2017 11:27:33 +1100
Message-Id: <20171101002733.7213-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The overview comments in the powerpc watchdog are out of date after
several iterations and changes of the code. Bring them up to date.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 58 +++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 15e209a37c2d..0ddcd19b500d 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -25,15 +25,45 @@
 #include <asm/paca.h>
 
 /*
- * The watchdog has a simple timer that runs on each CPU, once per timer
- * period. This is the heartbeat.
+ * The powerpc watchdog ensures that each CPU is able to service timers.
+ * The watchdog sets up a simple timer on each CPU to run once per timer
+ * period, and updates a per-cpu timestamp and a "pending" cpumask. This is
+ * the heartbeat.
  *
- * Then there are checks to see if the heartbeat has not triggered on a CPU
- * for the panic timeout period. Currently the watchdog only supports an
- * SMP check, so the heartbeat only turns on when we have 2 or more CPUs.
+ * Then there are two systems to check that the heartbeat is still running.
+ * The local soft-NMI, and the SMP checker.
  *
- * This is not an NMI watchdog, but Linux uses that name for a generic
- * watchdog in some cases, so NMI gets used in some places.
+ * The soft-NMI checker can detect lockups on the local CPU. When interrupts
+ * are disabled with local_irq_disable(), platforms that use soft-masking
+ * can leave hardware interrupts enabled and handle them with a masked
+ * interrupt handler. The masked handler can send the timer interrupt to the
+ * watchdog's soft_nmi_interrupt(), which appears to Linux as an NMI
+ * interrupt, and can be used to detect CPUs stuck with IRQs disabled.
+ *
+ * The soft-NMI checker will compare the heartbeat timestamp for this CPU
+ * with the current time, and take action if the difference exceeds the
+ * watchdog threshold.
+ *
+ * The limitation of the soft-NMI watchdog is that it does not work when
+ * interrupts are hard disabled or otherwise not being serviced. This is
+ * solved by also having a SMP watchdog where all CPUs check all other
+ * CPUs heartbeat.
+ *
+ * The SMP checker can detect lockups on other CPUs. A gobal "pending"
+ * cpumask is kept, containing all CPUs which enable the watchdog. Each
+ * CPU clears their pending bit in their heartbeat timer. When the bitmask
+ * becomes empty, the last CPU to clear its pending bit updates a global
+ * timestamp and refills the pending bitmask.
+ *
+ * In the heartbeat timer, if any CPU notices that the global timestamp has
+ * not been updated for a period exceeding the watchdog threshold, then it
+ * means the CPU(s) with their bit still set in the pending mask have had
+ * their heartbeat stop, and action is taken.
+ *
+ * Some platforms implement true NMI IPIs, which can by used by the SMP
+ * watchdog to detect an unresponsive CPU and pull it out of its stuck
+ * state with the NMI IPI, to get crash/debug data from it. This way the
+ * SMP watchdog can detect hardware interrupts off lockups.
  */
 
 static cpumask_t wd_cpus_enabled __read_mostly;
@@ -46,19 +76,7 @@ static u64 wd_timer_period_ms __read_mostly;  /* interval between heartbeat */
 static DEFINE_PER_CPU(struct timer_list, wd_timer);
 static DEFINE_PER_CPU(u64, wd_timer_tb);
 
-/*
- * These are for the SMP checker. CPUs clear their pending bit in their
- * heartbeat. If the bitmask becomes empty, the time is noted and the
- * bitmask is refilled.
- *
- * All CPUs clear their bit in the pending mask every timer period.
- * Once all have cleared, the time is noted and the bits are reset.
- * If the time since all clear was greater than the panic timeout,
- * we can panic with the list of stuck CPUs.
- *
- * This will work best with NMI IPIs for crash code so the stuck CPUs
- * can be pulled out to get their backtraces.
- */
+/* SMP checker bits */
 static unsigned long __wd_smp_lock;
 static cpumask_t wd_smp_cpus_pending;
 static cpumask_t wd_smp_cpus_stuck;
-- 
2.15.0.rc2
