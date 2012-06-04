Return-Path: <zch@az84smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C812BB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 21:04:20 +1000 (EST)
Received: from mail81-ch1 (localhost [127.0.0.1])	by mail81-ch1-R.bigfish.com
 (Postfix) with ESMTP id 7F934100310	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 11:03:35 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail81-ch1.bigfish.com (Postfix) with ESMTP id
 5D5D4420048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 11:03:31 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q54B465V027085	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 04:04:07 -0700
Date: Mon, 4 Jun 2012 19:04:44 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
Message-ID: <20120604110444.GA20676@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
 <4FC933BF.1020901@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FC933BF.1020901@freescale.com>
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

On Fri, Jun 01, 2012 at 04:27:27PM -0500, Scott Wood wrote:
> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> \> +#if defined(CONFIG_FSL_BOOKE) || defined(CONFIG_6xx)
> > +extern void __flush_disable_L1(void);
> > +#endif
> 
> Prototypes aren't normally guarded by ifdefs.

OK. Thanks.

> 
> > +static void __cpuinit smp_85xx_mach_cpu_die(void)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +	u32 tmp;
> > +
> > +	local_irq_disable();
> > +	idle_task_exit();
> > +	generic_set_cpu_dead(cpu);
> > +	mb();
> > +
> > +	mtspr(SPRN_TCR, 0);
> > +
> > +	__flush_disable_L1();
> > +	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
> > +	mtspr(SPRN_HID0, tmp);
> > +
> > +	/* Enter NAP mode. */
> > +	tmp = mfmsr();
> > +	tmp |= MSR_WE;
> > +	mb();
> > +	mtmsr(tmp);
> > +	isync();
> 
> Need isync after writing to HID0.
> 
> > +		/*
> > +		 * We don't set the BPTR register here upon it points
> > +		 * to the boot page properly.
> > +		 */
> > +		mpic_reset_core(hw_cpu);
> 
> That comment's wording is hard to follow -- maybe s/upon it points/since
> it already points/
> 
> > +		/* wait until core is ready... */
> > +		if (!spin_event_timeout(in_be32(&spin_table->addr_l) == 1,
> > +						10000, 100)) {
> > +			pr_err("%s: timeout waiting for core %d to reset\n",
> > +							__func__, hw_cpu);
> > +			ret = -ENOENT;
> > +			goto out;
> > +		}
> 
> We need to fix U-Boot to write addr_l last (with an msync beforehand).

I agree.

> 
> > -#ifdef CONFIG_KEXEC
> > +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
> 
> Let's not grow lists like this.  Is there any harm in building it
> unconditionally?
> 
> -Scott

We need this ifdef. We only set give_timebase/take_timebase
when CONFIG_KEXEC or CONFIG_HOTPLUG_CPU is defined.

-Chenhui
