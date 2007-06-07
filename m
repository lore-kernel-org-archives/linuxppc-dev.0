Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84FF4DDED7
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:49:18 +1000 (EST)
In-Reply-To: <1181228038.2785.54.camel@pmac.infradead.org>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
	<1180904670.31677.18.camel@localhost.localdomain>
	<1181228038.2785.54.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12ed5ad1cec125816d475094f39fe2b5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 7 Jun 2007 17:49:12 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Put the proper interface informations in the device-tree, maybe some 
>> OS
>> smarter than linux will make good use on it and maybe linux will be
>> fixed at one point too (not by you, of course, you gave us that line
>> often enough about not being paid to do the right thing).
>
> In general, Linux is doing the right thing by probing.

Compare to PCI.  After Linux has found out how to
drive a PHB from the device tree, it can detect the
whole PCI tree on its own.  The device tree can still
be used to find out special things about the devices
(interrupt routing, ...) or to change some of the
probing algorithm (in the case of hardware bugs, for
example).

Now with NOR flash, the situation is analogue.  The
device tree tells Linux how to drive the flash bus
controller, and certain things about that bus (width,
for example).  It also should tell Linux what kind
of devices are on that bus (CFI, ...).  Linux can
do its own probes then, or it can use the device tree
for special cases.

> There are two major command sets for NOR flash -- the Intel/Sharp
> command set, and the AMD/Fujitsu command set.
>
> There are also two major ways to detect flash chips -- the JEDEC probe
> with magic numbers for mfr/chip ident,

A heuristic, but it's been worked out well enough over
the years that it is pretty reliable now.

> and the CFI ('Common Flash
> Interface') probe which gets you tables of information about the chip,
> including what optional command set extensions it has, etc.

But it only is 100% reliable _if_ you already know the
chip is CFI compatible.

> You _can_ bypass the probe and pass straight through to the 'back-end'
> chip driver. But unless you provide the CFI information you won't get 
> to
> use any of the optional chip features (or blacklist some of the
> known-broken features). It doesn't make a lot of sense to try using the
> back-end chip drivers directly. Just go through the normal probe
> process, really.

Just don't do any heuristic probes ("just try if something's
there", etc.) -- using the CFI probe algorithm on a flash
device that the device tree tells you is a CFI device should
be just fine, certainly.

> If you really want to bypass the probe, then I suspect you want the 
> full
> CFI tables to be present in your OF properties.

I never saw how that kind of info is useful for the OS to
have in the device tree -- if the OS can use the device at
all, it can get that info straight from the device easy
enough.


Segher
