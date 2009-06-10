Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DE6AB715C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 07:46:31 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89F4ADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 07:46:30 +1000 (EST)
Subject: Re: Delay on intialization ide subsystem(most likely)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Gusev <a.gusev1980@mail.ru>
In-Reply-To: <20090611003834.7bde5e95@power-debian>
References: <20090425170203.74603b9c@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
	<20090530144643.76cb456e@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
	<20090611003834.7bde5e95@power-debian>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 07:46:17 +1000
Message-Id: <1244670377.3352.12.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-11 at 00:38 +0400, Andrey Gusev wrote:

> I try this small fix, traces in disappeared, but lost interrupts on the place:)
> Some interesting thing from dmesg:
> 
> [    0.435806] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 251
> [    0.435824] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 252
> [    0.435840] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 253
> [    0.435856] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 254
> [    0.435867] CPU0: L2CR is 80080000
> [    0.435880] CPU0: L3CR is 8f0b0000
> [478142827.057095] CPU1: L2CR was 80000
> [478142827.057133] CPU1: L2CR set to 80080000
> [478142827.057139] CPU1: L3CR was 0
> [478142827.057300] CPU1: L3CR set to 8f0b0000
> [    0.437529] Processor 1 found.
> [    0.437588] clockevent: decrementer mult[886] shift[16] cpu[1]
> 
> This is don't look good.

What doesn't look good ? It's copying the L2CR and L3CR values over from
CPU 0 to CPU 1 when bringing the later up, I don't see anything wrong.

Cheers,
Ben.

> > 
> > 
> > > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > 
> > DMA status indicates that DMA transfer is still active according to
> > the controller.  This one is really a platform/hardware specific
> > issue.
> > 
> 
> Notes for Ben, I checked only 2.6.26, but may be somebody checked 2.6.24
> or this is interpolation.
> 
> Thanks,
> Andrey 
