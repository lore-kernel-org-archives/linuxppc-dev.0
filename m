Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5A192BDF2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Dec 2004 10:59:09 +1100 (EST)
Date: Fri, 3 Dec 2004 00:49:50 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: benh@kernel.crashing.org
Message-ID: <20041202234949.GA4893@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [patch]: pmac_cpufreq: .get for gpois, use generic cpufreq debugging
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,
the attached (against 2.6.10-rc2-bk14) cleans up some minor things in
pmac_cpufreq:
 - use the generic cpufreq-debugging functions
 - fix return value in gpios init (no problem, since currently unused)
 - implement get for gpio driven frequency scaling (is it too expensive
   to look up the of node every time?) 
I couldn't test the gpios part since my pbook uses pmu driven frequency
scaling, but it's simple. Can you think of a clean way to get the
current frequency on these beasts? Maybe you point me to the correct
place area in the darwin sources?
Please apply the patch if appropriate.
 -- Guido

Singed-Off-By: Guido Guenther <agx@sigxcpu.org>

--- linux-2.6.10-rc2-bk14/arch/ppc/platforms/pmac_cpufreq.c.orig	2004-12-02 20:55:51.000000000 +0100
+++ linux-2.6.10-rc2-bk14/arch/ppc/platforms/pmac_cpufreq.c	2004-12-03 00:03:37.000000000 +0100
@@ -36,6 +36,7 @@
 #include <asm/system.h>
 #include <asm/open_pic.h>
 
+#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, "pmac-cpufreq", msg)
 /* WARNING !!! This will cause calibrate_delay() to be called,
  * but this is an __init function ! So you MUST go edit
  * init/main.c to make it non-init before enabling DEBUG_FREQ
@@ -118,14 +119,12 @@
  */
 static int __pmac cpu_750fx_cpu_speed(int low_speed)
 {
-#ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
-#endif
+	dprintk("HID1, before: %x\n", mfspr(SPRN_HID1));
 #ifdef CONFIG_6xx
 	low_choose_750fx_pll(low_speed);
 #endif
+	dprintk("HID1, after: %x\n", mfspr(SPRN_HID1));
 #ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
 	debug_calc_bogomips();
 #endif
 
@@ -202,9 +201,7 @@
 
 	preempt_disable();
 
-#ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
-#endif
+	dprintk("HID1, before: %x\n", mfspr(SPRN_HID1));
 	/* Disable all interrupt sources on openpic */
  	openpic_set_priority(0xf);
 
@@ -262,9 +259,7 @@
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context, current->active_mm->pgd);
 
-#ifdef DEBUG_FREQ
-	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
-#endif
+	dprintk("HID1, after: %x\n", mfspr(SPRN_HID1));
 
 	/* Restore low level PMU operations */
 	pmu_unlock();
@@ -354,15 +349,33 @@
 	return 0x50 + (*reg);
 }
 
+static struct freq_attr* pmac_cpufreq_attr[] = { 
+        &cpufreq_freq_attr_scaling_available_freqs,
+        NULL,
+};
+
 static struct cpufreq_driver pmac_cpufreq_driver = {
 	.verify 	= pmac_cpufreq_verify,
 	.target 	= pmac_cpufreq_target,
 	.init		= pmac_cpufreq_cpu_init,
 	.name		= "powermac",
 	.owner		= THIS_MODULE,
+	.attr		= pmac_cpufreq_attr,
 };
 
 
+static unsigned int __pmac pmac_cpufreq_get_gpios(unsigned int cpu)
+{
+	struct device_node *freq_gpio_np = of_find_node_by_name(NULL,
+								"frequency-gpio");
+	int rc;
+
+	frequency_gpio = read_gpio(freq_gpio_np);
+	rc = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, frequency_gpio, 0);
+	return (rc & 0x01) ? hi_freq : low_freq;
+}
+
+
 static int __pmac pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np = of_find_node_by_name(NULL,
@@ -371,6 +384,7 @@
 								"frequency-gpio");
 	struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL,
 								     "slewing-done");
+	struct cpufreq_driver *driver = &pmac_cpufreq_driver;
 	u32 *value;
 
 	/*
@@ -395,6 +409,7 @@
 		int lenp, rc;
 		u32 *freqs, *ratio;
 
+		dprintk("using GIO\n.");
 		freqs = (u32 *)get_property(cpunode, "bus-frequencies", &lenp);
 		lenp /= sizeof(u32);
 		if (freqs == NULL || lenp != 2) {
@@ -423,14 +438,15 @@
 		low_freq = (low_freq * (*ratio)) / 2000;
 		hi_freq = (hi_freq * (*ratio)) / 2000;
 
-		/* Now we get the frequencies, we read the GPIO to see what is out current
+		/* Now we get the frequencies, we read the GPIO to see what is our current
 		 * speed
 		 */
 		rc = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, frequency_gpio, 0);
 		cur_freq = (rc & 0x01) ? hi_freq : low_freq;
 
 		set_speed_proc = gpios_set_cpu_speed;
-		return 1;
+		driver->get = pmac_cpufreq_get_gpios;
+		return 0;
 	}
 
 	/* If we use the PMU, look for the min & max frequencies in the
@@ -450,7 +466,8 @@
 		return 1;
 	hi_freq = (*value) / 1000;
 	set_speed_proc = pmu_set_cpu_speed;
+	dprintk("using PMU\n.");
 
 	return 0;
 }
 
