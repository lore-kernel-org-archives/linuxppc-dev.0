Return-Path: <jonsmirl@gmail.com>
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193]) by ozlabs.org (Postfix) with ESMTP id 59D04DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 01:45:37 +1000 (EST)
Received: by pzk31 with SMTP id 31so87723pzk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Jun 2009 08:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090603132217.GA18353@oksana.dev.rtsoft.ru>
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
	<4A266FB2.2040902@gersys.de>
	<20090603132217.GA18353@oksana.dev.rtsoft.ru>
Date: Wed, 3 Jun 2009 11:38:35 -0400
Message-ID: <9e4733910906030838o7313c311je3545cd974d3edd5@mail.gmail.com>
Subject: Re: PWM class? (was: Re: MPC52xx simple GPIO support)
From: Jon Smirl <jonsmirl@gmail.com>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Stefan Strobl <nst@gersys.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 3, 2009 at 9:22 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
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

What happened to this one?

http://ozlabs.org/pipermail/linuxppc-dev/2008-October/063562.html


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
>
> Sure, as you've said, it could be quite boringly to implement,
> could take quite some time to pass all review cycles etc.
> But someday someone will have to do this. :-)
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Jon Smirl
jonsmirl@gmail.com
