Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYcK3281zDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 11:49:37 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id j5so4985190pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 16:49:37 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
Date: Thu,  2 Mar 2017 11:49:16 +1100
Message-Id: <20170302004920.21948-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To determine which logical CPUs are on the same core the kernel uses the
ibm,chipid property from the device tree node associated with that cpu.
The lookup for this this information is currently open coded in both
traverse_siblings() and traverse_siblings_chip_id(). This patch replaces
these manual lookups with the existing cpu_to_chip_id() function.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 893bd7f79be6..dfe0e1d9cd06 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -613,19 +613,11 @@ EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
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
@@ -634,7 +626,6 @@ static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
 				cpumask_clear_cpu(i, cpu_core_mask(cpu));
 			}
 		}
-		of_node_put(np);
 	}
 }
 
@@ -664,23 +655,19 @@ static void traverse_core_siblings(int cpu, bool add)
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
+	/* threads that share a chip-id are considered siblings (same die) */
+	chip_id = cpu_to_chip_id(cpu);
+
+	if (chip_id >= 0) {
+		traverse_siblings_chip_id(cpu, add, chip_id);
+		return;
 	}
 
+	/* if the chip-id fails then threads which share L2 cache are */
+
 	l2_cache = cpu_to_l2cache(cpu);
 	mask = add ? cpu_online_mask : cpu_present_mask;
 	for_each_cpu(i, mask) {
-- 
2.9.3
