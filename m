Return-Path: <B35336@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 63D95B6F92
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 23:37:06 +1100 (EST)
Received: from mail30-tx2 (localhost.localdomain [127.0.0.1])	by
 mail30-tx2-R.bigfish.com (Postfix) with ESMTP id A93ED132842C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:36:54 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.242])	by
 mail30-tx2.bigfish.com (Postfix) with ESMTP id 7429B30804F	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:36:07 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/7] powerpc/85xx: add support to JOG feature using cpufreq
 interface
Date: Fri, 4 Nov 2011 20:36:06 +0800
Message-ID: <1320410166-14500-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

Some 85xx silicons like MPC8536 and P1022 has the JOG PM feature.

The patch adds the support to change CPU frequency using the standard
cpufreq interface. Add the all PLL ratio core support. The ratio CORE
to CCB can 1:1, 1.5, 2:1, 2.5:1, 3:1, 3.5:1 and 4:1

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/platforms/85xx/Makefile  |    1 +
 arch/powerpc/platforms/85xx/cpufreq.c |  255 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig        |    8 +
 3 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/cpufreq.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 0bdaddc..75432a5 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SUSPEND)	+= sleep.o
+obj-$(CONFIG_MPC85xx_CPUFREQ) += cpufreq.o
 
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/cpufreq.c b/arch/powerpc/platforms/85xx/cpufreq.c
new file mode 100644
index 0000000..20f0458
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/cpufreq.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright (C) 2008-2011 Freescale Semiconductor, Inc.
+ *	Dave Liu <daveliu@freescale.com>
+ *
+ * The cpufreq driver is for Freescale 85xx processor,
+ * based on arch/powerpc/platforms/cell/cbe_cpufreq.c
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005-2007
+ *	Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/of_platform.h>
+
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/reg.h>
+#include <asm/io.h>
+
+#include <sysdev/fsl_soc.h>
+
+static DEFINE_MUTEX(mpc85xx_switch_mutex);
+static void __iomem *guts;
+
+static struct cpufreq_frequency_table mpc85xx_freqs[] = {
+	{2,	0},
+	{3,	0},
+	{4,	0},
+	{5,	0},
+	{6,	0},
+	{7,	0},
+	{8,	0},
+	{0,	CPUFREQ_TABLE_END},
+};
+
+#define FREQ_533MHz	533340000
+#define CORE0_RATIO_SHIFT	16
+#define CORE1_RATIO_SHIFT	24
+#define CORE_RATIO_MASK		0x3f
+
+#define PORPLLSR	0x0
+
+#define PMJCR		0x7c
+#define PMJCR_CORE0_SPD_MASK	0x00001000
+#define PMJCR_CORE1_SPD_MASK	0x00002000
+#define PMJCR_CORE0_RATIO_MASK	(CORE_RATIO_MASK << CORE0_RATIO_SHIFT)
+#define PMJCR_CORE1_RATIO_MASK	(CORE_RATIO_MASK << CORE1_RATIO_SHIFT)
+
+#define POWMGTCSR	0x80
+#define POWMGTCSR_LOSSLESS_MASK	0x00400000
+#define POWMGTCSR_JOG_MASK	0x00200000
+
+/*
+ * hardware specific functions
+ */
+static int get_pll(int cpu)
+{
+	int ret, shift;
+	u32 pll = in_be32(guts + PORPLLSR);
+	shift = (cpu == 1) ? CORE1_RATIO_SHIFT : CORE0_RATIO_SHIFT;
+	ret = (pll >> shift) & CORE_RATIO_MASK;
+
+	return ret;
+}
+
+static void set_pll(unsigned int pll, int cpu)
+{
+	int shift;
+	u32 busfreq, corefreq, val;
+	u32 core_spd, mask, tmp;
+
+	tmp = in_be32(guts + PMJCR);
+	shift = (cpu == 1) ? CORE1_RATIO_SHIFT : CORE0_RATIO_SHIFT;
+	busfreq = fsl_get_sys_freq();
+	val = (pll & CORE_RATIO_MASK) << shift;
+
+	corefreq = ((busfreq * pll) >> 1);
+	/* must set the bit[18/19] if the requested core freq > 533 MHz */
+	core_spd = (cpu == 1) ? PMJCR_CORE1_SPD_MASK : PMJCR_CORE0_SPD_MASK;
+	if (corefreq > FREQ_533MHz)
+		val |= core_spd;
+
+	mask = (cpu == 1) ? (PMJCR_CORE1_RATIO_MASK | PMJCR_CORE1_SPD_MASK) :
+		(PMJCR_CORE0_RATIO_MASK | PMJCR_CORE0_SPD_MASK);
+	tmp &= ~mask;
+	tmp |= val;
+	out_be32(guts + PMJCR, tmp);
+	val = in_be32(guts + PMJCR);
+	out_be32(guts + POWMGTCSR,
+			POWMGTCSR_LOSSLESS_MASK | POWMGTCSR_JOG_MASK);
+	pr_debug("PMJCR request %08x at CPU %d\n", tmp, cpu);
+}
+
+static void verify_pll(int cpu)
+{
+	int shift;
+	u32 busfreq, pll, corefreq;
+
+	shift = (cpu == 1) ? CORE1_RATIO_SHIFT : CORE0_RATIO_SHIFT;
+	busfreq = fsl_get_sys_freq();
+	pll = (in_be32(guts + PORPLLSR) >> shift) & CORE_RATIO_MASK;
+
+	corefreq = (busfreq * pll) >> 1;
+	corefreq /= 1000000;
+	pr_debug("PORPLLSR core freq %dMHz at CPU %d\n", corefreq, cpu);
+}
+
+/*
+ * cpufreq functions
+ */
+static int mpc85xx_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	u32 busfreq = fsl_get_sys_freq();
+	int i, cur_pll;
+
+	/* we need the freq unit with kHz */
+	busfreq /= 1000;
+
+	/* initialize frequency table */
+	pr_info("core %d frequency table:\n", policy->cpu);
+	for (i = 0; mpc85xx_freqs[i].frequency != CPUFREQ_TABLE_END; i++) {
+		mpc85xx_freqs[i].frequency =
+				(busfreq * mpc85xx_freqs[i].index) >> 1;
+		pr_info("%d: %dkHz\n", i, mpc85xx_freqs[i].frequency);
+	}
+
+	/* the latency of a transition, the unit is ns */
+	policy->cpuinfo.transition_latency = 2000;
+
+	cur_pll = get_pll(policy->cpu);
+	pr_debug("current pll is at %d\n", cur_pll);
+
+	for (i = 0; mpc85xx_freqs[i].frequency != CPUFREQ_TABLE_END; i++) {
+		if (mpc85xx_freqs[i].index == cur_pll)
+			policy->cur = mpc85xx_freqs[i].frequency;
+	}
+	pr_debug("current core freq is %d\n", policy->cur);
+
+	cpufreq_frequency_table_get_attr(mpc85xx_freqs, policy->cpu);
+
+	/* this ensures that policy->cpuinfo_min
+	 * and policy->cpuinfo_max are set correctly */
+	return cpufreq_frequency_table_cpuinfo(policy, mpc85xx_freqs);
+}
+
+static int mpc85xx_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static int mpc85xx_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, mpc85xx_freqs);
+}
+
+static int mpc85xx_cpufreq_target(struct cpufreq_policy *policy,
+			      unsigned int target_freq,
+			      unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int new;
+
+	cpufreq_frequency_table_target(policy,
+				       mpc85xx_freqs,
+				       target_freq,
+				       relation,
+				       &new);
+
+	freqs.old = policy->cur;
+	freqs.new = mpc85xx_freqs[new].frequency;
+	freqs.cpu = policy->cpu;
+
+	mutex_lock(&mpc85xx_switch_mutex);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	pr_info("Setting frequency for core %d to %d kHz, " \
+		 "PLL ratio is %d/2\n",
+		 policy->cpu,
+		 mpc85xx_freqs[new].frequency,
+		 mpc85xx_freqs[new].index);
+
+	set_pll(mpc85xx_freqs[new].index, policy->cpu);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&mpc85xx_switch_mutex);
+
+	ppc_proc_freq = freqs.new * 1000ul;
+
+	verify_pll(policy->cpu);
+
+	return 0;
+}
+
+static struct cpufreq_driver mpc85xx_cpufreq_driver = {
+	.verify		= mpc85xx_cpufreq_verify,
+	.target		= mpc85xx_cpufreq_target,
+	.init		= mpc85xx_cpufreq_cpu_init,
+	.exit		= mpc85xx_cpufreq_cpu_exit,
+	.name		= "mpc85xx-cpufreq",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+};
+
+/*
+ * module init and destoy
+ */
+static struct of_device_id mpc85xx_jog_ids[] __initdata = {
+	{ .compatible = "fsl,mpc8536-guts", },
+	{ .compatible = "fsl,p1022-guts", },
+	{}
+};
+
+static int __init mpc85xx_cpufreq_init(void)
+{
+	struct device_node *np;
+
+	pr_info("Freescale MPC85xx CPU frequency switching driver\n");
+	np = of_find_matching_node(NULL, mpc85xx_jog_ids);
+	if (np == NULL)
+		return -ENODEV;
+
+	guts = of_iomap(np, 0);
+	of_node_put(np);
+	if (guts == NULL)
+		return -ENOMEM;
+
+	return cpufreq_register_driver(&mpc85xx_cpufreq_driver);
+}
+
+static void __exit mpc85xx_cpufreq_exit(void)
+{
+	iounmap(guts);
+
+	cpufreq_unregister_driver(&mpc85xx_cpufreq_driver);
+}
+
+module_init(mpc85xx_cpufreq_init);
+module_exit(mpc85xx_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dave Liu <daveliu@freescale.com>");
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b9ba861..64bddda 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -199,6 +199,14 @@ config CPU_FREQ_PMAC64
 	  This adds support for frequency switching on Apple iMac G5,
 	  and some of the more recent desktop G5 machines as well.
 
+config MPC85xx_CPUFREQ
+	bool "Support for Freescale MPC85xx CPU freq"
+	depends on PPC_85xx && PPC32
+	select CPU_FREQ_TABLE
+	help
+	  This adds support for frequency switching on Freescale MPC85xx,
+	  currently including P1022 and MPC8536.
+
 config PPC_PASEMI_CPUFREQ
 	bool "Support for PA Semi PWRficient"
 	depends on PPC_PASEMI
-- 
1.6.4.1
