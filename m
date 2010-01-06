Return-Path: <anton@ozlabs.org>
Message-Id: <20100106045524.853685851@samba.org>>
References: <20100106045509.245662398@samba.org>>
Date: Wed, 06 Jan 2010 15:55:10 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 1/6] powerpc: cpumask_of_node() should handle -1 as a node
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibus_to_node can return -1 if we cannot determine which node a pci bus
is on. If passed -1, cpumask_of_node will negatively index the lookup array
and pull in random data:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
00000000,00000003,00000000,00000000
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
64-65

Change cpumask_of_node to check for -1 and return cpu_all_mask in this
case:

# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpus
ffffffff,ffffffff,ffffffff,ffffffff
# cat /sys/devices/pci0000:00/0000:00:01.0/local_cpulist
0-127

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/topology.h	2010-01-06 15:20:22.992583563 +1100
+++ linux-cpumask/arch/powerpc/include/asm/topology.h	2010-01-06 15:27:24.058833128 +1100
@@ -17,7 +17,9 @@ static inline int cpu_to_node(int cpu)
 
 #define parent_node(node)	(node)
 
-#define cpumask_of_node(node) (&numa_cpumask_lookup_table[node])
+#define cpumask_of_node(node) ((node) == -1 ?				\
+			       cpu_all_mask :				\
+			       &numa_cpumask_lookup_table[node])
 
 int of_node_to_nid(struct device_node *device);
 

-- 
