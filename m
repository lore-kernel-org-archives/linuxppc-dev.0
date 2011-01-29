Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:24:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, jlarrew@linux.vnet.ibm.com
Subject: [PATCH 1/5] powerpc/numa: Only use active VPHN count fields
Message-ID: <20110130092434.42a887ef@kryten>
In-Reply-To: <20110130092217.70ebb424@kryten>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
	<20110130092217.70ebb424@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


VPHN supports up to 8 distance fields but the number of entries in
ibm,associativity-reference-points signifies how many are in use.
Don't look at all the VPHN counts, only distance_ref_points_depth
worth.

Since we already cap our distance metrics at MAX_DISTANCE_REF_POINTS,
use that to size the VPHN arrays and add a BUILD_BUG_ON to avoid it growing
larger than the VPHN maximum of 8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2011-01-29 10:48:21.280075270 +1100
+++ linux-2.6/arch/powerpc/mm/numa.c	2011-01-29 10:54:24.547203014 +1100
@@ -1291,8 +1291,7 @@ u64 memory_hotplug_max(void)
 
 /* Vrtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
-#define VPHN_NR_CHANGE_CTRS (8)
-static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
+static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
 static void set_topology_timer(void);
@@ -1305,12 +1304,15 @@ static void setup_cpu_associativity_chan
 {
 	int cpu = 0;
 
+	/* The VPHN feature supports a maximum of 8 reference points */
+	BUILD_BUG_ON(MAX_DISTANCE_REF_POINTS > 8);
+
 	for_each_possible_cpu(cpu) {
 		int i = 0;
 		u8 *counts = vphn_cpu_change_counts[cpu];
 		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
 
-		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
+		for (i = 0; i < distance_ref_points_depth; i++) {
 			counts[i] = hypervisor_counts[i];
 		}
 	}
@@ -1339,7 +1341,7 @@ static int update_cpu_associativity_chan
 		u8 *counts = vphn_cpu_change_counts[cpu];
 		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
 
-		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
+		for (i = 0; i < distance_ref_points_depth; i++) {
 			if (hypervisor_counts[i] > counts[i]) {
 				counts[i] = hypervisor_counts[i];
 				changed = 1;
