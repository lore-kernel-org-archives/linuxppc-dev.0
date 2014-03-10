Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C606A2C00FE
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 07:34:52 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 02:04:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E2CB8125803E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:06:58 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2AKYgM810158490
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:04:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2AKYiWh017649
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2014 02:04:45 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 04/52] CPU hotplug,
 perf: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net,
 rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
 akpm@linux-foundation.org
Date: Tue, 11 Mar 2014 02:04:39 +0530
Message-ID: <20140310203438.10746.24505.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the perf subsystem's hotplug notifier by using this latter form of
callback registration.

Also provide a bare-bones version of perf_cpu_notifier() that doesn't
invoke the notifiers for the already online CPUs. This would be useful
for subsystems that need to perform a different set of initialization
for the already online CPUs, or don't need the initialization altogether.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 include/linux/perf_event.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e56b07f..3356abc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -835,6 +835,8 @@ do {									\
 		{ .notifier_call = fn, .priority = CPU_PRI_PERF };	\
 	unsigned long cpu = smp_processor_id();				\
 	unsigned long flags;						\
+									\
+	cpu_notifier_register_begin();					\
 	fn(&fn##_nb, (unsigned long)CPU_UP_PREPARE,			\
 		(void *)(unsigned long)cpu);				\
 	local_irq_save(flags);						\
@@ -843,9 +845,21 @@ do {									\
 	local_irq_restore(flags);					\
 	fn(&fn##_nb, (unsigned long)CPU_ONLINE,				\
 		(void *)(unsigned long)cpu);				\
-	register_cpu_notifier(&fn##_nb);				\
+	__register_cpu_notifier(&fn##_nb);				\
+	cpu_notifier_register_done();					\
 } while (0)
 
+/*
+ * Bare-bones version of perf_cpu_notifier(), which doesn't invoke the
+ * callback for already online CPUs.
+ */
+#define __perf_cpu_notifier(fn)						\
+do {									\
+	static struct notifier_block fn##_nb =				\
+		{ .notifier_call = fn, .priority = CPU_PRI_PERF };	\
+									\
+	__register_cpu_notifier(&fn##_nb);				\
+} while (0)
 
 struct perf_pmu_events_attr {
 	struct device_attribute attr;
