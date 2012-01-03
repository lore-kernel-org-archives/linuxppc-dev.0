Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E54CCB6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 09:14:54 +1100 (EST)
Received: from mail143-va3 (localhost [127.0.0.1])	by
 mail143-va3-R.bigfish.com (Postfix) with ESMTP id 85DD4600201	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 22:14:47 +0000 (UTC)
Received: from VA3EHSMHS033.bigfish.com (unknown [10.7.14.251])	by
 mail143-va3.bigfish.com (Postfix) with ESMTP id E84B1202B0	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 22:14:20 +0000 (UTC)
Message-ID: <4F037DB8.4080207@freescale.com>
Date: Tue, 3 Jan 2012 16:14:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v3] powerpc/85xx: add support to JOG feature using cpufreq
 interface
References: <1324985129-26219-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1324985129-26219-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/27/2011 05:25 AM, Zhao Chenhui wrote:
>  * The driver doesn't support MPC8536 Rev 1.0 due to a JOG erratum.
>    Subsequent revisions of MPC8536 have corrected the erratum.

Where do you check for this?

> +#define POWMGTCSR_LOSSLESS_MASK	0x00400000
> +#define POWMGTCSR_JOG_MASK	0x00200000

Are these really masks, or just values to use?

> +#define POWMGTCSR_CORE0_IRQ_MSK	0x80000000
> +#define POWMGTCSR_CORE0_CI_MSK	0x40000000
> +#define POWMGTCSR_CORE0_DOZING	0x00000008
> +#define POWMGTCSR_CORE0_NAPPING	0x00000004
> +
> +#define POWMGTCSR_CORE_INT_MSK	0x00000800
> +#define POWMGTCSR_CORE_CINT_MSK	0x00000400
> +#define POWMGTCSR_CORE_UDE_MSK	0x00000200
> +#define POWMGTCSR_CORE_MCP_MSK	0x00000100
> +#define P1022_POWMGTCSR_MSK	(POWMGTCSR_CORE_INT_MSK | \
> +				 POWMGTCSR_CORE_CINT_MSK | \
> +				 POWMGTCSR_CORE_UDE_MSK | \
> +				 POWMGTCSR_CORE_MCP_MSK)
> +
> +static void keep_waking_up(void *dummy)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	mb();
> +
> +	in_jog_process = 1;
> +	mb();
> +
> +	while (in_jog_process != 0)
> +		mb();
> +
> +	local_irq_restore(flags);
> +}

Please document this.  Compare in_jog_process == 1, not != 0 -- it's
unlikely, but what if the other cpu sees that in_jog_process has been
set to 1, exits and sets in_jog_process to 0, then re-enters set_pll and
sets in_jog_process to -1 again before this function does another load
of in_jog_process?

Do you really need all these mb()s?  I think this would suffice:

	local_irq_save(flags);

	in_jog_process = 1;

	while (in_jog_process == 1)
		barrier();

	local_irq_restore();

It's not really a performance issue, just simplicity.

> +static int p1022_set_pll(unsigned int cpu, unsigned int pll)
> +{
> +	int index, hw_cpu = get_hard_smp_processor_id(cpu);
> +	int shift;
> +	u32 corefreq, val, mask = 0;
> +	unsigned int cur_pll = get_pll(hw_cpu);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (pll == cur_pll)
> +		return 0;
> +
> +	shift = hw_cpu * CORE_RATIO_BITS + CORE0_RATIO_SHIFT;
> +	val = (pll & CORE_RATIO_MASK) << shift;
> +
> +	corefreq = sysfreq * pll / 2;
> +	/*
> +	 * Set the COREx_SPD bit if the requested core frequency
> +	 * is larger than the threshold frequency.
> +	 */
> +	if (corefreq > FREQ_533MHz)
> +		val |= PMJCR_CORE0_SPD_MASK << hw_cpu;

P1022 manual says the threshold is 500 MHz (but doesn't say how to set
the bit if the frequency is exactly 500 MHz).  Where did 533340000 come
from?

> +
> +	mask = (CORE_RATIO_MASK << shift) | (PMJCR_CORE0_SPD_MASK << hw_cpu);
> +	clrsetbits_be32(guts + PMJCR, mask, val);
> +
> +	/* readback to sync write */
> +	val = in_be32(guts + PMJCR);

You don't use val after this -- just ignore the return value from in_be32().

> +	/*
> +	 * A Jog request can not be asserted when any core is in a low
> +	 * power state on P1022. Before executing a jog request, any
> +	 * core which is in a low power state must be waked by a
> +	 * interrupt, and keep waking up until the sequence is
> +	 * finished.
> +	 */
> +	for_each_present_cpu(index) {
> +		if (!cpu_online(index))
> +			return -EFAULT;
> +	}

EFAULT is not the appropriate error code -- it is for when userspace
passes a bad virtual address.

Better, don't fail here -- bring the other core out of the low power
state in order to do the jog.  cpufreq shouldn't stop working just
because we took a core offline.

What prevents a core from going offline just after you check here?

> +	in_jog_process = -1;
> +	mb();
> +	smp_call_function(keep_waking_up, NULL, 0);

What does "keep waking up" mean?  Something like spin_while_jogging
might be clearer.

> +	local_irq_save(flags);
> +	mb();
> +	/* Wait for the other core to wake. */
> +	while (in_jog_process != 1)
> +		mb();

Timeout?  And more unnecessary mb()s.

Might be nice to support more than two cores, even if this code isn't
currently expected to be used on such hardware (it's just a generic
"hold other cpus" loop; might as well make it reusable).  You could do
this by using an atomic count for other cores to check in and out of the
spin loop.

> +	out_be32(guts + POWMGTCSR, POWMGTCSR_JOG_MASK | P1022_POWMGTCSR_MSK);
> +
> +	if (!spin_event_timeout(((in_be32(guts + POWMGTCSR) &
> +	    POWMGTCSR_JOG_MASK) == 0), 10000, 10)) {
> +		pr_err("%s: Fail to switch the core frequency.\n", __func__);
> +		ret = -EFAULT;
> +	}
> +
> +	clrbits32(guts + POWMGTCSR, P1022_POWMGTCSR_MSK);
> +	in_jog_process = 0;
> +	mb();

This mb() (or better, a readback of POWMGTCSR) should be before you
clear in_jog_process.  For clarity of its purpose, the clearing of
POWMGTCSR should go in the failure branch of spin_event_timeout().

> +	/* the latency of a transition, the unit is ns */
> +	policy->cpuinfo.transition_latency = 2000;

Is this based on observation?

> diff --git a/arch/powerpc/platforms/85xx/sleep.S b/arch/powerpc/platforms/85xx/sleep.S
> index 763d2f2..919781d 100644
> --- a/arch/powerpc/platforms/85xx/sleep.S
> +++ b/arch/powerpc/platforms/85xx/sleep.S
> @@ -59,6 +59,7 @@ powmgtreq:
>  	 * r5 = JOG or deep sleep request
>  	 *      JOG-0x00200000, deep sleep-0x00100000
>  	 */
> +_GLOBAL(mpc85xx_enter_jog)
>  _GLOBAL(mpc85xx_enter_deep_sleep)
>  	lis	r6, ccsrbase_low@ha
>  	stw	r4, ccsrbase_low@l(r6)

Why does this need two entry points rather than a more appropriate name?

> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 3fe6d92..1d0c4e0 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -200,6 +200,14 @@ config CPU_FREQ_PMAC64
>  	  This adds support for frequency switching on Apple iMac G5,
>  	  and some of the more recent desktop G5 machines as well.
>  
> +config MPC85xx_CPUFREQ
> +	bool "Support for Freescale MPC85xx CPU freq"
> +	depends on PPC_85xx && PPC32
> +	select CPU_FREQ_TABLE
> +	help
> +	  This adds support for frequency switching on Freescale MPC85xx,
> +	  currently including P1022 and MPC8536.

default y, given the dependencies?  Or wait for more testing before we
do that?

-Scott
