Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9048AB7237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 06:54:44 +1100 (EST)
Received: from mail104-db3 (localhost.localdomain [127.0.0.1])	by
 mail104-db3-R.bigfish.com (Postfix) with ESMTP id 5B160FB8192	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 19:54:23 +0000 (UTC)
Received: from DB3EHSMHS016.bigfish.com (unknown [10.3.81.251])	by
 mail104-db3.bigfish.com (Postfix) with ESMTP id 1DD0D1668051	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 19:54:23 +0000 (UTC)
Date: Thu, 17 Nov 2011 13:54:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 4/7] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20111117195431.GB14587@schlenkerla.am.freescale.net>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-4-git-send-email-chenhui.zhao@freescale.com>
 <4EC452B4.5090104@freescale.com>
 <20111117115322.GA10020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111117115322.GA10020@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 07:53:22PM +0800, Zhao Chenhui wrote:
> On Wed, Nov 16, 2011 at 06:17:56PM -0600, Scott Wood wrote:
> > On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> > > +	local_irq_save(flags);
> > > +	/*
> > > +	 * A Jog request can not be asserted when any core is in a low power
> > > +	 * state. Before executing a jog request, any core which is in
> > > +	 * a low power state must be waked by a interrupt.
> > > +	 */
> > > +	if (mpc85xx_freqs == p1022_freqs_table) {
> > > +		powersave = ppc_md.power_save;
> > > +		ppc_md.power_save = NULL;
> > > +		wmb();
> > > +		val = in_be32(guts + POWMGTCSR);
> > > +		for_each_online_cpu(i) {
> > > +			if (val & ((POWMGTCSR_CORE0_DOZING |
> > > +					POWMGTCSR_CORE0_NAPPING) << (i * 2)))
> > > +				smp_send_reschedule(i);
> > > +		}
> > > +	}
> > 
> > This is racy, what if another core read ppc_md.power_save just before
> > you wrote NULL, but hasn't yet entered a low power state?
> > 
> 
> Yes, It's rare but it is possible. Perhaps I can check if the core is
> in ppc_md.power_save() by the flag _TLF_NAPPING.

There's still a race window between when power_save is checked and when
_TLF_NAPPING is set.

Just send the IPI unconditionally to all CPUs.  Since we want to clear
MSR[EE] on all CPUs, what we really want is probably smp_call_function(). 

The called function would be entered with interrupts disabled, should
update an atomic counter to check in with the main core, and should wait
for the main core to indicate that jog is finished and it's OK to return.

> > > +	local_irq_restore(flags);
> > > +
> > > +	/* verify */
> > > +	if (!spin_event_timeout(get_pll(hw_cpu) == pll, 10000, 10)) {
> > > +		pr_err("%s: Fail to switch the core frequency. "
> > > +			"The current PLL of core %d is %d instead of %d.\n",
> > > +				__func__, hw_cpu, get_pll(hw_cpu), pll);
> > > +		ret = -EINVAL;
> > > +	}
> > 
> > Shouldn't the pll be where it's supposed to be as soon as we resume
> > execution?  I don't see a need to spin here, provided we properly wait
> > for the jog to happen earlier (which we want to do so that we don't
> > enable power_save and EE early).
> 
> I found some delay is needed to wait the pll to update in tests.

This delay should happen earlier -- you should spin waiting for
POWMGTCSR[JOG] to clear before you enable interrupts, restore
ppc_md.power_save, or do any other cleanup that assumes you're done with
the jog.

Have you seen the PLL not be updated after POWMGTCSR[JOG] is clear?

-Scott
