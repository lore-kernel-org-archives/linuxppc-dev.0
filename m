Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR004.bigfish.com (smtp-cpk.frontbridge.com
 [204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6D462B7200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 22:53:49 +1100 (EST)
Received: from mail145-va3 (localhost [127.0.0.1])	by
 mail145-va3-R.bigfish.com (Postfix) with ESMTP id 30756200502	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 11:57:00 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.250])	by
 mail145-va3.bigfish.com (Postfix) with ESMTP id 5406D4E0048	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 11:56:58 +0000 (UTC)
Received: from localhost.localdomain ([10.193.20.166])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id pAHBrNPr002578	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 05:53:24 -0600 (CST)
Date: Thu, 17 Nov 2011 19:53:22 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20111117115322.GA10020@localhost.localdomain>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-4-git-send-email-chenhui.zhao@freescale.com>
 <4EC452B4.5090104@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EC452B4.5090104@freescale.com>
Sender: <zch@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: zch@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2011 at 06:17:56PM -0600, Scott Wood wrote:
> On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> > From: Li Yang <leoli@freescale.com>
> > 
> > Some 85xx silicons like MPC8536 and P1022 has the JOG PM feature.
> 
> P1023 as well -- any plan to support?
> 
> I see this in the p1022 and mpc8536 manuals:
> 
> > The system operates as if a request to enter sleep mode has occurred, with the exception that the
> > values written into the PMCDR register (clock disable register for sleep/ deep sleep modes) are
> > ignored, and it is treated as if every bit in PMCDR is a logic 1. This means that the eTSECs, USB
> > controllers, DDR and eLBC will be stopped.
> 
> ...which doesn't sound good.
> 
> > The patch adds the support to change CPU frequency using the standard
> > cpufreq interface. Add the all PLL ratio core support. The ratio CORE
> > to CCB can 1:1(except MPC8536), 3:2, 2:1, 5:2, 3:1, 7:2 and 4:1.
> 
> The ratios supported are implementation-specific.  Only p1022 supports
> 1:1.  p1023 supports only 3:2, 2:1, 5:2, and 3:1 (assuming the
> preliminary manual I have is accurate).
> 
> > +	local_irq_save(flags);
> > +	/*
> > +	 * A Jog request can not be asserted when any core is in a low power
> > +	 * state. Before executing a jog request, any core which is in
> > +	 * a low power state must be waked by a interrupt.
> > +	 */
> > +	if (mpc85xx_freqs == p1022_freqs_table) {
> > +		powersave = ppc_md.power_save;
> > +		ppc_md.power_save = NULL;
> > +		wmb();
> > +		val = in_be32(guts + POWMGTCSR);
> > +		for_each_online_cpu(i) {
> > +			if (val & ((POWMGTCSR_CORE0_DOZING |
> > +					POWMGTCSR_CORE0_NAPPING) << (i * 2)))
> > +				smp_send_reschedule(i);
> > +		}
> > +	}
> 
> This is racy, what if another core read ppc_md.power_save just before
> you wrote NULL, but hasn't yet entered a low power state?
> 

Yes, It's rare but it is possible. Perhaps I can check if the core is
in ppc_md.power_save() by the flag _TLF_NAPPING.

> You should send a reschedule to all cores regardless of what you see in
> POWMGTCSR.
> 
> The p1022 also says that MSR[EE] should be zero -- it is on this core,
> but what about the other?
> 
> > +	setbits32(guts + POWMGTCSR, POWMGTCSR_JOG_MASK);
> 
> This might work on p1022, but don't you have to go through a core reset
> on mpc8536?  In that case, you can't just set the bit, you have to go
> through the deep sleep code to save/restore state.
> 
> P1022 also says, "Mask all the interrupts to the cores by setting the
> bits CORE_UDE_MSK, CORE_MCP_MSK, CORE_INT_MSK and CORE_CINT_MSK in the
> POWMGTCSR," which I don't see happening.

I will fix them.

> 
> Though, this directly contradicts where it later says, "The user must
> not issue a jog request at the same time as issuing a request
> for another low power mode, or while the system is in the process of
> entering a low power mode. This means that a jog request must not be
> asserted when any other bit of POWMGTCSR is non-zero. If the user tries
> to do this, the jog request is ignored."
> 
> POWMGTCSR must be zero except for the JOG bit, but you must set other
> POWMGTCSR bits.  Lovely. :-P  I assume that the "This means..."
> statement is just wrong, and you really are supposed to set those other
> bits.  P1023 refines the statement to, "This means that POWMGTCSR[JOG]
> must not be asserted when any of the other power management request bits
> (COREn_DOZ, SLP) in POWMGTCSR are set."
> 
> > +	if (powersave) {
> > +		ppc_md.power_save = powersave;
> > +		wmb();
> > +	}
> 
> How do you know the jog has happened at this point?  Just because you've
> issued a store that requests it doesn't mean it has taken effect by the
> time you execute the next instruction.
> 
> > +	local_irq_restore(flags);
> > +
> > +	/* verify */
> > +	if (!spin_event_timeout(get_pll(hw_cpu) == pll, 10000, 10)) {
> > +		pr_err("%s: Fail to switch the core frequency. "
> > +			"The current PLL of core %d is %d instead of %d.\n",
> > +				__func__, hw_cpu, get_pll(hw_cpu), pll);
> > +		ret = -EINVAL;
> > +	}
> 
> Shouldn't the pll be where it's supposed to be as soon as we resume
> execution?  I don't see a need to spin here, provided we properly wait
> for the jog to happen earlier (which we want to do so that we don't
> enable power_save and EE early).

I found some delay is needed to wait the pll to update in tests.

-chenhui
