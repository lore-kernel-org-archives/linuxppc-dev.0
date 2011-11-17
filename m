Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F41E2B71DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 11:18:09 +1100 (EST)
Received: from mail11-va3 (localhost [127.0.0.1])	by mail11-va3-R.bigfish.com
 (Postfix) with ESMTP id 24C0C2003A0	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 17 Nov 2011 00:16:13 +0000 (UTC)
Received: from VA3EHSMHS011.bigfish.com (unknown [10.7.14.253])	by
 mail11-va3.bigfish.com (Postfix) with ESMTP id BA1C2140019	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:16:12 +0000 (UTC)
Message-ID: <4EC452B4.5090104@freescale.com>
Date: Wed, 16 Nov 2011 18:17:56 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-4-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> Some 85xx silicons like MPC8536 and P1022 has the JOG PM feature.

P1023 as well -- any plan to support?

I see this in the p1022 and mpc8536 manuals:

> The system operates as if a request to enter sleep mode has occurred, with the exception that the
> values written into the PMCDR register (clock disable register for sleep/ deep sleep modes) are
> ignored, and it is treated as if every bit in PMCDR is a logic 1. This means that the eTSECs, USB
> controllers, DDR and eLBC will be stopped.

...which doesn't sound good.

> The patch adds the support to change CPU frequency using the standard
> cpufreq interface. Add the all PLL ratio core support. The ratio CORE
> to CCB can 1:1(except MPC8536), 3:2, 2:1, 5:2, 3:1, 7:2 and 4:1.

The ratios supported are implementation-specific.  Only p1022 supports
1:1.  p1023 supports only 3:2, 2:1, 5:2, and 3:1 (assuming the
preliminary manual I have is accurate).

> +	local_irq_save(flags);
> +	/*
> +	 * A Jog request can not be asserted when any core is in a low power
> +	 * state. Before executing a jog request, any core which is in
> +	 * a low power state must be waked by a interrupt.
> +	 */
> +	if (mpc85xx_freqs == p1022_freqs_table) {
> +		powersave = ppc_md.power_save;
> +		ppc_md.power_save = NULL;
> +		wmb();
> +		val = in_be32(guts + POWMGTCSR);
> +		for_each_online_cpu(i) {
> +			if (val & ((POWMGTCSR_CORE0_DOZING |
> +					POWMGTCSR_CORE0_NAPPING) << (i * 2)))
> +				smp_send_reschedule(i);
> +		}
> +	}

This is racy, what if another core read ppc_md.power_save just before
you wrote NULL, but hasn't yet entered a low power state?

You should send a reschedule to all cores regardless of what you see in
POWMGTCSR.

The p1022 also says that MSR[EE] should be zero -- it is on this core,
but what about the other?

> +	setbits32(guts + POWMGTCSR, POWMGTCSR_JOG_MASK);

This might work on p1022, but don't you have to go through a core reset
on mpc8536?  In that case, you can't just set the bit, you have to go
through the deep sleep code to save/restore state.

P1022 also says, "Mask all the interrupts to the cores by setting the
bits CORE_UDE_MSK, CORE_MCP_MSK, CORE_INT_MSK and CORE_CINT_MSK in the
POWMGTCSR," which I don't see happening.

Though, this directly contradicts where it later says, "The user must
not issue a jog request at the same time as issuing a request
for another low power mode, or while the system is in the process of
entering a low power mode. This means that a jog request must not be
asserted when any other bit of POWMGTCSR is non-zero. If the user tries
to do this, the jog request is ignored."

POWMGTCSR must be zero except for the JOG bit, but you must set other
POWMGTCSR bits.  Lovely. :-P  I assume that the "This means..."
statement is just wrong, and you really are supposed to set those other
bits.  P1023 refines the statement to, "This means that POWMGTCSR[JOG]
must not be asserted when any of the other power management request bits
(COREn_DOZ, SLP) in POWMGTCSR are set."

> +	if (powersave) {
> +		ppc_md.power_save = powersave;
> +		wmb();
> +	}

How do you know the jog has happened at this point?  Just because you've
issued a store that requests it doesn't mean it has taken effect by the
time you execute the next instruction.

> +	local_irq_restore(flags);
> +
> +	/* verify */
> +	if (!spin_event_timeout(get_pll(hw_cpu) == pll, 10000, 10)) {
> +		pr_err("%s: Fail to switch the core frequency. "
> +			"The current PLL of core %d is %d instead of %d.\n",
> +				__func__, hw_cpu, get_pll(hw_cpu), pll);
> +		ret = -EINVAL;
> +	}

Shouldn't the pll be where it's supposed to be as soon as we resume
execution?  I don't see a need to spin here, provided we properly wait
for the jog to happen earlier (which we want to do so that we don't
enable power_save and EE early).

> +static int mpc85xx_cpufreq_target(struct cpufreq_policy *policy,
> +			      unsigned int target_freq,
> +			      unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	unsigned int new;
> +	int ret = 0;
> +
> +	cpufreq_frequency_table_target(policy,
> +				       mpc85xx_freqs,
> +				       target_freq,
> +				       relation,
> +				       &new);
> +
> +	freqs.old = policy->cur;
> +	freqs.new = mpc85xx_freqs[new].frequency;
> +	freqs.cpu = policy->cpu;
> +
> +	mutex_lock(&mpc85xx_switch_mutex);
> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +	ret = set_pll(policy->cpu, mpc85xx_freqs[new].index);
> +	if (!ret) {
> +		pr_info("cpufreq: Setting core%d frequency to %d kHz and " \
> +			 "PLL ratio to %d:2\n",
> +			 policy->cpu,
> +			 mpc85xx_freqs[new].frequency,
> +			 mpc85xx_freqs[new].index);
> +
> +		ppc_proc_freq = freqs.new * 1000ul;
> +	}
> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	mutex_unlock(&mpc85xx_switch_mutex);

I still do not understand what sense it makes to set a global variable
(ppc_proc_freq) to the frequency of a specific CPU.

> +static int mpc85xx_job_probe(struct platform_device *ofdev)
> +{
> +	struct device_node *np = ofdev->dev.of_node;
> +
> +	if (of_device_is_compatible(np, "fsl,mpc8536-guts")) {
> +		threshold_freq = FREQ_800MHz;
> +		mpc85xx_freqs = mpc8536_freqs_table;
> +	} else if (of_device_is_compatible(np, "fsl,p1022-guts")) {
> +		threshold_freq = FREQ_533MHz;
> +		mpc85xx_freqs = p1022_freqs_table;
> +	}

Maybe use .data in the of_device_id table, similar to
arch/powerpc/platforms/83xx/suspend.c?  Though it's slightly less
convenient now that we need to call of_match_device() again in order to
get a match pointer.

-Scott
