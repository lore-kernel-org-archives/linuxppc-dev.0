Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04EB7100D1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 06:59:14 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAQJxDMo030356
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:59:13 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAQJxD9p1802316
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:59:13 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAQJxCka013749
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2009 06:59:13 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH v6 2/2] pseries: Serialize cpu hotplug operations during
	deactivate Vs deallocate
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Fri, 27 Nov 2009 01:29:05 +0530
Message-ID: <20091126195905.29159.82837.stgit@drishya>
In-Reply-To: <20091126195121.29159.66098.stgit@drishya>
References: <20091126195121.29159.66098.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gautham R Shenoy <ego@in.ibm.com>

Currently the cpu-allocation/deallocation process comprises of two steps:
- Set the indicators and to update the device tree with DLPAR node
  information.

- Online/offline the allocated/deallocated CPU.

This is achieved by writing to the sysfs tunables "probe" during allocation
and "release" during deallocation.

At the sametime, the userspace can independently online/offline the CPUs of
the system using the sysfs tunable "online".

It is quite possible that when a userspace tool offlines a CPU
for the purpose of deallocation and is in the process of updating the device
tree, some other userspace tool could bring the CPU back online by writing to
the "online" sysfs tunable thereby causing the deallocate process to fail.

The solution to this is to serialize writes to the "probe/release" sysfs
tunable with the writes to the "online" sysfs tunable.

This patch employs a mutex to provide this serialization, which is a no-op on
all architectures except PPC_PSERIES

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/dlpar.c |   45 +++++++++++++++++++++++++-------
 drivers/base/cpu.c                     |    2 +
 include/linux/cpu.h                    |   13 +++++++++
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 642e1b2..fd2f0af 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -436,6 +436,18 @@ int dlpar_release_drc(u32 drc_index)
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 
+static DEFINE_MUTEX(pseries_cpu_hotplug_mutex);
+
+void cpu_hotplug_driver_lock()
+{
+	mutex_lock(&pseries_cpu_hotplug_mutex);
+}
+
+void cpu_hotplug_driver_unlock()
+{
+	mutex_unlock(&pseries_cpu_hotplug_mutex);
+}
+
 static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 {
 	struct device_node *dn;
@@ -443,13 +455,18 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	char *cpu_name;
 	int rc;
 
+	cpu_hotplug_driver_lock();
 	rc = strict_strtoul(buf, 0, &drc_index);
-	if (rc)
-		return -EINVAL;
+	if (rc) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	dn = dlpar_configure_connector(drc_index);
-	if (!dn)
-		return -EINVAL;
+	if (!dn) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	/* configure-connector reports cpus as living in the base
 	 * directory of the device tree.  CPUs actually live in the
@@ -459,7 +476,8 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 			   GFP_KERNEL);
 	if (!cpu_name) {
 		dlpar_free_cc_nodes(dn);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	sprintf(cpu_name, "/cpus%s", dn->full_name);
@@ -469,7 +487,8 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	rc = dlpar_acquire_drc(drc_index);
 	if (rc) {
 		dlpar_free_cc_nodes(dn);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	rc = dlpar_attach_node(dn);
@@ -479,6 +498,8 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	}
 
 	rc = online_node_cpus(dn);
+out:
+	cpu_hotplug_driver_unlock();
 
 	return rc ? rc : count;
 }
@@ -499,26 +520,30 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 		return -EINVAL;
 	}
 
+	cpu_hotplug_driver_lock();
 	rc = offline_node_cpus(dn);
 	if (rc) {
 		of_node_put(dn);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	rc = dlpar_release_drc(*drc_index);
 	if (rc) {
 		of_node_put(dn);
-		return -EINVAL;
+		goto out;
 	}
 
 	rc = dlpar_detach_node(dn);
 	if (rc) {
 		dlpar_acquire_drc(*drc_index);
-		return rc;
+		goto out;
 	}
 
 	of_node_put(dn);
-	return count;
+out:
+	cpu_hotplug_driver_unlock();
+	return rc ? rc : count;
 }
 
 static int __init pseries_dlpar_init(void)
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 7c03af7..27fd775 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -35,6 +35,7 @@ static ssize_t __ref store_online(struct sys_device *dev, struct sysdev_attribut
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 	ssize_t ret;
 
+	cpu_hotplug_driver_lock();
 	switch (buf[0]) {
 	case '0':
 		ret = cpu_down(cpu->sysdev.id);
@@ -49,6 +50,7 @@ static ssize_t __ref store_online(struct sys_device *dev, struct sysdev_attribut
 	default:
 		ret = -EINVAL;
 	}
+	cpu_hotplug_driver_unlock();
 
 	if (ret >= 0)
 		ret = count;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index c972f7c..e287863 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -117,6 +117,19 @@ extern void put_online_cpus(void);
 #define unregister_hotcpu_notifier(nb)	unregister_cpu_notifier(nb)
 int cpu_down(unsigned int cpu);
 
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+extern void cpu_hotplug_driver_lock(void);
+extern void cpu_hotplug_driver_unlock(void);
+#else
+static inline void cpu_hotplug_driver_lock(void)
+{
+}
+
+static inline void cpu_hotplug_driver_unlock(void)
+{
+}
+#endif
+
 #else		/* CONFIG_HOTPLUG_CPU */
 
 #define get_online_cpus()	do { } while (0)
