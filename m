Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67591DDDEF
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 01:40:07 +1100 (EST)
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
From: Nate Case <ncase@xes-inc.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <8763najzl1.fsf@macbook.be.48ers.dk>
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
	<Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
	<8763najzl1.fsf@macbook.be.48ers.dk>
Content-Type: text/plain
Date: Thu, 30 Oct 2008 09:39:35 -0500
Message-Id: <1225377575.27415.99.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-30 at 08:45 +0100, Peter Korsgaard wrote:
> I would write a dedicated driver for something like that instead of
> using gpiolib.
> 
> Gpiolib has quite some overhead compared to the actual work for
> changing a SoC gpio pin, but it also has some very nice
> advantages. For most stuff people use GPIO pins for, the overhead is
> not an issue (SPI chip selects, leds, keys, reset signals, ..). It's
> very handy that we nowadays have generic drivers that work with any
> GPIO (being SoC gpios or stuff on spi/i2c).

For what it's worth, I think it could be useful to have an optimally
fast gpiolib driver.  This would let you have truly generic bit-bang
drivers.  Take a look at drivers/spi for example -- there's ~7 bit-bang
drivers in there that use spi_bitbang.c for a library of functions.  I
am not familiar with these drivers, but at a glance it seems feasible
that with fast gpiolib implementations you could reduce all of those to
a single spi_bitbang.c driver.

Trent, it looks like the big performance wins for you were obtained by
deviating from the gpiolib interface?  In that case a generic SPI/JTAG
bit bang driver wouldn't benefit from the speed boosts in your MPC8572
GPIO driver (without explicitly calling mpc8572_gpio_lock and
_mpc8572_gpio_set, etc).  Is that correct?  In any case, I appreciate
what you did with your driver, so please don't give up on getting some
of your bits merged in :)

-- 
Nate Case <ncase@xes-inc.com>
