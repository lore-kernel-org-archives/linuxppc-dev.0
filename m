Return-Path: <B35336@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 48496B75DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 20:56:16 +1100 (EST)
Received: from mail142-tx2 (localhost.localdomain [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id 2FD76550335	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:58 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.245])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id E66CD198051	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:35 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 4/7] powerpc/85xx: add support to JOG feature using cpufreq
 interface
Date: Wed, 16 Nov 2011 17:55:42 +0800
Message-ID: <1321437344-19253-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
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
to CCB can 1:1(except MPC8536), 3:2, 2:1, 5:2, 3:1, 7:2 and 4:1.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
Changes for v2:
 - rework set_pll(). wakeup all cores before issuing a jog request.
 - use the platform driver framwork

 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/cpufreq-jog.c |  322 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig            |    8 +
 3 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/cpufreq-jog.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index cec54c7..49a865a 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SUSPEND)	+= sleep.o
+obj-$(CONFIG_MPC85xx_CPUFREQ) += cpufreq-jog.o
 
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/cpufreq-jog.c b/arch/powerpc/platforms/85xx/cpufreq-jog.c
new file mode 100644
index 0000000..efe62b9
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/cpufreq-jog.c
@@ -0,0 +1,322 @@
+/*
+ * Copyright (C) 2008-2011 Freescale Semiconductor, Inc.
+ * Author: Dave Liu <daveliu@freescale.com>
+ * Modifier: Chenhui Zhao <chenhui.zhao@freescale.com>
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
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/of_platform.h>
+
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+
+#include <sysdev/fsl_soc.h>
+
+static DEFINE_MUTEX(mpc85xx_switch_mutex);
+static void __iomem *guts;
+static u32 sysfreq, threshold_freq;
+static struct cpufreq_frequency_table *mpc85xx_freqs;
+
+static struct cpufreq_frequency_table mpc8536_freqs_table[] = {
+	{3,	0},
+	{4,	0},
+	{5,	0},
+	{6,	0},
+	{7,	0},
+	{8,	0},
+	{0,	CPUFREQ_TABLE_END},
+};
+
+static struct cpufreq_frequency_table p1022_freqs_table[] = {
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
+#define FREQ_800MHz	800000000
+
+#define CORE_RATIO_BITS		8
+#define CORE_RATIO_MASK		0x3f
+#define CORE0_RATIO_SHIFT	16
+
+#define PORPLLSR	0x0
+
+#define PMJCR		0x7c
+#define PMJCR_CORE0_SPD_MASK	0x00001000
+
+#define POWMGTCSR	0x80
+#define POWMGTCSR_LOSSLESS_MASK	0x00400000
+#define POWMGTCSR_JOG_MASK	0x00200000
+#define POWMGTCSR_CORE0_IRQ_MSK	0x80000000
+#define POWMGTCSR_CORE0_CI_MSK	0x40000000
+#define POWMGTCSR_CORE0_DOZING	0x00000008
+#define POWMGTCSR_CORE0_NAPPING	0x00000004
+
+/*
+ * hardware specific functions
+ */
+static int get_pll(int hw_cpu)
+{
+	int ret, shift;
+	u32 cur_pll = in_be32(guts + PORPLLSR);
+
+	shift = hw_cpu * CORE_RATIO_BITS + CORE0_RATIO_SHIFT;
+	ret = (cur_pll >> shift) & CORE_RATIO_MASK;
+	return ret;
+}
+
+static int set_pll(unsigned int cpu, unsigned int pll)
+{
+	void *powersave = NULL;
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+	int shift, i;
+	u32 corefreq, val;
+	u32 mask;
+	unsigned long flags;
+	int ret = 0;
+
+	if (pll == get_pll(hw_cpu))
+		return 0;
+
+	shift = hw_cpu * CORE_RATIO_BITS + CORE0_RATIO_SHIFT;
+	val = (pll & CORE_RATIO_MASK) << shift;
+
+	corefreq = sysfreq * pll / 2;
+	/*
+	 * Set the COREx_SPD bit if the requested core frequency
+	 * is larger than the threshold frequency.
+	 */
+	if (corefreq > threshold_freq)
+		val |= PMJCR_CORE0_SPD_MASK << hw_cpu;
+
+	mask = (CORE_RATIO_MASK << shift) | (PMJCR_CORE0_SPD_MASK << hw_cpu);
+	clrsetbits_be32(guts + PMJCR, mask, val);
+
+	/* readback to sync write */
+	val = in_be32(guts + PMJCR);
+
+	local_irq_save(flags);
+	/*
+	 * A Jog request can not be asserted when any core is in a low power
+	 * state. Before executing a jog request, any core which is in
+	 * a low power state must be waked by a interrupt.
+	 */
+	if (mpc85xx_freqs == p1022_freqs_table) {
+		powersave = ppc_md.power_save;
+		ppc_md.power_save = NULL;
+		wmb();
+		val = in_be32(guts + POWMGTCSR);
+		for_each_online_cpu(i) {
+			if (val & ((POWMGTCSR_CORE0_DOZING |
+					POWMGTCSR_CORE0_NAPPING) << (i * 2)))
+				smp_send_reschedule(i);
+		}
+	}
+	setbits32(guts + POWMGTCSR, POWMGTCSR_JOG_MASK);
+
+	if (powersave) {
+		ppc_md.power_save = powersave;
+		wmb();
+	}
+
+	local_irq_restore(flags);
+
+	/* verify */
+	if (!spin_event_timeout(get_pll(hw_cpu) == pll, 10000, 10)) {
+		pr_err("%s: Fail to switch the core frequency. "
+			"The current PLL of core %d is %d instead of %d.\n",
+				__func__, hw_cpu, get_pll(hw_cpu), pll);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * cpufreq functions
+ */
+static int mpc85xx_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int i, cur_pll;
+	int hw_cpu = get_hard_smp_processor_id(policy->cpu);
+
+	if (!cpu_present(policy->cpu))
+		return -EINVAL;
+
+	/* the latency of a transition, the unit is ns */
+	policy->cpuinfo.transition_latency = 2000;
+
+	cur_pll = get_pll(hw_cpu);
+
+	/* initialize frequency table */
+	pr_debug("core%d frequency table:\n", hw_cpu);
+	for (i = 0; mpc85xx_freqs[i].frequency != CPUFREQ_TABLE_END; i++) {
+		/* The frequency unit is kHz. */
+		mpc85xx_freqs[i].frequency =
+				(sysfreq * mpc85xx_freqs[i].index / 2) / 1000;
+		pr_debug("%d: %dkHz\n", i, mpc85xx_freqs[i].frequency);
+
+		if (mpc85xx_freqs[i].index == cur_pll)
+			policy->cur = mpc85xx_freqs[i].frequency;
+	}
+	pr_debug("current pll is at %d, and core freq is%d\n",
+					cur_pll, policy->cur);
+
+	cpufreq_frequency_table_get_attr(mpc85xx_freqs, policy->cpu);
+
+	/*
+	 * This ensures that policy->cpuinfo_min
+	 * and policy->cpuinfo_max are set correctly.
+	 */
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
+	int ret = 0;
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
+	ret = set_pll(policy->cpu, mpc85xx_freqs[new].index);
+	if (!ret) {
+		pr_info("cpufreq: Setting core%d frequency to %d kHz and " \
+			 "PLL ratio to %d:2\n",
+			 policy->cpu,
+			 mpc85xx_freqs[new].frequency,
+			 mpc85xx_freqs[new].index);
+
+		ppc_proc_freq = freqs.new * 1000ul;
+	}
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&mpc85xx_switch_mutex);
+
+	return ret;
+}
+
+static struct cpufreq_driver mpc85xx_cpufreq_driver = {
+	.verify		= mpc85xx_cpufreq_verify,
+	.target		= mpc85xx_cpufreq_target,
+	.init		= mpc85xx_cpufreq_cpu_init,
+	.exit		= mpc85xx_cpufreq_cpu_exit,
+	.name		= "mpc85xx-JOG",
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_CONST_LOOPS,
+};
+
+static int mpc85xx_job_probe(struct platform_device *ofdev)
+{
+	struct device_node *np = ofdev->dev.of_node;
+
+	if (of_device_is_compatible(np, "fsl,mpc8536-guts")) {
+		threshold_freq = FREQ_800MHz;
+		mpc85xx_freqs = mpc8536_freqs_table;
+	} else if (of_device_is_compatible(np, "fsl,p1022-guts")) {
+		threshold_freq = FREQ_533MHz;
+		mpc85xx_freqs = p1022_freqs_table;
+	}
+
+	sysfreq = fsl_get_sys_freq();
+
+	guts = of_iomap(np, 0);
+	if (guts == NULL)
+		return -ENOMEM;
+
+	pr_info("Freescale MPC85xx CPU frequency switching(JOG) driver\n");
+
+	return cpufreq_register_driver(&mpc85xx_cpufreq_driver);
+}
+
+static int mpc85xx_jog_remove(struct platform_device *ofdev)
+{
+	iounmap(guts);
+	cpufreq_unregister_driver(&mpc85xx_cpufreq_driver);
+
+	return 0;
+}
+
+static struct of_device_id mpc85xx_jog_ids[] = {
+	{ .compatible = "fsl,mpc8536-guts", },
+	{ .compatible = "fsl,p1022-guts", },
+	{}
+};
+
+static struct platform_driver mpc85xx_jog_driver = {
+	.driver = {
+		.name = "mpc85xx_cpufreq_jog",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc85xx_jog_ids,
+	},
+	.probe = mpc85xx_job_probe,
+	.remove = mpc85xx_jog_remove,
+};
+
+static int __init mpc85xx_jog_init(void)
+{
+	return platform_driver_register(&mpc85xx_jog_driver);
+}
+
+static void __exit mpc85xx_jog_exit(void)
+{
+	platform_driver_unregister(&mpc85xx_jog_driver);
+}
+
+module_init(mpc85xx_jog_init);
+module_exit(mpc85xx_jog_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dave Liu <daveliu@freescale.com>");
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e458872..63bd32a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -200,6 +200,14 @@ config CPU_FREQ_PMAC64
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
