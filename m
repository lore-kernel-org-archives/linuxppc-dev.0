Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 986BEB722B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 06:44:59 +1100 (EST)
Received: from mail67-va3 (localhost [127.0.0.1])	by mail67-va3-R.bigfish.com
 (Postfix) with ESMTP id 89750700372	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 17 Nov 2011 19:47:54 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.237])	by
 mail67-va3.bigfish.com (Postfix) with ESMTP id 44B84400019	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 19:47:54 +0000 (UTC)
Date: Thu, 17 Nov 2011 13:44:43 -0600
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH v2 2/7] powerpc/85xx: add HOTPLUG_CPU support
Message-ID: <20111117194443.GA14587@schlenkerla.am.freescale.net>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-2-git-send-email-chenhui.zhao@freescale.com>
 <4EC408C1.1040400@freescale.com>
 <3F607A5180246847A760FD34122A1E052D4486@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3F607A5180246847A760FD34122A1E052D4486@039-SN1MPN1-003.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 05:16:09AM -0600, Li Yang-R58472 wrote:
> 
> 
> >Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472
> >Subject: Re: [PATCH v2 2/7] powerpc/85xx: add HOTPLUG_CPU support
> >
> >On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> >> +static void __cpuinit smp_85xx_mach_cpu_die(void) {
> >> +	unsigned int cpu = smp_processor_id();
> >> +	register u32 tmp;
> >> +
> >> +	local_irq_disable();
> >> +	idle_task_exit();
> >> +	generic_set_cpu_dead(cpu);
> >> +	mb();
> >> +
> >> +	mtspr(SPRN_TCR, 0);
> >> +	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
> >
> >Clearing these bits in TSR should be unnecessary since we clear TCR -- and
> >doesn't really accomplish anything since the TSR bits can continue to be
> >set.
> 
> I also recommend setting the CORE_IRQ_MASK and CORE_CI_MASK in the
> POWMGTCSR register so that no interrupt will wakeup the core from NAP.

Any interrupt that we don't want to use as a wakeup source should already
be disabled at the MPIC.  Won't disabling IRQs in POWMGTCSR prevent us
from being woken by devices that we want to use as a wakeup source?

> >If watchdog is in use, we need to set the period to the highest possible
> >to effectively disable it.
> 
> Setting it to the highest timeout doesn't really disable the watchdog. 

It means the watchdog won't expire for thousands of years, which is
beyond any reasonable design parameter for uptime.

We already do this in Topaz when entering nap.

> >> +static int __cpuinit smp_85xx_kick_cpu(int nr)
> >> +
> >>  {
> >>  	unsigned long flags;
> >>  	const u64 *cpu_rel_addr;
> >> -	__iomem u32 *bptr_vaddr;
> >> +	__iomem struct epapr_spin_table *epapr;
> >
> >Please don't call this just "epapr".  That's like calling a reference to
> >any powerpc-specific struct "powerpc".
> >
> >How about "spin_table"?
> 
> You mean the name of the variable not the structure, right?  I agree.

Right, the variable name.

> >>  struct smp_ops_t smp_85xx_ops = {
> >>  	.kick_cpu = smp_85xx_kick_cpu,
> >> +	.setup_cpu	= smp_85xx_setup_cpu,
> >> +#ifdef CONFIG_HOTPLUG_CPU
> >> +	.cpu_disable	= generic_cpu_disable,
> >> +	.cpu_die	= generic_cpu_die,
> >> +#endif
> >
> >Only fill these fields in on e500v1/v2, until we properly support e500mc.
> >Likewise in ppc_md.cpu_die and anywhere else we advertise this
> >functionality.
> 
> Is there a standard function call that can tell that it is an e500mc not legacy e500?

Use CONFIG_E500MC -- we don't support combined e500v2/e500mc kernels for
other reasons.

If that ever changes, we'll need to do something based on the cpu table.

-Scott
