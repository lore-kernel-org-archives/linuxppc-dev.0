Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: Make cpu_to_chip_id() available when SMP=n
Date: Wed, 20 Nov 2013 11:05:01 +1100
Message-Id: <1384905902-18042-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Up until now we have only used cpu_to_chip_id() in the topology code,
which is only used on SMP builds. However my recent commit a4da0d5
"Implement arch_get_random_long/int() for powernv" added a usage when
SMP=n, breaking the build.

Move cpu_to_chip_id() into prom.c so it is available for SMP=n builds.

We would move the extern to prom.h, but that breaks the include in
topology.h. Instead we leave it in smp.h, but move it out of the
CONFIG_SMP #ifdef. We also need to include asm/smp.h in rng.c, because
the linux version skips asm/smp.h on UP. What a mess.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/smp.h       |  2 +-
 arch/powerpc/kernel/prom.c           | 20 ++++++++++++++++++++
 arch/powerpc/kernel/smp.c            | 16 ----------------
 arch/powerpc/platforms/powernv/rng.c |  1 +
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 98da78e..084e080 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -33,6 +33,7 @@ extern int boot_cpuid;
 extern int spinning_secondaries;
 
 extern void cpu_die(void);
+extern int cpu_to_chip_id(int cpu);
 
 #ifdef CONFIG_SMP
 
@@ -112,7 +113,6 @@ static inline struct cpumask *cpu_core_mask(int cpu)
 }
 
 extern int cpu_to_core_id(int cpu);
-extern int cpu_to_chip_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4432fd8..67a7b3b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -786,6 +786,26 @@ int of_get_ibm_chip_id(struct device_node *np)
 	return -1;
 }
 
+/**
+ * cpu_to_chip_id - Return the cpus chip-id
+ * @cpu: The logical cpu number.
+ *
+ * Return the value of the ibm,chip-id property corresponding to the given
+ * logical cpu number. If the chip-id can not be found, returns -1.
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
+EXPORT_SYMBOL(cpu_to_chip_id);
+
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Fix up the uninitialized fields in a new device node:
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8e59abc..e5174d3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -597,22 +597,6 @@ out:
 	return id;
 }
 
-/* Return the value of the chip-id property corresponding
- * to the given logical cpu.
- */
-int cpu_to_chip_id(int cpu)
-{
-	struct device_node *np;
-
-	np = of_get_cpu_node(cpu, NULL);
-	if (!np)
-		return -1;
-
-	of_node_put(np);
-	return of_get_ibm_chip_id(np);
-}
-EXPORT_SYMBOL(cpu_to_chip_id);
-
 /* Helper routines for cpu to core mapping */
 int cpu_core_index_of_thread(int cpu)
 {
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 8844628..1cb160d 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/smp.h>
 
 
 struct powernv_rng {
-- 
1.8.3.2
