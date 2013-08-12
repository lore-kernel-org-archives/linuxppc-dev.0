Return-Path: <paulus@ozlabs.org>
Date: Mon, 12 Aug 2013 16:28:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] powerpc: Pull out cpu_core_mask updates into a
 separate function
Message-ID: <20130812062847.GB20246@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This factors out the details of updating cpu_core_mask into a separate
function, to make it easier to change how the mask is calculated later.
This makes no functional change.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
v2: add is bool

 arch/powerpc/kernel/smp.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 38b0ba6..1568525 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -609,11 +609,36 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	return cache;
 }
 
+static void traverse_core_siblings(int cpu, bool add)
+{
+	struct device_node *l2_cache;
+	const struct cpumask *mask;
+	int i;
+
+	l2_cache = cpu_to_l2cache(cpu);
+	mask = add ? cpu_online_mask : cpu_present_mask;
+	for_each_cpu(i, mask) {
+		struct device_node *np = cpu_to_l2cache(i);
+		if (!np)
+			continue;
+		if (np == l2_cache) {
+			if (add) {
+				cpumask_set_cpu(cpu, cpu_core_mask(i));
+				cpumask_set_cpu(i, cpu_core_mask(cpu));
+			} else {
+				cpumask_clear_cpu(cpu, cpu_core_mask(i));
+				cpumask_clear_cpu(i, cpu_core_mask(cpu));
+			}
+		}
+		of_node_put(np);
+	}
+	of_node_put(l2_cache);
+}
+
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
-	struct device_node *l2_cache;
 	int i, base;
 
 	atomic_inc(&init_mm.mm_count);
@@ -652,18 +677,7 @@ void start_secondary(void *unused)
 		cpumask_set_cpu(cpu, cpu_core_mask(base + i));
 		cpumask_set_cpu(base + i, cpu_core_mask(cpu));
 	}
-	l2_cache = cpu_to_l2cache(cpu);
-	for_each_online_cpu(i) {
-		struct device_node *np = cpu_to_l2cache(i);
-		if (!np)
-			continue;
-		if (np == l2_cache) {
-			cpumask_set_cpu(cpu, cpu_core_mask(i));
-			cpumask_set_cpu(i, cpu_core_mask(cpu));
-		}
-		of_node_put(np);
-	}
-	of_node_put(l2_cache);
+	traverse_core_siblings(cpu, true);
 
 	smp_wmb();
 	notify_cpu_starting(cpu);
@@ -719,7 +733,6 @@ int arch_sd_sibling_asym_packing(void)
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
-	struct device_node *l2_cache;
 	int cpu = smp_processor_id();
 	int base, i;
 	int err;
@@ -739,20 +752,7 @@ int __cpu_disable(void)
 		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
 		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
 	}
-
-	l2_cache = cpu_to_l2cache(cpu);
-	for_each_present_cpu(i) {
-		struct device_node *np = cpu_to_l2cache(i);
-		if (!np)
-			continue;
-		if (np == l2_cache) {
-			cpumask_clear_cpu(cpu, cpu_core_mask(i));
-			cpumask_clear_cpu(i, cpu_core_mask(cpu));
-		}
-		of_node_put(np);
-	}
-	of_node_put(l2_cache);
-
+	traverse_core_siblings(cpu, false);
 
 	return 0;
 }
-- 
1.8.4.rc2
