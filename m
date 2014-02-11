Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB1312C03B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:02:18 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 17:02:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DA40F2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:02:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B6ga3A10879362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 17:42:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B72Blp031421
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:02:12 +1100
Subject: [PATCH v1 2/2] powernv,
 cpufreq: Add per-core locking to serialize frequency transitions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Tue, 11 Feb 2014 12:32:08 +0530
Message-ID: <20140211070208.21159.86862.stgit@drishya>
In-Reply-To: <20140211065757.21159.49689.stgit@drishya>
References: <20140211065757.21159.49689.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

On POWER systems, the CPU frequency is controlled at a core-level and
hence we need to serialize so that only one of the threads in the core
switches the core's frequency at a time.

Using a global mutex lock would needlessly serialize _all_ frequency
transitions in the system (across all cores). So introduce per-core
locking to enable finer-grained synchronization and thereby enhance
the speed and responsiveness of the cpufreq driver to varying workload
demands.

The design of per-core locking is very simple and straight-forward: we
first define a Per-CPU lock and use the ones that belongs to the first
thread sibling of the core.

cpu_first_thread_sibling() macro is used to find the *common* lock for
all thread siblings belonging to a core.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ea3b630..8240e90 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -24,8 +24,15 @@
 #include <linux/of.h>
 #include <asm/cputhreads.h>
 
-/* FIXME: Make this per-core */
-static DEFINE_MUTEX(freq_switch_mutex);
+/* Per-Core locking for frequency transitions */
+static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
+
+#define lock_core_freq(cpu)				\
+			mutex_lock(&per_cpu(freq_switch_lock,\
+				cpu_first_thread_sibling(cpu)));
+#define unlock_core_freq(cpu)				\
+			mutex_unlock(&per_cpu(freq_switch_lock,\
+				cpu_first_thread_sibling(cpu)));
 
 #define POWERNV_MAX_PSTATES	256
 
@@ -219,7 +226,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
 	freqs.new = powernv_freqs[new_index].frequency;
 	freqs.cpu = policy->cpu;
 
-	mutex_lock(&freq_switch_mutex);
+	lock_core_freq(policy->cpu);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
@@ -231,7 +238,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
 	rc = powernv_set_freq(policy->cpus, new_index);
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-	mutex_unlock(&freq_switch_mutex);
+	unlock_core_freq(policy->cpu);
 
 	return rc;
 }
@@ -248,7 +255,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 
 static int __init powernv_cpufreq_init(void)
 {
-	int rc = 0;
+	int cpu, rc = 0;
 
 	/* Discover pstates from device tree and init */
 
@@ -258,6 +265,10 @@ static int __init powernv_cpufreq_init(void)
 		pr_info("powernv-cpufreq disabled\n");
 		return rc;
 	}
+	/* Init per-core mutex */
+	for_each_possible_cpu(cpu) {
+		mutex_init(&per_cpu(freq_switch_lock, cpu));
+	}
 
 	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
 	return rc;
