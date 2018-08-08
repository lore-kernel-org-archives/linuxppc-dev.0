Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ldy34m8YzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 14:41:27 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w784d0Ud042426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 00:41:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqnvnq5d5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 00:41:25 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 05:41:23 +0100
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Bringmann <mbringm@us.ibm.com>,
 Manjunatha H R <manjuhr1@in.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/topology: Check at boot for topology updates
Date: Wed,  8 Aug 2018 10:11:09 +0530
Message-Id: <1533703269-17861-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a shared lpar, Phyp will not update the cpu associativity at boot
time. Just after the boot system does recognize itself as a shared lpar and
trigger a request for correct cpu associativity. But by then the scheduler
would have already created/destroyed its sched domains.

This causes
- Broken load balance across Nodes causing islands of cores.
- Performance degradation esp if the system is lightly loaded
- dmesg to wrongly report all cpus to be in Node 0.
- Messages in dmesg saying borken topology.
- With commit: 051f3ca02e46432 ("sched/topology: Introduce NUMA identity
  node sched domain"), can cause rcu stalls at boot up.

>From a scheduler maintainer's perspective, moving cpus from one node to
another or creating more numa levels after boot is not appropriate
without some notification to the user space. 
https://lore.kernel.org/lkml/20150406214558.GA38501@linux.vnet.ibm.com/T/#u

The sched_domains_numa_masks table which is used to generate cpumasks is
only created at boot time just before creating sched domains and never
updated.  Hence, its better to get the topology correct before the sched
domains are created.

For example on 64 core Power 8 shared lpar, dmesg reports

[    2.088360] Brought up 512 CPUs
[    2.088368] Node 0 CPUs: 0-511
[    2.088371] Node 1 CPUs:
[    2.088373] Node 2 CPUs:
[    2.088375] Node 3 CPUs:
[    2.088376] Node 4 CPUs:
[    2.088378] Node 5 CPUs:
[    2.088380] Node 6 CPUs:
[    2.088382] Node 7 CPUs:
[    2.088386] Node 8 CPUs:
[    2.088388] Node 9 CPUs:
[    2.088390] Node 10 CPUs:
[    2.088392] Node 11 CPUs:
...
[    3.916091] BUG: arch topology borken
[    3.916103]      the DIE domain not a subset of the NUMA domain
[    3.916105] BUG: arch topology borken
[    3.916106]      the DIE domain not a subset of the NUMA domain
...

numactl/lscpu output will still be correct with cores spreading across
all nodes.

Socket(s):             64
NUMA node(s):          12
Model:                 2.0 (pvr 004d 0200)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     pHyp
Virtualization type:   para
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
NUMA node11 CPU(s):    160-167,256-263,352-359,448-455

Currently on this lpar, the scheduler detects 2 levels of Numa and
created numa sched domains for all cpus, but it finds a single DIE
domain consisting of all cpus. Hence it deletes all numa sched domains.

To address this, split the topology update init, such that the first
part detects vphn/prrn soon after cpus are setup and force updates
topology just before scheduler creates sched domain.

With the fix, dmesg reports

[    0.491336] numa: Node 0 CPUs: 0-7 32-39 64-71 96-103 176-183 272-279 368-375 464-471
[    0.491351] numa: Node 1 CPUs: 8-15 40-47 72-79 104-111 184-191 280-287 376-383 472-479
[    0.491359] numa: Node 2 CPUs: 16-23 48-55 80-87 112-119 192-199 288-295 384-391 480-487
[    0.491366] numa: Node 3 CPUs: 24-31 56-63 88-95 120-127 200-207 296-303 392-399 488-495
[    0.491374] numa: Node 4 CPUs: 208-215 304-311 400-407 496-503
[    0.491379] numa: Node 5 CPUs: 168-175 264-271 360-367 456-463
[    0.491384] numa: Node 6 CPUs: 128-135 224-231 320-327 416-423
[    0.491389] numa: Node 7 CPUs: 136-143 232-239 328-335 424-431
[    0.491394] numa: Node 8 CPUs: 216-223 312-319 408-415 504-511
[    0.491399] numa: Node 9 CPUs: 144-151 240-247 336-343 432-439
[    0.491404] numa: Node 10 CPUs: 152-159 248-255 344-351 440-447
[    0.491409] numa: Node 11 CPUs: 160-167 256-263 352-359 448-455

and lscpu would also report

Socket(s):             64
NUMA node(s):          12
Model:                 2.0 (pvr 004d 0200)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     pHyp
Virtualization type:   para
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
NUMA node11 CPU(s):    160-167,256-263,352-359,448-455

Previous attempt to solve this problem
https://patchwork.ozlabs.org/patch/530090/

Reported-by: Manjunatha H R <manjuhr1@in.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  4 ++++
 arch/powerpc/kernel/smp.c           |  6 ++++++
 arch/powerpc/mm/numa.c              | 22 ++++++++++++++--------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 16b077801a5f..a14550476bc7 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -92,6 +92,7 @@ extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
 extern int find_and_online_cpu_nid(int cpu);
 extern int timed_topology_update(int nsecs);
+extern void check_topology_updates(void);
 #else
 static inline int start_topology_update(void)
 {
@@ -113,6 +114,9 @@ static inline int timed_topology_update(int nsecs)
 {
 	return 0;
 }
+static void check_topology_updates(void)
+{
+}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4794d6b4f4d2..2aa0ffd954c9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1156,6 +1156,12 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	if (smp_ops && smp_ops->bringup_done)
 		smp_ops->bringup_done();
 
+	/*
+	 * On a shared LPAR, associativity needs to be requested.
+	 * Hence, check for numa topology updates before dumping
+	 * cpu topology
+	 */
+	check_topology_updates();
 	dump_numa_cpu_topology();
 
 	/*
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0c7e05d89244..eab46a44436f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1515,6 +1515,7 @@ int start_topology_update(void)
 		   lppaca_shared_proc(get_lppaca())) {
 		if (!vphn_enabled) {
 			vphn_enabled = 1;
+			topology_update_needed = 1;
 			setup_cpu_associativity_change_counters();
 			timer_setup(&topology_timer, topology_timer_fn,
 				    TIMER_DEFERRABLE);
@@ -1551,6 +1552,19 @@ int prrn_is_enabled(void)
 	return prrn_enabled;
 }
 
+void check_topology_updates(void)
+{
+	/* Do not poll for changes if disabled at boot */
+	if (topology_updates_enabled)
+		start_topology_update();
+
+	if (topology_update_needed) {
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+					nr_cpumask_bits);
+		numa_update_cpu_topology(false);
+	}
+}
+
 static int topology_read(struct seq_file *file, void *v)
 {
 	if (vphn_enabled || prrn_enabled)
@@ -1597,10 +1611,6 @@ static const struct file_operations topology_ops = {
 
 static int topology_update_init(void)
 {
-	/* Do not poll for changes if disabled at boot */
-	if (topology_updates_enabled)
-		start_topology_update();
-
 	if (vphn_enabled)
 		topology_schedule_update();
 
@@ -1608,10 +1618,6 @@ static int topology_update_init(void)
 		return -ENOMEM;
 
 	topology_inited = 1;
-	if (topology_update_needed)
-		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
-					nr_cpumask_bits);
-
 	return 0;
 }
 device_initcall(topology_update_init);
-- 
2.17.1
