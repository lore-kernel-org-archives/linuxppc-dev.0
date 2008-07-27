Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 0E0BBDDF58
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:25:16 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/6] make core id information available to userspace
Date: Sun, 27 Jul 2008 00:24:54 -0500
Message-Id: <1217136295-18693-6-git-send-email-ntl@pobox.com>
In-Reply-To: <1217136295-18693-1-git-send-email-ntl@pobox.com>
References: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Existing Open Firmware practice is to report each processor core as a
separate node in the device tree.  Report the value of the "reg" OF
property corresponding to a logical CPU's device node as the core_id
attribute in /sys/devices/system/cpu/cpu*/topology/core_id.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/smp.c      |   23 +++++++++++++++++++++++
 include/asm-powerpc/smp.h      |    1 +
 include/asm-powerpc/topology.h |    1 +
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e8bc6a0..f3a2360 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -380,6 +380,29 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+/* Return the value of the reg property corresponding to the given
+ * logical cpu.
+ */
+int cpu_to_core_id(int cpu)
+{
+	struct device_node *np;
+	const int *reg;
+	int id = -1;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		goto out;
+
+	reg = of_get_property(np, "reg", NULL);
+	if (!reg)
+		goto out;
+
+	id = *reg;
+out:
+	of_node_put(np);
+	return id;
+}
+
 /* Must be called when no change can occur to cpu_present_map,
  * i.e. during cpu online or offline.
  */
diff --git a/include/asm-powerpc/smp.h b/include/asm-powerpc/smp.h
index 32e9100..4d28e1e 100644
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -63,6 +63,7 @@ extern int smp_hw_index[];
 
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 DECLARE_PER_CPU(cpumask_t, cpu_core_map);
+extern int cpu_to_core_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
diff --git a/include/asm-powerpc/topology.h b/include/asm-powerpc/topology.h
index f00e8e5..c32da6f 100644
--- a/include/asm-powerpc/topology.h
+++ b/include/asm-powerpc/topology.h
@@ -109,6 +109,7 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
 
 #define topology_thread_siblings(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_siblings(cpu)	(per_cpu(cpu_core_map, cpu))
+#define topology_core_id(cpu)		(cpu_to_core_id(cpu))
 #endif
 #endif
 
-- 
1.5.6.2
