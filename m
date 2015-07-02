Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C91AD1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 09:02:11 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 19:02:08 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A10856E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 18:53:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62N24OA44171264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 23:02:04 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62N23sb006477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 19:02:04 -0400
Date: Thu, 2 Jul 2015 16:02:02 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Rientjes <rientjes@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150702230202.GA2807@linux.vnet.ibm.com>
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

Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
have an ordering issue during boot with early calls to cpu_to_node().
The value returned by those calls now depend on the per-cpu area being
setup, but that is not guaranteed to be the case during boot. Instead,
we need to add an early_cpu_to_node() which doesn't use the per-CPU area
and call that from certain spots that are known to invoke cpu_to_node()
before the per-CPU areas are not configured.

On an example 2-node NUMA system with the following topology:

available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3
node 0 size: 2029 MB
node 0 free: 1753 MB
node 1 cpus: 4 5 6 7
node 1 size: 2045 MB
node 1 free: 1945 MB
node distances:
node   0   1 
  0:  10  40 
  1:  40  10 

we currently emit at boot:

[    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 

After this commit, we correctly emit:

[    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 5f1048e..f2c4c89 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -39,6 +39,8 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 extern int __node_distance(int, int);
 #define node_distance(a, b) __node_distance(a, b)
 
+extern int early_cpu_to_node(int);
+
 extern void __init dump_numa_cpu_topology(void);
 
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c69671c..23a2cf3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -715,8 +715,8 @@ void __init setup_arch(char **cmdline_p)
 
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
-	return __alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu)), size, align,
-				    __pa(MAX_DMA_ADDRESS));
+	return __alloc_bootmem_node(NODE_DATA(early_cpu_to_node(cpu)), size,
+				    align, __pa(MAX_DMA_ADDRESS));
 }
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
@@ -726,7 +726,7 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
 
 static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 {
-	if (cpu_to_node(from) == cpu_to_node(to))
+	if (early_cpu_to_node(from) == early_cpu_to_node(to))
 		return LOCAL_DISTANCE;
 	else
 		return REMOTE_DISTANCE;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5e80621..9ffabf4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -157,6 +157,11 @@ static void map_cpu_to_node(int cpu, int node)
 		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
 }
 
+int early_cpu_to_node(int cpu)
+{
+	return numa_cpu_lookup_table[cpu];
+}
+
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
 static void unmap_cpu_from_node(unsigned long cpu)
 {
