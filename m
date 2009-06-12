Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC2E3B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 10:37:14 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 00569DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 10:37:13 +1000 (EST)
Date: Fri, 12 Jun 2009 04:37:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PWM class? (was: Re: MPC52xx simple GPIO support)
Message-ID: <20090612003701.GA9496@oksana.dev.rtsoft.ru>
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
	<4A266FB2.2040902@gersys.de>
	<20090603132217.GA18353@oksana.dev.rtsoft.ru>
	<fa686aa40906111500w1760290bm890f3ee132500b1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40906111500w1760290bm890f3ee132500b1d@mail.gmail.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Stefan Strobl <nst@gersys.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 04:00:51PM -0600, Grant Likely wrote:
> On Wed, Jun 3, 2009 at 7:22 AM, Anton Vorontsov<avorontsov@ru.mvista.com> wrote:
> > On Wed, Jun 03, 2009 at 02:42:26PM +0200, Stefan Strobl wrote:
> > [...]
> >> The led class provides support for setting the brightness, which
> >> obviously the gpio driver doesn't support. The hardware (mpc52xx_gpt)
> >> would support it in PWM mode though. I'm now wandering how this could be
> >> best implemented.
> >>
> >> 1) - Create some PWM class similar to the GPIO class
> >>    - Add support for PWM mode in mpc52xx_gpt.c that uses that PWM class
> >>    - And add an interface for the LED to use the PWM class
> >>
> >> 2) - Create an LED driver that accesses the mpc52xx_gpt directly.
> >>
> >> I think I would be overwhelmed trying to implement (1) but am confident
> >> to do (2). What do you think is the right approach?
> >
> > I'd suggest creating a generic PWM class, i.e. PWMLIB, alike to
> > GPIOLIB. (2) can be an acceptable approach for now, but for the
> > long-term solution (1) is the way to go.
> >
> > The non-lib PWM API is already there, see include/linux/pwm.h,
> > and arch/arm/mach-pxa/pwm.c as an implementation example.
> >
> > Note that PXA implementation is SOC-specific, which is not very
> > good.
> >
> > So I'd suggest creating drivers/pwm/pwmlib.c, borrowing
> > ideas from gpiolib. And then we can reuse drivers/leds/leds-pwm.c
> > driver (of course, after adding appropriate OF code into it).
> 
> Ugh.  The referenced pwm api is about as trivial as it gets; it is an
> anonymous context pointer (anonymous struct pwm_device *) with a set
> of accessor functions.  PWMs are also not nearly as common as GPIO
> pins, and I am not interested in gpiolib being duplicated for PWMs, at
> least not until there are more that just two examples of use to draw
> from.

I didn't say that we should duplicate gpiolib. I said that we
might borrow some ideas. ;-)

> If anything, I'd rather struct pwm_device be non-anonymous and contain
> a set of ops which call directly into the driver.  That way is at
> least multiplatform friendly.  I don't think the gpio API is the
> example to follow here.  But even then I think it is premature to try
> and define a PWM api.  Personally, I'd modify mpc52xx_gpt to export
> its own PWM interface for the time being using the existing GPIO
> infrastructure to find the appropriate pin.

Jon Smirl found that there were already some efforts put
into making generic PWM class:

http://thread.gmane.org/gmane.linux.kernel.embedded/1160

Briefly looking, the class is pretty cool. Somebody should just
continue this work.

> If you do decide to do a generic PWM api, then I think the way to go
> is to build it as an extension to gpiolib.

I don't think David Brownell will like this idea. But
who knows... maybe.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
