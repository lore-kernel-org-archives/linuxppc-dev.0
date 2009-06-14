Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2E123B7131
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 09:51:04 +1000 (EST)
Date: Mon, 15 Jun 2009 01:50:53 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614235053.GK3639@local>
References: <20090614122136.GD3639@local>
	<20090614171406.GA1010@pengutronix.de>
	<20090614183357.GE3639@local>
	<20090614190533.GA7387@pengutronix.de>
	<20090614192359.GG3639@local> <4A355155.4020500@grandegger.com>
	<20090614203444.GH3639@local>
	<20090614220022.GB24323@pengutronix.de>
	<20090614230135.GI3639@local>
	<20090614234643.GA17791@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090614234643.GA17791@pengutronix.de>
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

On Mon, Jun 15, 2009 at 01:46:43AM +0200, Wolfram Sang wrote:
> 
> > driver. A user _has_ to setup irq, if there is none, he still has to set
> > irq=UIO_IRQ_NONE. For that matter, 'not specified' and 'not found' is both
> > the same bad thing.
> 
> Hmm, what should I do?
> 
> A typical interrupts-property in a device-tree is specified as:
> 
> 	interrupts = <&irq_controller_node irq_number irq_sense>;
> 
> Something like UIO_IRQ_NONE does not fit into this scheme, even more as it is
> Linux-specific and device trees need to be OS independant.
> 
> I'm pretty sure the correct way to state that you don't need an interrupt in
> the device-tree is to simply not specify the above interrupt property.
> 
> Well, yes, that means you can't distinguish between 'forgotten' and
> 'intentionally left out'. I wonder if it is really that bad? If something does
> not work (= one is missing interrupts), the first place to look at is the
> device tree. If one does not see an interrupt-property, voila, problem solved.
> 
> (Note that with my latest suggestion, a _wrong_ interrupt is handled the same
> way as with platform_data. request_irq() should equally fail if the
> return-value from irq_of_parse_and_map() is simply forwarded.)

I agree. And assuming Alan is right, forget what I said about IRQ 0 being a
valid interrupt number.

Thanks,
Hans

> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
