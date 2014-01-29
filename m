Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D292A2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 07:31:41 +1100 (EST)
Received: by mail-qc0-f176.google.com with SMTP id e16so3603680qcx.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 12:31:38 -0800 (PST)
Date: Wed, 29 Jan 2014 15:31:36 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
In-Reply-To: <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linaro-kernel@lists.linaro.org, linux-sh@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jan 2014, Nicolas Pitre wrote:

> In order to integrate cpuidle with the scheduler, we must have a better
> proximity in the core code with what cpuidle is doing and not delegate
> such interaction to arch code.
> 
> Architectures implementing arch_cpu_idle() should simply enter
> a cheap idle mode in the absence of a proper cpuidle driver.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

As mentioned in my reply to Olof's comment on patch #5/6, here's a new 
version of this patch adding the safety local_irq_enable() to the core 
code.

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: idle: move the cpuidle entry point to the generic idle loop

In order to integrate cpuidle with the scheduler, we must have a better
proximity in the core code with what cpuidle is doing and not delegate
such interaction to arch code.

Architectures implementing arch_cpu_idle() should simply enter
a cheap idle mode in the absence of a proper cpuidle driver.

In both cases i.e. whether it is a cpuidle driver or the default
arch_cpu_idle(), the calling convention expects IRQs to be disabled
on entry and enabled on exit. There is a warning in place already but
let's add a forced IRQ enable here as well.  This will allow for
removing the forced IRQ enable some implementations do locally and 
allowing for the warning to trig.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 988573a9a3..14ca43430a 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -3,6 +3,7 @@
  */
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
@@ -95,8 +96,10 @@ static void cpu_idle_loop(void)
 				if (!current_clr_polling_and_test()) {
 					stop_critical_timings();
 					rcu_idle_enter();
-					arch_cpu_idle();
-					WARN_ON_ONCE(irqs_disabled());
+					if (cpuidle_idle_call())
+						arch_cpu_idle();
+					if (WARN_ON_ONCE(irqs_disabled()))
+						local_irq_enable();
 					rcu_idle_exit();
 					start_critical_timings();
 				} else {
