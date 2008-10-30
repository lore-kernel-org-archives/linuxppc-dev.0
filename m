Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 803D2DDDE3
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 18:45:35 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so886036ugm.14
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 00:45:32 -0700 (PDT)
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
	<Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 30 Oct 2008 08:45:30 +0100
In-Reply-To: <Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp> (Trent
	Piepho's message of "Wed\, 29 Oct 2008 18\:07\:47 -0700 \(PDT\)")
Message-ID: <8763najzl1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Trent" == Trent Piepho <tpiepho@freescale.com> writes:

 Trent> On Tue, 23 Sep 2008, Peter Korsgaard wrote:
 >> +- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio" for
 >> +  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.

 Trent> Why have the three different compatible settings when the code
 Trent> doesn't do anything different?

Purely for cosmetics / ease of use - As requested by Kumar:

http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062934.html

 >> +#define MPC8XXX_GPIO_PINS	32

 Trent> 8572 has eight GPIOs.

Doesn't matter - It's register interface is compatible. Most real
world design with the other SoCs also don't have all 32 gpio pins
available because of pin multiplexing.

 Trent> I wrote an MPC8572 GPIO driver back in March, and posted it
 Trent> internally at Freescale on June 2nd.  But it was just
 Trent> ignored...  I wonder what your secret is to get Kumar to apply
 Trent> your patches?  It's too bad this work keeps getting
 Trent> duplicated.

Did you try bribing? ;) No, seriously, why didn't you post it to
linuxppc-dev, so the rest of the world would know about it?

 Trent> My patch started out *very* much like yours, except it
 Trent> pre-dated the OF gpio controller stuff and of_mm_gpiochip so
 Trent> it didn't use that.

 Trent> But, I'm using the GPIOs to bit-bang a JTAG bus in the 20-30
 Trent> MHz range.  The obvious GPIO driver is *much* too slow for
 Trent> that.  I got less than 3 MHz, and your driver looks like it
 Trent> might be slightly slower than my initial driver.

I would write a dedicated driver for something like that instead of
using gpiolib.

Gpiolib has quite some overhead compared to the actual work for
changing a SoC gpio pin, but it also has some very nice
advantages. For most stuff people use GPIO pins for, the overhead is
not an issue (SPI chip selects, leds, keys, reset signals, ..). It's
very handy that we nowadays have generic drivers that work with any
GPIO (being SoC gpios or stuff on spi/i2c).

 Trent> So I went to a lot of effort to speed it up and managed to
 Trent> increase GPIO performance by nearly a factor of 10.  Trying to
 Trent> commit my driver at this point is probably hopeless and I
 Trent> doubt anyone else cares about gpio speed.  But at least the
 Trent> number of gpios for 8572 can be fixed.

Sure, going dedicated always can improve performance. I recently did
some work in u-boot talking directly to the mpc83xx spi controller and
got ~5x throughput compared to the Linux driver.

-- 
Bye, Peter Korsgaard
