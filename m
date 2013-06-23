Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E8EB2C0A84
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:55 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 23:33:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EC4052BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:51 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDih7n54788202
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:43 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDioht030067
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:44:51 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 16/45] tick-broadcast: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:11:31 +0530
Message-ID: <20130623134128.19094.36132.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
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

 kernel/time/tick-broadcast.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index d66f554..53493a6 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -227,12 +227,14 @@ static void tick_do_broadcast(struct cpumask *mask)
  */
 static void tick_do_periodic_broadcast(void)
 {
+	get_online_cpus_atomic();
 	raw_spin_lock(&tick_broadcast_lock);
 
 	cpumask_and(tmpmask, cpu_online_mask, tick_broadcast_mask);
 	tick_do_broadcast(tmpmask);
 
 	raw_spin_unlock(&tick_broadcast_lock);
+	put_online_cpus_atomic();
 }
 
 /*
@@ -335,11 +337,13 @@ out:
  */
 void tick_broadcast_on_off(unsigned long reason, int *oncpu)
 {
+	get_online_cpus_atomic();
 	if (!cpumask_test_cpu(*oncpu, cpu_online_mask))
 		printk(KERN_ERR "tick-broadcast: ignoring broadcast for "
 		       "offline CPU #%d\n", *oncpu);
 	else
 		tick_do_broadcast_on_off(&reason);
+	put_online_cpus_atomic();
 }
 
 /*
@@ -505,6 +509,7 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
 	ktime_t now, next_event;
 	int cpu, next_cpu = 0;
 
+	get_online_cpus_atomic();
 	raw_spin_lock(&tick_broadcast_lock);
 again:
 	dev->next_event.tv64 = KTIME_MAX;
@@ -562,6 +567,7 @@ again:
 			goto again;
 	}
 	raw_spin_unlock(&tick_broadcast_lock);
+	put_online_cpus_atomic();
 }
 
 /*
@@ -753,6 +759,7 @@ void tick_broadcast_switch_to_oneshot(void)
 	struct clock_event_device *bc;
 	unsigned long flags;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
 	tick_broadcast_device.mode = TICKDEV_MODE_ONESHOT;
@@ -761,6 +768,7 @@ void tick_broadcast_switch_to_oneshot(void)
 		tick_broadcast_setup_oneshot(bc);
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
+	put_online_cpus_atomic();
 }
 
 
