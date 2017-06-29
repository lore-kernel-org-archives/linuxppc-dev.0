Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyrV33zZJzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:13:15 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so10887501pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:13:15 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/4] powerpc/smp: Use cpu_to_chip_id() to find core siblings
Date: Thu, 29 Jun 2017 17:12:53 +1000
Message-Id: <20170629071256.8159-2-oohall@gmail.com>
In-Reply-To: <20170629071256.8159-1-oohall@gmail.com>
References: <20170629071256.8159-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building the CPU scheduler topology the kernel uses the ibm,chipid
property from the devicetree to group logical CPUs. Currently the DT
search for this property is open-coded in smp.c and this functionality
is a duplication of what's in cpu_to_chip_id() already. This patch
removes the existing search in favor of that.

It's worth mentioning that the semantics of the search are different
in cpu_to_chip_id(). When there is no ibm,chipid in the CPUs node it
will also search /cpus and / for the property, but this should not
effect the output topology.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index dbcd22e09a2c..40f1f268be83 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -829,19 +829,11 @@ EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
 static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
 {
-	const struct cpumask *mask;
-	struct device_node *np;
-	int i, plen;
-	const __be32 *prop;
+	const struct cpumask *mask = add ? cpu_online_mask : cpu_present_mask;
+	int i;
 
-	mask = add ? cpu_online_mask : cpu_present_mask;
 	for_each_cpu(i, mask) {
-		np = of_get_cpu_node(i, NULL);
-		if (!np)
-			continue;
-		prop = of_get_property(np, "ibm,chip-id", &plen);
-		if (prop && plen == sizeof(int) &&
-		    of_read_number(prop, 1) == chipid) {
+		if (cpu_to_chip_id(i) == chipid) {
 			if (add) {
 				cpumask_set_cpu(cpu, cpu_core_mask(i));
 				cpumask_set_cpu(i, cpu_core_mask(cpu));
@@ -850,7 +842,6 @@ static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
 				cpumask_clear_cpu(i, cpu_core_mask(cpu));
 			}
 		}
-		of_node_put(np);
 	}
 }
 
@@ -880,21 +871,15 @@ static void traverse_core_siblings(int cpu, bool add)
 {
 	struct device_node *l2_cache, *np;
 	const struct cpumask *mask;
-	int i, chip, plen;
-	const __be32 *prop;
+	int chip_id;
+	int i;
 
-	/* First see if we have ibm,chip-id properties in cpu nodes */
-	np = of_get_cpu_node(cpu, NULL);
-	if (np) {
-		chip = -1;
-		prop = of_get_property(np, "ibm,chip-id", &plen);
-		if (prop && plen == sizeof(int))
-			chip = of_read_number(prop, 1);
-		of_node_put(np);
-		if (chip >= 0) {
-			traverse_siblings_chip_id(cpu, add, chip);
-			return;
-		}
+	/* threads that share a chip-id are considered siblings */
+	chip_id = cpu_to_chip_id(cpu);
+
+	if (chip_id >= 0) {
+		traverse_siblings_chip_id(cpu, add, chip_id);
+		return;
 	}
 
 	l2_cache = cpu_to_l2cache(cpu);
-- 
2.9.4
