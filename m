Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whnpq5sRvzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:24:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v2] powerpc/numa: Fix percpu allocations to be NUMA aware
Date: Tue,  6 Jun 2017 20:23:57 +1000
Message-Id: <1496744637-24585-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 8c272261194d ("powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID"), we
switched to the generic implementation of cpu_to_node(), which uses a percpu
variable to hold the NUMA node for each CPU.

Unfortunately we neglected to notice that we use cpu_to_node() in the allocation
of our percpu areas, leading to a chicken and egg problem. In practice what
happens is when we are setting up the percpu areas, cpu_to_node() reports that
all CPUs are on node 0, so we allocate all percpu areas on node 0.

This is visible in the dmesg output, as all pcpu allocs being in group 0:

  pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
  pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
  pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
  pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31
  pcpu-alloc: [0] 32 33 34 35 [0] 36 37 38 39
  pcpu-alloc: [0] 40 41 42 43 [0] 44 45 46 47

To fix it we need an early_cpu_to_node() which can run prior to percpu being
setup. We already have the numa_cpu_lookup_table we can use, so just plumb it
in. With the patch dmesg output shows two groups, 0 and 1:

  pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
  pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
  pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
  pcpu-alloc: [1] 24 25 26 27 [1] 28 29 30 31
  pcpu-alloc: [1] 32 33 34 35 [1] 36 37 38 39
  pcpu-alloc: [1] 40 41 42 43 [1] 44 45 46 47

We can also check the data_offset in the paca of various CPUs, with the fix we
see:

  CPU 0:  data_offset = 0x0ffe8b0000
  CPU 24: data_offset = 0x1ffe5b0000

And we can see from dmesg that CPU 24 has an allocation on node 1:

  node   0: [mem 0x0000000000000000-0x0000000fffffffff]
  node   1: [mem 0x0000001000000000-0x0000001fffffffff]

Cc: stable@vger.kernel.org # v3.16+
Fixes: 8c272261194d ("powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/topology.h | 14 ++++++++++++++
 arch/powerpc/kernel/setup_64.c      |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

v2: Don't bother with node_distance() just compare the nids in pcpu_cpu_distance()

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8b3b46b7b0f2..329771559cbb 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -44,8 +44,22 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 
+static inline int early_cpu_to_node(int cpu)
+{
+	int nid;
+
+	nid = numa_cpu_lookup_table[cpu];
+
+	/*
+	 * Fall back to node 0 if nid is unset (it should be, except bugs).
+	 * This allows callers to safely do NODE_DATA(early_cpu_to_node(cpu)).
+	 */
+	return (nid < 0) ? 0 : nid;
+}
 #else
 
+static inline int early_cpu_to_node(int cpu) { return 0; }
+
 static inline void dump_numa_cpu_topology(void) {}
 
 static inline int sysfs_add_device_to_node(struct device *dev, int nid)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f35ff9dea4fb..a8c1f99e9607 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -661,7 +661,7 @@ void __init emergency_stack_init(void)
 
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
-	return __alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu)), size, align,
+	return __alloc_bootmem_node(NODE_DATA(early_cpu_to_node(cpu)), size, align,
 				    __pa(MAX_DMA_ADDRESS));
 }
 
@@ -672,7 +672,7 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
 
 static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 {
-	if (cpu_to_node(from) == cpu_to_node(to))
+	if (early_cpu_to_node(from) == early_cpu_to_node(to))
 		return LOCAL_DISTANCE;
 	else
 		return REMOTE_DISTANCE;
-- 
2.7.4
