From: John Steele Scott <toojays@toojays.net>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] cpufreq support for 7447A on 2004 iBooks
Date: Sat, 5 Jun 2004 18:45:58 +0930
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>, cpufreq@www.linux.org.uk
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200406051846.50718.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Okay, thanks to some tips from Benjamin Herrenschmidt, I now have a patch
against 2.6.6 which lets you control dynamic frequency scaling on the latest
model iBook G4. I imagine that this same method would apply to the new
PowerBooks as well.

cheers,

John

diff -upr -X dontdiff linux/arch/ppc/kernel/misc.S
linux-2.6.6-dfs/arch/ppc/kernel/misc.S
- --- linux/arch/ppc/kernel/misc.S	2004-06-05 18:02:48.000000000 +0930
+++ linux-2.6.6-dfs/arch/ppc/kernel/misc.S	2004-05-28 12:47:22.000000000 +0930
@@ -253,6 +253,24 @@ _GLOBAL(low_choose_750fx_pll)
 	mtmsr	r7
 	blr

+_GLOBAL(choose_7447a_dfs)
+	/* Clear MSR:EE */
+	mfmsr	r7
+	rlwinm	r0,r7,0,17,15
+	mtmsr	r0
+
+	/* Calc new HID1 value */
+	mfspr	r4,SPRN_HID1
+	insrwi	r4,r3,1,9	/* insert parameter into bit 9 */
+	sync
+	mtspr	SPRN_HID1,r4
+	sync
+	isync
+
+	/* Return */
+	mtmsr	r7
+	blr
+
 #endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_6xx */

 /* void local_save_flags_ptr(unsigned long *flags) */
diff -upr -X dontdiff linux/arch/ppc/platforms/pmac_cpufreq.c
linux-2.6.6-dfs/arch/ppc/platforms/pmac_cpufreq.c
- --- linux/arch/ppc/platforms/pmac_cpufreq.c	2004-06-05 18:02:48.000000000
+0930
+++ linux-2.6.6-dfs/arch/ppc/platforms/pmac_cpufreq.c	2004-06-05
18:08:06.000000000 +0930
@@ -47,6 +47,7 @@
 #warning "WARNING, CPUFREQ not recommended on SMP kernels"
 #endif

+extern void choose_7447a_dfs(int dfs);
 extern void low_choose_750fx_pll(int pll);
 extern void low_sleep_handler(void);
 extern void openpic_suspend(struct sys_device *sysdev, u32 state);
@@ -61,6 +62,7 @@ static unsigned int cur_freq;
 /* Clean that up some day ... use a func ptr or at least an enum... */
 static int cpufreq_uses_pmu;
 static int cpufreq_uses_gpios;
+static int cpufreq_uses_dfs;

 static u32 voltage_gpio;
 static u32 frequency_gpio;
@@ -123,6 +125,29 @@ static int __pmac cpu_750fx_cpu_speed(in
 	return 0;
 }

+/* Switch CPU speed using DFS */
+static int __pmac dfs_set_cpu_speed(int low_speed)
+{
+	/* If ramping up, set voltage first */
+	if (low_speed == 0) {
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x05);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/1000);
+	}
+
+	/* set frequency */
+	choose_7447a_dfs(low_speed);
+
+	/* If ramping down, set voltage last */
+	if (low_speed == 1) {
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, voltage_gpio, 0x04);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/1000);
+	}
+
+	return 0;
+}
+
 /* Switch CPU speed using slewing GPIOs
  */
 static int __pmac gpios_set_cpu_speed(unsigned int low_speed)
@@ -273,6 +298,8 @@ static int __pmac do_set_cpu_speed(int s
 		rc = pmu_set_cpu_speed(speed_mode);
 	else if (cpufreq_uses_gpios)
 		rc = gpios_set_cpu_speed(speed_mode);
+	else if (cpufreq_uses_dfs)
+		rc = dfs_set_cpu_speed(speed_mode);
 	else
 		rc = cpu_750fx_cpu_speed(speed_mode);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
@@ -346,6 +373,7 @@ static struct cpufreq_driver pmac_cpufre
  *  - iBook2 500 (PMU based, 400Mhz & 500Mhz)
  *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
  *  - Recent MacRISC3 machines
+ *  - iBook G4s with 7447A CPUs
  */
 static int __init pmac_cpufreq_setup(void)
 {
@@ -375,6 +403,32 @@ static int __init pmac_cpufreq_setup(voi
 		struct device_node *freq_gpio_np = of_find_node_by_name(NULL,
"frequency-gpio");
 		struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL,
"slewing-done");

+		/*  Check for 7447A based iBook G4 */
+		if (machine_is_compatible("PowerBook6,5")) {
+			/* OF only reports the high frequency */
+			hi_freq = cur_freq;
+			low_freq = cur_freq/2;
+			if(mfspr(HID1) & HID1_DFS)
+				cur_freq = low_freq;
+			else
+				cur_freq = hi_freq;
+
+			volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
+			if (!volt_gpio_np){
+				printk(KERN_ERR "cpufreq: missing cpu-vcore-select gpio\n");
+				goto out;
+			}
+
+			u32 *reg = (u32 *)get_property(volt_gpio_np, "reg", NULL);
+			voltage_gpio = *reg;
+
+			cpufreq_uses_pmu = 0;
+			cpufreq_uses_gpios = 0;
+			cpufreq_uses_dfs = 1;
+			has_freq_ctl = 1;
+			goto out;
+		}
+
 		/*
 		 * Check to see if it's GPIO driven or PMU only
 		 *
@@ -497,7 +551,7 @@ out:
 	printk(KERN_INFO "Registering PowerMac CPU frequency driver\n");
 	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Boot: %d Mhz, switch method:
%s\n",
 	       low_freq/1000, hi_freq/1000, cur_freq/1000,
- -	       cpufreq_uses_pmu ? "PMU" : (cpufreq_uses_gpios ? "GPIOs" : "CPU"));
+	       cpufreq_uses_pmu ? "PMU" : (cpufreq_uses_gpios ? "GPIOs" :
(cpufreq_uses_dfs ? "DFS" : "CPU")));

 	return cpufreq_register_driver(&pmac_cpufreq_driver);
 }
diff -upr -X dontdiff linux/include/asm-ppc/reg.h
linux-2.6.6-dfs/include/asm-ppc/reg.h
- --- linux/include/asm-ppc/reg.h	2004-06-05 18:02:48.000000000 +0930
+++ linux-2.6.6-dfs/include/asm-ppc/reg.h	2004-06-05 18:37:00.778149544 +0930
@@ -174,6 +174,7 @@

 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
+#define HID1_DFS	(1<<22)		/* 7447A Dynamic Frequency Scaling */
 #define HID1_PC0	(1<<16)		/* 7450 PLL_CFG[0] */
 #define HID1_PC1	(1<<15)		/* 7450 PLL_CFG[1] */
 #define HID1_PC2	(1<<14)		/* 7450 PLL_CFG[2] */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
