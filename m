Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43A702C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:30:54 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 06:21:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A3F8C2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:30:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKFrRq4587900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:15:53 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKUoG1022294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:30:52 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 13/45] timer: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 01:57:31 +0530
Message-ID: <20130625202730.16593.35113.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, wangyun@linux.vnet.ibm.com,
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/timer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index 15ffdb3..5db594c 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -729,6 +729,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
+	get_online_cpus_atomic();
 	base = lock_timer_base(timer, &flags);
 
 	ret = detach_if_pending(timer, base, false);
@@ -768,6 +769,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 
 out_unlock:
 	spin_unlock_irqrestore(&base->lock, flags);
+	put_online_cpus_atomic();
 
 	return ret;
 }
@@ -926,6 +928,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(timer_pending(timer) || !timer->function);
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&base->lock, flags);
 	timer_set_base(timer, base);
 	debug_activate(timer, timer->expires);
@@ -940,6 +943,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 */
 	wake_up_nohz_cpu(cpu);
 	spin_unlock_irqrestore(&base->lock, flags);
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
