Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7DC35B70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 09:46:01 +1000 (EST)
Date: Mon, 15 Jun 2009 01:45:46 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614234546.GJ3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
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

On Mon, Jun 15, 2009 at 12:12:07AM +0100, Alan Cox wrote:
> > > +	if (!uioinfo->irq)
> > > +		uioinfo->irq = UIO_IRQ_NONE;
> > 
> > Please don't do this. It's inconsistent if all other UIO drivers require
> > people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
> > introduced because 0 may be a legal interrupt number on some platforms.
> 
> Zero is not a valid IRQ number in the kernel (except in arch specific
> depths). IRQ numbers are also *unsigned* so -1 isn't a safe definition.

The above uioinfo->irq is a signed long.

> 
> Zero means no IRQ. If any old UIO code is assuming otherwise it wants
> fixing.

It doesn't. It won't complain about IRQ 0 and will pass it on to
request_irq, which will probably fail if it is as you say.

I did it that way because I saw IRQ 0 in /proc/interrupts on every PC...

> 
> It is the job of the platform to map a physical IRQ 0 to some other
> representation if it exists outside of arch specific code.

Funny.

> This was
> decided some years ago and a large part of the kernel simply doesn't
> support any notion of a real IRQ 0.

Can you tell me the reason for that decision or point me to some ml archive?

Thanks,
Hans

> 
> Alan
