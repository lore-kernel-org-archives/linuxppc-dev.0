Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 31C47B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 14:48:02 +1000 (EST)
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 71DA3DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 14:47:59 +1000 (EST)
Received: by yxe33 with SMTP id 33so7130856yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Aug 2009 21:47:57 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1249325206.3404.1@antares>
References: <fa686aa40908031050g2d03abb5s9dfe4dceb2072af6@mail.gmail.com>
	<1249325206.3404.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 4 Aug 2009 22:47:37 -0600
Message-ID: <fa686aa40908042147l1a270a37s154fb752b1c3a1a6@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx/wdt: Fix 5200 wdt always being used as
	gpt
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 3, 2009 at 12:46 PM, Albrecht Dre=DF<albrecht.dress@arcor.de> w=
rote:
> Am 03.08.09 19:50 schrieb(en) Grant Likely:
>>
>> Just about all mpc5200 device trees have the fsl,has-wdt property on GPT=
0
>> even when it isn't used as a watchdog.
>
> Sorry, I do not understand... =A0The file
> Documentation/powerpc/dts-bindings/fsl/mpc5200.txt says
>
> <snip>
> On the mpc5200 and 5200b, GPT0 has a watchdog timer function. =A0If the b=
oard
> design supports the internal wdt, then the device node for GPT0 should
> include the empty property 'fsl,has-wdt'.
> </snip>
>
> I interpreted this as "if you don't want to have the wdt function of gpt0=
,
> remove this property". =A0If this assumption is wrong, how is the kernel
> supposed to decide if a device shall be used as gpt or as wdt?

That just states whether or not the functionality is there.  In fact,
the device can be used as both a WDT and a GPIO pin at the same time.

The kernel should decide how to use it based on what userspace asks it
to do.  If the WDT interface is opened, then it should be used as a
WDT.  If the GPIO interface is opened, then it should be used as a
GPIO (and not disturb the WDT settings).  If the gpt timer API is
called (not yet merged), then it should be used as a timer; but only
if it hasn't already been set up as a WDT.

>
>> The boards using GPT0 as a GPIO or timer will be broken by this patch.
>
> A wdt is a security device which will (IMHO) either not be used as such, =
or
> it is a *must not* be used for something else on a particular board (you =
may
> even want u-boot to activate it, e.g. to detect a hanging boot process). =
=A0In
> both cases, a "tuned" device tree is needed.

There is no property in the current binding that provides that data to
the kernel.  It works for it to be implicit based on how userspace
accesses the device, but if you want added assurance to ensure that
nothing else can use the WDT then you can define a new property to
state that explicitly and inhibit other uses.  That way no older
boards remain broken regardless of how they currently use GPT0

In fact, it probably makes sense to have a property to describe a
timeout value to preload into the WDT at boot time, or respect a
watchdog value already initialized by firmware (so that even if
userspace fails to start the watchdog daemon, the system will still
get reset).

>> I know it is a lot more work, but the correct solution is to merge the G=
PT
>> watchdog driver into the regular GPT driver so that we don't have two de=
vice
>> drivers trying to bind against the same device.
>
> I see the benefit of removing some duplicate code and of having gpio acce=
ss
> in parallel with the wdt, but it wouldn't solve the general confusion abo=
ve!
> =A0Will look into that, though...

I took a look at the code this evening, and it actually shouldn't be
too difficult to rework.  Most of the work would be relocating the
functions in the wdt driver into the gpt driver and wiring it into the
GPT probe/remove functions.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
