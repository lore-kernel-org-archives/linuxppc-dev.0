Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97D39B7CB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Feb 2010 11:02:36 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1NNspR1030439
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 16:54:51 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o1O02PUK210186
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 17:02:26 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1O02PCU031069
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 17:02:25 -0700
Message-Id: <201002240002.o1O02OBe031005@d03av05.boulder.ibm.com>
Subject: [PATCH 1/2] powerpc: Partition hibernation support
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2010 18:02:33 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Enables support for HMC initiated partition hibernation. This is
a firmware assisted hibernation, since the firmware handles writing
the memory out to disk, along with other partition information,
so we just mimic suspend to ram.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/Kconfig                         |    2 
 arch/powerpc/include/asm/hvcall.h            |    1 
 arch/powerpc/include/asm/machdep.h           |    1 
 arch/powerpc/include/asm/rtas.h              |   10 +
 arch/powerpc/kernel/rtas.c                   |  118 ++++++++++-----
 arch/powerpc/platforms/pseries/Makefile      |    1 
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    6 
 arch/powerpc/platforms/pseries/suspend.c     |  209 +++++++++++++++++++++++++++
 8 files changed, 312 insertions(+), 36 deletions(-)

diff -puN /dev/null arch/powerpc/platforms/pseries/suspend.c
--- /dev/null	2009-12-15 17:58:07.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/suspend.c	2010-02-23 16:29:25.000000000 -0600
@@ -0,0 +1,209 @@
+/*
+  * Copyright (C) 2010 Brian King IBM Corporation
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, write to the Free Software
+  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+  */
+
+#include <linux/suspend.h>
+#include <asm/hvcall.h>
+#include <asm/machdep.h>
+#include <asm/mmu.h>
+#include <asm/rtas.h>
+
+static u64 stream_id;
+static struct sys_device suspend_sysdev;
+static DECLARE_COMPLETION(suspend_work);
+static struct rtas_suspend_me_data suspend_data;
+static atomic_t suspending;
+
+/**
+ * pseries_suspend_begin - First phase of hibernation
+ *
+ * Check to ensure we are in a valid state to hibernate
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int pseries_suspend_begin(suspend_state_t state)
+{
+	long vs, rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	if (!rtas_service_present("ibm,suspend-me"))
+		return -ENOSYS;
+
+	/* Make sure the state is valid */
+	rc = plpar_hcall(H_VASI_STATE, retbuf, stream_id);
+
+	vs = retbuf[0];
+
+	if (rc) {
+		pr_err("pseries_suspend_begin: vasi_state returned %ld\n",rc);
+		return rc;
+	} else if (vs == H_VASI_ENABLED) {
+		return RTAS_NOT_SUSPENDABLE;
+	} else if (vs != H_VASI_SUSPENDING) {
+		pr_err("pseries_suspend_begin: vasi_state returned state %ld\n", vs);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * pseries_suspend_cpu - Suspend a single CPU
+ *
+ * Makes the H_JOIN call to suspend the CPU
+ *
+ **/
+static int pseries_suspend_cpu(void)
+{
+	if (atomic_read(&suspending))
+		return rtas_suspend_cpu(&suspend_data);
+	return 0;
+}
+
+/**
+ * pseries_suspend_enter - Final phase of hibernation
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int pseries_suspend_enter(suspend_state_t state)
+{
+	int rc = rtas_suspend_last_cpu(&suspend_data);
+
+	atomic_set(&suspending, 0);
+	atomic_set(&suspend_data.done, 1);
+	return rc;
+}
+
+/**
+ * pseries_prepare_late - Suspend all other CPUs
+ *
+ * Call H_JOIN for all CPUs except for this CPU
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int pseries_prepare_late(void)
+{
+	atomic_set(&suspending, 1);
+	atomic_set(&suspend_data.working, 0);
+	atomic_set(&suspend_data.done, 0);
+	atomic_set(&suspend_data.error, 0);
+	suspend_data.token = rtas_token("ibm,suspend-me");
+	suspend_data.complete = &suspend_work;
+	INIT_COMPLETION(suspend_work);
+	return 0;
+}
+
+/**
+ * store_hibernate - Initiate partition hibernation
+ * @dev:	device struct
+ * @attr:	device attribute struct
+ * @buf:	buffer
+ * @count:	buffer size
+ *
+ * Write the stream ID received from the HMC to this file
+ * to trigger hibernating the partition
+ *
+ * Return value:
+ * 	number of bytes printed to buffer / other on failure
+ **/
+static ssize_t store_hibernate(struct sys_device *dev,
+			       struct sysdev_attribute *attr,
+			       const char *buf, size_t count)
+{
+	unsigned long long val = simple_strtoull (buf, NULL, 16);
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	stream_id = val;
+	rc = pseries_suspend_begin(PM_SUSPEND_MEM);
+	if (!rc)
+		rc = pm_suspend(PM_SUSPEND_MEM);
+
+	stream_id = 0;
+
+	if (!rc)
+		rc = count;
+	return rc;
+}
+
+static SYSDEV_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
+
+static struct sysdev_class suspend_sysdev_class = {
+	.name = "power",
+};
+
+static struct platform_suspend_ops pseries_suspend_ops = {
+	.valid		= suspend_valid_only_mem,
+	.begin		= pseries_suspend_begin,
+	.prepare_late	= pseries_prepare_late,
+	.enter		= pseries_suspend_enter,
+};
+
+/**
+ * pseries_suspend_sysfs_register - Register with sysfs
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int pseries_suspend_sysfs_register(struct sys_device *sysdev)
+{
+	int rc;
+
+	if ((rc = sysdev_class_register(&suspend_sysdev_class)))
+		return rc;
+
+	sysdev->id = 0;
+	sysdev->cls = &suspend_sysdev_class;
+
+	if ((rc = sysdev_register(sysdev)))
+		goto class_unregister;
+	if ((rc = sysdev_create_file(sysdev, &attr_hibernate)))
+		goto fail;
+
+	return 0;
+
+fail:
+	sysdev_unregister(sysdev);
+class_unregister:
+	sysdev_class_unregister(&suspend_sysdev_class);
+	return rc;
+}
+
+/**
+ * pseries_suspend_init - initcall for pSeries suspend
+ *
+ * Return value:
+ * 	0 on success / other on failure
+ **/
+static int __init pseries_suspend_init(void)
+{
+	int rc;
+
+	if ((rc = pseries_suspend_sysfs_register(&suspend_sysdev)))
+		return rc;
+
+	ppc_md.suspend_disable_cpu = pseries_suspend_cpu;
+	suspend_set_ops(&pseries_suspend_ops);
+	return 0;
+}
+
+__initcall(pseries_suspend_init);
diff -puN arch/powerpc/kernel/rtas.c~powerpc_allarch_pseries_hibernation arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2010-02-23 15:33:06.000000000 -0600
@@ -46,14 +46,6 @@ struct rtas_t rtas = {
 };
 EXPORT_SYMBOL(rtas);
 
-struct rtas_suspend_me_data {
-	atomic_t working; /* number of cpus accessing this struct */
-	atomic_t done;
-	int token; /* ibm,suspend-me */
-	int error;
-	struct completion *complete; /* wait on this until working == 0 */
-};
-
 DEFINE_SPINLOCK(rtas_data_buf_lock);
 EXPORT_SYMBOL(rtas_data_buf_lock);
 
@@ -710,14 +702,54 @@ void rtas_os_term(char *str)
 
 static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
 #ifdef CONFIG_PPC_PSERIES
-static void rtas_percpu_suspend_me(void *info)
+static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
+{
+	u16 slb_size = mmu_slb_size;
+	int rc = H_MULTI_THREADS_ACTIVE;
+	int cpu;
+
+	atomic_inc(&data->working);
+
+	slb_set_size(SLB_MIN_SIZE);
+	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
+
+	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
+	       !atomic_read(&data->error))
+		rc = rtas_call(data->token, 0, 1, NULL);
+
+	if (rc || atomic_read(&data->error)) {
+		printk(KERN_DEBUG "ibm,suspend-me returned %d\n", rc);
+		slb_set_size(slb_size);
+	}
+
+	if (atomic_read(&data->error))
+		rc = atomic_read(&data->error);
+
+	atomic_set(&data->error, rc);
+
+	if (wake_when_done) {
+		atomic_set(&data->done, 1);
+
+		for_each_online_cpu(cpu)
+			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+	}
+
+	if (atomic_dec_return(&data->working) == 0)
+		complete(data->complete);
+
+	return rc;
+}
+
+int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
+{
+	return __rtas_suspend_last_cpu(data, 0);
+}
+
+static int __rtas_suspend_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
 {
 	long rc = H_SUCCESS;
 	unsigned long msr_save;
-	u16 slb_size = mmu_slb_size;
 	int cpu;
-	struct rtas_suspend_me_data *data =
-		(struct rtas_suspend_me_data *)info;
 
 	atomic_inc(&data->working);
 
@@ -725,7 +757,7 @@ static void rtas_percpu_suspend_me(void
 	msr_save = mfmsr();
 	mtmsr(msr_save & ~(MSR_EE));
 
-	while (rc == H_SUCCESS && !atomic_read(&data->done))
+	while (rc == H_SUCCESS && !atomic_read(&data->done) && !atomic_read(&data->error))
 		rc = plpar_hcall_norets(H_JOIN);
 
 	mtmsr(msr_save);
@@ -737,33 +769,37 @@ static void rtas_percpu_suspend_me(void
 		/* All other cpus are in H_JOIN, this cpu does
 		 * the suspend.
 		 */
-		slb_set_size(SLB_MIN_SIZE);
-		printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n",
-		       smp_processor_id());
-		data->error = rtas_call(data->token, 0, 1, NULL);
-
-		if (data->error) {
-			printk(KERN_DEBUG "ibm,suspend-me returned %d\n",
-			       data->error);
-			slb_set_size(slb_size);
-		}
+		return __rtas_suspend_last_cpu(data, wake_when_done);
 	} else {
 		printk(KERN_ERR "H_JOIN on cpu %i failed with rc = %ld\n",
 		       smp_processor_id(), rc);
-		data->error = rc;
+		atomic_set(&data->error, rc);
 	}
 
-	atomic_set(&data->done, 1);
+	if (wake_when_done) {
+		atomic_set(&data->done, 1);
 
-	/* This cpu did the suspend or got an error; in either case,
-	 * we need to prod all other other cpus out of join state.
-	 * Extra prods are harmless.
-	 */
-	for_each_online_cpu(cpu)
-		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+		/* This cpu did the suspend or got an error; in either case,
+		 * we need to prod all other other cpus out of join state.
+		 * Extra prods are harmless.
+		 */
+		for_each_online_cpu(cpu)
+			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+	}
 out:
 	if (atomic_dec_return(&data->working) == 0)
 		complete(data->complete);
+	return rc;
+}
+
+int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
+{
+	return __rtas_suspend_cpu(data, 0);
+}
+
+static void rtas_percpu_suspend_me(void *info)
+{
+	__rtas_suspend_cpu((struct rtas_suspend_me_data *)info, 1);
 }
 
 static int rtas_ibm_suspend_me(struct rtas_args *args)
@@ -798,29 +834,41 @@ static int rtas_ibm_suspend_me(struct rt
 
 	atomic_set(&data.working, 0);
 	atomic_set(&data.done, 0);
+	atomic_set(&data.error, 0);
 	data.token = rtas_token("ibm,suspend-me");
-	data.error = 0;
 	data.complete = &done;
 
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
 	if (on_each_cpu(rtas_percpu_suspend_me, &data, 0))
-		data.error = -EINVAL;
+		atomic_set(&data.error, -EINVAL);
 
 	wait_for_completion(&done);
 
-	if (data.error != 0)
+	if (atomic_read(&data.error) != 0)
 		printk(KERN_ERR "Error doing global join\n");
 
-	return data.error;
+	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
 static int rtas_ibm_suspend_me(struct rtas_args *args)
 {
 	return -ENOSYS;
 }
+
+int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
+{
+	return -ENOSYS;
+}
+
+int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
+{
+	return -ENOSYS;
+}
 #endif
+EXPORT_SYMBOL_GPL(rtas_suspend_cpu);
+EXPORT_SYMBOL_GPL(rtas_suspend_last_cpu);
 
 asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 {
diff -puN arch/powerpc/include/asm/rtas.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/rtas.h
--- linux-2.6/arch/powerpc/include/asm/rtas.h~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/include/asm/rtas.h	2010-02-23 15:33:06.000000000 -0600
@@ -63,6 +63,14 @@ struct rtas_t {
 	struct device_node *dev;	/* virtual address pointer */
 };
 
+struct rtas_suspend_me_data {
+	atomic_t working; /* number of cpus accessing this struct */
+	atomic_t done;
+	int token; /* ibm,suspend-me */
+	atomic_t error;
+	struct completion *complete; /* wait on this until working == 0 */
+};
+
 /* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
@@ -174,6 +182,8 @@ extern int rtas_set_indicator(int indica
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
 extern void rtas_initialize(void);
+extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
+extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
 
 struct rtc_time;
 extern unsigned long rtas_get_boot_time(void);
diff -puN arch/powerpc/Kconfig~powerpc_allarch_pseries_hibernation arch/powerpc/Kconfig
--- linux-2.6/arch/powerpc/Kconfig~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/Kconfig	2010-02-23 15:33:06.000000000 -0600
@@ -216,7 +216,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   PPC_85xx || PPC_86xx
+		   PPC_85xx || PPC_86xx || PPC_PSERIES
 
 config PPC_DCR_NATIVE
 	bool
diff -puN arch/powerpc/platforms/pseries/Makefile~powerpc_allarch_pseries_hibernation arch/powerpc/platforms/pseries/Makefile
--- linux-2.6/arch/powerpc/platforms/pseries/Makefile~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/Makefile	2010-02-23 15:33:06.000000000 -0600
@@ -26,3 +26,4 @@ obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst
 obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
+obj-$(CONFIG_SUSPEND)		+= suspend.o
diff -puN arch/powerpc/include/asm/hvcall.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/hvcall.h
--- linux-2.6/arch/powerpc/include/asm/hvcall.h~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/include/asm/hvcall.h	2010-02-23 15:33:06.000000000 -0600
@@ -74,6 +74,7 @@
 #define H_NOT_ENOUGH_RESOURCES -44
 #define H_R_STATE       -45
 #define H_RESCINDEND    -46
+#define H_MULTI_THREADS_ACTIVE -9005
 
 
 /* Long Busy is a condition that can be returned by the firmware
diff -puN arch/powerpc/include/asm/machdep.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/machdep.h
--- linux-2.6/arch/powerpc/include/asm/machdep.h~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/include/asm/machdep.h	2010-02-23 15:33:06.000000000 -0600
@@ -265,6 +265,7 @@ struct machdep_calls {
 	 */
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
+	int (*suspend_disable_cpu)(void);
 #endif
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
diff -puN arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_allarch_pseries_hibernation arch/powerpc/platforms/pseries/hotplug-cpu.c
--- linux-2.6/arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_allarch_pseries_hibernation	2010-02-23 15:33:06.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-02-23 15:33:06.000000000 -0600
@@ -116,6 +116,12 @@ static void pseries_mach_cpu_die(void)
 
 	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
 		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
+		if (ppc_md.suspend_disable_cpu)
+			ppc_md.suspend_disable_cpu();
+	}
+
+	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
+		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
 		cede_latency_hint = 2;
 
 		get_lppaca()->idle = 1;
_
