Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id C40142C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:45:23 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0600IR8BZJOTG0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Wed, 29 Jan 2014 12:45:19 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic idle
 loop
Date: Wed, 29 Jan 2014 12:45:08 -0500
Message-id: <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to integrate cpuidle with the scheduler, we must have a better
proximity in the core code with what cpuidle is doing and not delegate
such interaction to arch code.

Architectures implementing arch_cpu_idle() should simply enter
a cheap idle mode in the absence of a proper cpuidle driver.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/cpu/idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 988573a9a3..ffcd3ee9af 100644
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
@@ -95,7 +96,8 @@ static void cpu_idle_loop(void)
 				if (!current_clr_polling_and_test()) {
 					stop_critical_timings();
 					rcu_idle_enter();
-					arch_cpu_idle();
+					if (cpuidle_idle_call())
+						arch_cpu_idle();
 					WARN_ON_ONCE(irqs_disabled());
 					rcu_idle_exit();
 					start_critical_timings();
-- 
1.8.4.108.g55ea5f6
