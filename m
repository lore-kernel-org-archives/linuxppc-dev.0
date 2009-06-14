Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 57884B70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 04:34:07 +1000 (EST)
Date: Sun, 14 Jun 2009 20:33:57 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614183357.GE3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090614171406.GA1010@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090614171406.GA1010@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 14, 2009 at 07:14:06PM +0200, Wolfram Sang wrote:
> Hello Hans,
> 
> > > +	uioinfo->irq = irq_of_parse_and_map(op->node, 0);
> > > +	if (!uioinfo->irq)
> > > +		uioinfo->irq = UIO_IRQ_NONE;
> > 
> > Please don't do this. It's inconsistent if all other UIO drivers require
> > people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
> > introduced because 0 may be a legal interrupt number on some platforms.
> 
> Yes, well, the '0' vs. 'NO_IRQ' thing is still not fully sorted out AFAIK.

A "cat /proc/interrupts" on any common x86 PC shows you that IRQ 0 is used
there. OK, it's unlikely someone wants to write a UIO driver for that one,
but that might be different on other platforms.
Anyway, 0 is a valid IRQ number, so it cannot be used as "no irq".

> But you are possibly right here, as long as irq_of_parse_and_map does return
> NO_IRQ, I should explicitly check for it, like this:
> 
> 	if (uioinfo->irq == NO_IRQ)
> 		uioinfo->irq = UIO_IRQ_NONE;

Sorry for my ignorance, but what is NO_IRQ? If I do a

grep -r NO_IRQ include/

I get nothing.

> 
> > > +/* Match table for of_platform binding */
> > > +static const struct of_device_id __devinitconst uio_of_genirq_match[] = {
> > 
> > checkpatch.pl complains about that. Please check.
> 
> Did that, it is a false positive. See here:
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/0906.1/02780.html

Well, you claim it's a false positive. So far, you did not get any responses,
AFAICS. I tend to agree with you, but I'd like to avoid patches that don't
pass checkpatch.pl, whatever the reason. Either the false positive gets
confirmed and fixed, or you should fix your patch.

Thanks,
Hans

> 
> Regards,
> 
>    Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
