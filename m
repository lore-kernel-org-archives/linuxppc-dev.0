Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1601AB70E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 09:01:47 +1000 (EST)
Date: Mon, 15 Jun 2009 01:01:36 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614230135.GI3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090614171406.GA1010@pengutronix.de>
	<20090614183357.GE3639@local>
	<20090614190533.GA7387@pengutronix.de>
	<20090614192359.GG3639@local> <4A355155.4020500@grandegger.com>
	<20090614203444.GH3639@local>
	<20090614220022.GB24323@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090614220022.GB24323@pengutronix.de>
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

On Mon, Jun 15, 2009 at 12:00:22AM +0200, Wolfram Sang wrote:
> > > For x86 it's not defined at all. But as this code is for the PowerPC,
> > 
> > No, it isn't. What makes you say that? The Kconfig entry doesn't depend
> > on PowerPC. I compiled it on x86...
> 
> It depends on OF. You could compile on x86? Have to check that...

Ooops, forget it. It cannot be selected on x86. I was a bit distracted when
I wrote that, sorry.

> 
> > > where using NO_IRQ seems still to be OK.
> > 
> > No. uio_pdrv_genirq can be used on all platforms, and not all platforms have
> > NO_IRQ. NO_IRQ can be used in platform specific code only.
> 
> Well, the wrapper uses irq_of_parse_and_map(). So far, it returns NO_IRQ if an
> IRQ was not specified (or not found). I could check if there was an
> interrupt-property at all, so I can distinguish between 'not specified' and
> 'not found'. Then, UIO_IRQ_NONE would only be used, if there was none
> specified. Otherwise it will always be the result from irq_of_parse_and_map(),
> whatever that is (even NO_IRQ). Is this what you have in mind?

I would find it better if probe() failed if no irq is specified, printing a
message that tells the user to setup his data correctly before loading the
driver. A user _has_ to setup irq, if there is none, he still has to set
irq=UIO_IRQ_NONE. For that matter, 'not specified' and 'not found' is both
the same bad thing.

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
