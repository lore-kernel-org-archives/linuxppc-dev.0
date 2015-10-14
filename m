Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE04C1A0673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:08:46 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F417A14016A
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 20:08:45 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Oct 2015 14:38:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C0EC5E0058
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 14:38:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9E98cZk55574682
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 14:38:38 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9E96qIB018279
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 14:38:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, nacc@linux.vnet.ibm.com
Subject: [RFC] powerpc/numa: Use VPHN based node ID information on shared
 processor LPARs
Date: Wed, 14 Oct 2015 14:32:15 +0530
Message-Id: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
dynamic virtual-physical mapping for any given processor. Currently we
use VPHN node ID information only after getting either a PRRN or a VPHN
event. But during boot time inside the function numa_setup_cpu, we still
query the OF device tree for the node ID value which might be different
than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
scenario where there are no PRRN or VPHN event after boot, all node-cpu
mapping will remain incorrect there after.

With this proposed change, numa_setup_cpu will try to override the OF
device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
hcall fetched node ID value. Right now shared processor property of the
LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
during boot time. So initmem_init function has been moved after ppc_md.
setup_arch inside setup_arch during boot.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Before the change:
# numactl -H
available: 2 nodes (0,3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 0 MB
node 0 free: 0 MB
node 3 cpus:
node 3 size: 16315 MB
node 3 free: 15716 MB
node distances:
node   0   3 
  0:  10  20 
  3:  20  10 
 
After the change:
# numactl -H
available: 2 nodes (0,3)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 3 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 3 size: 16315 MB
node 3 free: 15537 MB
node distances:
node   0   3 
  0:  10  20 
  3:  20  10

 arch/powerpc/kernel/setup_64.c |  2 +-
 arch/powerpc/mm/numa.c         | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index bdcbb71..56026b7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -694,7 +694,6 @@ void __init setup_arch(char **cmdline_p)
 	exc_lvl_early_init();
 	emergency_stack_init();
 
-	initmem_init();
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
@@ -703,6 +702,7 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
+	initmem_init();
 	paging_init();
 
 	/* Initialize the MMU context management stuff */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8b9502a..e404d05 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -41,6 +41,10 @@
 #include <asm/setup.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_PPC_SPLPAR
+static int vphn_get_node(unsigned int cpu);
+#endif
+
 static int numa_enabled = 1;
 
 static char *cmdline __initdata;
@@ -553,6 +557,17 @@ static int numa_setup_cpu(unsigned long lcpu)
 
 	nid = of_node_to_nid_single(cpu);
 
+	/*
+	 * Override the OF device tree fetched node number
+	 * with VPHN based node number in case of a shared
+	 * processor LPAR on PHYP platform.
+	 */
+#ifdef CONFIG_PPC_SPLPAR
+	if (lppaca_shared_proc(get_lppaca())) {
+		nid = vphn_get_node(lcpu);
+	}
+#endif
+
 out_present:
 	if (nid < 0 || !node_online(nid))
 		nid = first_online_node;
@@ -1364,6 +1379,14 @@ static int update_lookup_table(void *data)
 	return 0;
 }
 
+static int vphn_get_node(unsigned int cpu)
+{
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+
+	vphn_get_associativity(cpu, associativity);
+	return associativity_to_nid(associativity);
+}
+
 /*
  * Update the node maps and sysfs entries for each cpu whose home node
  * has changed. Returns 1 when the topology has changed, and 0 otherwise.
@@ -1372,7 +1395,6 @@ int arch_update_cpu_topology(void)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i = 0;
@@ -1408,8 +1430,7 @@ int arch_update_cpu_topology(void)
 		}
 
 		/* Use associativity from first thread for all siblings */
-		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_nid(associativity);
+		new_nid = vphn_get_node(cpu);
 		if (new_nid < 0 || !node_online(new_nid))
 			new_nid = first_online_node;
 
-- 
2.1.0
