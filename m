Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A167CDE0A0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 07:52:01 +1000 (EST)
In-Reply-To: <fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
	<fa686aa40804081426u2c2a530ej8ecb6ce9f8fb49a0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29c98f1cd48092a67f9c7e431063e656@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Question on mpc52xx_common.c
Date: Tue, 8 Apr 2008 23:51:54 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I disagree and that is not my point.  My point is that perfection is
> neither obtainable or necessary.

It's a nice goal though.

> Many of the recently established
> embedded guidelines are not "perfect" because they are counter to a
> few of the OF recommended practices.  However, they are consistent
> within themselves, they work, and once established they are not going
> to change.

Yeah.  Which is good, even if the bindings themselves aren't
so good.

> Now, if out-of-tree ports continue to break then we've got a problem
> that needs to be fixed.  Once a binding is established (which usually
> takes a few kernel releases)

This is a big problem that is totally avoidable.

*Before* accepting any patches that use a new binding (including
patches to .dts files), that binding itself needs to be discussed.
This will be a lot less work than trying to see what's going on in
some platform/device code and/or some example device tree, and
spotting mistakes there.  It might be a little more work upfront,
and it might seem like it would increase lead time, but as usual,
it's worth it.

Let's flat out refuse any patch series that uses a non-documented
binding.

> it should be very stable and even if the
> definition of ideal is changed, backwards compatibility must be
> maintained.

Which is a good argument why getting it right the first time is
so important (as with all interfaces, nothing specific about
device trees here).

>>  The ARM method of using just a device number is so much easier ...
>
> Only if the assumption is made that very little data needs to be
> shared between the kernel and the firmware.

...which means the kernel has to know *everything* about the hardware
setup and/or what settings the firmware established; i.e., the kernel
has to 100% replace the firmware.  This can be nice for some use cases
(it's the route LinuxBIOS took originally), but it simply doesn't
scale, not in any dimension.


Segher
