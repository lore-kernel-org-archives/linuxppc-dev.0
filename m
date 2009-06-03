Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E1431DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 23:22:18 +1000 (EST)
Date: Wed, 3 Jun 2009 17:22:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Strobl <nst@gersys.de>
Subject: PWM class? (was: Re: MPC52xx simple GPIO support)
Message-ID: <20090603132217.GA18353@oksana.dev.rtsoft.ru>
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
	<4A266FB2.2040902@gersys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4A266FB2.2040902@gersys.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2009 at 02:42:26PM +0200, Stefan Strobl wrote:
[...]
> The led class provides support for setting the brightness, which
> obviously the gpio driver doesn't support. The hardware (mpc52xx_gpt)
> would support it in PWM mode though. I'm now wandering how this could be
> best implemented.
> 
> 1) - Create some PWM class similar to the GPIO class
>    - Add support for PWM mode in mpc52xx_gpt.c that uses that PWM class
>    - And add an interface for the LED to use the PWM class
> 
> 2) - Create an LED driver that accesses the mpc52xx_gpt directly.
> 
> I think I would be overwhelmed trying to implement (1) but am confident
> to do (2). What do you think is the right approach?

I'd suggest creating a generic PWM class, i.e. PWMLIB, alike to
GPIOLIB. (2) can be an acceptable approach for now, but for the
long-term solution (1) is the way to go.

The non-lib PWM API is already there, see include/linux/pwm.h,
and arch/arm/mach-pxa/pwm.c as an implementation example.

Note that PXA implementation is SOC-specific, which is not very
good.

So I'd suggest creating drivers/pwm/pwmlib.c, borrowing
ideas from gpiolib. And then we can reuse drivers/leds/leds-pwm.c
driver (of course, after adding appropriate OF code into it).

Sure, as you've said, it could be quite boringly to implement,
could take quite some time to pass all review cycles etc.
But someday someone will have to do this. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
