Return-Path: <zch@az84smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8DD0B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 19:08:10 +1000 (EST)
Received: from mail99-ch1 (localhost [127.0.0.1])	by mail99-ch1-R.bigfish.com
 (Postfix) with ESMTP id B97264002C7	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 09:07:24 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail99-ch1.bigfish.com (Postfix) with ESMTP id
 34D8B80048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 09:07:22 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5597sQQ020706	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 02:07:57 -0700
Date: Tue, 5 Jun 2012 17:08:31 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120605090831.GA21929@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <4FC8E250.9090000@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FC8E250.9090000@freescale.com>
Sender: <zch@az84smr01.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 01, 2012 at 10:40:00AM -0500, Scott Wood wrote:
> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >  #ifdef CONFIG_KEXEC
> > +static struct ccsr_guts __iomem *guts;
> > +static u64 timebase;
> > +static int tb_req;
> > +static int tb_valid;
> > +
> > +static void mpc85xx_timebase_freeze(int freeze)
> 
> Why is this under CONFIG_KEXEC?  It'll also be needed for CPU hotplug.

Yes, the timebase sync is also needed for CPU hotplug, but this patch is unrelated to CPU hotplug.
I added CONFIG_HOTPLUG_CPU in the next patch.

> 
> > +{
> > +	unsigned int mask;
> > +
> > +	if (!guts)
> > +		return;
> > +
> > +	mask = CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
> > +	if (freeze)
> > +		setbits32(&guts->devdisr, mask);
> > +	else
> > +		clrbits32(&guts->devdisr, mask);
> > +
> > +	in_be32(&guts->devdisr);
> > +}
> > +
> > +static void mpc85xx_give_timebase(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +
> > +	while (!tb_req)
> > +		barrier();
> > +	tb_req = 0;
> > +
> > +	mpc85xx_timebase_freeze(1);
> > +	timebase = get_tb();
> > +	mb();
> > +	tb_valid = 1;
> > +
> > +	while (tb_valid)
> > +		barrier();
> > +
> > +	mpc85xx_timebase_freeze(0);
> > +
> > +	local_irq_restore(flags);
> > +}
> > +
> > +static void mpc85xx_take_timebase(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +
> > +	tb_req = 1;
> > +	while (!tb_valid)
> > +		barrier();
> > +
> > +	set_tb(timebase >> 32, timebase & 0xffffffff);
> > +	mb();
> > +	tb_valid = 0;
> > +
> > +	local_irq_restore(flags);
> > +}
> 
> I know you say this is for dual-core chips only, but it would be nice if
> you'd write this in a way that doesn't assume that (even if the
> corenet-specific timebase freezing comes later).

At this point, I have not thought about how to implement the cornet-specific timebase freezing.

> 
> Do we need an isync after setting the timebase, to ensure it's happened
> before we enable the timebase?  Likewise, do we need a readback after
> disabling the timebase to ensure it's disabled before we read the
> timebase in give_timebase?

I checked the e500 core manual (Chapter 2.16 Synchronization Requirements for SPRs).
Only some SPR registers need an isync. The timebase registers do not.

I did a readback in mpc85xx_timebase_freeze().

> 
> >  atomic_t kexec_down_cpus = ATOMIC_INIT(0);
> >  
> >  void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
> > @@ -228,6 +286,20 @@ smp_85xx_setup_cpu(int cpu_nr)
> >  		doorbell_setup_this_cpu();
> >  }
> >  
> > +#ifdef CONFIG_KEXEC
> > +static const struct of_device_id guts_ids[] = {
> > +	{ .compatible = "fsl,mpc8572-guts", },
> > +	{ .compatible = "fsl,mpc8560-guts", },
> > +	{ .compatible = "fsl,mpc8536-guts", },
> > +	{ .compatible = "fsl,p1020-guts", },
> > +	{ .compatible = "fsl,p1021-guts", },
> > +	{ .compatible = "fsl,p1022-guts", },
> > +	{ .compatible = "fsl,p1023-guts", },
> > +	{ .compatible = "fsl,p2020-guts", },
> > +	{},
> > +};
> > +#endif
> 
> MPC8560 and MPC8536 are single-core...

Thanks. I will remove them.

> 
> Also please use a more specific name, such as e500v2_smp_guts_ids or
> mpc85xx_smp_guts_ids -- when corenet support is added it will likely be
> in the same file.
> 
> >  void __init mpc85xx_smp_init(void)
> >  {
> >  	struct device_node *np;
> > @@ -249,6 +321,19 @@ void __init mpc85xx_smp_init(void)
> >  		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
> >  	}
> >  
> > +#ifdef CONFIG_KEXEC
> > +	np = of_find_matching_node(NULL, guts_ids);
> > +	if (np) {
> > +		guts = of_iomap(np, 0);
> > +		smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
> > +		smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
> > +		of_node_put(np);
> > +	} else {
> > +		smp_85xx_ops.give_timebase = smp_generic_give_timebase;
> > +		smp_85xx_ops.take_timebase = smp_generic_take_timebase;
> > +	}
> 
> Do not use smp_generic_give/take_timebase, ever.  If you don't have the
> guts node, then just assume the timebase is already synced.
> 
> -Scott

smp_generic_give/take_timebase is the default in KEXEC before.
If do not set them, it may make KEXEC fail on other platforms.

-Chenhui
