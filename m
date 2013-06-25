Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58C772C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:29:17 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 06:19:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 28C763578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:29:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKELLn4587966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKT9xH026370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:29:10 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 01/45] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 01:55:42 +0530
Message-ID: <20130625202541.16593.17752.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, "Rafael J. Wysocki" <rjw@sisk.pl>,
 sbw@mit.edu, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current CPU offline code uses stop_machine() internally. And disabling
preemption prevents stop_machine() from taking effect, thus also preventing
CPUs from going offline, as a side effect.

There are places where this side-effect of preempt_disable() (or equivalent)
is used to synchronize with CPU hotplug. Typically these are in atomic
sections of code, where they can't make use of get/put_online_cpus(), because
the latter set of APIs can sleep.

Going forward, we want to get rid of stop_machine() from the CPU hotplug
offline path. And then, with stop_machine() gone, disabling preemption will
no longer prevent CPUs from going offline.

So provide a set of APIs for such atomic hotplug readers, to prevent (any)
CPUs from going offline. For now, they will default to preempt_disable()
and preempt_enable() itself, but this will help us do the tree-wide conversion,
as a preparatory step to remove stop_machine() from CPU hotplug.

(Besides, it is good documentation as well, since it clearly marks places
where we synchronize with CPU hotplug, instead of combining it subtly with
disabling preemption).

In future, when actually removing stop_machine(), we will alter the
implementation of these APIs to a suitable synchronization scheme.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/cpu.h |   20 ++++++++++++++++++++
 kernel/cpu.c        |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9f3c7e8..a57b25a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -17,6 +17,8 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
 
 struct device;
 
@@ -175,6 +177,8 @@ extern struct bus_type cpu_subsys;
 
 extern void get_online_cpus(void);
 extern void put_online_cpus(void);
+extern unsigned int get_online_cpus_atomic(void);
+extern void put_online_cpus_atomic(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 #define hotcpu_notifier(fn, pri)	cpu_notifier(fn, pri)
@@ -202,6 +206,22 @@ static inline void cpu_hotplug_driver_unlock(void)
 #define put_online_cpus()	do { } while (0)
 #define cpu_hotplug_disable()	do { } while (0)
 #define cpu_hotplug_enable()	do { } while (0)
+
+static inline unsigned int get_online_cpus_atomic(void)
+{
+	/*
+	 * Disable preemption to avoid getting complaints from the
+	 * debug_smp_processor_id() code.
+	 */
+	preempt_disable();
+	return smp_processor_id();
+}
+
+static inline void put_online_cpus_atomic(void)
+{
+	preempt_enable();
+}
+
 #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 198a388..2d03398 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -154,6 +154,44 @@ void cpu_hotplug_enable(void)
 	cpu_maps_update_done();
 }
 
+/*
+ * get_online_cpus_atomic - Prevent any CPU from going offline
+ *
+ * Atomic hotplug readers (tasks which wish to prevent CPUs from going
+ * offline during their critical section, but can't afford to sleep)
+ * can invoke this function to synchronize with CPU offline. This function
+ * can be called recursively, provided it is matched with an equal number
+ * of calls to put_online_cpus_atomic().
+ *
+ * Note: This does NOT prevent CPUs from coming online! It only prevents
+ * CPUs from going offline.
+ *
+ * Lock ordering rule: Strictly speaking, there is no lock ordering
+ * requirement here, but it is advisable to keep the locking consistent.
+ * As a simple rule-of-thumb, use these functions in the outer-most blocks
+ * of your critical sections, outside of other locks.
+ *
+ * Returns the current CPU number, with preemption disabled.
+ */
+unsigned int get_online_cpus_atomic(void)
+{
+	/*
+	 * The current CPU hotplug implementation uses stop_machine() in
+	 * the CPU offline path. And disabling preemption prevents
+	 * stop_machine() from taking effect. Thus, this prevents any CPU
+	 * from going offline.
+	 */
+	preempt_disable();
+	return smp_processor_id();
+}
+EXPORT_SYMBOL_GPL(get_online_cpus_atomic);
+
+void put_online_cpus_atomic(void)
+{
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(put_online_cpus_atomic);
+
 #else /* #if CONFIG_HOTPLUG_CPU */
 static void cpu_hotplug_begin(void) {}
 static void cpu_hotplug_done(void) {}
