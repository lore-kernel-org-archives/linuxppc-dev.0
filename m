Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D5D6B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 14:18:39 +1000 (EST)
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
In-Reply-To: <1305973726-28006-1-git-send-email-dbaryshkov@gmail.com>
References: <1305973726-28006-1-git-send-email-dbaryshkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 14:14:48 +1000
Message-ID: <1308284088.32158.0.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-05-21 at 14:28 +0400, Dmitry Eremin-Solenikov wrote:
> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
> boxes with all pmac-dependant features removed and simple cleanup
> applied.

No special comment other than please replace all the g5_* with maple_
for consistency.

Cheers,
Ben.

> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/powerpc/kernel/misc_64.S          |    4 +-
>  arch/powerpc/platforms/Kconfig         |    8 +
>  arch/powerpc/platforms/maple/Makefile  |    1 +
>  arch/powerpc/platforms/maple/cpufreq.c |  317 ++++++++++++++++++++++++++++++++
>  4 files changed, 328 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/maple/cpufreq.c
> 
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 206a321..c442aae 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -339,7 +339,7 @@ _GLOBAL(real_205_writeb)
>  #endif /* CONFIG_PPC_PASEMI */
>  
> 
> -#ifdef CONFIG_CPU_FREQ_PMAC64
> +#if defined(CONFIG_CPU_FREQ_PMAC64) || defined(CONFIG_CPU_FREQ_MAPLE)
>  /*
>   * SCOM access functions for 970 (FX only for now)
>   *
> @@ -408,7 +408,7 @@ _GLOBAL(scom970_write)
>  	/* restore interrupts */
>  	mtmsrd	r5,1
>  	blr
> -#endif /* CONFIG_CPU_FREQ_PMAC64 */
> +#endif /* CONFIG_CPU_FREQ_PMAC64 || CONFIG_CPU_FREQ_MAPLE */
>  
> 
>  /*
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index f7b0772..4c5eb5b 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -187,6 +187,14 @@ config PPC_PASEMI_CPUFREQ
>  	  This adds the support for frequency switching on PA Semi
>  	  PWRficient processors.
>  
> +config CPU_FREQ_MAPLE
> +	bool "Support for Maple 970FX Evaluation Board"
> +	depends on PPC_MAPLE
> +	select CPU_FREQ_TABLE
> +	help
> +	  This adds support for frequency switching on Maple 970FX
> +	  Evaluation Board and compatible boards (IBM JS2x blades).
> +
>  endmenu
>  
>  config PPC601_SYNC_FIX
> diff --git a/arch/powerpc/platforms/maple/Makefile b/arch/powerpc/platforms/maple/Makefile
> index 1be1a99..0b3e3e3 100644
> --- a/arch/powerpc/platforms/maple/Makefile
> +++ b/arch/powerpc/platforms/maple/Makefile
> @@ -1 +1,2 @@
>  obj-y	+= setup.o pci.o time.o
> +obj-$(CONFIG_CPU_FREQ_MAPLE) += cpufreq.o
> diff --git a/arch/powerpc/platforms/maple/cpufreq.c b/arch/powerpc/platforms/maple/cpufreq.c
> new file mode 100644
> index 0000000..854adfa
> --- /dev/null
> +++ b/arch/powerpc/platforms/maple/cpufreq.c
> @@ -0,0 +1,317 @@
> +/*
> + *  Copyright (C) 2011 Dmitry Eremin-Solenikov
> + *  Copyright (C) 2002 - 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> + *  and                       Markus Demleitner <msdemlei@cl.uni-heidelberg.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This driver adds basic cpufreq support for SMU & 970FX based G5 Macs,
> + * that is iMac G5 and latest single CPU desktop.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/sched.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/completion.h>
> +#include <linux/mutex.h>
> +#include <asm/prom.h>
> +#include <asm/machdep.h>
> +#include <asm/irq.h>
> +#include <asm/sections.h>
> +#include <asm/cputable.h>
> +#include <asm/time.h>
> +
> +#define DBG(fmt...) pr_debug(fmt)
> +
> +/* see 970FX user manual */
> +
> +#define SCOM_PCR 0x0aa001			/* PCR scom addr */
> +
> +#define PCR_HILO_SELECT		0x80000000U	/* 1 = PCR, 0 = PCRH */
> +#define PCR_SPEED_FULL		0x00000000U	/* 1:1 speed value */
> +#define PCR_SPEED_HALF		0x00020000U	/* 1:2 speed value */
> +#define PCR_SPEED_QUARTER	0x00040000U	/* 1:4 speed value */
> +#define PCR_SPEED_MASK		0x000e0000U	/* speed mask */
> +#define PCR_SPEED_SHIFT		17
> +#define PCR_FREQ_REQ_VALID	0x00010000U	/* freq request valid */
> +#define PCR_VOLT_REQ_VALID	0x00008000U	/* volt request valid */
> +#define PCR_TARGET_TIME_MASK	0x00006000U	/* target time */
> +#define PCR_STATLAT_MASK	0x00001f00U	/* STATLAT value */
> +#define PCR_SNOOPLAT_MASK	0x000000f0U	/* SNOOPLAT value */
> +#define PCR_SNOOPACC_MASK	0x0000000fU	/* SNOOPACC value */
> +
> +#define SCOM_PSR 0x408001			/* PSR scom addr */
> +/* warning: PSR is a 64 bits register */
> +#define PSR_CMD_RECEIVED	0x2000000000000000U   /* command received */
> +#define PSR_CMD_COMPLETED	0x1000000000000000U   /* command completed */
> +#define PSR_CUR_SPEED_MASK	0x0300000000000000U   /* current speed */
> +#define PSR_CUR_SPEED_SHIFT	(56)
> +
> +/*
> + * The G5 only supports two frequencies (Quarter speed is not supported)
> + */
> +#define CPUFREQ_HIGH                  0
> +#define CPUFREQ_LOW                   1
> +
> +static struct cpufreq_frequency_table g5_cpu_freqs[] = {
> +	{CPUFREQ_HIGH, 		0},
> +	{CPUFREQ_LOW,		0},
> +	{0,			CPUFREQ_TABLE_END},
> +};
> +
> +static struct freq_attr* g5_cpu_freqs_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL,
> +};
> +
> +/* Power mode data is an array of the 32 bits PCR values to use for
> + * the various frequencies, retrieved from the device-tree
> + */
> +static int g5_pmode_cur;
> +
> +static DEFINE_MUTEX(g5_switch_mutex);
> +
> +static const u32 *g5_pmode_data;
> +static int g5_pmode_max;
> +
> +/*
> + * Fake voltage switching for platforms with missing support
> + */
> +
> +static void g5_dummy_switch_volt(int speed_mode)
> +{
> +}
> +
> +/*
> + * SCOM based frequency switching for 970FX rev3
> + */
> +static int g5_scom_switch_freq(int speed_mode)
> +{
> +	unsigned long flags;
> +	int to;
> +
> +	/* If frequency is going up, first ramp up the voltage */
> +	if (speed_mode < g5_pmode_cur)
> +		g5_dummy_switch_volt(speed_mode);
> +
> +	local_irq_save(flags);
> +
> +	/* Clear PCR high */
> +	scom970_write(SCOM_PCR, 0);
> +	/* Clear PCR low */
> +	scom970_write(SCOM_PCR, PCR_HILO_SELECT | 0);
> +	/* Set PCR low */
> +	scom970_write(SCOM_PCR, PCR_HILO_SELECT |
> +		      g5_pmode_data[speed_mode]);
> +
> +	/* Wait for completion */
> +	for (to = 0; to < 10; to++) {
> +		unsigned long psr = scom970_read(SCOM_PSR);
> +
> +		if ((psr & PSR_CMD_RECEIVED) == 0 &&
> +		    (((psr >> PSR_CUR_SPEED_SHIFT) ^
> +		      (g5_pmode_data[speed_mode] >> PCR_SPEED_SHIFT)) & 0x3)
> +		    == 0)
> +			break;
> +		if (psr & PSR_CMD_COMPLETED)
> +			break;
> +		udelay(100);
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	/* If frequency is going down, last ramp the voltage */
> +	if (speed_mode > g5_pmode_cur)
> +		g5_dummy_switch_volt(speed_mode);
> +
> +	g5_pmode_cur = speed_mode;
> +	ppc_proc_freq = g5_cpu_freqs[speed_mode].frequency * 1000ul;
> +
> +	return 0;
> +}
> +
> +static int g5_scom_query_freq(void)
> +{
> +	unsigned long psr = scom970_read(SCOM_PSR);
> +	int i;
> +
> +	for (i = 0; i <= g5_pmode_max; i++)
> +		if ((((psr >> PSR_CUR_SPEED_SHIFT) ^
> +		      (g5_pmode_data[i] >> PCR_SPEED_SHIFT)) & 0x3) == 0)
> +			break;
> +	return i;
> +}
> +
> +/*
> + * Common interface to the cpufreq core
> + */
> +
> +static int g5_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_frequency_table_verify(policy, g5_cpu_freqs);
> +}
> +
> +static int g5_cpufreq_target(struct cpufreq_policy *policy,
> +	unsigned int target_freq, unsigned int relation)
> +{
> +	unsigned int newstate = 0;
> +	struct cpufreq_freqs freqs;
> +	int rc;
> +
> +	if (cpufreq_frequency_table_target(policy, g5_cpu_freqs,
> +			target_freq, relation, &newstate))
> +		return -EINVAL;
> +
> +	if (g5_pmode_cur == newstate)
> +		return 0;
> +
> +	mutex_lock(&g5_switch_mutex);
> +
> +	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
> +	freqs.new = g5_cpu_freqs[newstate].frequency;
> +	freqs.cpu = 0;
> +
> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	rc = g5_scom_switch_freq(newstate);
> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> +	mutex_unlock(&g5_switch_mutex);
> +
> +	return rc;
> +}
> +
> +static unsigned int g5_cpufreq_get_speed(unsigned int cpu)
> +{
> +	return g5_cpu_freqs[g5_pmode_cur].frequency;
> +}
> +
> +static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	policy->cpuinfo.transition_latency = 12000;
> +	policy->cur = g5_cpu_freqs[g5_scom_query_freq()].frequency;
> +	/* secondary CPUs are tied to the primary one by the
> +	 * cpufreq core if in the secondary policy we tell it that
> +	 * it actually must be one policy together with all others. */
> +	cpumask_copy(policy->cpus, cpu_online_mask);
> +	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
> +
> +	return cpufreq_frequency_table_cpuinfo(policy,
> +		g5_cpu_freqs);
> +}
> +
> +
> +static struct cpufreq_driver g5_cpufreq_driver = {
> +	.name		= "maple",
> +	.owner		= THIS_MODULE,
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.init		= g5_cpufreq_cpu_init,
> +	.verify		= g5_cpufreq_verify,
> +	.target		= g5_cpufreq_target,
> +	.get		= g5_cpufreq_get_speed,
> +	.attr		= g5_cpu_freqs_attr,
> +};
> +
> +static int __init g5_cpufreq_init(void)
> +{
> +	struct device_node *cpus;
> +	struct device_node *cpunode;
> +	unsigned int psize;
> +	unsigned long max_freq;
> +	const u32 *valp;
> +	u32 pvr_hi;
> +	int rc = -ENODEV;
> +
> +	cpus = of_find_node_by_path("/cpus");
> +	if (cpus == NULL) {
> +		DBG("No /cpus node !\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Get first CPU node */
> +	for (cpunode = NULL;
> +	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
> +		const u32 *reg = of_get_property(cpunode, "reg", NULL);
> +		if (reg == NULL || (*reg) != 0)
> +			continue;
> +		if (!strcmp(cpunode->type, "cpu"))
> +			break;
> +	}
> +	if (cpunode == NULL) {
> +		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
> +		goto bail_cpus;
> +	}
> +
> +	/* Check 970FX for now */
> +	/* we actually don't care on which CPU to access PVR */
> +	pvr_hi = PVR_VER(mfspr(SPRN_PVR));
> +	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
> +		printk(KERN_ERR "cpufreq: Unsupported CPU version (%x)\n", pvr_hi);
> +		goto bail_noprops;
> +	}
> +
> +	/* Look for the powertune data in the device-tree */
> +	g5_pmode_data = of_get_property(cpunode, "power-mode-data",&psize);
> +	if (!g5_pmode_data) {
> +		DBG("No power-mode-data !\n");
> +		goto bail_noprops;
> +	}
> +	g5_pmode_max = psize / sizeof(u32) - 1;
> +
> +	/*
> +	 * From what I see, clock-frequency is always the maximal frequency.
> +	 * The current driver can not slew sysclk yet, so we really only deal
> +	 * with powertune steps for now. We also only implement full freq and
> +	 * half freq in this version. So far, I haven't yet seen a machine
> +	 * supporting anything else.
> +	 */
> +	valp = of_get_property(cpunode, "clock-frequency", NULL);
> +	if (!valp)
> +		return -ENODEV;
> +	max_freq = (*valp)/1000;
> +	g5_cpu_freqs[0].frequency = max_freq;
> +	g5_cpu_freqs[1].frequency = max_freq/2;
> +
> +	/* Force apply current frequency to make sure everything is in
> +	 * sync (voltage is right for example). Firmware may leave us with
> +	 * a strange setting ...
> +	 */
> +	g5_dummy_switch_volt(CPUFREQ_HIGH);
> +	msleep(10);
> +	g5_pmode_cur = -1;
> +	g5_scom_switch_freq(g5_scom_query_freq());
> +
> +	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
> +	printk(KERN_INFO "Frequency method: SCOM, Voltage method: none\n");
> +	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
> +		g5_cpu_freqs[1].frequency/1000,
> +		g5_cpu_freqs[0].frequency/1000,
> +		g5_cpu_freqs[g5_pmode_cur].frequency/1000);
> +
> +	rc = cpufreq_register_driver(&g5_cpufreq_driver);
> +
> +	of_node_put(cpunode);
> +	of_node_put(cpus);
> +
> +	return rc;
> +
> +bail_noprops:
> +	of_node_put(cpunode);
> +bail_cpus:
> +	of_node_put(cpus);
> +
> +	return rc;
> +}
> +
> +module_init(g5_cpufreq_init);
> +
> +
> +MODULE_LICENSE("GPL");
