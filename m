Return-Path: <a.gusev1980@mail.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68738B7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 06:38:47 +1000 (EST)
Received: from mx39.mail.ru (mx39.mail.ru [94.100.176.53])
	by ozlabs.org (Postfix) with ESMTP id 8A28BDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 06:38:46 +1000 (EST)
Date: Thu, 11 Jun 2009 00:38:34 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090611003834.7bde5e95@power-debian>
In-Reply-To: <200906082220.41763.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
	<20090530144643.76cb456e@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 8 Jun 2009 22:20:41 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Saturday 30 May 2009 12:46:43 Andrey Gusev wrote:
> > On Wed, 20 May 2009 17:56:14 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > On Friday 15 May 2009 22:40:07 Andrey Gusev wrote:
> > > > On Wed, 13 May 2009 20:46:33 +0200
> > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > 
> > > > > On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> > > > > > On Wed, 13 May 2009 15:28:26 +0200
> > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > 
> > > > > > > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > > > > > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > > > 
> > > > > > > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > > > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > > > > > > > > wrote:
> 
> Indeed.  The delay problem is a more generic kernel/hardware issue.
Ok, I can rather stable reproduce it on 2.6.29-rc6. I want to narrow it,
disabling almost all options in kernel configuration. Could some options
from 'kernel hacking' help me?
> 
> Thanks for testing.  Unfortunately none of fixes helped.. :/
> 
> > [   70.287747] sysfs: cannot create duplicate filename
> > '/class/ide_port/ide1' [   70.287841] ------------[ cut
> > here ]------------ [   70.287879] Badness at fs/sysfs/dir.c:487
> 
> This is caused by small mistake in one of fixes, follow-up fixup:
> 
> diff -u b/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> --- b/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -708,6 +708,8 @@
>  		goto out;
>  	} else if (rc == -EBUSY)
>  		printk(KERN_ERR "%s: not ready before the probe\n",
> hwif->name);
> +	else
> +		rc = -ENODEV;
>  
>  	/*
>  	 * Second drive should only exist if first drive was found,

I try this small fix, traces in disappeared, but lost interrupts on the place:)
Some interesting thing from dmesg:

[    0.435806] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 251
[    0.435824] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 252
[    0.435840] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 253
[    0.435856] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 254
[    0.435867] CPU0: L2CR is 80080000
[    0.435880] CPU0: L3CR is 8f0b0000
[478142827.057095] CPU1: L2CR was 80000
[478142827.057133] CPU1: L2CR set to 80080000
[478142827.057139] CPU1: L3CR was 0
[478142827.057300] CPU1: L3CR set to 8f0b0000
[    0.437529] Processor 1 found.
[    0.437588] clockevent: decrementer mult[886] shift[16] cpu[1]

This is don't look good.

> 
> 
> > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> 
> DMA status indicates that DMA transfer is still active according to
> the controller.  This one is really a platform/hardware specific
> issue.
> 

Notes for Ben, I checked only 2.6.26, but may be somebody checked 2.6.24
or this is interpolation.

Thanks,
Andrey 
