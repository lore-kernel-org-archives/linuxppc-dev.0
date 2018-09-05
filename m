Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425DWQ47mczF3HT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 05:37:54 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id t68-v6so15894875oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 12:37:54 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/21] powerpc: use for_each_of_cpu_node iterator
Date: Wed,  5 Sep 2018 14:37:28 -0500
Message-Id: <20180905193738.19325-12-robh@kernel.org>
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/powerpc/platforms/powermac/feature.c | 51 ++++++++---------------
 arch/powerpc/platforms/powermac/setup.c   | 15 +++----
 2 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 4eb8cb38fc69..ed2f54b3f173 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1049,7 +1049,6 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 	unsigned long flags;
 	struct macio_chip *macio;
 	struct device_node *np;
-	struct device_node *cpus;
 	const int dflt_reset_lines[] = {	KL_GPIO_RESET_CPU0,
 						KL_GPIO_RESET_CPU1,
 						KL_GPIO_RESET_CPU2,
@@ -1059,10 +1058,7 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 	if (macio->type != macio_keylargo)
 		return -ENODEV;

-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL)
-		return -ENODEV;
-	for (np = cpus->child; np != NULL; np = np->sibling) {
+	for_each_of_cpu_node(np) {
 		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
@@ -1072,7 +1068,6 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 			break;
 		}
 	}
-	of_node_put(cpus);
 	if (np == NULL || reset_io == 0)
 		reset_io = dflt_reset_lines[param];

@@ -1504,16 +1499,12 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 	unsigned long flags;
 	struct macio_chip *macio;
 	struct device_node *np;
-	struct device_node *cpus;

 	macio = &macio_chips[0];
 	if (macio->type != macio_keylargo2 && macio->type != macio_shasta)
 		return -ENODEV;

-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL)
-		return -ENODEV;
-	for (np = cpus->child; np != NULL; np = np->sibling) {
+	for_each_of_cpu_node(np) {
 		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
@@ -1523,7 +1514,6 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 			break;
 		}
 	}
-	of_node_put(cpus);
 	if (np == NULL || reset_io == 0)
 		return -ENODEV;

@@ -2515,31 +2505,26 @@ static int __init probe_motherboard(void)
 	 * supposed to be set when not supported, but I'm not very confident
 	 * that all Apple OF revs did it properly, I do it the paranoid way.
 	 */
-	while (uninorth_base && uninorth_rev > 3) {
-		struct device_node *cpus = of_find_node_by_path("/cpus");
+	if (uninorth_base && uninorth_rev > 3) {
 		struct device_node *np;

-		if (!cpus || !cpus->child) {
-			printk(KERN_WARNING "Can't find CPU(s) in device tree !\n");
-			of_node_put(cpus);
-			break;
-		}
-		np = cpus->child;
-		/* Nap mode not supported on SMP */
-		if (np->sibling) {
-			of_node_put(cpus);
-			break;
-		}
-		/* Nap mode not supported if flush-on-lock property is present */
-		if (of_get_property(np, "flush-on-lock", NULL)) {
-			of_node_put(cpus);
-			break;
+		for_each_of_cpu_node(np) {
+			int cpu_count = 1;
+
+			/* Nap mode not supported on SMP */
+			if (of_get_property(np, "flush-on-lock", NULL) ||
+			    (cpu_count > 1)) {
+				powersave_nap = 0;
+				of_node_put(np);
+				break;
+			}
+
+			cpu_count++;
+			powersave_nap = 1;
 		}
-		of_node_put(cpus);
-		powersave_nap = 1;
-		printk(KERN_DEBUG "Processor NAP mode on idle enabled.\n");
-		break;
 	}
+	if (powersave_nap)
+		printk(KERN_DEBUG "Processor NAP mode on idle enabled.\n");

 	/* On CPUs that support it (750FX), lowspeed by default during
 	 * NAP mode
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 3a529fcdae97..2f00e3daafb0 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -243,10 +243,9 @@ static void __init l2cr_init(void)
 {
 	/* Checks "l2cr-value" property in the registry */
 	if (cpu_has_feature(CPU_FTR_L2CR)) {
-		struct device_node *np = of_find_node_by_name(NULL, "cpus");
-		if (!np)
-			np = of_find_node_by_type(NULL, "cpu");
-		if (np) {
+		struct device_node *np;
+
+		for_each_of_cpu_node(np) {
 			const unsigned int *l2cr =
 				of_get_property(np, "l2cr-value", NULL);
 			if (l2cr) {
@@ -256,6 +255,7 @@ static void __init l2cr_init(void)
 				_set_L2CR(ppc_override_l2cr_value);
 			}
 			of_node_put(np);
+			break;
 		}
 	}

@@ -279,8 +279,8 @@ static void __init pmac_setup_arch(void)
 	/* Set loops_per_jiffy to a half-way reasonable value,
 	   for use until calibrate_delay gets called. */
 	loops_per_jiffy = 50000000 / HZ;
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != NULL) {
+
+	for_each_of_cpu_node(cpu) {
 		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != NULL) {
 			if (pvr >= 0x30 && pvr < 0x80)
@@ -292,8 +292,9 @@ static void __init pmac_setup_arch(void)
 			else
 				/* 601, 603, etc. */
 				loops_per_jiffy = *fp / (2 * HZ);
+			of_node_put(cpu);
+			break;
 		}
-		of_node_put(cpu);
 	}

 	/* See if newworld or oldworld */
--
2.17.1
