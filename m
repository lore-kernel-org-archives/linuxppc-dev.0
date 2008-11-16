Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 4883EDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 08:25:18 +1100 (EST)
Message-Id: <20081116212515.093117788@goodmis.org>
References: <20081116212428.938752312@goodmis.org>
Date: Sun, 16 Nov 2008 16:24:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ftrace, PPC: do not latency trace idle
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: give better timing to latency tracers

When idle is called, interrupts are disabled, but the idle function
will still wake up on an interrupt. The problem is that the interrupt
disabled latency tracer will take this call to idle as a latency.

This patch disables the latency tracing when going into idle.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
CC:  Paul Mackerras <paulus@samba.org>
CC:  Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/idle.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 31982d0..88d9c1d 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -69,10 +69,15 @@ void cpu_idle(void)
 				smp_mb();
 				local_irq_disable();
 
+				/* Don't trace irqs off for idle */
+				stop_critical_timings();
+
 				/* check again after disabling irqs */
 				if (!need_resched() && !cpu_should_die())
 					ppc_md.power_save();
 
+				start_critical_timings();
+
 				local_irq_enable();
 				set_thread_flag(TIF_POLLING_NRFLAG);
 
-- 
1.5.6.5

-- 
