Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFD3967A64
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2005 21:48:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 21:47:25 +1100
Message-Id: <1110797245.19810.306.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Fix PowerMac cpufreq for newer machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch fixes the cpufreq support for newer machines, including
latest Apple laptops using the 7447A CPU. With this patch, it should now
propertly detect that the CPU is booting low speed on some models, and
let you switch it to full speed (previously, /proc/cpuinfo would display
the frequency of the full speed CPU but it was really running low
speed).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2005-03-13 18:23:11.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-03-14 13:32:36.000000000 +1100
@@ -464,20 +464,22 @@
 	u32 *reg;
 	struct cpufreq_driver *driver = &pmac_cpufreq_driver;
 
-	/* OF only reports the high frequency */
-	hi_freq = cur_freq;
-	low_freq = cur_freq/2;
-	driver->get = dfs_get_cpu_speed;
-	cur_freq = driver->get(0);
-
+	/* Look for voltage GPIO */
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+	reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
+	voltage_gpio = *reg;
 	if (!volt_gpio_np){
 		printk(KERN_ERR "cpufreq: missing cpu-vcore-select gpio\n");
 		return 1;
 	}
 
-	reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
-	voltage_gpio = *reg;
+	/* OF only reports the high frequency */
+	hi_freq = cur_freq;
+	low_freq = cur_freq/2;
+
+	/* Read actual frequency from CPU */
+	driver->get = dfs_get_cpu_speed;
+	cur_freq = driver->get(0);
 	set_speed_proc = dfs_set_cpu_speed;
 
 	return 0;
@@ -492,7 +494,7 @@
  *  - iBook2 500/600 (PMU based, 400Mhz & 500/600Mhz)
  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
  *  - Recent MacRISC3 laptops
- *  - iBook G4s and PowerBook G4s with 7447A CPUs
+ *  - All new machines with 7447A CPUs
  */
 static int __init pmac_cpufreq_setup(void)
 {
@@ -513,11 +515,10 @@
 		goto out;
 	cur_freq = (*value) / 1000;
 
-	/*  Check for 7447A based iBook G4 or PowerBook */
-	if (machine_is_compatible("PowerBook6,5") ||
-	    machine_is_compatible("PowerBook6,4") ||
-	    machine_is_compatible("PowerBook5,5") ||
-	    machine_is_compatible("PowerBook5,4")) {
+	/*  Check for 7447A based MacRISC3 */
+	if (machine_is_compatible("MacRISC3") &&
+	    get_property(cpunode, "dynamic-power-step", NULL) &&
+	    PVR_VER(mfspr(SPRN_PVR)) == 0x8003) {
 		pmac_cpufreq_init_7447A(cpunode);
 	/* Check for other MacRISC3 machines */
 	} else if (machine_is_compatible("PowerBook3,4") ||
