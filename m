Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 388E5DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 05:25:21 +1100 (EST)
Date: Fri, 24 Oct 2008 20:25:33 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix i2c on PPC linkstation / kurobox machines
In-Reply-To: <1224807581.7654.424.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0810242025010.7996@axis700.grange>
References: <20081022191650.GA11406@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810232029380.9657@axis700.grange>
	<20081023213309.GA19777@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810240059170.9657@axis700.grange>
	<1224807581.7654.424.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
	=?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 24 Oct 2008, Benjamin Herrenschmidt wrote:

> On Fri, 2008-10-24 at 01:05 +0200, Guennadi Liakhovetski wrote:
> > i2c is broken on linkstation / kurobox machines since at least 2.6.27. Fix 
> > it. Also remove CONFIG_SERIAL_OF_PLATFORM, which, if enabled, breaks the 
> > serial console after the "console handover: boot [udbg0] -> real [ttyS1]" 
> > message.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> You may want to use udbg_printf() to track down what's up. There's some
> fishy code there indeed, what happens is that the legacy serial code
> creates a platform device at boot time. Then, the of_serial attaches to
> the device node for the same device and tries to register it. It's
> supposed to "detect" that it's the same device but yeah, it may be
> buggy, I've seen problems with it in the past, among others, I think it
> can lose some state.
> 
> In the meantime, removing SERIAL_OF_PLATFORM is a good solution.
> 
> Ben.

I think, this needs an acked-by for -stable.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
