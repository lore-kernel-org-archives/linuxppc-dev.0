Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBCCEDDEFE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:36:48 +1000 (EST)
In-Reply-To: <4662E7EA.70506@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 19:36:38 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If it's a flash, compatible should be the chip type, and maybe as a
>> second entry, what type of flash protocol (amd, intel, cfi, ...) it's
>> compatible.
>
>     As I've already (and repatedly) stated before,

And you repeatedly got answers too, yet you choose
to rehash this whole discussion again.

> this gets you *nothing* WRT
> selecting the proper driver in the current Linux MTD subsystem.

Which Linux driver to use is not something that should
be (directly) communicated in a device tree -- even if
you take the position the device tree is a nice big
configuration file for Linux, what if a new Linux flash
subsystem shows up (or even simply a driver got renamed,
etc.) -- the device tree on your board doesn't necessarily
change when your kernel version does.

> What it
> actually *needs* to know is flash mapping information,

It needs to know what kind of flash it is, and how it
is connected -- i.e., it needs to describe the hardware.
How Linux then decides to use it is its own game, but
at least the device tree puts all the information it
could possibly need out there.

> the CFI/JEDEC interface
> then can be deduced by probing

Most of the time, sure.  Not always.

> -- so, this property ("ptobe-type"), although 
> specified in Documentation/powerpc/booting-without-of.txt, is optional.

Who is talking about "probe-type"?  We are talking
about "compatible".


Segher
