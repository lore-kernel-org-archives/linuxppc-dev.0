Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0250B7128
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 09:11:01 +1000 (EST)
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21B70DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 09:11:00 +1000 (EST)
Date: Mon, 15 Jun 2009 00:12:07 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
In-Reply-To: <20090614122136.GD3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> > +	if (!uioinfo->irq)
> > +		uioinfo->irq = UIO_IRQ_NONE;
> 
> Please don't do this. It's inconsistent if all other UIO drivers require
> people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
> introduced because 0 may be a legal interrupt number on some platforms.

Zero is not a valid IRQ number in the kernel (except in arch specific
depths). IRQ numbers are also *unsigned* so -1 isn't a safe definition.

Zero means no IRQ. If any old UIO code is assuming otherwise it wants
fixing.

It is the job of the platform to map a physical IRQ 0 to some other
representation if it exists outside of arch specific code. This was
decided some years ago and a large part of the kernel simply doesn't
support any notion of a real IRQ 0.

Alan
