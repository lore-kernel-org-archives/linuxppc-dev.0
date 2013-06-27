Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CCD22C03D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:56:38 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:47:07 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2618F2BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:56:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJfgOx6422806
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:41:42 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RJuWot014736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:56:34 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 04/45] CPU hotplug: Add infrastructure to check lacking
 hotplug synchronization
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:23:05 +0530
Message-ID: <20130627195305.29830.10263.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
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
