Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6638B6F12
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286W40m001542
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:04 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdG42461748
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdmZ021111
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/18] powerpc/smp: Create idle threads on demand and properly
	reset them
Date: Tue,  8 Mar 2011 17:37:28 +1100
Message-Id: <1299566250-10516-17-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of creating idle threads at boot for all possible CPUs, we
create them on demand, like x86 or ARM, and we properly call init_idle
to re-initialize an idle thread when a CPU was unplugged and is now
re-plugged.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c |  100 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7beb001..e337073 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -57,6 +57,25 @@
 #define DBG(fmt...)
 #endif
 
+
+/* Store all idle threads, this can be reused instead of creating
+* a new thread. Also avoids complicated thread destroy functionality
+* for idle threads.
+*/
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * Needed only for CONFIG_HOTPLUG_CPU because __cpuinitdata is
+ * removed after init for !CONFIG_HOTPLUG_CPU.
+ */
+static DEFINE_PER_CPU(struct task_struct *, idle_thread_array);
+#define get_idle_for_cpu(x)      (per_cpu(idle_thread_array, x))
+#define set_idle_for_cpu(x, p)   (per_cpu(idle_thread_array, x) = (p))
+#else
+static struct task_struct *idle_thread_array[NR_CPUS] __cpuinitdata ;
+#define get_idle_for_cpu(x)      (idle_thread_array[(x)])
+#define set_idle_for_cpu(x, p)   (idle_thread_array[(x)] = (p))
+#endif
+
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
@@ -238,23 +257,6 @@ static void __devinit smp_store_cpu_info(int id)
 	per_cpu(cpu_pvr, id) = mfspr(SPRN_PVR);
 }
 
-static void __init smp_create_idle(unsigned int cpu)
-{
-	struct task_struct *p;
-
-	/* create a process for the processor */
-	p = fork_idle(cpu);
-	if (IS_ERR(p))
-		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-#ifdef CONFIG_PPC64
-	paca[cpu].__current = p;
-	paca[cpu].kstack = (unsigned long) task_thread_info(p)
-		+ THREAD_SIZE - STACK_FRAME_OVERHEAD;
-#endif
-	current_set[cpu] = task_thread_info(p);
-	task_thread_info(p)->cpu = cpu;
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu;
@@ -288,10 +290,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			max_cpus = NR_CPUS;
 	else
 		max_cpus = 1;
-
-	for_each_possible_cpu(cpu)
-		if (cpu != boot_cpuid)
-			smp_create_idle(cpu);
 }
 
 void __devinit smp_prepare_boot_cpu(void)
@@ -355,9 +353,62 @@ void generic_set_cpu_dead(unsigned int cpu)
 }
 #endif
 
+struct create_idle {
+	struct work_struct work;
+	struct task_struct *idle;
+	struct completion done;
+	int cpu;
+};
+
+static void __cpuinit do_fork_idle(struct work_struct *work)
+{
+	struct create_idle *c_idle =
+		container_of(work, struct create_idle, work);
+
+	c_idle->idle = fork_idle(c_idle->cpu);
+	complete(&c_idle->done);
+}
+
+static int __cpuinit create_idle(unsigned int cpu)
+{
+	struct thread_info *ti;
+	struct create_idle c_idle = {
+		.cpu	= cpu,
+		.done	= COMPLETION_INITIALIZER_ONSTACK(c_idle.done),
+	};
+	INIT_WORK_ONSTACK(&c_idle.work, do_fork_idle);
+
+	c_idle.idle = get_idle_for_cpu(cpu);
+
+	/* We can't use kernel_thread since we must avoid to
+	 * reschedule the child. We use a workqueue because
+	 * we want to fork from a kernel thread, not whatever
+	 * userspace process happens to be trying to online us.
+	 */
+	if (!c_idle.idle) {
+		schedule_work(&c_idle.work);
+		wait_for_completion(&c_idle.done);
+	} else
+		init_idle(c_idle.idle, cpu);
+	if (IS_ERR(c_idle.idle)) {		
+		pr_err("Failed fork for CPU %u: %li", cpu, PTR_ERR(c_idle.idle));
+		return PTR_ERR(c_idle.idle);
+	}
+	ti = task_thread_info(c_idle.idle);
+
+#ifdef CONFIG_PPC64
+	paca[cpu].__current = c_idle.idle;
+	paca[cpu].kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+#endif
+	ti->cpu = cpu;
+	current_set[cpu] = ti;
+
+	return 0;
+}
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
-	int c;
+	int rc, c;
 
 	secondary_ti = current_set[cpu];
 
@@ -365,6 +416,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
 		return -EINVAL;
 
+	/* Make sure we have an idle thread */
+	rc = create_idle(cpu);
+	if (rc)
+		return rc;
+
 	/* Make sure callin-map entry is 0 (can be leftover a CPU
 	 * hotplug
 	 */
-- 
1.7.1
