Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsFkj1C0DzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 05:50:05 +1000 (AEST)
Message-Id: <20170912194148.418497420@linutronix.de>
Date: Tue, 12 Sep 2017 21:37:23 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch V2 29/29] lockup_detector: Cleanup hotplug locking mess
References: <20170912193654.321505854@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All watchdog thread related functions are delegated to the smpboot thread
infrastructure, which handles serialization against CPU hotplug correctly.

The sysctl interface is completely decoupled from anything which requires
CPU hotplug protection.

No need to protect the sysctl writes against cpu hotplug anymore. Remove it
and add the now required protection to the powerpc arch_nmi_watchdog
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170831073055.331699267@linutronix.de

---
 arch/powerpc/kernel/watchdog.c |    2 ++
 kernel/watchdog.c              |    6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -359,6 +359,7 @@ void watchdog_nmi_reconfigure(bool run)
 {
 	int cpu;
 
+	cpus_read_lock();
 	if (!run) {
 		for_each_cpu(cpu, &wd_cpus_enabled)
 			stop_wd_on_cpu(cpu);
@@ -367,6 +368,7 @@ void watchdog_nmi_reconfigure(bool run)
 		for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
 			start_wd_on_cpu(cpu);
 	}
+	cpus_read_unlock();
 }
 
 /*
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -664,7 +664,6 @@ static int proc_watchdog_common(int whic
 {
 	int err, old, *param = table->data;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	if (!write) {
@@ -681,7 +680,6 @@ static int proc_watchdog_common(int whic
 			proc_watchdog_update();
 	}
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 
@@ -725,7 +723,6 @@ int proc_watchdog_thresh(struct ctl_tabl
 {
 	int err, old;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	old = READ_ONCE(watchdog_thresh);
@@ -735,7 +732,6 @@ int proc_watchdog_thresh(struct ctl_tabl
 		proc_watchdog_update();
 
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 
@@ -750,7 +746,6 @@ int proc_watchdog_cpumask(struct ctl_tab
 {
 	int err;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	err = proc_do_large_bitmap(table, write, buffer, lenp, ppos);
@@ -758,7 +753,6 @@ int proc_watchdog_cpumask(struct ctl_tab
 		proc_watchdog_update();
 
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 #endif /* CONFIG_SYSCTL */
