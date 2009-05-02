Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 365ABDE0D4
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 10:14:27 +1000 (EST)
Date: Sat, 2 May 2009 04:14:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros should
	select FRAME_POINTER
Message-ID: <20090502001425.GC9342@oksana.dev.rtsoft.ru>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Irqsoff, switch and preempt tracers use CALLER_ADDR macros, so they
should select FRAME_POINTER. Otherwise traces are meaningless.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 kernel/trace/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 450d3c2..ad44791 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -122,6 +122,7 @@ config IRQSOFF_TRACER
 	select TRACE_IRQFLAGS
 	select TRACING
 	select TRACER_MAX_TRACE
+	select FRAME_POINTER
 	help
 	  This option measures the time spent in irqs-off critical
 	  sections, with microsecond accuracy.
@@ -143,6 +144,7 @@ config PREEMPT_TRACER
 	depends on PREEMPT
 	select TRACING
 	select TRACER_MAX_TRACE
+	select FRAME_POINTER
 	help
 	  This option measures the time spent in preemption off critical
 	  sections, with microsecond accuracy.
@@ -171,6 +173,7 @@ config SCHED_TRACER
 	select TRACING
 	select CONTEXT_SWITCH_TRACER
 	select TRACER_MAX_TRACE
+	select FRAME_POINTER
 	help
 	  This tracer tracks the latency of the highest priority task
 	  to be scheduled in, starting from the point it has woken up.
-- 
1.6.2.2
