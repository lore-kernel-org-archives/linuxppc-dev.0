Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 6EC81DDE17
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 07:41:02 +1000 (EST)
Received: from [192.168.1.37] (node119.75.251.72.1dial.com [72.251.75.119])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7FLeNp2085539
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 14:40:44 -0700 (PDT)
Message-ID: <48A5F6EA.9040906@hypersurf.com>
Date: Fri, 15 Aug 2008 14:36:42 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 12.5 MHz woo hoo!
Content-Type: multipart/mixed; boundary="------------020802040709070502090403"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020802040709070502090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[root@PowerMac8600B root]# cat /proc/cpuinfo
processor       : 0
cpu             : 750GX
temperature     : 1-76 C (uncalibrated)
clock           : 200.000000MHz
revision        : 2.3 (pvr 0008 0203)
bogomips        : 24.96
timebase        : 12500000	<-- 12.5 MHz exactly!!!
platform        : PowerMac
model           : Power Macintosh
machine         : Power Macintosh
motherboard     : AAPL,8500 MacRISC
detected as     : 16 (PowerMac 8500/8600)
pmac flags      : 00000000
pmac-generation : OldWorld

Hey, anybody know if that temperature, thermal thingy works well enough 
to bother fooling with the code to produce a more valid value?

also:

[root@PowerMac8600B root]# alias tis
alias tis='cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state'
[root@PowerMac8600B root]# tis
250000 178419
300000 0
350000 0
400000 0
450000 0
500000 0
550000 0
600000 0
650000 0
700000 0
750000 0
800000 0
850000 0
900000 0
950000 0
1000000 0

[root@PowerMac8600B root]# uname -vr
2.6.26-pll #4 Thu Aug 14 04:02:58 PDT 2008

Finally, can someone tell me if the attached file shows up ok if it were 
a patch I wanted to submit? I can't seem to figure out how to 'import 
inline' using this ancient mailer.

kevin

--------------020802040709070502090403
Content-Type: text/plain;
 name="pll_if.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pll_if.c"

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
#define DEBUG

#include "linux/init.h"
#include "linux/module.h"
#include <linux/autoconf.h>
#include "linux/kernel.h"
#include <linux/errno.h>
#include <linux/cpu.h>
#include "linux/of.h"
#include "linux/notifier.h"
#include "linux/delay.h"

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS
#include "linux/sysdev.h"
#endif
#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER
#include "linux/hrtimer.h"
#endif

#include <asm/uaccess.h>
#include <asm/bitops.h>
#include "asm/time.h"
#include <asm/mmu.h>
#include <asm/processor.h>
#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/cputable.h>
#include <asm/system.h>
#include <asm/pll_if.h>
#include <asm/pll.h>
#include <asm/smp.h>

MODULE_LICENSE("GPL");

static unsigned int boot_ratio;
static unsigned int pllifvBusClock;

static unsigned int override_bus_clock = 0;

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER
static enum hrtimer_restart pllTimerF(struct hrtimer *hrt);
static struct hrtimer pll_timer;
static unsigned long hrtimers_got_no_freakin_callback_data;
#ifdef DEBUG
cycles_t pll_time_stamp;
#endif
#else
static void pllTimerF(unsigned long newPLL);
static struct timer_list pll_timer;
cycles_t pll_time_stamp;
#endif

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS
extern unsigned long loops_per_jiffy;

unsigned long boot_loops;
static struct sys_device *sysdev_cpu;

static ssize_t show_ppc750gxpll(struct sys_device *dev, char *buf)
{
	return sprintf(buf, "%x\n", get_PLL());
}

int modifyPLL(unsigned int pll, int scaleLPJ);

//static ssize_t __attribute_used__ store_ppc750gxpll(struct sys_device *dev,
//	const char *buf, size_t count)
static ssize_t __used store_ppc750gxpll(struct sys_device *dev,
	const char *buf, size_t count)
{
unsigned int pll;
char *ptr;

	pr_debug(__FILE__">%s()-%d:  buf=%s\n", __func__, __LINE__, buf);

	pll = simple_strtoul(buf, &ptr, 16);

	pr_debug(__FILE__">%s()-%d:  %x (%d)\n", __func__, __LINE__, pll, pll);

/*	modifyPLL(pll,!0); */
	modifyPLL(pll, 0);

	return ptr-buf;
}

static SYSDEV_ATTR(ppc750gxpll, 0600, show_ppc750gxpll, store_ppc750gxpll);
#endif

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_CPU_FREQ
struct plliftCallData {
	void *data;
	int scalar;
};

static struct plliftCallData pllifvSwitchCallData;
static struct plliftCallData pllifvLockCallData;
static RAW_NOTIFIER_HEAD(pllifvPllSwitchChain);
static RAW_NOTIFIER_HEAD(pllifvPllLockChain);
#endif

/*
 * This initializes the code for the PLL control:
 * boot_ratio is used to scale the loops_per_jiffy value from its boot value
 * boot_loops is the boot value of loops_per_jiffy and is used to compute new
 * values
 */
static int __init init_PLL(void)
{
unsigned int temp;
#ifdef CONFIG_PPC_OF
const u32 *clk;
struct device_node *tree_root;
#endif

	if (!cpu_has_feature(CPU_FTR_DUAL_PLL_750FX))
		return -ENODEV;

	boot_ratio = 0;

	/*
	 * See if bus clock override was specified
	 */
	if (override_bus_clock)
		pllifvBusClock = override_bus_clock*1000;

#ifdef CONFIG_PPC_OF
	/*
	 * If bus clock is not specified, try to get it via OF
	 */
	if (!pllifvBusClock) {
		/*
		 * Get root node (aka MacRISC bus)
		 */
		tree_root = of_find_node_by_name(NULL, "");


		if (tree_root) {
			clk = of_get_property(tree_root, "clock-frequency",
				NULL);

			if (clk && *clk)
				pllifvBusClock = (unsigned int) *clk;

			of_node_put(tree_root);

			pr_debug(__FILE__">%s()-%d:  Bus clock from OF is %u\n",
				__func__, __LINE__, pllifvBusClock);
		}
	}
#endif /* CONFIG_PPC_OF */
#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS
	temp = get_PLL();
	temp = get_PLL_ratio(get_active_PLL(temp), temp);

	/*
	 * Units for boot ratio is halves, i.e. 20 is a ratio of 10.
	 * From 21 on the returned value needs to be converted to halves.
	 */
	if (temp > 20)
		temp = (temp-10)<<1;

	boot_ratio = temp;
	boot_loops = loops_per_jiffy;

	/*
	 * Try to get the cpu sysdev
	 */
	sysdev_cpu = get_cpu_sysdev(boot_cpuid);

	if (sysdev_cpu != NULL)
		sysdev_create_file(sysdev_cpu, &attr_ppc750gxpll);
#endif

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER
	hrtimer_init(&pll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
#else
	init_timer(&pll_timer);
#endif

	pll_timer.function = pllTimerF;

	return 0;
}

/*__initcall(init_PLL); */

static void exit_PLL(void)
{
#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS
	if (sysdev_cpu != NULL)
		sysdev_remove_file(sysdev_cpu, &attr_ppc750gxpll);
#endif

	/*
	 * Make sure there are no timers pending by making sure we are not
	 * doing anything
	 */
	while (test_bit(PLL_LOCK_BIT, (unsigned long *)&boot_ratio))
		msleep(1);
}

module_init(init_PLL);
module_exit(exit_PLL);

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS
static unsigned long pllNewLPJ(unsigned int oldRatio, unsigned int newRatio,
	unsigned long LPJ)
{
	if (LPJ > 200000000)
		return LPJ/oldRatio*newRatio;
	else
		return LPJ*newRatio/oldRatio;
}

static inline void pllUpdateLPJ(unsigned int oldRatio, unsigned int newRatio,
	unsigned long LPJ)
{
	loops_per_jiffy = pllNewLPJ(oldRatio, newRatio, LPJ);
}
#else
#define pllUpdateLPJ(a, b, c)
#endif

static void pllifiSwitchPLLs(unsigned int newPLL)
{
#if 0
unsigned long flags;
#endif
unsigned int new_ratio, new_ratio_cp, old_ratio, current_pll, masked_boot_ratio;

pr_debug(__FILE__">%s()-%d:  newPLL=0x%08x\n", __func__, __LINE__, newPLL);

	/*
	 * Compute new loops_per_jiffy
	 */
	current_pll = get_PLL();
	new_ratio = get_PLL_ratio(get_next_PLL(newPLL), current_pll);
	old_ratio = get_PLL_ratio(get_active_PLL(current_pll), current_pll);
	masked_boot_ratio = boot_ratio&0xff;
	new_ratio_cp = new_ratio;

	pr_debug(__FILE__">%s()-%d:  current_pll=0x%08x, new=%d, old=%d\n",
		__func__, __LINE__, current_pll, new_ratio, old_ratio);

	current_pll = (current_pll&~PLL_SEL_MASK)|(newPLL&PLL_SEL_MASK);

	pr_debug(__FILE__">%s()-%d:  current_pll=0x%08x, new=%d, old=%d\n",
		__func__, __LINE__, current_pll, new_ratio, old_ratio);

	/*
	 * Convert to halves
	 */
	if (new_ratio > 20)
		new_ratio = (new_ratio-10)<<1;
	if (old_ratio > 20)
		old_ratio = (old_ratio-10)<<1;

	/*
	 * Make sure that we never shorten the sleep values
	 */
	if (new_ratio > old_ratio) {
		if (newPLL&PLL_DO_LPJ)
			pllUpdateLPJ(masked_boot_ratio, new_ratio, boot_loops);

		pr_debug(__FILE__">%s()-%d:  masked_boot_ratio=%d, new_ratio="
		"%d, boot_loops=%ld, loops_per_jiffy=%ld\n", __func__, __LINE__,
		masked_boot_ratio, new_ratio, boot_loops, loops_per_jiffy);

		set_PLL(current_pll);
	} else {
		pr_debug(__FILE__">%s()-%d:  masked_boot_ratio=%d, new_"
			"ratio=%d, boot_loops=%ld, loops_per_jiffy=%ld\n",
			__func__, __LINE__, masked_boot_ratio, new_ratio,
			boot_loops, loops_per_jiffy);

		set_PLL(current_pll);

		if (newPLL&PLL_DO_LPJ)
			pllUpdateLPJ(masked_boot_ratio, new_ratio, boot_loops);

		pr_debug(__FILE__">%s()-%d:  masked_boot_ratio=%d, new_"
			"ratio=%d, boot_loops=%ld, loops_per_jiffy=%ld\n",
			__func__, __LINE__, masked_boot_ratio, new_ratio,
			boot_loops, loops_per_jiffy);
	}

	raw_notifier_call_chain(&pllifvPllSwitchChain, pllifmPllSwitch,
		pllifvSwitchCallData.data);

	/*
	 * This is used to print the clock frequency in /proc/cpuinfo
	 */
	ppc_proc_freq = pllifCfgToFreq(new_ratio_cp);
	pr_debug(__FILE__">%s()-%d:  pllifCfgToFreq(%u)=%lu\n", __func__,
		__LINE__, new_ratio_cp, ppc_proc_freq);

#if 0
	save_flags(flags);
	cli();

	loops_per_jiffy = pllNewLPJ(masked_boot_ratio, new_ratio, boot_loops);

	set_PLL(current_pll);

	restore_flags(flags);
#endif
}

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER
static enum hrtimer_restart pllTimerF(struct hrtimer *hrt)
{
#ifdef DEBUG
cycles_t now;
cycles_t usec, tmp, cntlz, cnttz;

	now = get_cycles();

	now = now-pll_time_stamp;

	/*
	 * Aw cmon, I'm just havin' a little fun with PPC assembly.
	 * Just wish I could find a way to use an rlwinm ...
	 */
	cnttz = tb_ticks_per_sec; /* needed to get the assembly to ...
				 * look right ... ??? */
	tmp = now*15625;

	__asm__ __volatile__ (
		"addi %0,%3,-1\n"
		"andc %1,%3,%0\n"
		"cntlzw %1,%1\n"
		"subfic %1,%1,31\n"
		"cntlzw %0,%2\n":
		"=r"(cntlz), "=r"(cnttz):
		"r"(tmp), "b"(cnttz)
	);

	/*
	 * 1,000,000 usec per sec and 1,000,000 is 15625<<6
	 */
	usec = ((tmp<<cntlz)/(tb_ticks_per_sec>>cnttz))<<6;
	usec = (usec+(1UL<<(cntlz+cnttz-1)))>>(cntlz+cnttz);

	pr_debug(__FILE__">%s()-%d:  Time delta is %lu cycles, "
		"%lu uS (cntlz=%lu, cnttz=%lu)\n", __func__, __LINE__, now,
		usec, cntlz, cnttz);
#endif
	raw_notifier_call_chain(&pllifvPllLockChain, pllifmPllLock,
		pllifvLockCallData.data);

	/*
	 * Clear all lock bits
	 */
	boot_ratio &= ~(PLL_TIMER|PLL0_LOCK|PLL1_LOCK);

	if ((unsigned int) hrtimers_got_no_freakin_callback_data)
		pllifiSwitchPLLs((unsigned int)
			hrtimers_got_no_freakin_callback_data);

	return HRTIMER_NORESTART;
}
#else
static void pllTimerF(unsigned long newPLL)
{
cycles_t now;

	now = get_cycles();
	now = now-pll_time_stamp;

#ifdef DEBUG
	{
	cycles_t usec, tmp, cntlz, cnttz;

		/*
		 * Aw cmon, I'm just havin' a little fun with PPC assembly.
		 * Just wish I could find a way to use an rlwinm ...
		 */
		cnttz = tb_ticks_per_sec; /* needed to get the assembly to ...
					 * look right ... ??? */
#define MULFIRST
#ifdef MULFIRST
		tmp = now*15625;
#else
		tmp = now;
#endif

		__asm__ __volatile__ (
			"addi %0,%3,-1\n"
			"andc %1,%3,%0\n"
			"cntlzw %1,%1\n"
			"subfic %1,%1,31\n"
			"cntlzw %0,%2\n":
			"=r"(cntlz), "=r"(cnttz):
			"r"(tmp), "b"(cnttz)
		);

		/*
		 * 1,000,000 usec per sec and 1,000,000 is 15625<<6
		 */
//		usec = (((now<<cntlz)/(tb_ticks_per_sec>>cnttz)*15625)+(1UL<<
//			(cntlz+cnttz-1-6)))>>(cntlz+cnttz-6);
#ifdef MULFIRST
		usec = ((tmp<<cntlz)/(tb_ticks_per_sec>>cnttz))<<6;
		usec = (usec+(1UL<<(cntlz+cnttz-1)))>>(cntlz+cnttz);
#else
		usec = ((tmp<<cntlz)/(tb_ticks_per_sec>>cnttz)*15625)<<6;
		usec = (usec+(1UL<<(cntlz+cnttz-1)))>>(cntlz+cnttz);
#endif

		pr_debug(__FILE__">%s()-%d:  Time delta is %lu cycles, "
			"%lu uS (cntlz=%lu, cnttz=%lu)\n", __func__, __LINE__,
			now, usec, cntlz, cnttz);
	}
#endif
	/*
	 * Make sure it has been at least 100 usec. 100 usec is 100 *
	 * tb_ticks_per_sec / 1,000,000 cycles, so:
	 *	if(now<100*tb_ticks_per_sec/1000000
	 * 1,000,000 is 15625<<6, so:
	 *	if((now<<6)<100*tb_ticks_per_sec/15625)
	 * 100 is 25<<2, so:
	 *	if((now<<4)<25*tb_ticks_per_sec/15625)
	 * 15625 is 3125*5, so:
	 *	if((now<<4)*5<25*tb_ticks_per_sec/3125)
	 * obviously 25/3125 -> 1/125:
	 *	if((now<<4)*5<tb_ticks_per_sec/125)
	 */
	if ((now<<4)*5 < tb_ticks_per_sec/125)
		udelay(100-now*1000000/tb_ticks_per_sec);

	raw_notifier_call_chain(&pllifvPllLockChain, pllifmPllLock,
		pllifvLockCallData.data);

	/*
	 * Clear all lock bits
	 */
	boot_ratio &= ~(PLL_TIMER|PLL0_LOCK|PLL1_LOCK);

	if ((unsigned int)newPLL)
		pllifiSwitchPLLs((unsigned int)newPLL);
}
#endif

/*
 * Handle accesses to the pll register. Examples for write:
 *	  value		CFGx/RNGx/res	   effect
 *	0x08010000			switch to PLL1
 *	0x08000000			switch to PLL0
 *	0xc000fa00	1111 1/01/0	PLL0 off (CFG/RNG 31/1)
 *	0xc000f200	1111 0/01/0	PLL0 to 20x (CFG/RNG 30/1)
 *	0x30000004	0000 0/10/0	PLL1 off (CFG/RNG 0/2)
 *	0x30000054	0101 0/10/0	PLL1 to 5x (CFG/RNG a/2)
 */
/**
 * modifyPLL: - Takes steps to modify PLL as requested
 * @pll: Specifies the new value and desired operation to be performed
 * @scaleLPJ: flag to indicate whether to scale the loops_per_jiffy value
 *
 * Based on the value passed in the pll argument, this takes the steps necessary
 * to change the PLL as requested. The upper 7 or 8 bits of the PLL are read
 * only. These bit positions in the pll argument are used to specify flags that
 * indicate the validity of the other fields in the pll argument. See the
 * pll_if.h header for detail and actual values.
 */
int modifyPLL(unsigned int pll, int scaleLPJ)
{
unsigned int current_pll, work_mask, pll_x;
int rval = 0;

	pr_debug(__FILE__">%s()-%d:\n", __func__, __LINE__);
	pr_debug(__FILE__">%s()-%d:  pll=0x%08x\n", __func__, __LINE__, pll);

	/*
	 * This is not reentrant
	 */
	if (test_and_set_bit(PLL_LOCK_BIT, (unsigned long *)&boot_ratio)) {
		pr_debug(__FILE__">%s()-%d:  Busy!\n", __func__, __LINE__);
		return -EAGAIN;
	}

	/*
	 * Don't allow any changes if a timer is pending
	 */
	if (test_bit(PLL_TIMER_BIT, (unsigned long *)&boot_ratio))
		goto checkPLLBusy;

	current_pll = get_PLL();
	work_mask = pll>>24;

	/*
	 * Check to see if the currently selected PLL is being modified
	 */
	pll_x = get_active_PLL(current_pll);

	if ((pll_x == 0 && work_mask&(PLL0_DO_CFG|PLL0_DO_RNG|PLL0_DO_CONTROL))
		|| (pll_x == 1 && work_mask&(PLL1_DO_CFG|PLL1_DO_RNG)))
		goto checkPLLInVal;

	/*
	 * Can't change to a PLL that is off. Also can't immediately change to
	 * one that is not locked. Catch that supposedly impossible condition.
	 */
	if (work_mask&PLL_DO_SEL) {
	int next_ratio;
	unsigned int which_config;

		pll_x = get_next_PLL(pll);

		/*
		 * Figure out where the next ratio comes from. It will be from
		 * pll if we are changing the next pll and current_pll if not.
		 */
		which_config = pll_x?((work_mask&PLL1_DO_CFG)?pll:current_pll):
			((work_mask&PLL0_DO_CFG)?pll:current_pll);
		next_ratio = get_PLL_ratio(pll_x, which_config);
		if (next_ratio < 4 || next_ratio > 30)
			goto checkPLLInVal;

		pll_x = ((pll_x == 0 && boot_ratio&PLL0_LOCK) || (pll_x == 1 &&
			boot_ratio&PLL1_LOCK))?1:0;

	}
	/*
	 * To avoid complications, don't allow both plls to be half ratios
	 */
	if (work_mask&PLL0_DO_CFG) {
	int old_ratio1, new_ratio0;

		old_ratio1 = get_PLL_ratio(1, current_pll);
		new_ratio0 = get_PLL_ratio(0, pll);

		if (old_ratio1 > 4 && old_ratio1 < 20 && new_ratio0 > 4 &&
			new_ratio0 < 20 && (old_ratio1&0x1) & (new_ratio0&0x1))
			goto checkPLLInVal;
	} else if (work_mask&PLL1_DO_CFG) {
	int old_ratio0, new_ratio1;

		old_ratio0 = get_PLL_ratio(0, current_pll);
		new_ratio1 = get_PLL_ratio(1, pll);

		if (old_ratio0 > 4 && old_ratio0 < 20 && new_ratio1 > 4 &&
			new_ratio1 < 20 && (old_ratio0&0x1) & (new_ratio1&0x1))
			goto checkPLLInVal;
	}

	/*
	 * Determine if we will need to schedule a timer for a PLL relock. If
	 * any PLL config is being changed then a timer will be needed. Also
	 * need one if changing to a PLL that is not locked, though that should
	 * not happen.
	 */
	if ((work_mask&(PLL0_DO_CFG|PLL0_DO_RNG|PLL1_DO_CFG|PLL1_DO_RNG|
		PLL0_DO_CONTROL)) || (work_mask&PLL_DO_SEL && pll_x)) {
	unsigned int pll_mask, temp;

		pll_mask = 0;

		if (work_mask&PLL0_DO_CFG) {
			pll_mask |= PLL0_CFG_MASK;

			/*
			 * Flag that PLL0 needs to relock
			 */
			boot_ratio |= PLL0_LOCK;
		}

		if (work_mask&PLL0_DO_RNG)
			pll_mask |= PLL0_RNG_MASK;

		if (work_mask&PLL1_DO_CFG) {
			pll_mask |= PLL1_CFG_MASK;

			/*
			 * Flag that PLL1 needs to relock
			 */
			boot_ratio |= PLL1_LOCK;
		}

		if (work_mask&PLL1_DO_RNG)
			pll_mask |= PLL1_RNG_MASK;

		temp = (current_pll&~pll_mask)|(pll&pll_mask);

		if (pll_mask)
			set_PLL(temp);

		/*
		 * Flag that a timer is pending
		 */
		boot_ratio |= PLL_TIMER;

		/*
		 * Schedule a timer to clear the PLL lock bits (and signal that
		 * it is ok to select the PLL)
		 */
#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER
		/*
		 * Oh please, someone tell me I'm just to stupid to know how
		 * to pass this to the timer function!
		 */
		hrtimers_got_no_freakin_callback_data = (work_mask&PLL_DO_SEL)?
			(PLL_DO_SEL<<24)|(scaleLPJ?PLL_DO_LPJ:0)|pll&
			PLL_SEL_MASK:0;

		pll_timer.expires = ktime_set(0, 100000);

		hrtimer_start(&pll_timer, pll_timer.expires, HRTIMER_MODE_REL);
#ifdef DEBUG
		pll_time_stamp = get_cycles();
#endif
#else
		/*
		 * We might want to pass three pieces of data to the timer
		 *   i)	that we want to switch PLLs (PLL_DO_SEL)
		 *  ii)	which PLL to switch to (PLL_SEL_MASK)
		 * iii) flag to control whether loops_per_jiffy is updated
		 *      (PLL_DO_LPJ)
		 */
		pll_timer.data = (work_mask&PLL_DO_SEL)?(PLL_DO_SEL<<24)|(
			scaleLPJ?PLL_DO_LPJ:0)|(pll&PLL_SEL_MASK):0;

		/*
		 * Relock takes 100 us. See how many jiffies will take care of
		 * it.
		 */
		pll_timer.expires = (100*HZ/1000000);
		if (pll_timer.expires == 0)
			pll_timer.expires = 1;

		pll_timer.expires = jiffies+pll_timer.expires;
		add_timer(&pll_timer);

		pll_time_stamp = get_cycles();
#endif
	} else if (work_mask&PLL_DO_SEL)
		pllifiSwitchPLLs(pll|(scaleLPJ?PLL_DO_LPJ:0));

checkPLLOut:
	clear_bit(PLL_LOCK_BIT, (unsigned long *)&boot_ratio);

	return rval;
checkPLLBusy:
	rval = -EBUSY;
	goto checkPLLOut;
checkPLLInVal:
	rval = -EINVAL;
	goto checkPLLOut;
}
EXPORT_SYMBOL(modifyPLL);

/**
 * pllifCFgToFreq: - Takes a ratio and returns the frequency
 * @cfg: The PLL ratio field value
 *
 * This takes a PLL ratio field value and uses it along with the bus frequency
 * to compute the processor frequency.
 */
unsigned int pllifCfgToFreq(unsigned int cfg)
{
	return (cfg < 21?cfg>>1:cfg-10)*pllifvBusClock;
}
EXPORT_SYMBOL(pllifCfgToFreq);

#ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_CPU_FREQ
/**
 * pllifGetBusClock: - Returns the bus frequency
 *
 * This returns the determined bus frequency in Hz.
 */
unsigned int pllifGetBusClock()
{
	return pllifvBusClock;
}
EXPORT_SYMBOL(pllifGetBusClock);

/**
 * pllifRegisterPllSwitchCB: - Registers a pll switch call back
 * @nb: structure describing the call back to register
 *
 * This registers a call back function that will be called when the clock is
 * switched from one PLL to the other.
 */
int pllifRegisterPllSwitchCB(struct notifier_block *nb)
{
int ret;

	pllifvSwitchCallData.data = (void *)nb->next;
	nb->next = NULL;

	pllifvSwitchCallData.scalar = nb->priority;
	nb->priority = 0;

	ret = raw_notifier_chain_register(&pllifvPllSwitchChain, nb);

	return ret;
}
EXPORT_SYMBOL(pllifRegisterPllSwitchCB);

/**
 * pllifUnregisterPllSwitchCB: - Cancels a previously registered call back
 * @nb: structure describing the call back to cancel
 *
 * This cancels a previously registered switch call back
 */
void pllifUnregisterPllSwitchCB(struct notifier_block *nb)
{

	raw_notifier_chain_unregister(&pllifvPllSwitchChain, nb);
}
EXPORT_SYMBOL(pllifUnregisterPllSwitchCB);

/**
 * pllifRegisterPllLockCB: - Registers a pll lock call back
 * @nb: structure describing the call back to register
 *
 * This registers a call back function that will be called when a PLL has
 * locked to a new frequency.
 */
int pllifRegisterPllLockCB(struct notifier_block *nb)
{
int ret;

	pllifvLockCallData.data = (void *)nb->next;
	nb->next = NULL;

	pllifvLockCallData.scalar = nb->priority;
	nb->priority = 0;

	ret = raw_notifier_chain_register(&pllifvPllLockChain, nb);

	return ret;
}
EXPORT_SYMBOL(pllifRegisterPllLockCB);

/**
 * pllifUnregisterPllLockCB: - Cancels a previously registered call back
 * @nb: structure describing the call back to cancel
 *
 * This cancels a previously registered PLL lock call back
 */
void pllifUnregisterPllLockCB(struct notifier_block *nb)
{

	raw_notifier_chain_unregister(&pllifvPllLockChain, nb);
}
EXPORT_SYMBOL(pllifUnregisterPllLockCB);
#endif

module_param(override_bus_clock, uint, 0644);
MODULE_PARM_DESC(override_bus_clock,
	"Bus clock frequency in KHz used to compute core clock frequency from"
	" bus ratios.");

--------------020802040709070502090403--
