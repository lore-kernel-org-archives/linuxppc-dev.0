Return-Path: <rcj@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA3A92C011C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 07:32:10 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcj@linux.vnet.ibm.com>;
 Sat, 27 Apr 2013 07:27:05 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 50480357804A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 07:32:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3QLIIk818219070
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 07:18:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3QLW4JP011884
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 07:32:05 +1000
Date: Fri, 26 Apr 2013 16:32:03 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Bring all threads online prior to
 migration/hibernation
Message-ID: <20130426213203.GC3698@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch before a migration/hibernation all threads present but
not online will be brought online.  After migration/hibernation those
threads are taken back offline.

During migration/hibernation all online CPUs must call H_JOIN, this is
required by the hypervisor.  Without this patch, threads that are offline
(H_CEDE'd) will not be woken to make the H_JOIN call and the OS will be
deadlocked (all threads either JOIN'd or CEDE'd).

Cc: <stable@kernel.org>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h          |    2 +
 arch/powerpc/kernel/rtas.c               |   95 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/suspend.c |   22 +++++++
 3 files changed, 119 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index aef00c6..ee38f29 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -262,6 +262,8 @@ extern void rtas_progress(char *s, unsigned short hex);
 extern void rtas_initialize(void);
 extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
+extern int rtas_online_cpus_mask(cpumask_var_t cpus);
+extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
 extern int rtas_ibm_suspend_me(struct rtas_args *);
 
 struct rtc_time;
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 1fd6e7b..855ee98 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -807,6 +808,77 @@ static void rtas_percpu_suspend_me(void *info)
 	__rtas_suspend_cpu((struct rtas_suspend_me_data *)info, 1);
 }
 
+enum rtas_cpu_state {
+	DOWN,
+	UP,
+};
+
+/* On return cpumask will be altered to indicate CPUs changed */
+static int rtas_cpu_state_change_mask(enum rtas_cpu_state state,
+				cpumask_var_t cpus)
+{
+	int cpu;
+	int cpuret = 0;
+	int ret = 0;
+
+	if (cpumask_empty(cpus))
+		return 0;
+
+	for_each_cpu(cpu, cpus) {
+		switch (state) {
+		case DOWN:
+			cpuret = cpu_down(cpu);
+			break;
+		case UP:
+			cpuret = cpu_up(cpu);
+			break;
+		}
+		if (cpuret) {
+			pr_debug("%s: cpu_%s for cpu#%d returned %d.\n",
+					__func__,
+					((state == UP) ? "up" : "down"),
+					cpu, cpuret);
+			if (!ret)
+				ret = cpuret;
+			if (state == UP) {
+				cpumask_shift_right(cpus, cpus, cpu);
+				cpumask_shift_left(cpus, cpus, cpu);
+				break;
+			} else
+				cpumask_clear_cpu(cpu, cpus);
+		}
+	}
+
+	return ret;
+}
+
+int rtas_online_cpus_mask(cpumask_var_t cpus)
+{
+	int ret;
+
+	ret = rtas_cpu_state_change_mask(UP, cpus);
+
+	if (ret) {
+		cpumask_var_t tmp_mask;
+
+		if (!alloc_cpumask_var(&tmp_mask, GFP_TEMPORARY))
+			return ret;
+
+		cpumask_copy(tmp_mask, cpus);
+		rtas_offline_cpus_mask(tmp_mask);
+		free_cpumask_var(tmp_mask);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(rtas_online_cpus_mask);
+
+int rtas_offline_cpus_mask(cpumask_var_t cpus)
+{
+	return rtas_cpu_state_change_mask(DOWN, cpus);
+}
+EXPORT_SYMBOL(rtas_offline_cpus_mask);
+
 int rtas_ibm_suspend_me(struct rtas_args *args)
 {
 	long state;
@@ -814,6 +886,8 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	struct rtas_suspend_me_data data;
 	DECLARE_COMPLETION_ONSTACK(done);
+	cpumask_var_t offline_mask;
+	int cpuret;
 
 	if (!rtas_service_present("ibm,suspend-me"))
 		return -ENOSYS;
@@ -837,11 +911,24 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 		return 0;
 	}
 
+	if (!alloc_cpumask_var(&offline_mask, GFP_TEMPORARY))
+		return -ENOMEM;
+
 	atomic_set(&data.working, 0);
 	atomic_set(&data.done, 0);
 	atomic_set(&data.error, 0);
 	data.token = rtas_token("ibm,suspend-me");
 	data.complete = &done;
+
+	/* All present CPUs must be online */
+	cpumask_andnot(offline_mask, cpu_present_mask, cpu_online_mask);
+	cpuret = rtas_online_cpus_mask(offline_mask);
+	if (cpuret) {
+		pr_err("%s: Could not bring present CPUs online.\n", __func__);
+		atomic_set(&data.error, cpuret);
+		goto out;
+	}
+
 	stop_topology_update();
 
 	/* Call function on all CPUs.  One of us will make the
@@ -857,6 +944,14 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 
 	start_topology_update();
 
+	/* Take down CPUs not online prior to suspend */
+	cpuret = rtas_offline_cpus_mask(offline_mask);
+	if (cpuret)
+		pr_warn("%s: Could not restore CPUs to offline state.\n",
+				__func__);
+
+out:
+	free_cpumask_var(offline_mask);
 	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 47226e0..5f997e7 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -16,6 +16,7 @@
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
   */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/suspend.h>
 #include <linux/stat.h>
@@ -126,11 +127,15 @@ static ssize_t store_hibernate(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
+	cpumask_var_t offline_mask;
 	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!alloc_cpumask_var(&offline_mask, GFP_TEMPORARY))
+		return -ENOMEM;
+
 	stream_id = simple_strtoul(buf, NULL, 16);
 
 	do {
@@ -140,15 +145,32 @@ static ssize_t store_hibernate(struct device *dev,
 	} while (rc == -EAGAIN);
 
 	if (!rc) {
+		/* All present CPUs must be online */
+		cpumask_andnot(offline_mask, cpu_present_mask,
+				cpu_online_mask);
+		rc = rtas_online_cpus_mask(offline_mask);
+		if (rc) {
+			pr_err("%s: Could not bring present CPUs online.\n",
+					__func__);
+			goto out;
+		}
+
 		stop_topology_update();
 		rc = pm_suspend(PM_SUSPEND_MEM);
 		start_topology_update();
+
+		/* Take down CPUs not online prior to suspend */
+		if (!rtas_offline_cpus_mask(offline_mask))
+			pr_warn("%s: Could not restore CPUs to offline "
+					"state.\n", __func__);
 	}
 
 	stream_id = 0;
 
 	if (!rc)
 		rc = count;
+out:
+	free_cpumask_var(offline_mask);
 	return rc;
 }
 
-- 
1.7.10.4
