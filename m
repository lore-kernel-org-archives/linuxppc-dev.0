Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E28DFB70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 18:43:45 +1000 (EST)
Date: Mon, 15 Jun 2009 09:44:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090615094449.04b029f0@lxorguk.ukuu.org.uk>
In-Reply-To: <20090614234546.GJ3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090615001207.1829e7b5@lxorguk.ukuu.org.uk>
	<20090614234546.GJ3639@local>
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

> I did it that way because I saw IRQ 0 in /proc/interrupts on every PC...
> 
> > 
> > It is the job of the platform to map a physical IRQ 0 to some other
> > representation if it exists outside of arch specific code.
> 
> Funny.
> 
> > This was
> > decided some years ago and a large part of the kernel simply doesn't
> > support any notion of a real IRQ 0.
> 
> Can you tell me the reason for that decision or point me to some ml archive?

The natural C way to write "No xxx" is if (!xxx) hence

	if (!dev->irq) {
		polling_start();
		return 0;
	}

The PC "IRQ 0" is the timer - which only appears in the arch code.

Alan
