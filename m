Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR006.bigfish.com (smtp-cpk.frontbridge.com
 [204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2E9E71007D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 21:27:30 +1100 (EST)
Received: from mail142-tx2 (localhost.localdomain [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id 9CB9B5502EC	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 10:27:14 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.249])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id 1C13E198055	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 10:27:14 +0000 (UTC)
Received: from localhost.localdomain ([10.193.20.166])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id pA7ARLkH025001	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 04:27:22 -0600 (CST)
Date: Mon, 7 Nov 2011 18:27:24 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20111107102724.GA16470@localhost.localdomain>
References: <1320410166-14500-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4403E.3040700@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EB4403E.3040700@freescale.com>
Sender: <zch@localhost.localdomain>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: zch@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2011 at 02:42:54PM -0500, Scott Wood wrote:
> On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
> > From: Li Yang <leoli@freescale.com>
> > 
> > Some 85xx silicons like MPC8536 and P1022 has the JOG PM feature.
> > 
> > The patch adds the support to change CPU frequency using the standard
> > cpufreq interface. Add the all PLL ratio core support. The ratio CORE
> > to CCB can 1:1, 1.5, 2:1, 2.5:1, 3:1, 3.5:1 and 4:1
> > 
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> >  arch/powerpc/platforms/85xx/Makefile  |    1 +
> >  arch/powerpc/platforms/85xx/cpufreq.c |  255 +++++++++++++++++++++++++++++++++
> >  arch/powerpc/platforms/Kconfig        |    8 +
> >  3 files changed, 264 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/85xx/cpufreq.c
> 
> Please name this something more specific, such as 85xx/cpufreq-jog.c
> 
> Other 85xx/qoriq chips, such as p4080, have different mechanisms for
> updating CPU frequency.
> 
> > +static struct cpufreq_frequency_table mpc85xx_freqs[] = {
> > +	{2,	0},
> > +	{3,	0},
> > +	{4,	0},
> > +	{5,	0},
> > +	{6,	0},
> > +	{7,	0},
> > +	{8,	0},
> > +	{0,	CPUFREQ_TABLE_END},
> > +};
> 
> Only p1022 can handle 1:1 (index 2).
> 
> > +static void set_pll(unsigned int pll, int cpu)
> > +{
> > +	int shift;
> > +	u32 busfreq, corefreq, val;
> > +	u32 core_spd, mask, tmp;
> > +
> > +	tmp = in_be32(guts + PMJCR);
> > +	shift = (cpu == 1) ? CORE1_RATIO_SHIFT : CORE0_RATIO_SHIFT;
> > +	busfreq = fsl_get_sys_freq();
> > +	val = (pll & CORE_RATIO_MASK) << shift;
> > +
> > +	corefreq = ((busfreq * pll) >> 1);
> 
> Use "/ 2", not ">> 1".  Same asm code, more readable.
> 
> > +	/* must set the bit[18/19] if the requested core freq > 533 MHz */
> > +	core_spd = (cpu == 1) ? PMJCR_CORE1_SPD_MASK : PMJCR_CORE0_SPD_MASK;
> > +	if (corefreq > FREQ_533MHz)
> > +		val |= core_spd;
> 
> this is the cutoff for p1022 -- on mpc8536 the manual says the cutoff is
> 800 MHz.
> 
> > +	mask = (cpu == 1) ? (PMJCR_CORE1_RATIO_MASK | PMJCR_CORE1_SPD_MASK) :
> > +		(PMJCR_CORE0_RATIO_MASK | PMJCR_CORE0_SPD_MASK);
> > +	tmp &= ~mask;
> > +	tmp |= val;
> > +	out_be32(guts + PMJCR, tmp);
> 
> clrsetbits_be32()
> 
> > +	val = in_be32(guts + PMJCR);
> > +	out_be32(guts + POWMGTCSR,
> > +			POWMGTCSR_LOSSLESS_MASK | POWMGTCSR_JOG_MASK);
> 
> setbits32()
> 
> > +	pr_debug("PMJCR request %08x at CPU %d\n", tmp, cpu);
> > +}
> > +
> > +static void verify_pll(int cpu)
> > +{
> > +	int shift;
> > +	u32 busfreq, pll, corefreq;
> > +
> > +	shift = (cpu == 1) ? CORE1_RATIO_SHIFT : CORE0_RATIO_SHIFT;
> > +	busfreq = fsl_get_sys_freq();
> > +	pll = (in_be32(guts + PORPLLSR) >> shift) & CORE_RATIO_MASK;
> > +
> > +	corefreq = (busfreq * pll) >> 1;
> > +	corefreq /= 1000000;
> > +	pr_debug("PORPLLSR core freq %dMHz at CPU %d\n", corefreq, cpu);
> > +}
> 
> It looks like the entire point of this function is to make a debug
> print...  #ifdef DEBUG the contents?  Or if we mark fsl_get_sys_freq()
> as __pure (or better, read this once at init, since it involves
> searching the device tree), will it all get optimized away?
> 
> 
> > +	/* initialize frequency table */
> > +	pr_info("core %d frequency table:\n", policy->cpu);
> > +	for (i = 0; mpc85xx_freqs[i].frequency != CPUFREQ_TABLE_END; i++) {
> > +		mpc85xx_freqs[i].frequency =
> > +				(busfreq * mpc85xx_freqs[i].index) >> 1;
> > +		pr_info("%d: %dkHz\n", i, mpc85xx_freqs[i].frequency);
> > +	}
> 
> This should be pr_debug.
> 
> > +	/* the latency of a transition, the unit is ns */
> > +	policy->cpuinfo.transition_latency = 2000;
> > +
> > +	cur_pll = get_pll(policy->cpu);
> > +	pr_debug("current pll is at %d\n", cur_pll);
> > +
> > +	for (i = 0; mpc85xx_freqs[i].frequency != CPUFREQ_TABLE_END; i++) {
> > +		if (mpc85xx_freqs[i].index == cur_pll)
> > +			policy->cur = mpc85xx_freqs[i].frequency;
> > +	}
> 
> You could combine these loops.
> 
> > +	/* this ensures that policy->cpuinfo_min
> > +	 * and policy->cpuinfo_max are set correctly */
> 
> comment style
> 
> > +static int mpc85xx_cpufreq_target(struct cpufreq_policy *policy,
> > +			      unsigned int target_freq,
> > +			      unsigned int relation)
> > +{
> > +	struct cpufreq_freqs freqs;
> > +	unsigned int new;
> > +
> > +	cpufreq_frequency_table_target(policy,
> > +				       mpc85xx_freqs,
> > +				       target_freq,
> > +				       relation,
> > +				       &new);
> > +
> > +	freqs.old = policy->cur;
> > +	freqs.new = mpc85xx_freqs[new].frequency;
> > +	freqs.cpu = policy->cpu;
> > +
> > +	mutex_lock(&mpc85xx_switch_mutex);
> > +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +
> > +	pr_info("Setting frequency for core %d to %d kHz, " \
> > +		 "PLL ratio is %d/2\n",
> > +		 policy->cpu,
> > +		 mpc85xx_freqs[new].frequency,
> > +		 mpc85xx_freqs[new].index);
> > +
> > +	set_pll(mpc85xx_freqs[new].index, policy->cpu);
> > +
> > +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +	mutex_unlock(&mpc85xx_switch_mutex);
> > +
> > +	ppc_proc_freq = freqs.new * 1000ul;
> 
> ppc_proc_freq is global -- can CPUs not have their frequencies adjusted
> separately?
> 
> It should be under the lock, if the lock is needed at all.
> 

There is only one ppc_proc_freq. no lock.

> > +/*
> > + * module init and destoy
> > + */
> > +static struct of_device_id mpc85xx_jog_ids[] __initdata = {
> > +	{ .compatible = "fsl,mpc8536-guts", },
> > +	{ .compatible = "fsl,p1022-guts", },
> > +	{}
> > +};
> > +
> > +static int __init mpc85xx_cpufreq_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	pr_info("Freescale MPC85xx CPU frequency switching driver\n");
> 
> If you're going to print something here, print it after you find a node
> you can work with -- not on all 85xx/qoriq that have this driver enabled.
> 
> -Scott

Thanks. I will fix them all.

-chenhui
