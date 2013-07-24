Return-Path: <rcj@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBA3E2C0177
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 01:00:31 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcj@linux.vnet.ibm.com>;
 Wed, 24 Jul 2013 20:20:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AB8061258051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:29:39 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OF17TH30933082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:31:07 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OF08Lg003933
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 15:00:12 GMT
Date: Wed, 24 Jul 2013 10:00:05 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Jan Stancek <jstancek@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2] powerpc: VPHN topology change updates all siblings
Message-ID: <20130724150005.GB13737@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When an associativity level change is found for one thread, the
siblings threads need to be updated as well.  This is done today
for PRRN in stage_topology_update() but is missing for VPHN in
update_cpu_associativity_changes_mask().

All threads should be updated to move to the new node.  Without this
patch, a single thread may be flagged for a topology change, leaving it
in a different node from its siblings, which is incorrect.  This causes
problems for the scheduler where overlapping scheduler groups are created
and a loop is formed in those groups.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---
cpu_sibling_mask is now defined for UP which fixes that build break.
---
 arch/powerpc/include/asm/smp.h |  4 +++
 arch/powerpc/mm/numa.c         | 59 +++++++++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index ffbaabe..48cfc85 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -145,6 +145,10 @@ extern void __cpu_die(unsigned int cpu);
 #define smp_setup_cpu_maps()
 static inline void inhibit_secondary_onlining(void) {}
 static inline void uninhibit_secondary_onlining(void) {}
+static inline const struct cpumask *cpu_sibling_mask(int cpu)
+{
+	return cpumask_of(cpu);
+}
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0839721..5850798 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <asm/cputhreads.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
@@ -1318,7 +1319,8 @@ static int update_cpu_associativity_changes_mask(void)
 			}
 		}
 		if (changed) {
-			cpumask_set_cpu(cpu, changes);
+			cpumask_or(changes, changes, cpu_sibling_mask(cpu));
+			cpu = cpu_last_thread_sibling(cpu);
 		}
 	}
 
@@ -1426,7 +1428,7 @@ static int update_cpu_topology(void *data)
 	if (!data)
 		return -EINVAL;
 
-	cpu = get_cpu();
+	cpu = smp_processor_id();
 
 	for (update = data; update; update = update->next) {
 		if (cpu != update->cpu)
@@ -1446,12 +1448,12 @@ static int update_cpu_topology(void *data)
  */
 int arch_update_cpu_topology(void)
 {
-	unsigned int cpu, changed = 0;
+	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
-	int weight, i = 0;
+	int weight, new_nid, i = 0;
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
@@ -1464,19 +1466,46 @@ int arch_update_cpu_topology(void)
 	cpumask_clear(&updated_cpus);
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
-		ud = &updates[i++];
-		ud->cpu = cpu;
-		vphn_get_associativity(cpu, associativity);
-		ud->new_nid = associativity_to_nid(associativity);
-
-		if (ud->new_nid < 0 || !node_online(ud->new_nid))
-			ud->new_nid = first_online_node;
+		/*
+		 * If siblings aren't flagged for changes, updates list
+		 * will be too short. Skip on this update and set for next
+		 * update.
+		 */
+		if (!cpumask_subset(cpu_sibling_mask(cpu),
+					&cpu_associativity_changes_mask)) {
+			pr_info("Sibling bits not set for associativity "
+					"change, cpu%d\n", cpu);
+			cpumask_or(&cpu_associativity_changes_mask,
+					&cpu_associativity_changes_mask,
+					cpu_sibling_mask(cpu));
+			cpu = cpu_last_thread_sibling(cpu);
+			continue;
+		}
 
-		ud->old_nid = numa_cpu_lookup_table[cpu];
-		cpumask_set_cpu(cpu, &updated_cpus);
+		/* Use associativity from first thread for all siblings */
+		vphn_get_associativity(cpu, associativity);
+		new_nid = associativity_to_nid(associativity);
+		if (new_nid < 0 || !node_online(new_nid))
+			new_nid = first_online_node;
+
+		if (new_nid == numa_cpu_lookup_table[cpu]) {
+			cpumask_andnot(&cpu_associativity_changes_mask,
+					&cpu_associativity_changes_mask,
+					cpu_sibling_mask(cpu));
+			cpu = cpu_last_thread_sibling(cpu);
+			continue;
+		}
 
-		if (i < weight)
-			ud->next = &updates[i];
+		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
+			ud = &updates[i++];
+			ud->cpu = sibling;
+			ud->new_nid = new_nid;
+			ud->old_nid = numa_cpu_lookup_table[sibling];
+			cpumask_set_cpu(sibling, &updated_cpus);
+			if (i < weight)
+				ud->next = &updates[i];
+		}
+		cpu = cpu_last_thread_sibling(cpu);
 	}
 
 	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
-- 
1.8.1.2
