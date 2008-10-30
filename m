Return-Path: <tpiepho@freescale.com>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE40DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 12:18:26 +1100 (EST)
Date: Wed, 29 Oct 2008 18:07:47 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
In-Reply-To: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Sep 2008, Peter Korsgaard wrote:
> +- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio" for
> +  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.

Why have the three different compatible settings when the code doesn't do
anything different?

> +#define MPC8XXX_GPIO_PINS	32

8572 has eight GPIOs.

I wrote an MPC8572 GPIO driver back in March, and posted it internally at
Freescale on June 2nd.  But it was just ignored...  I wonder what your secret
is to get Kumar to apply your patches?  It's too bad this work keeps getting
duplicated.

My patch started out *very* much like yours, except it pre-dated the OF gpio
controller stuff and of_mm_gpiochip so it didn't use that.

But, I'm using the GPIOs to bit-bang a JTAG bus in the 20-30 MHz range.  The
obvious GPIO driver is *much* too slow for that.  I got less than 3 MHz, and
your driver looks like it might be slightly slower than my initial driver.

So I went to a lot of effort to speed it up and managed to increase GPIO
performance by nearly a factor of 10.  Trying to commit my driver at this
point is probably hopeless and I doubt anyone else cares about gpio speed. 
But at least the number of gpios for 8572 can be fixed.
