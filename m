Return-Path: <paulus@ozlabs.org>
Date: Sat, 10 Aug 2013 13:46:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Use ibm,chip-id property to compute
 cpu_core_mask if available
Message-ID: <20130810034615.GE5240@iris.ozlabs.ibm.com>
References: <20130810034530.GD5240@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130810034530.GD5240@iris.ozlabs.ibm.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some systems have an ibm,chip-id property in the cpu nodes in the
device tree.  On these systems, we now use that to compute the
cpu_core_mask (i.e. the set of core siblings) rather than looking
at cache properties.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/smp.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 663cefd..076977c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -587,6 +587,32 @@ int cpu_first_thread_of_core(int core)
 }
 EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
+static void traverse_siblings_chip_id(int cpu, int add, int chipid)
+{
+	const struct cpumask *mask;
+	struct device_node *np;
+	int i, plen;
+	const int *prop;
+
+	mask = add ? cpu_online_mask : cpu_present_mask;
+	for_each_cpu(i, mask) {
+		np = of_get_cpu_node(i, NULL);
+		if (!np)
+			continue;
+		prop = of_get_property(np, "ibm,chip-id", &plen);
+		if (prop && plen == sizeof(int) && *prop == chipid) {
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
+}
+
 /* Must be called when no change can occur to cpu_present_mask,
  * i.e. during cpu online or offline.
  */
@@ -611,14 +637,29 @@ static struct device_node *cpu_to_l2cache(int cpu)
 
 static void traverse_core_siblings(int cpu, int add)
 {
-	struct device_node *l2_cache;
+	struct device_node *l2_cache, *np;
 	const struct cpumask *mask;
-	int i;
+	int i, chip, plen;
+	const int *prop;
+
+	/* First see if we have ibm,chip-id properties in cpu nodes */
+	np = of_get_cpu_node(cpu, NULL);
+	if (np) {
+		chip = -1;
+		prop = of_get_property(np, "ibm,chip-id", &plen);
+		if (prop && plen == sizeof(int))
+			chip = *(int *)prop;
+		of_node_put(np);
+		if (chip >= 0) {
+			traverse_siblings_chip_id(cpu, add, chip);
+			return;
+		}
+	}
 
 	l2_cache = cpu_to_l2cache(cpu);
 	mask = add ? cpu_online_mask : cpu_present_mask;
 	for_each_cpu(i, mask) {
-		struct device_node *np = cpu_to_l2cache(i);
+		np = cpu_to_l2cache(i);
 		if (!np)
 			continue;
 		if (np == l2_cache) {
-- 
1.8.3.1
