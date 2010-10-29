Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0030B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 11:30:26 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9T0E8Aj021844
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 20:14:08 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9T0ULs41781954
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 20:30:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9T0UKh8011666
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 20:30:21 -0400
Date: Thu, 28 Oct 2010 20:30:17 -0400
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101029002921.17835.88560.sendpatchset@manic8ball.ltc.austin.ibm.com>
In-Reply-To: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH 3/3] powerpc: Disable VPHN polling during a suspend operation
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Tie the polling mechanism into the ibm,suspend-me rtas call to
stop/restart polling before/after a suspend, hibernate, migrate,
or checkpoint restart operation. This ensures that the system has a
chance to disable the polling if the partition is migrated to a system
that does not support VPHN (and vice versa).

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |    6 +++++-
 arch/powerpc/kernel/rtas.c          |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index afe4aaa..1747d27 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -49,7 +49,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 {
 	return -1;
 }
-#endif
+#endif /* CONFIG_PCI */
 
 #define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
 				 cpu_all_mask :				\
@@ -93,6 +93,8 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
 
+extern int __init init_topology_update(void);
+extern int stop_topology_update(void);
 #else
 
 static inline void dump_numa_cpu_topology(void) {}
@@ -107,6 +109,8 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
 {
 }
 
+static int __init init_topology_update(void) {}
+static int stop_topology_update(void) {}
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8fe8bc6..317ff2f 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -41,6 +41,7 @@
 #include <asm/atomic.h>
 #include <asm/time.h>
 #include <asm/mmu.h>
+#include <asm/topology.h>
 
 struct rtas_t rtas = {
 	.lock = __ARCH_SPIN_LOCK_UNLOCKED
@@ -706,6 +707,18 @@ void rtas_os_term(char *str)
 
 static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
 #ifdef CONFIG_PPC_PSERIES
+static void pre_suspend_work(void)
+{
+	stop_topology_update();
+	return;
+}
+
+static void post_suspend_work(void)
+{
+	init_topology_update();
+	return;
+}
+
 static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
 {
 	u16 slb_size = mmu_slb_size;
@@ -713,6 +726,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
 	int cpu;
 
 	slb_set_size(SLB_MIN_SIZE);
+	pre_suspend_work();
 	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
 
 	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
@@ -728,6 +742,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
 		rc = atomic_read(&data->error);
 
 	atomic_set(&data->error, rc);
+	post_suspend_work();
 
 	if (wake_when_done) {
 		atomic_set(&data->done, 1);
-- 
1.7.2.3
