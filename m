Return-Path: <paulus@ozlabs.org>
Date: Mon, 12 Aug 2013 16:29:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/2] powerpc: Use ibm,chip-id property to compute
 cpu_core_mask if available
Message-ID: <20130812062933.GC20246@iris.ozlabs.ibm.com>
References: <20130812062847.GB20246@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130812062847.GB20246@iris.ozlabs.ibm.com>
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

Some systems have an ibm,chip-id property in the cpu nodes in the
device tree.  On these systems, we now use that to compute the
cpu_core_mask (i.e. the set of core siblings) rather than looking
at cache properties.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
v2: add is bool, use of_read_number

 arch/powerpc/kernel/smp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1568525..a4137de 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -587,6 +587,33 @@ int cpu_first_thread_of_core(int core)
 }
 EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
+static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
+{
+	const struct cpumask *mask;
+	struct device_node *np;
+	int i, plen;
+	const __be32 *prop;
+
+	mask = add ? cpu_online_mask : cpu_present_mask;
+	for_each_cpu(i, mask) {
+		np = of_get_cpu_node(i, NULL);
+		if (!np)
+			continue;
+		prop = of_get_property(np, "ibm,chip-id", &plen);
+		if (prop && plen == sizeof(int) &&
+		    of_read_number(prop, 1) == chipid) {
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
@@ -611,14 +638,29 @@ static struct device_node *cpu_to_l2cache(int cpu)
 
 static void traverse_core_siblings(int cpu, bool add)
 {
-	struct device_node *l2_cache;
+	struct device_node *l2_cache, *np;
 	const struct cpumask *mask;
-	int i;
+	int i, chip, plen;
+	const __be32 *prop;
+
+	/* First see if we have ibm,chip-id properties in cpu nodes */
+	np = of_get_cpu_node(cpu, NULL);
+	if (np) {
+		chip = -1;
+		prop = of_get_property(np, "ibm,chip-id", &plen);
+		if (prop && plen == sizeof(int))
+			chip = of_read_number(prop, 1);
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
1.8.4.rc2
