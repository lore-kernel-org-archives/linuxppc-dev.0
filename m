Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9004A1A0C6C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:57:44 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 21 Jan 2015 03:57:42 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5DC706E8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 05:49:33 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0LAveec24051798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:57:40 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0LAvdDS026793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 05:57:40 -0500
Subject: [PATCH V2] cpuidle: Add missing checks to the exit condition of
 cpu_idle_poll()
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Wed, 21 Jan 2015 16:27:25 +0530
Message-ID: <20150121105655.15279.59626.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpu_idle_poll() is entered into when either the cpu_idle_force_poll is set or
tick_check_broadcast_expired() returns true. The exit condition from
cpu_idle_poll() is tif_need_resched().

However this does not take into account scenarios where cpu_idle_force_poll
changes or tick_check_broadcast_expired() returns false, without setting
the resched flag. So a cpu will be caught in cpu_idle_poll() needlessly,
thereby wasting power. Add an explicit check on cpu_idle_force_poll and
tick_check_broadcast_expired() to the exit condition of cpu_idle_poll()
to avoid this.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V1: Modified the Changelog

 kernel/sched/idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c47fce7..aaf1c1d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -47,7 +47,8 @@ static inline int cpu_idle_poll(void)
 	rcu_idle_enter();
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
-	while (!tif_need_resched())
+	while (!tif_need_resched() &&
+		(cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
