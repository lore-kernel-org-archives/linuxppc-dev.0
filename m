Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F93C2C05E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:31:40 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 01:55:24 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 882F91258051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:00:40 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKVXPI23593204
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:01:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKVYLf009330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:31:36 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 17/45] time/clocksource: Use get/put_online_cpus_atomic()
 to prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 01:58:20 +0530
Message-ID: <20130625202820.16593.17778.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 John Stultz <john.stultz@linaro.org>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/time/clocksource.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e713ef7..c4bbc25 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/cpu.h>
 
 #include "tick-internal.h"
 
@@ -252,6 +253,7 @@ static void clocksource_watchdog(unsigned long data)
 	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
 
+	get_online_cpus_atomic();
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
 		goto out;
@@ -329,6 +331,7 @@ static void clocksource_watchdog(unsigned long data)
 	add_timer_on(&watchdog_timer, next_cpu);
 out:
 	spin_unlock(&watchdog_lock);
+	put_online_cpus_atomic();
 }
 
 static inline void clocksource_start_watchdog(void)
@@ -367,6 +370,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
 	unsigned long flags;
 
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
@@ -386,6 +390,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 	/* Check if the watchdog timer needs to be started. */
 	clocksource_start_watchdog();
 	spin_unlock_irqrestore(&watchdog_lock, flags);
+	put_online_cpus_atomic();
 }
 
 static void clocksource_dequeue_watchdog(struct clocksource *cs)
