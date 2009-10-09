Return-Path: <ego@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D929B8A5E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 19:31:10 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id n998V69v028693
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 14:01:06 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n998V62H2486272
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 14:01:06 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n998V5QD013022
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 19:31:06 +1100
Subject: [PATCH v4 4/4] pseries: Serialize cpu hotplug operations during
	deactivate Vs deallocate
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Fri, 09 Oct 2009 14:01:05 +0530
Message-ID: <20091009083105.32381.42354.stgit@sofia.in.ibm.com>
In-Reply-To: <20091009082952.32381.32794.stgit@sofia.in.ibm.com>
References: <20091009082952.32381.32794.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 arch/powerpc/platforms/pseries/dlpar.c |   26 ++++++++++++++++++++++----
 drivers/base/cpu.c                     |    2 ++
 include/linux/cpu.h                    |   13 +++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 9752386..fc261e6 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -644,6 +644,18 @@ static ssize_t memory_release_store(struct class *class, const char *buf,
 	return rc ? -1 : count;
 }
 
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
 static ssize_t cpu_probe_store(struct class *class, const char *buf,
 			       size_t count)
 {
@@ -656,14 +668,15 @@ static ssize_t cpu_probe_store(struct class *class, const char *buf,
 	if (rc)
 		return -EINVAL;
 
+	cpu_hotplug_driver_lock();
 	rc = acquire_drc(drc_index);
 	if (rc)
-		return rc;
+		goto out;
 
 	dn = configure_connector(drc_index);
 	if (!dn) {
 		release_drc(drc_index);
-		return rc;
+		goto out;
 	}
 
 	/* fixup dn name */
@@ -672,7 +685,8 @@ static ssize_t cpu_probe_store(struct class *class, const char *buf,
 	if (!cpu_name) {
 		free_cc_nodes(dn);
 		release_drc(drc_index);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	sprintf(cpu_name, "/cpus/%s", dn->full_name);
@@ -684,6 +698,8 @@ static ssize_t cpu_probe_store(struct class *class, const char *buf,
 		release_drc(drc_index);
 
 	rc = online_node_cpus(dn);
+out:
+	cpu_hotplug_driver_unlock();
 
 	return rc ? rc : count;
 }
@@ -705,6 +721,7 @@ static ssize_t cpu_release_store(struct class *class, const char *buf,
 		return -EINVAL;
 	}
 
+	cpu_hotplug_driver_lock();
 	rc = offline_node_cpus(dn);
 
 	if (rc)
@@ -713,7 +730,7 @@ static ssize_t cpu_release_store(struct class *class, const char *buf,
 	rc = release_drc(*drc_index);
 	if (rc) {
 		of_node_put(dn);
-		return rc;
+		goto out;
 	}
 
 	rc = remove_device_tree_nodes(dn);
@@ -723,6 +740,7 @@ static ssize_t cpu_release_store(struct class *class, const char *buf,
 	of_node_put(dn);
 
 out:
+	cpu_hotplug_driver_unlock();
 	return rc ? rc : count;
 }
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index e62a4cc..07c3f05 100644
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
index 4753619..b0ad4e1 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -115,6 +115,19 @@ extern void put_online_cpus(void);
 #define unregister_hotcpu_notifier(nb)	unregister_cpu_notifier(nb)
 int cpu_down(unsigned int cpu);
 
+#ifdef CONFIG_PPC_PSERIES
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
