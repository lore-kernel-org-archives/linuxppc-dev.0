Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 857EFDDFBD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 08:42:41 +1000 (EST)
Received: from [192.168.1.37] (node29.77.251.72.1dial.com [72.251.77.29])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m53Mg8UK048615
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 15:42:32 -0700 (PDT)
Message-ID: <4845C8B7.5070702@hypersurf.com>
Date: Tue, 03 Jun 2008 15:41:59 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 750GX cpu freq support
Content-Type: multipart/mixed; boundary="------------040203050902000703040702"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040203050902000703040702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	 I was hoping that someone might know something about the cpufreq stuff 
and would be willing to take a look at what I have so far.

	It all loads up and tries to run. But if I switch to the conservative 
governor it starts trying to switch to some 4.2 billion KHz (-49000). It 
(the system) seems to eventually freeze up. The ondemand governor sort 
of has the opposite effect. It wants to go to 0 KHz?

	This is built on a module called pll_if that handles the low level 
interface to the PLL register (HID1). It (pll_if) includes an optional 
sysfs attribute that can be used to monkey with the PLL. I have a perl 
script to allow one to modify the PLL in a more human friendly way. Via 
the sysfs attribute, pll_if is useable. So I don't think the problem is 
in it (though it is supposed to prevent you from doing anything stupid, 
like switching to a PLL that is off or modifying the active PLL - but it 
may not be as bullet proof as I would like).

	In particular, the frequency switch in my driver is not synchronous (it 
may not be completed when Target() returns). Don't know if 
cpufreq_core/governors care about this? Is this notifier stuff some kind 
of generic "callback" framework?

	Any investigating tips would be appreciated. I don't know whether 
pll_if is being asked to do something dumb and is doing it or if it is 
freezing up else where.

	"System" is a powermac 8600 with a powerlogix 750GX card in it.

kevin

P.S.:  This will show how much of a novice I am:  What's a "git"?

--------------040203050902000703040702
Content-Type: text/plain;
 name="cf750gx-new_c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cf750gx-new_c"

/*
 * cf750gx.c - cpufreq driver for the dual PLLs in the 750gx
 * ($Revision: 1.0 $)
 *
 *  Copyright (C) 2008       kevin Diggs
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or (at
 *  your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/cpufreq.h>
#include <linux/compiler.h>
#include <linux/dmi.h>
#include "linux/of.h"

//#include <asm/io.h>
//#include <asm/msr.h>
#include <asm/processor.h>
//#include <asm/cpufeature.h>
#include <asm/delay.h>
//#include <asm/uaccess.h>
#include "asm/pll.h"
#include "asm/pll_if.h"

#include "cf750gx.h"

#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, \
	"ppc-750gx-cpufreq", msg)

MODULE_AUTHOR("Kevin Diggs");
MODULE_DESCRIPTION("750GX Dual PLL cpufreq driver");
MODULE_LICENSE("GPL");

static const struct pll_750fgx __initdata pll_750fx ={
	.min_ratio = 2,
	.max_ratio = 20,
	.min_core = 400000,
	.max_core = 800000,
};

static const struct pll_750fgx __initdata pll_750gx = {
	.min_ratio = 2,
	.max_ratio = 20,
	.min_core = 500000,
	.max_core = 1000000,
};

static unsigned int override_min_core=0;
static unsigned int override_max_core=0;
static unsigned int override_bus_freq=0;
static unsigned int freq_steps=0;

static unsigned int cf750gxvBusSpeed=0;
static unsigned int cf750gxvMinCore=0;
static unsigned int cf750gxvMaxCore=0;

struct cpufreq_frequency_table *cf750gxvFreqTable;

static int cf750gxTarget(struct cpufreq_policy *policy,
			       unsigned int target_freq, unsigned int relation)
{
unsigned int next_state = 0; /* Index into freq_table */
unsigned int next_perf_state = 0; /* Index into perf table */
//unsigned int i;
int result = 0;
unsigned int pll,new_pll;
unsigned int active_pll;
struct cpufreq_freqs freqs;

	dprintk("cf750gxTarget() %d (%d)\n", target_freq, policy->cpu);

	result = cpufreq_frequency_table_target(policy,
						cf750gxvFreqTable,
						target_freq,
						relation, &next_state);
	if (unlikely(result))
		return -ENODEV;

	pll=get_PLL();
	active_pll=get_active_PLL(pll);

#ifdef CONFIG_HOTPLUG_CPU
	/* cpufreq holds the hotplug lock, so we are safe from here on */
//	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
#else
//	online_policy_cpus = policy->cpus;
#endif

	next_perf_state = cf750gxvFreqTable[next_state].index;
	if (cf750gxiPackState(get_PLL_ratio(active_pll,pll), get_PLL_range(
		active_pll,pll)) == next_perf_state) {
		dprintk("Already at target state (P%d)\n",
			next_perf_state);
		return 0;
	}

//	cpus_clear(cmd.mask);

	if(active_pll)
	{
		/*
		 * Since active PLL is 1, modify PLL 0
		 */
		next_perf_state=next_perf_state<<(PLL0_CFG_SHIFT-
			PLL1_CFG_SHIFT);

		new_pll=(PLL0_DO_CFG|PLL0_DO_RNG|PLL_DO_SEL)<<24;
	}
	else
	{
		/*
		 * Use PLL 1
		 */
		new_pll=((PLL1_DO_CFG|PLL1_DO_RNG|PLL_DO_SEL)<<24)|PLL_SEL_MASK;
	}

	new_pll=new_pll|next_perf_state;

	dprintk(__FILE__"-%d:  Modifying PLL:  0x%x\n",__LINE__,new_pll);

	freqs.old=cfgToFreq(get_PLL_ratio(active_pll,pll),cf750gxvBusSpeed);
	freqs.new=cf750gxvFreqTable[next_state].frequency;
	freqs.cpu=0;

	dprintk(__FILE__"-%d:  freqs.old=%d, freqs.new=%d\n",__LINE__,freqs.
		old,freqs.new);

	cpufreq_notify_transition(&freqs,CPUFREQ_PRECHANGE);

	result=modifyPLL(new_pll,0);

	cpufreq_notify_transition(&freqs,CPUFREQ_POSTCHANGE);

	return result;
}

static int cf750gxVerify(struct cpufreq_policy *policy)
{
	dprintk("cf750gxVerify\n");

	return cpufreq_frequency_table_verify(policy, cf750gxvFreqTable);
}

static int cf750gxCpuInit(struct cpufreq_policy *policy)
{
	unsigned int i,pll,ratio;
	unsigned int result = 0;

	dprintk("cf750gxCpuInit\n");

	pll=get_PLL();
	ratio=get_PLL_ratio(get_active_PLL(pll),pll);

	if(ratio>20) ratio=(ratio-10)<<1;

	policy->cur=ratio*cf750gxvBusSpeed/2000;

//	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
	policy->cpuinfo.transition_latency = getLatency();

	result = cpufreq_frequency_table_cpuinfo(policy, cf750gxvFreqTable);
	if (result)
		goto err_freqfree;

	cpufreq_frequency_table_get_attr(cf750gxvFreqTable, policy->cpu);

	return result;

err_freqfree:
	kfree(cf750gxvFreqTable);

	return result;
}

static int cf750gxCpuExit(struct cpufreq_policy *policy)
{
	dprintk("cf750gxCpuExit\n");

	cpufreq_frequency_table_put_attr(policy->cpu);

	return 0;
}

static int cf750gxResume(struct cpufreq_policy *policy)
{
	return 0;
}

static struct freq_attr *cf750gxvAttr[] = {
	&cpufreq_freq_attr_scaling_available_freqs,
	NULL,
};

static struct cpufreq_driver cf750gxvDrv = {
	.verify = cf750gxVerify,
	.target = cf750gxTarget,
	.init = cf750gxCpuInit,
	.exit = cf750gxCpuExit,
	.resume = cf750gxResume,
	.name = "ppc750gx-cpufreq",
	.owner = THIS_MODULE,
	.attr = cf750gxvAttr,
};

static int __init cf750gxInit(void)
{
int ret;
unsigned int freq,i,j,rng;
unsigned short min_ratio,max_ratio;
struct cpufreq_frequency_table *tbp;
const struct pll_750fgx *pll_defaults;
#ifdef CONFIG_PPC_OF
struct device_node *tree_root;
const u32 *clk;
#endif /* CONFIG_PPC_OF */

	dprintk("cf750gxInit\n");

	if ( !cpu_has_feature(CPU_FTR_DUAL_PLL_750FX))
		return 0;

	/*
	 * See if bus speed override was specified
	 */
	if(override_bus_freq) cf750gxvBusSpeed=override_bus_freq;

#ifdef CONFIG_PPC_OF
	/*
	 * If bus speed not specified, try to get it via OF
	 */
	if(!cf750gxvBusSpeed)
	{
		/*
		 * Get root node (aka MacRISC bus)
		 */
		tree_root=of_find_node_by_name(NULL,"");

		if(tree_root)
		{
			clk=of_get_property(tree_root,"clock-frequency",NULL);

			if(clk && *clk)
				cf750gxvBusSpeed=(unsigned int)*clk/1000;

			of_node_put(tree_root);

			dprintk(__FILE__"-%d:  Bus speed from OF:  %d KHz\n",
				__LINE__,cf750gxvBusSpeed);
		}
	}
#endif /* CONFIG_PPC_OF */

	/*
	 * Get processor min and max core frequencies. If they have not been
	 * overriden, then get them from version defaults.
	 */
	if((cur_cpu_spec->pvr_value>>16)==0x7000)
		pll_defaults=&pll_750fx;
	else
		pll_defaults=&pll_750gx;

	cf750gxvMinCore=override_min_core?override_min_core:pll_defaults->
			min_core;
	cf750gxvMaxCore=override_max_core?override_max_core:pll_defaults->
			max_core;

	dprintk(__FILE__"-%d:  cf750gxvMinCore is %u, cf750gxvMaxCore is %u\n",
		__LINE__,cf750gxvMinCore,cf750gxvMaxCore);
	dprintk(__FILE__"-%d:  pll_defaults:  min_ratio %d, max_ratio %d\n",
		__LINE__,pll_defaults->min_ratio,pll_defaults->max_ratio);

	if(!cf750gxvMinCore)
	{
		dprintk("Can't determine minimum core frequency\n");
		ret=-EINVAL;
		goto ErrSimple;
	}

	if(!cf750gxvMaxCore)
	{
		dprintk("Can't determine maximum core frequency\n");
		ret=-EINVAL;
		goto ErrSimple;
	}

	if(!cf750gxvBusSpeed)
	{
		dprintk("Can't determine system bus speed\n");
		ret=-EINVAL;
		goto ErrSimple;
	}

	/*
	 * Build maximum freq table. This will depend on the bus freq, the core
	 * frequency limits, and the ratios.
	 */
	min_ratio=pll_defaults->min_ratio;
	freq=min_ratio*cf750gxvBusSpeed;

	if(freq<cf750gxvMinCore)
	{
		/*
		 * Core min is above min ratio and bus speed clock. Find min
		 * ratio such that min ratio * bus speed >= core min.
		 */
		min_ratio=cf750gxvMinCore/cf750gxvBusSpeed;
		j=cf750gxvMinCore%cf750gxvBusSpeed;

		if(j) min_ratio++;
	}
	else
	{
		/*
		 * Core min is below min ratio and speed clock. Reset core min.
		 */
		cf750gxvMinCore=freq;
	}

	max_ratio=pll_defaults->max_ratio;
	freq=max_ratio*cf750gxvBusSpeed;

	if(freq>cf750gxvMaxCore)
	{
		/*
		 * Core max is below max ratio and bus speed. Find max ratio
		 * such that max ratio * bus speed <= core max.
		 */
		max_ratio=cf750gxvMaxCore/cf750gxvBusSpeed;
	}
	else
	{
		/*
		 * Core max is above max ratio and bus speed clock. Reset core
		 * max.
		 */
		cf750gxvMaxCore=freq;
	}

	dprintk(__FILE__"-%d:  min_ratio is %d, max_ratio is %d\n",__LINE__,
		min_ratio,max_ratio);

	/*
	 * Bus ratios for the GX range from 2-20 for 19 INTEGER frequencies.
	 * The above checks may have changed this. There are max_ratio -
	 * min_ratio + 1 frequencies.
	 */
	j=max_ratio-min_ratio+1;
	cf750gxvFreqTable=kmalloc(sizeof(struct cpufreq_frequency_table)*(j+2),
		GFP_KERNEL);
	if(cf750gxvFreqTable==NULL)
	{
		ret = -ENOMEM;
		goto ErrSimple;
	}

	dprintk(__FILE__"-%d:  cf750gxvFreqTable=%p\n",__LINE__,
		cf750gxvFreqTable);

	/*
	 * Use index of first entry to keep track of the count (one extra
	 * entry)
	 */
	cf750gxvFreqTable[0].frequency=CPUFREQ_ENTRY_INVALID;
	cf750gxvFreqTable[0].index=j;

	/*
	 * Populate the table
	 */
//	for(tbp=cf750gxvFreqTable+1,i=min_ratio; i<=max_ratio; tbp++,i++)
	for(tbp=cf750gxvFreqTable,i=min_ratio; i<=max_ratio; tbp++,i++)
	{
		tbp->frequency=i*cf750gxvBusSpeed;

		if(tbp->frequency<600) rng=2;
		else if(tbp->frequency<900) rng=0;
		else rng=1;

		/*
		 * The computation in the first argument converts the bus
		 * ratio value to the PLL configuration value needed for the
		 * given ratio
		 */
		tbp->index=cf750gxiPackState(i>10?i+10:(i<<1),rng);
	}

	/*
	 * The other extra array member
	 */
	tbp->frequency=CPUFREQ_TABLE_END;

	ret=cpufreq_register_driver(&cf750gxvDrv);

	dprintk(__FILE__"-%d:  return from cpufreq_register_driver() is %d\n",
		__LINE__,ret);

	if(ret) goto ErrFreqTable;

ErrSimple:
	return ret;
ErrFreqTable:
	kfree(cf750gxvFreqTable);
	return ret;
}

static void __exit cf750gxExit(void)
{
	dprintk("cf750gxExit\n");

	cpufreq_unregister_driver(&cf750gxvDrv);

	if(cf750gxvFreqTable)
		kfree(cf750gxvFreqTable);

	cf750gxvFreqTable=NULL;

	return;
}

module_param(override_max_core, uint, 0644);
MODULE_PARM_DESC(override_max_core,
	"clock frequency in KHz.");

module_param(override_min_core, uint, 0644);
MODULE_PARM_DESC(override_min_core,
	"clock frequency in KHz.");

module_param(override_bus_freq, uint, 0644);
MODULE_PARM_DESC(override_bus_freq,
	"bus frequency in KHz used to compute clock frequency using multipliers.");

module_param(freq_steps, uint, 0644);
MODULE_PARM_DESC(freq_steps,
	"specify number of frequency steps to use between min and max.");

late_initcall(cf750gxInit);
module_exit(cf750gxExit);

MODULE_ALIAS("dual-pll");

--------------040203050902000703040702--
