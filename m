Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 91176DDF46
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 06:46:23 +1000 (EST)
Date: Wed, 25 Apr 2007 15:46:33 -0500
To: paulus@samba.org
Subject: [PATCH] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070425204633.GC19781@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cpufreq driver for PA Semi PWRficient processors.

Signed-off-by: Egor Martovetsky <egor@pasemi.com>
Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pasemi/Makefile
+++ powerpc/arch/powerpc/platforms/pasemi/Makefile
@@ -1,2 +1,3 @@
 obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o gpio_mdio.o
 
+obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
Index: powerpc/arch/powerpc/platforms/pasemi/cpufreq.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright (C) 2007 PA Semi, Inc
+ *
+ * Author: Egor Martovetsky <egor@pasemi.com>
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/timer.h>
+
+#include <asm/hw_irq.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#define SDCASR_REG		0x0100
+#define SDCASR_REG_STRIDE	0x1000
+#define SDCPWR_CFGA0_REG	0x0100
+#define SDCPWR_PWST0_REG	0x0000
+#define SDCPWR_GIZTIME_REG	0x0440
+
+/* SDCPWR_GIZTIME_REG fields */
+#define SDCPWR_GIZTIME_GR	0x80000000
+#define SDCPWR_GIZTIME_LONGLOCK	0x000000ff
+
+/* This should eventually come out of the device tree */
+#define SDCPWR_BASE		0xfc104000
+#define SDCPWR_SIZE		0x1000
+
+#define SDCASR_BASE		0xfc120000
+#define SDCASR_SIZE		0x2000
+
+static void __iomem *sdcpwr_mapbase;
+static void __iomem *sdcasr_mapbase;
+
+
+static DEFINE_MUTEX(pas_switch_mutex);
+
+/* Current astate, is used when waking up from power savings on
+ * one core, in case the other core has switched states during
+ * the idle time.
+ */
+static int current_astate;
+
+/* We support 5(A0-A4) power states excluding turbo(A5-A6) modes */
+static struct cpufreq_frequency_table pas_freqs[] = {
+	{0,	0},
+	{1,	0},
+	{2,	0},
+	{3,	0},
+	{4,	0},
+	{0,	CPUFREQ_TABLE_END},
+};
+
+static struct freq_attr *pas_cpu_freqs_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+/*
+ * hardware specific functions
+ */
+
+static int get_astate_freq(int astate)
+{
+	u32 ret;
+	ret = in_le32(sdcpwr_mapbase + SDCPWR_CFGA0_REG + (astate * 0x10)) & 0x3f;
+
+	return ret;
+}
+
+static int get_cur_astate(int cpu)
+{
+	u32 ret;
+
+	ret = in_le32(sdcpwr_mapbase + SDCPWR_PWST0_REG);
+	ret = (ret >> (cpu * 4)) & 0x7;
+
+	return ret;
+}
+
+static int get_gizmo_latency(void)
+{
+	u32 giztime, ret;
+	giztime = in_le32(sdcpwr_mapbase + SDCPWR_GIZTIME_REG);
+
+	/* just provide the upper bound */
+	ret = (giztime & SDCPWR_GIZTIME_LONGLOCK) * ((giztime & SDCPWR_GIZTIME_GR) ? 128 : 1) * 1000;
+	return ret;
+}
+
+static void set_astate(int cpu, unsigned int astate)
+{
+	u64 flags;
+
+	/* Return if called before init has run */
+	if (unlikely(!sdcasr_mapbase))
+		return;
+
+	local_irq_save(flags);
+
+	out_le32(sdcasr_mapbase + SDCASR_REG + SDCASR_REG_STRIDE*cpu, astate);
+
+	local_irq_restore(flags);
+}
+
+void restore_astate(int cpu)
+{
+	set_astate(cpu, current_astate);
+}
+
+/*
+ * cpufreq functions
+ */
+
+static int pas_cpufreq_cpu_init (struct cpufreq_policy *policy)
+{
+	u32 *max_freq;
+	int i, cur_astate;
+	struct device_node *cpu;
+
+	cpu = of_get_cpu_node(policy->cpu, NULL);
+
+	if(!cpu)
+		return -ENODEV;
+
+	sdcpwr_mapbase = ioremap(SDCPWR_BASE, SDCPWR_SIZE);
+	sdcasr_mapbase = ioremap(SDCASR_BASE, SDCASR_SIZE);
+	if (!sdcpwr_mapbase || !sdcasr_mapbase)
+		panic("SDCMAP: Cannot map registers!");
+
+	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
+
+	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
+
+	if(!max_freq)
+		return -EINVAL;
+
+	// we need the freq in kHz
+	*max_freq /= 1000;
+
+	pr_debug("max clock-frequency is at %u kHz\n", *max_freq);
+	pr_debug("initializing frequency table\n");
+
+	// initialize frequency table
+	for (i=0; pas_freqs[i].frequency!=CPUFREQ_TABLE_END; i++) {
+		pas_freqs[i].frequency = get_astate_freq(pas_freqs[i].index) * 100000;
+		pr_debug("%d: %d\n", i, pas_freqs[i].frequency);
+	}
+
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+
+	policy->cpuinfo.transition_latency = get_gizmo_latency();
+
+	cur_astate = get_cur_astate(policy->cpu);
+	pr_debug("current astate is at %d\n",cur_astate);
+
+	policy->cur = pas_freqs[cur_astate].frequency;
+	policy->cpus = cpu_possible_map;
+
+	cpufreq_frequency_table_get_attr (pas_freqs, policy->cpu);
+
+	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max are set correctly */
+	return cpufreq_frequency_table_cpuinfo (policy, pas_freqs);
+}
+
+static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static int pas_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, pas_freqs);
+}
+
+static int pas_cpufreq_target(struct cpufreq_policy *policy, unsigned int target_freq,
+			    unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int pas_astate_new;
+	int i;
+
+	cpufreq_frequency_table_target(policy,
+				       pas_freqs,
+				       target_freq,
+				       relation,
+				       &pas_astate_new);
+
+	freqs.old = policy->cur;
+	freqs.new = pas_freqs[pas_astate_new].frequency;
+	freqs.cpu = policy->cpu;
+
+	mutex_lock (&pas_switch_mutex);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	pr_debug("setting frequency for cpu %d to %d kHz, 1/%d of max frequency\n",
+		 policy->cpu,
+		 pas_freqs[pas_astate_new].frequency,
+		 pas_freqs[pas_astate_new].index);
+
+	current_astate = pas_astate_new;
+
+	for_each_online_cpu(i) {
+		set_astate(i, pas_astate_new);
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&pas_switch_mutex);
+
+	return 0;
+}
+
+static struct cpufreq_driver pas_cpufreq_driver = {
+	.name		= "pas-cpufreq",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.init		= pas_cpufreq_cpu_init,
+	.exit		= pas_cpufreq_cpu_exit,
+	.verify		= pas_cpufreq_verify,
+	.target		= pas_cpufreq_target,
+	.attr		= pas_cpu_freqs_attr,
+};
+
+/*
+ * module init and destoy
+ */
+
+static int __init pas_cpufreq_init(void)
+{
+	return cpufreq_register_driver(&pas_cpufreq_driver);
+}
+
+static void __exit pas_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&pas_cpufreq_driver);
+}
+
+module_init(pas_cpufreq_init);
+module_exit(pas_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>");
Index: powerpc/arch/powerpc/platforms/pasemi/idle.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pasemi/idle.c
+++ powerpc/arch/powerpc/platforms/pasemi/idle.c
@@ -61,6 +61,10 @@ static int pasemi_system_reset_exception
 		/* do system reset */
 		return 0;
 	}
+
+	/* Set higher astate since we come out of power savings at 0 */
+	restore_astate(hard_smp_processor_id());
+
 	/* everything handled */
 	regs->msr |= MSR_RI;
 	return 1;
@@ -68,6 +72,11 @@ static int pasemi_system_reset_exception
 
 void __init pasemi_idle_init(void)
 {
+#ifndef CONFIG_PPC_PASEMI_CPUFREQ
+	printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
+	current_mode = 0;
+#endif
+
 	ppc_md.system_reset_exception = pasemi_system_reset_exception;
 	ppc_md.power_save = modes[current_mode].entry;
 	printk(KERN_INFO "Using PA6T idle loop (%s)\n", modes[current_mode].name);
Index: powerpc/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pasemi/pasemi.h
+++ powerpc/arch/powerpc/platforms/pasemi/pasemi.h
@@ -14,6 +14,14 @@ extern void __init pasemi_idle_init(void
 extern void idle_spin(void);
 extern void idle_doze(void);
 
+/* Restore astate to last set */
+#ifdef CONFIG_PPC_PASEMI_CPUFREQ
+extern void restore_astate(int cpu);
+#else
+static inline void restore_astate(int cpu)
+{
+}
+#endif
 
 
 #endif /* _PASEMI_PASEMI_H */
Index: powerpc/arch/powerpc/platforms/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/platforms/Kconfig
+++ powerpc/arch/powerpc/platforms/Kconfig
@@ -155,7 +155,7 @@ source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
-	depends on CPU_FREQ && ADB_PMU && PPC32
+	depends on ADB_PMU && PPC32
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple PowerBooks,
@@ -164,11 +164,21 @@ config CPU_FREQ_PMAC
 
 config CPU_FREQ_PMAC64
 	bool "Support for some Apple G5s"
-	depends on CPU_FREQ && PPC64
+	depends on PPC64
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple iMac G5,
 	  and some of the more recent desktop G5 machines as well.
+
+config PPC_PASEMI_CPUFREQ
+	bool "Support for PA Semi PWRficient"
+	depends on PPC_PASEMI
+	default y
+	select CPU_FREQ_TABLE
+	help
+	  This adds the support for frequency switching on PA Semi
+	  PWRficient processors.
+
 endmenu
 
 config PPC601_SYNC_FIX
