Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3D132C00D4
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 22:05:36 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 12 Aug 2013 21:54:45 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E5583578051
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 22:05:29 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7CBng8f46268488
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 21:49:42 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7CC5T1g010667
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 22:05:29 +1000
Subject: [PATCH] powerpc: Make chip-id information available to userspace
To: linuxppc-dev@ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 17:35:57 +0530
Message-ID: <20130812120539.4230.90961.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far "/sys/devices/system/cpu/cpuX/topology/physical_package_id"
was always default (-1) on ppc64 architecture.

Now, some systems have an ibm,chip-id property in the cpu nodes in
the device tree. On these systems, we now use this information to
display physical_package_id.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h      |    1 +
 arch/powerpc/include/asm/topology.h |    1 +
 arch/powerpc/kernel/smp.c           |   15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index ffbaabe..ff21fda 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -112,6 +112,7 @@ static inline struct cpumask *cpu_core_mask(int cpu)
 }
 
 extern int cpu_to_core_id(int cpu);
+extern int cpu_to_chip_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 161ab66..89e3ef2 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -96,6 +96,7 @@ static inline int prrn_is_enabled(void)
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
 
+#define topology_physical_package_id(cpu)	(cpu_to_chip_id(cpu))
 #define topology_thread_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 076977c..a59e1d3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -574,6 +574,21 @@ out:
 	return id;
 }

+/* Return the value of the chip-id property corresponding
+ * to the given logical cpu.
+ */
+int cpu_to_chip_id(int cpu)
+{
+	struct device_node *np;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		return -1;
+
+	of_node_put(np);
+	return of_get_ibm_chip_id(np);
+}
+
 /* Helper routines for cpu to core mapping */
 int cpu_core_index_of_thread(int cpu)
 {
