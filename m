Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C60B2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:29:49 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 01:51:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F299CE0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 01:59:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKU0S228901460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:00:00 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKTgOU009288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:29:44 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 04/45] CPU hotplug: Add infrastructure to check lacking
 hotplug synchronization
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 01:56:27 +0530
Message-ID: <20130625202627.16593.77574.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, Alex Shi <alex.shi@intel.com>,
 nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 fweisbec@gmail.com, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, sbw@mit.edu,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a debugging infrastructure to warn if an atomic hotplug reader has not
invoked get_online_cpus_atomic() before traversing/accessing the
cpu_online_mask. Encapsulate these checks under a new debug config option
DEBUG_HOTPLUG_CPU.

This debugging infrastructure proves useful in the tree-wide conversion
of atomic hotplug readers from preempt_disable() to the new APIs, and
help us catch the places we missed, much before we actually get rid of
stop_machine(). We can perhaps remove the debugging checks later on.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alex Shi <alex.shi@intel.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/cpumask.h |   12 ++++++
 kernel/cpu.c            |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d08e4d2..9197ca4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -101,6 +101,18 @@ extern const struct cpumask *const cpu_active_mask;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+#ifdef CONFIG_DEBUG_HOTPLUG_CPU
+extern void check_hotplug_safe_cpumask(const struct cpumask *mask);
+extern void check_hotplug_safe_cpu(unsigned int cpu,
+				   const struct cpumask *mask);
+#else
+static inline void check_hotplug_safe_cpumask(const struct cpumask *mask) { }
+static inline void check_hotplug_safe_cpu(unsigned int cpu,
+					  const struct cpumask *mask)
+{
+}
+#endif
+
 /* verify cpu argument to cpumask_* operators */
 static inline unsigned int cpumask_check(unsigned int cpu)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 860f51a..5297ec1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -63,6 +63,92 @@ static struct {
 	.refcount = 0,
 };
 
+#ifdef CONFIG_DEBUG_HOTPLUG_CPU
+
+static DEFINE_PER_CPU(unsigned long, atomic_reader_refcnt);
+
+static int current_is_hotplug_safe(const struct cpumask *mask)
+{
+
+	/* If we are not dealing with cpu_online_mask, don't complain. */
+	if (mask != cpu_online_mask)
+		return 1;
+
+	/* If this is the task doing hotplug, don't complain. */
+	if (unlikely(current == cpu_hotplug.active_writer))
+		return 1;
+
+	/* If we are in early boot, don't complain. */
+	if (system_state != SYSTEM_RUNNING)
+		return 1;
+
+	/*
+	 * Check if the current task is in atomic context and it has
+	 * invoked get_online_cpus_atomic() to synchronize with
+	 * CPU Hotplug.
+	 */
+	if (preempt_count() || irqs_disabled())
+		return this_cpu_read(atomic_reader_refcnt);
+	else
+		return 1; /* No checks for non-atomic contexts for now */
+}
+
+static inline void warn_hotplug_unsafe(void)
+{
+	WARN_ONCE(1, "Must use get/put_online_cpus_atomic() to synchronize"
+		     " with CPU hotplug\n");
+}
+
+/*
+ * Check if the task (executing in atomic context) has the required protection
+ * against CPU hotplug, while accessing the specified cpumask.
+ */
+void check_hotplug_safe_cpumask(const struct cpumask *mask)
+{
+	if (!current_is_hotplug_safe(mask))
+		warn_hotplug_unsafe();
+}
+EXPORT_SYMBOL_GPL(check_hotplug_safe_cpumask);
+
+/*
+ * Similar to check_hotplug_safe_cpumask(), except that we don't complain
+ * if the task (executing in atomic context) is testing whether the CPU it
+ * is executing on is online or not.
+ *
+ * (A task executing with preemption disabled on a CPU, automatically prevents
+ *  offlining that CPU, irrespective of the actual implementation of CPU
+ *  offline. So we don't enforce holding of get_online_cpus_atomic() for that
+ *  case).
+ */
+void check_hotplug_safe_cpu(unsigned int cpu, const struct cpumask *mask)
+{
+	if(!current_is_hotplug_safe(mask) && cpu != smp_processor_id())
+		warn_hotplug_unsafe();
+}
+EXPORT_SYMBOL_GPL(check_hotplug_safe_cpu);
+
+static inline void atomic_reader_refcnt_inc(void)
+{
+	this_cpu_inc(atomic_reader_refcnt);
+}
+
+static inline void atomic_reader_refcnt_dec(void)
+{
+	this_cpu_dec(atomic_reader_refcnt);
+}
+
+#else
+
+static inline void atomic_reader_refcnt_inc(void)
+{
+}
+
+static inline void atomic_reader_refcnt_dec(void)
+{
+}
+
+#endif
+
 void get_online_cpus(void)
 {
 	might_sleep();
@@ -189,12 +275,15 @@ unsigned int get_online_cpus_atomic(void)
 	 * from going offline.
 	 */
 	preempt_disable();
+	atomic_reader_refcnt_inc();
+
 	return smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(get_online_cpus_atomic);
 
 void put_online_cpus_atomic(void)
 {
+	atomic_reader_refcnt_dec();
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(put_online_cpus_atomic);
