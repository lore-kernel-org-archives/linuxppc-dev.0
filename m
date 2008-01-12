Return-Path: <SRS0=h5jx=SC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 41855DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 17:29:07 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] Warp Base Platform
Date: Sat, 12 Jan 2008 07:23:29 +0100
References: <47852C41.8000506@pikatech.com>
	<20080111115143.4ed89ab6@zod.rchland.ibm.com>
	<4787FE23.7010201@pikatech.com>
In-Reply-To: <4787FE23.7010201@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801120723.29393.sr@denx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 January 2008, Sean MacLennan wrote:
> Josh Boyer wrote:
> >> +		if (gpio_base == NULL) {
> >> +			printk("ERROR: Unable to remap GPIO base.\n");
> >> +			return;
> >> +		}
> >> +	}
> >> +
> >> +	leds = readl(gpio_base + 0x100);
> >
> > Do you really want readl here?  That will byte-swap.
>
> According to the docs I got from the hardware guys, this is correct.
> That does *not* mean they didn't get it wrong. Unfortunately, it was
> just on a piece of paper and I don't know if I still have it.

You are accessing the 440EP GPIO controller here right? Then you really should 
use big endian access routines. From you code I assume that you have 
connected the LED signals to GPIO00 and GPIO01. I suggest to use code that 
looks like this:

#define LED_GREEN	(0x80000000 >> 0)
#define LED_RED		(0x80000000 >> 1)

	leds = in_be32(gpio_base);

	switch (green) {
	case 0: leds &= ~LED_GREEN; break;
	case 1: leds |=  LED_GREEN; break;
	}
	switch (red) {
	case 0: leds &= ~LED_RED; break;
	case 1: leds |=  LED_RED; break;
	}

       outbe32(leds, gpio_base);

And when you change the dts to describe both GPIO controllers you should map 
the 2nd one and remove the 0x100 offset above as I have done above.

Best regards,
Stefan
