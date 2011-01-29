Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:37:16 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, jlarrew@linux.vnet.ibm.com
Subject: [PATCH 5/5] powerpc/numa: Fix bug in unmap_cpu_from_node
Message-ID: <20110130093716.79e78bec@kryten>
In-Reply-To: <20110130092434.42a887ef@kryten>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
	<20110130092217.70ebb424@kryten> <20110130092434.42a887ef@kryten>
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


When converting to the new cpumask code I screwed up:

-       if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
-               cpu_clear(cpu, numa_cpumask_lookup_table[node]);
+       if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
+               cpumask_set_cpu(cpu, node_to_cpumask_map[node]);

This was introduced in commit 25863de07af9 (powerpc/cpumask: Convert NUMA code
to new cpumask API)

Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2011-01-29 13:06:05.259039081 +1100
+++ linux-2.6/arch/powerpc/mm/numa.c	2011-01-30 08:26:48.148366563 +1100
@@ -186,7 +186,7 @@ static void unmap_cpu_from_node(unsigned
 	dbg("removing cpu %lu from node %d\n", cpu, node);
 
 	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
-		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
+		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
 	} else {
 		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
 		       cpu, node);
