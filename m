Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 57B24B712B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 19:46:05 +1000 (EST)
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 19:45:39 +1000
Message-Id: <1245059139.12400.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-15 at 00:12 +0100, Alan Cox wrote:
> > > +	if (!uioinfo->irq)
> > > +		uioinfo->irq = UIO_IRQ_NONE;
> > 
> > Please don't do this. It's inconsistent if all other UIO drivers require
> > people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
> > introduced because 0 may be a legal interrupt number on some platforms.
> 
> Zero is not a valid IRQ number in the kernel (except in arch specific
> depths). IRQ numbers are also *unsigned* so -1 isn't a safe definition.
> 
> Zero means no IRQ. If any old UIO code is assuming otherwise it wants
> fixing.
> 
> It is the job of the platform to map a physical IRQ 0 to some other
> representation if it exists outside of arch specific code. This was
> decided some years ago and a large part of the kernel simply doesn't
> support any notion of a real IRQ 0.

Right, and powerpc complies with that rule, so 0 is fine for us.

Cheers,
Ben.
