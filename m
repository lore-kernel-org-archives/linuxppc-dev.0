Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F165B70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Oct 2010 06:45:38 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9GJhPPE010511
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2010 13:43:25 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o9GJjYp8156746
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2010 13:45:34 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9GJjXw7025905
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2010 13:45:34 -0600
Message-ID: <4CBA00DB.3080002@linux.vnet.ibm.com>
Date: Sat, 16 Oct 2010 14:45:31 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add support for Virtual Processor Home Node (VPHN)
Content-Type: multipart/mixed; boundary="------------030301060908050708050400"
Cc: markn@au1.ibm.com, antonb@au1.ibm.com, pmac@au1.ibm.com,
	Tony Breeds <tbreeds@au1.ibm.com>, lkessler@us.ibm.com,
	jlarrew@linux.vnet.ibm.com, Michael J Wolf <mjwolf@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030301060908050708050400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030301060908050708050400
Content-Type: text/plain;
 name="0001-powerpc-Add-support-for-Virtual-Processor-Home-Node-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-powerpc-Add-support-for-Virtual-Processor-Home-Node-.pa";
 filename*1="tch"

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

The SPLPAR option allows the platform to dispatch virtual processors on
physical processors that, due to the variable nature of work loads, are
temporarily free, thus improving the utilization of computing resources.
However, SPLPAR implies inconsistent mapping of virtual to physical
processors, thus defeating resource allocation software that attempts to
optimize performance on platforms that implement the NUMA option.

To bridge the gap between these two options, the VPHN option maintain a
substantially consistent mapping of a given virtual processor to a physical
processor or set of processors within a given associativity domain. When
allocating computing resources, the kernel can take advantage of this
statistically consistent mapping to improve processing performance.

VPHN mappings are substantially consistent but not static. For any given
dispatch cycle, a best effort is made by the hypervisor to dispatch the
virtual processor on a physical processor within a targeted associativity
domain (the virtual processor's home node). However, if processing capacity
within the home node is not available, some other physical processor is
assigned to meet the processing capacity entitlement. From time to time,
to optimize the total platform performance, it may be necessary for the
platform to change the home node of a given virtual processor.

The Virtual Processor Home Node feature addresses this by adding the
H_HOME_NODE_ASSOCIATIVITY hcall to retrieve the current associativity
domain information directly from the hypervisor for a given virtual
processor's home node. It also exposes a set of associativity change
counters in the Virtual Processor Area (VPA) of each processor to indicate
when associativity changes occur.

This patch sets a timer during boot that will periodically poll the
associativity change counters. When a change in associativity is detected,
it retrieves the new associativity domain information via the
H_HOME_NODE_ASSOCIATIVITY hcall and updates the NUMA node maps and sysfs
entries accordingly. The polling mechanism is also tied into the
ibm,suspend-me rtas call to stop/restart polling before/after a suspend,
hibernate, migrate, or checkpoint restart operation.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    3 +-
 arch/powerpc/include/asm/hvcall.h         |    3 +-
 arch/powerpc/include/asm/lppaca.h         |    5 +-
 arch/powerpc/include/asm/topology.h       |    6 +-
 arch/powerpc/kernel/rtas.c                |   15 ++
 arch/powerpc/mm/numa.c                    |  274 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 7 files changed, 293 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 20778a4..4ef662e 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -46,6 +46,7 @@
 #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
 #define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
+#define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 
 #ifndef __ASSEMBLY__
 
@@ -59,7 +60,7 @@ enum {
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
-		FW_FEATURE_CMO,
+		FW_FEATURE_CMO | FW_FEATURE_VPHN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index de03ca5..6de1e5f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -232,7 +232,8 @@
 #define H_GET_EM_PARMS		0x2B8
 #define H_SET_MPP		0x2D0
 #define H_GET_MPP		0x2D4
-#define MAX_HCALL_OPCODE	H_GET_MPP
+#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
+#define MAX_HCALL_OPCODE	H_HOME_NODE_ASSOCIATIVITY
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 14b592d..cc07d7f 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -62,7 +62,10 @@ struct lppaca {
 	volatile u32 dyn_pir;		// Dynamic ProcIdReg value	x20-x23
 	u32	dsei_data;           	// DSEI data                  	x24-x27
 	u64	sprg3;               	// SPRG3 value                	x28-x2F
-	u8	reserved3[80];		// Reserved			x30-x7F
+	u8	reserved3[40];		// Reserved			x30-x57
+	volatile u8 vphn_assoc_counts[8]; // Virtual processor home node
+					// associativity change counters x58-x5F
+	u8	reserved4[32];		// Reserved			x60-x7F
 
 //=============================================================================
 // CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
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
index 41048de..abfcdc7 100644
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
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 002878c..c182c2d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -20,10 +20,14 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/pfn.h>
+#include <linux/cpuset.h>
+#include <linux/node.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/system.h>
 #include <asm/smp.h>
+#include <asm/firmware.h>
+#include <asm/paca.h>
 
 static int numa_enabled = 1;
 
@@ -246,32 +250,41 @@ static void initialize_distance_lookup_table(int nid,
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
-static int of_node_to_nid_single(struct device_node *device)
+static int associativity_to_nid(const unsigned int *associativity)
 {
 	int nid = -1;
-	const unsigned int *tmp;
 
 	if (min_common_depth == -1)
 		goto out;
 
-	tmp = of_get_associativity(device);
-	if (!tmp)
-		goto out;
-
-	if (tmp[0] >= min_common_depth)
-		nid = tmp[min_common_depth];
+	if (associativity[0] >= min_common_depth)
+		nid = associativity[min_common_depth];
 
 	/* POWER4 LPAR uses 0xffff as invalid node */
 	if (nid == 0xffff || nid >= MAX_NUMNODES)
 		nid = -1;
 
-	if (nid > 0 && tmp[0] >= distance_ref_points_depth)
-		initialize_distance_lookup_table(nid, tmp);
+	if (nid > 0 && associativity[0] >= distance_ref_points_depth)
+		initialize_distance_lookup_table(nid, associativity);
 
 out:
 	return nid;
 }
 
+/* Returns the nid associated with the given device tree node,
+ * or -1 if not found.
+ */
+static int of_node_to_nid_single(struct device_node *device)
+{
+	int nid = -1;
+	const unsigned int *tmp;
+
+	tmp = of_get_associativity(device);
+	if (tmp)
+		nid = associativity_to_nid(tmp);
+	return nid;
+}
+
 /* Walk the device tree upwards, looking for an associativity id */
 int of_node_to_nid(struct device_node *device)
 {
@@ -1247,3 +1260,244 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 }
 
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+/* Vrtual Processor Home Node (VPHN) support */
+#define VPHN_NR_CHANGE_CTRS (8)
+static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
+static cpumask_t cpu_associativity_changes_mask;
+static void topology_work_fn(struct work_struct *work);
+static DECLARE_WORK(topology_work, topology_work_fn);
+static void topology_timer_fn(unsigned long ignored);
+static struct timer_list topology_timer =
+	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
+
+static void set_topology_timer(void);
+int stop_topology_update(void);
+
+/*
+ * Store the current values of the associativity change counters in the
+ * hypervisor.
+ */
+static void setup_cpu_associativity_change_counters(void)
+{
+	int cpu = 0;
+
+	for_each_possible_cpu(cpu) {
+		int i = 0;
+		u8 *counts = vphn_cpu_change_counts[cpu];
+		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+
+		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
+			counts[i] = hypervisor_counts[i];
+		}
+	}
+
+	return;
+}
+
+/*
+ * The hypervisor maintains a set of 8 associativity change counters in
+ * the VPA of each cpu that correspond to the associativity levels in the
+ * ibm,associativity-reference-points property. When an associativity
+ * level changes, the corresponding counter is incremented.
+ *
+ * Set a bit in cpu_associativity_changes_mask for each cpu whose home
+ * node associativity levels have changed.
+ */
+static void update_cpu_associativity_changes_mask(void)
+{
+	int cpu = 0;
+	cpumask_t *changes = &cpu_associativity_changes_mask;
+
+	cpumask_clear(changes);
+
+	for_each_possible_cpu(cpu) {
+		int i;
+		u8 *counts = vphn_cpu_change_counts[cpu];
+		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
+
+		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
+			if (hypervisor_counts[i] > counts[i]) {
+				counts[i] = hypervisor_counts[i];
+
+				if (!(cpumask_test_cpu(cpu, changes)))
+					cpumask_set_cpu(cpu, changes);
+			}
+		}
+	}
+
+	return;
+}
+
+/* 6 64-bit registers unpacked into 12 32-bit associativity values */
+#define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32))
+
+/*
+ * Convert the associativity domain numbers returned from the hypervisor
+ * to the sequence they would appear in the ibm,associativity property.
+ */
+static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
+{
+	int i = 0;
+	int nr_assoc_doms = 0;
+	const u16 *field = (const u16*) packed;
+
+#define VPHN_FIELD_UNUSED	(0xffff)
+#define VPHN_FIELD_MSB		(0x8000)
+#define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
+
+	for (i = 0; i < VPHN_ASSOC_BUFSIZE; i++) {
+		if (*field == VPHN_FIELD_UNUSED) {
+			/* All significant fields processed, and remaining
+			 * fields contain the reserved value of all 1's.
+			 * Just store them.
+			 */
+			unpacked[i] = *((u32*)field);
+			field += 2;
+		}
+		else if (*field & VPHN_FIELD_MSB) {
+			/* Data is in the lower 15 bits of this field */
+			unpacked[i] = *field & VPHN_FIELD_MASK;
+			field++;
+			nr_assoc_doms++;
+		}
+		else {
+			/* Data is in the lower 15 bits of this field
+			 * concatenated with the next 16 bit field
+			 */
+			unpacked[i] = *((u32*)field);
+			field += 2;
+			nr_assoc_doms++;
+		}
+	}
+
+	return nr_assoc_doms;
+}
+
+/*
+ * Retrieve the new associativity information for a virtual processor's
+ * home node.
+ */
+static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
+{
+	long rc = 0;
+	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	u64 flags = 1;
+	int hwcpu = get_hard_smp_processor_id(cpu);
+
+	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
+	vphn_unpack_associativity(retbuf, associativity);
+
+	return rc;
+}
+
+static long
+vphn_get_associativity(unsigned long cpu, unsigned int *associativity)
+{
+	long rc = 0;
+
+	rc = hcall_vphn(cpu, associativity);
+
+	switch (rc) {
+	case H_FUNCTION:
+		printk(KERN_INFO
+			"VPHN is not supported. Disabling polling...\n");
+		stop_topology_update();
+		break;
+	case H_HARDWARE:
+		printk(KERN_ERR
+			"hcall_vphn() experienced a hardware fault "
+			"preventing VPHN. Disabling polling...\n");
+		stop_topology_update();
+	}
+
+	return rc;
+}
+
+/*
+ * Update the node maps and sysfs entries for each cpu whose home node
+ * has changed.
+ */
+int arch_update_cpu_topology(void)
+{
+	int cpu = 0, nid = 0, old_nid = 0;
+	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	struct sys_device *sysdev = NULL;
+
+	for_each_cpu_mask(cpu, cpu_associativity_changes_mask) {
+		vphn_get_associativity(cpu, associativity);
+		nid = associativity_to_nid(associativity);
+
+		if (nid < 0 || !node_online(nid))
+			nid = first_online_node;
+
+		old_nid = numa_cpu_lookup_table[cpu];
+
+		/* Disable hotplug while we update the cpu
+		 * masks and sysfs.
+		 */
+		get_online_cpus();
+		unregister_cpu_under_node(cpu, old_nid);
+		unmap_cpu_from_node(cpu);
+		map_cpu_to_node(cpu, nid);
+		register_cpu_under_node(cpu, nid);
+		put_online_cpus();
+
+		sysdev = get_cpu_sysdev(cpu);
+		if (sysdev)
+			kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
+	}
+
+	return 1;
+}
+
+static void topology_work_fn(struct work_struct *work)
+{
+	rebuild_sched_domains();
+}
+
+void topology_schedule_update(void)
+{
+	schedule_work(&topology_work);
+}
+
+static void topology_timer_fn(unsigned long ignored)
+{
+	update_cpu_associativity_changes_mask();
+	if (!cpumask_empty(&cpu_associativity_changes_mask))
+		topology_schedule_update();
+	set_topology_timer();
+}
+
+static void set_topology_timer(void)
+{
+	topology_timer.data = 0;
+	topology_timer.expires = jiffies + 60 * HZ;
+	add_timer(&topology_timer);
+}
+
+/*
+ * Start polling for VPHN associativity changes.
+ */
+int __init init_topology_update(void)
+{
+	int rc = 0;
+
+	if (firmware_has_feature(FW_FEATURE_VPHN)) {
+		setup_cpu_associativity_change_counters();
+		init_timer_deferrable(&topology_timer);
+		set_topology_timer();
+		rc = 1;
+	}
+
+	return rc;
+}
+__initcall(init_topology_update);
+
+/*
+ * Disable polling for VPHN associativity changes.
+ */
+int stop_topology_update(void)
+{
+	return del_timer(&topology_timer);
+}
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 0a14d8c..0b0eff0 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -55,6 +55,7 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_XDABR,		"hcall-xdabr"},
 	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
 	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
+	{FW_FEATURE_VPHN,		"hcall-vphn"},
 };
 
 /* Build up the firmware features bitmask using the contents of
-- 
1.7.2.3


--------------030301060908050708050400--
