Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjYx31rfTzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:32:23 +1000 (AEST)
Message-Id: <20170831073055.331699267@linutronix.de>
Date: Thu, 31 Aug 2017 09:16:27 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [patch 29/29] lockup_detector: Cleanup hotplug locking mess
References: <20170831071558.995235362@linutronix.de>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/watchdog.c |    2 ++
 kernel/watchdog.c              |    6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -356,6 +356,7 @@ void watchdog_nmi_reconfigure(bool stop)
 {
 	int cpu;
 
+	cpus_read_lock();
 	if (stop) {
 		for_each_cpu(cpu, &wd_cpus_enabled)
 			stop_wd_on_cpu(cpu);
@@ -364,6 +365,7 @@ void watchdog_nmi_reconfigure(bool stop)
 		for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
 			start_wd_on_cpu(cpu);
 	}
+	cpus_read_unlock();
 }
 
 /*
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -652,7 +652,6 @@ static int proc_watchdog_common(int whic
 {
 	int err, old, *param = table->data;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	if (!write) {
@@ -669,7 +668,6 @@ static int proc_watchdog_common(int whic
 			proc_watchdog_update();
 	}
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 
@@ -713,7 +711,6 @@ int proc_watchdog_thresh(struct ctl_tabl
 {
 	int err, old;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	old = READ_ONCE(watchdog_thresh);
@@ -723,7 +720,6 @@ int proc_watchdog_thresh(struct ctl_tabl
 		proc_watchdog_update();
 
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 
@@ -738,7 +734,6 @@ int proc_watchdog_cpumask(struct ctl_tab
 {
 	int err;
 
-	cpu_hotplug_disable();
 	mutex_lock(&watchdog_mutex);
 
 	err = proc_do_large_bitmap(table, write, buffer, lenp, ppos);
@@ -746,7 +741,6 @@ int proc_watchdog_cpumask(struct ctl_tab
 		proc_watchdog_update();
 
 	mutex_unlock(&watchdog_mutex);
-	cpu_hotplug_enable();
 	return err;
 }
 #endif /* CONFIG_SYSCTL */
