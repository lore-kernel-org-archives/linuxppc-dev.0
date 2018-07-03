Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kh8b4LvBzF1RL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 21:04:31 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63B4Ps9076083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 07:04:28 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k06deum9r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 07:04:27 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 05:04:03 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 1/2] powerpc: Detect the presence of big-cores via "ibm,
 thread-groups"
Date: Tue,  3 Jul 2018 16:33:50 +0530
In-Reply-To: <cover.1530609795.git.ego@linux.vnet.ibm.com>
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1530609795.git.ego@linux.vnet.ibm.com>
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
Message-Id: <b922aa0ea79a83ad733508c861900a08c4fee25a.1530609795.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On IBM POWER9, the device tree exposes a property array identifed by
"ibm,thread-groups" which will indicate which groups of threads share a
particular set of resources.

As of today we only have one form of grouping identifying the group of
threads in the core that share the L1 cache, translation cache and
instruction data flow.

This patch defines the helper function to parse the contents of
"ibm,thread-groups" and a new structure to contain the parsed output.

The patch also creates the sysfs file named "small_core_siblings" that
returns the physical ids of the threads in the core that share the L1
cache, translation cache and instruction data flow.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 ++
 arch/powerpc/include/asm/cputhreads.h              |  22 +++++
 arch/powerpc/kernel/setup-common.c                 | 110 +++++++++++++++++++++
 arch/powerpc/kernel/sysfs.c                        |  35 +++++++
 4 files changed, 175 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 9c5e7732..53a823a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -487,3 +487,11 @@ Description:	Information about CPU vulnerabilities
 		"Not affected"	  CPU is not affected by the vulnerability
 		"Vulnerable"	  CPU is affected and no mitigation in effect
 		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
+
+What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_sibings
+Date:		03-Jul-2018
+KernelVersion:	v4.18.0
+Contact:	Gautham R. Shenoy <ego@linux.vnet.ibm.com>
+Description:	List of Physical ids of CPUs which share the the L1 cache,
+		translation cache and instruction data-flow with this CPU.
+Values:		Comma separated list of decimal integers.
diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index d71a909..33226d7 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -23,11 +23,13 @@
 extern int threads_per_core;
 extern int threads_per_subcore;
 extern int threads_shift;
+extern bool has_big_cores;
 extern cpumask_t threads_core_mask;
 #else
 #define threads_per_core	1
 #define threads_per_subcore	1
 #define threads_shift		0
+#define has_big_cores		0
 #define threads_core_mask	(*get_cpu_mask(0))
 #endif
 
@@ -69,12 +71,32 @@ static inline cpumask_t cpu_online_cores_map(void)
 	return cpu_thread_mask_to_cores(cpu_online_mask);
 }
 
+#define MAX_THREAD_LIST_SIZE	8
+struct thread_groups {
+	unsigned int property;
+	unsigned int nr_groups;
+	unsigned int threads_per_group;
+	unsigned int thread_list[MAX_THREAD_LIST_SIZE];
+};
+
 #ifdef CONFIG_SMP
 int cpu_core_index_of_thread(int cpu);
 int cpu_first_thread_of_core(int core);
+int parse_thread_groups(struct device_node *dn, struct thread_groups *tg);
+int get_cpu_thread_group_start(int cpu, struct thread_groups *tg);
 #else
 static inline int cpu_core_index_of_thread(int cpu) { return cpu; }
 static inline int cpu_first_thread_of_core(int core) { return core; }
+static inline int parse_thread_groups(struct device_node *dn,
+				      struct thread_groups *tg)
+{
+	return -ENODATA;
+}
+
+static inline int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
+{
+	return -1;
+}
 #endif
 
 static inline int cpu_thread_in_core(int cpu)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 40b44bb..a78ec66 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -402,10 +402,12 @@ void __init check_for_initrd(void)
 #ifdef CONFIG_SMP
 
 int threads_per_core, threads_per_subcore, threads_shift;
+bool has_big_cores = true;
 cpumask_t threads_core_mask;
 EXPORT_SYMBOL_GPL(threads_per_core);
 EXPORT_SYMBOL_GPL(threads_per_subcore);
 EXPORT_SYMBOL_GPL(threads_shift);
+EXPORT_SYMBOL_GPL(has_big_cores);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
 static void __init cpu_init_thread_core_maps(int tpc)
@@ -433,6 +435,108 @@ static void __init cpu_init_thread_core_maps(int tpc)
 
 u32 *cpu_to_phys_id = NULL;
 
+/*
+ * parse_thread_groups: Parses the "ibm,thread-groups" device tree
+ *                      property for the CPU device node dn and stores
+ *                      the parsed output in the thread_groups
+ *                      structure tg.
+ *
+ * ibm,thread-groups[0..N-1] array defines which group of threads in
+ * the CPU-device node can be grouped together based on the property.
+ *
+ * ibm,thread-groups[0] tells us the property based on which the
+ * threads are being grouped together. If this value is 1, it implies
+ * that the threads in the same group share L1, translation cache.
+ *
+ * ibm,thread-groups[1] tells us how many such thread groups exist.
+ *
+ * ibm,thread-groups[2] tells us the number of threads in each such
+ * group.
+ *
+ * ibm,thread-groups[3..N-1] is the list of threads identified by
+ * "ibm,ppc-interrupt-server#s" arranged as per their membership in
+ * the grouping.
+ *
+ * Example: If ibm,thread-groups = [1,2,4,5,6,7,8,9,10,11,12] it
+ * implies that there are 2 groups of 4 threads each, where each group
+ * of threads share L1, translation cache.
+ *
+ * The "ibm,ppc-interrupt-server#s" of the first group is {5,6,7,8}
+ * and the "ibm,ppc-interrupt-server#s" of the second group is {9, 10,
+ * 11, 12} structure
+ *
+ * Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ */
+int parse_thread_groups(struct device_node *dn,
+			struct thread_groups *tg)
+{
+	unsigned int nr_groups, threads_per_group, property;
+	int i;
+	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
+	u32 *thread_list;
+	size_t total_threads;
+	int ret;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array, 3);
+
+	if (ret)
+		return ret;
+
+	property = thread_group_array[0];
+	nr_groups = thread_group_array[1];
+	threads_per_group = thread_group_array[2];
+	total_threads = nr_groups * threads_per_group;
+
+	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
+					 thread_group_array,
+					 3 + total_threads);
+	if (ret)
+		return ret;
+
+	thread_list = &thread_group_array[3];
+
+	for (i = 0 ; i < total_threads; i++)
+		tg->thread_list[i] = thread_list[i];
+
+	tg->property = property;
+	tg->nr_groups = nr_groups;
+	tg->threads_per_group = threads_per_group;
+
+	return 0;
+}
+
+/*
+ * get_cpu_thread_group_start : Searches the thread group in tg->thread_list
+ *                              that @cpu belongs to.
+ *
+ * Returns the index to tg->thread_list that points to the the start
+ * of the thread_group that @cpu belongs to.
+ *
+ * Returns -1 if cpu doesn't belong to any of the groups pointed
+ * to by tg->thread_list.
+ */
+int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
+{
+	int hw_cpu_id = get_hard_smp_processor_id(cpu);
+	int i, j;
+
+	for (i = 0; i < tg->nr_groups; i++) {
+		int group_start = i * tg->threads_per_group;
+
+		for (j = 0; j < tg->threads_per_group; j++) {
+			int idx = group_start + j;
+
+			if (tg->thread_list[idx] == hw_cpu_id)
+				return group_start;
+		}
+	}
+
+	return -1;
+}
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -467,6 +571,7 @@ void __init smp_setup_cpu_maps(void)
 		const __be32 *intserv;
 		__be32 cpu_be;
 		int j, len;
+		struct thread_groups tg = {.nr_groups = 0};
 
 		DBG("  * %pOF...\n", dn);
 
@@ -505,6 +610,11 @@ void __init smp_setup_cpu_maps(void)
 			cpu++;
 		}
 
+		if (parse_thread_groups(dn, &tg) ||
+		    tg.nr_groups < 1 || tg.property != 1) {
+			has_big_cores = false;
+		}
+
 		if (cpu >= nr_cpu_ids) {
 			of_node_put(dn);
 			break;
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..f5717de 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/cputhreads.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
 }
 static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
 
+static ssize_t show_small_core_siblings(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	struct device_node *dn = of_get_cpu_node(cpu->dev.id, NULL);
+	struct thread_groups tg;
+	int i, j;
+	ssize_t ret = 0;
+
+	if (parse_thread_groups(dn, &tg))
+		return -ENODATA;
+
+	i = get_cpu_thread_group_start(cpu->dev.id, &tg);
+
+	if (i == -1)
+		return -ENODATA;
+
+	for (j = 0; j < tg.threads_per_group - 1; j++)
+		ret += sprintf(buf + ret, "%d,", tg.thread_list[i + j]);
+
+	ret += sprintf(buf + ret, "%d\n", tg.thread_list[i + j]);
+
+	return ret;
+}
+static DEVICE_ATTR(small_core_siblings, 0444, show_small_core_siblings, NULL);
+
 static int __init topology_init(void)
 {
 	int cpu, r;
@@ -1048,6 +1076,13 @@ static int __init topology_init(void)
 			register_cpu(c, cpu);
 
 			device_create_file(&c->dev, &dev_attr_physical_id);
+
+			if (has_big_cores) {
+				const struct device_attribute *attr =
+				       &dev_attr_small_core_siblings;
+
+			       device_create_file(&c->dev, attr);
+			}
 		}
 	}
 	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
-- 
1.9.4
