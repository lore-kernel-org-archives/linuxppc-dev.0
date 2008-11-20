Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 52B9CDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:11:50 +1100 (EST)
Message-Id: <20081120191149.086287646@goodmis.org>
References: <20081120190948.057007623@goodmis.org>
Date: Thu, 20 Nov 2008 14:09:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc: ftrace, do not latency trace idle
Cc: Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

Impact: fix for irq off latency tracer

When idle is called, interrupts are disabled, but the idle function
will still wake up on an interrupt. The problem is that the interrupt
disabled latency tracer will take this call to idle as a latency.

This patch disables the latency tracing when going into idle.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
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
