Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B676B71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 08:01:13 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id EE352DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 08:01:12 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so816742ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 15:01:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090603132217.GA18353@oksana.dev.rtsoft.ru>
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
	<4A266FB2.2040902@gersys.de>
	<20090603132217.GA18353@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 16:00:51 -0600
Message-ID: <fa686aa40906111500w1760290bm890f3ee132500b1d@mail.gmail.com>
Subject: Re: PWM class? (was: Re: MPC52xx simple GPIO support)
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Stefan Strobl <nst@gersys.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 3, 2009 at 7:22 AM, Anton Vorontsov<avorontsov@ru.mvista.com> w=
rote:
> On Wed, Jun 03, 2009 at 02:42:26PM +0200, Stefan Strobl wrote:
> [...]
>> The led class provides support for setting the brightness, which
>> obviously the gpio driver doesn't support. The hardware (mpc52xx_gpt)
>> would support it in PWM mode though. I'm now wandering how this could be
>> best implemented.
>>
>> 1) - Create some PWM class similar to the GPIO class
>> =A0 =A0- Add support for PWM mode in mpc52xx_gpt.c that uses that PWM cl=
ass
>> =A0 =A0- And add an interface for the LED to use the PWM class
>>
>> 2) - Create an LED driver that accesses the mpc52xx_gpt directly.
>>
>> I think I would be overwhelmed trying to implement (1) but am confident
>> to do (2). What do you think is the right approach?
>
> I'd suggest creating a generic PWM class, i.e. PWMLIB, alike to
> GPIOLIB. (2) can be an acceptable approach for now, but for the
> long-term solution (1) is the way to go.
>
> The non-lib PWM API is already there, see include/linux/pwm.h,
> and arch/arm/mach-pxa/pwm.c as an implementation example.
>
> Note that PXA implementation is SOC-specific, which is not very
> good.
>
> So I'd suggest creating drivers/pwm/pwmlib.c, borrowing
> ideas from gpiolib. And then we can reuse drivers/leds/leds-pwm.c
> driver (of course, after adding appropriate OF code into it).

Ugh.  The referenced pwm api is about as trivial as it gets; it is an
anonymous context pointer (anonymous struct pwm_device *) with a set
of accessor functions.  PWMs are also not nearly as common as GPIO
pins, and I am not interested in gpiolib being duplicated for PWMs, at
least not until there are more that just two examples of use to draw
from.

If anything, I'd rather struct pwm_device be non-anonymous and contain
a set of ops which call directly into the driver.  That way is at
least multiplatform friendly.  I don't think the gpio API is the
example to follow here.  But even then I think it is premature to try
and define a PWM api.  Personally, I'd modify mpc52xx_gpt to export
its own PWM interface for the time being using the existing GPIO
infrastructure to find the appropriate pin.

If you do decide to do a generic PWM api, then I think the way to go
is to build it as an extension to gpiolib.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
