Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sR066fwkzDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 00:48:22 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HEiAtQ005493
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 10:48:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kwvcjt29c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 10:48:19 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 17 Aug 2018 15:48:17 +0100
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Bringmann <mbringm@us.ibm.com>,
 Manjunatha H R <manjuhr1@in.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v5] powerpc/topology: Get topology for shared processors at
 boot
Date: Fri, 17 Aug 2018 20:18:10 +0530
Message-Id: <1534517290-10243-1-git-send-email-srikar@linux.vnet.ibm.com>
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
- With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity
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

To address this, detect the shared processor and update topology soon after
cpus are setup so that correct topology is updated just before scheduler
creates sched domain.

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
Changelog v1->v2
 Fix compile warnings and checkpatch issues.

Changelog v2->v3
 Fix compile warnings on !CONFIG_SMP

Changelog v3->v4
 Now do early topology init on shared processor.  Earlier we used to do only
 for vphn enabled.  However we want this update to happen even when
 topology_updates=off.  Changed patch title accordingly

Changelog v4->v5:
 Handled comments from Michael Ellerman where numa_update_cpu_topology
 was simply returning without updating the topology.

 arch/powerpc/include/asm/topology.h |  5 +++++
 arch/powerpc/kernel/smp.c           |  6 ++++++
 arch/powerpc/mm/numa.c              | 22 ++++++++++++++--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 16b077801a5f..a4a718dbfec6 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -92,6 +92,7 @@ extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
 extern int find_and_online_cpu_nid(int cpu);
 extern int timed_topology_update(int nsecs);
+extern void __init shared_proc_topology_init(void);
 #else
 static inline int start_topology_update(void)
 {
@@ -113,6 +114,10 @@ static inline int timed_topology_update(int nsecs)
 {
 	return 0;
 }
+
+#ifdef CONFIG_SMP
+static inline void shared_proc_topology_init(void) {}
+#endif
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4794d6b4f4d2..b3142c7b9c31 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1156,6 +1156,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	if (smp_ops && smp_ops->bringup_done)
 		smp_ops->bringup_done();
 
+	/*
+	 * On a shared LPAR, associativity needs to be requested.
+	 * Hence, get numa topology before dumping cpu topology
+	 */
+	shared_proc_topology_init();
 	dump_numa_cpu_topology();
 
 	/*
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0c7e05d89244..35ac5422903a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1078,7 +1078,6 @@ static int prrn_enabled;
 static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
-static int topology_update_needed;
 
 /*
  * Change polling interval for associativity changes.
@@ -1306,11 +1305,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 	struct device *dev;
 	int weight, new_nid, i = 0;
 
-	if (!prrn_enabled && !vphn_enabled) {
-		if (!topology_inited)
-			topology_update_needed = 1;
+	if (!prrn_enabled && !vphn_enabled && topology_inited)
 		return 0;
-	}
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
@@ -1423,7 +1419,6 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 out:
 	kfree(updates);
-	topology_update_needed = 0;
 	return changed;
 }
 
@@ -1551,6 +1546,15 @@ int prrn_is_enabled(void)
 	return prrn_enabled;
 }
 
+void __init shared_proc_topology_init(void)
+{
+	if (lppaca_shared_proc(get_lppaca())) {
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+			    nr_cpumask_bits);
+		numa_update_cpu_topology(false);
+	}
+}
+
 static int topology_read(struct seq_file *file, void *v)
 {
 	if (vphn_enabled || prrn_enabled)
@@ -1608,10 +1612,6 @@ static int topology_update_init(void)
 		return -ENOMEM;
 
 	topology_inited = 1;
-	if (topology_update_needed)
-		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
-					nr_cpumask_bits);
-
-- 
2.17.1
