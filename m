Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDA93B7127
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Nov 2010 10:25:08 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA9N8V03004507
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Nov 2010 18:08:31 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA9NP4jj160822
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Nov 2010 18:25:05 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oA9NP4Nr030167
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Nov 2010 16:25:04 -0700
Date: Tue, 9 Nov 2010 16:25:01 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101109232501.17098.55112.sendpatchset@manic8ball.ltc.austin.ibm.com>
In-Reply-To: <20101109232436.17098.20055.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101109232436.17098.20055.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH V2 2/3] powerpc: Poll VPA for topology changes and update NUMA
	maps
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

This patch sets a timer during boot that will periodically poll the
associativity change counters in the VPA. When a change in 
associativity is detected, it retrieves the new associativity domain 
information via the H_HOME_NODE_ASSOCIATIVITY hcall and updates the 
NUMA node maps and sysfs entries accordingly. Note that since the 
ibm,associativity device tree property does not exist on configurations 
with both NUMA and SPLPAR enabled, no device tree updates are necessary.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h |    5 +-
 arch/powerpc/mm/numa.c            |  274 +++++++++++++++++++++++++++++++++++--
 2 files changed, 268 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 7f5e0fe..380d48b 100644
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
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 74505b2..db6308c 100644
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
@@ -1248,3 +1261,244 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
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
+int start_topology_update(void)
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
+__initcall(start_topology_update);
+
+/*
+ * Disable polling for VPHN associativity changes.
+ */
+int stop_topology_update(void)
+{
+	return del_timer(&topology_timer);
+}
-- 
1.7.2.3
