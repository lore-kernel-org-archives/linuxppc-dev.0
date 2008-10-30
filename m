Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E86A9DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 19:58:57 +1100 (EST)
Date: Thu, 30 Oct 2008 01:58:32 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
In-Reply-To: <8763najzl1.fsf@macbook.be.48ers.dk>
Message-ID: <Pine.LNX.4.64.0810300123500.3943@t2.domain.actdsltmp>
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
	<Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
	<8763najzl1.fsf@macbook.be.48ers.dk>
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

On Thu, 30 Oct 2008, Peter Korsgaard wrote:
>>>>>> "Trent" == Trent Piepho <tpiepho@freescale.com> writes:
> Trent> On Tue, 23 Sep 2008, Peter Korsgaard wrote:
> >> +- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio" for
> >> +  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.
>
> Trent> Why have the three different compatible settings when the code
> Trent> doesn't do anything different?
>
> Purely for cosmetics / ease of use - As requested by Kumar:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062934.html

Though I see Scott didn't agree.

> >> +#define MPC8XXX_GPIO_PINS	32
>
> Trent> 8572 has eight GPIOs.
>
> Doesn't matter - It's register interface is compatible. Most real
> world design with the other SoCs also don't have all 32 gpio pins
> available because of pin multiplexing.

Doesn't it seem flawed that 32 gpios will show up under debugfs and via the
sysfs interface, when it's known that there are only 8?

Since there is an 8572 compat property, it's not like it's not solvable.

> Trent> I wrote an MPC8572 GPIO driver back in March, and posted it
> Trent> internally at Freescale on June 2nd.  But it was just
> Trent> ignored...  I wonder what your secret is to get Kumar to apply
> Trent> your patches?  It's too bad this work keeps getting
> Trent> duplicated.
>
> Did you try bribing? ;) No, seriously, why didn't you post it to
> linuxppc-dev, so the rest of the world would know about it?

Well, I get totally ignored posting to an internal Freescale list, it doesn't
seem like it will be any better posting to an external list.

> Trent> But, I'm using the GPIOs to bit-bang a JTAG bus in the 20-30
> Trent> MHz range.  The obvious GPIO driver is *much* too slow for
> Trent> that.  I got less than 3 MHz, and your driver looks like it
> Trent> might be slightly slower than my initial driver.
>
> I would write a dedicated driver for something like that instead of
> using gpiolib.

But the JTAG bus only uses four GPIOs, the other four get used for other
things with gpiolib, like gpio leds for example.  I also found it very handy
to be able to see and modify all the gpio lines, even the ones the JTAG driver
is using, via a sysfs interface to gpiolib.

> Gpiolib has quite some overhead compared to the actual work for
> changing a SoC gpio pin, but it also has some very nice

Certainly is does, but there are ways to make it faster.

> Trent> So I went to a lot of effort to speed it up and managed to
> Trent> increase GPIO performance by nearly a factor of 10.  Trying to
> Trent> commit my driver at this point is probably hopeless and I
> Trent> doubt anyone else cares about gpio speed.  But at least the
> Trent> number of gpios for 8572 can be fixed.
>
> Sure, going dedicated always can improve performance. I recently did
> some work in u-boot talking directly to the mpc83xx spi controller and
> got ~5x throughput compared to the Linux driver.

It's not dedicated though.  The gpiolib interface is still used.
