Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AFC6B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Jul 2010 02:18:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o69GID7O001546 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 9 Jul 2010 09:18:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o69GU9Wn016595
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 9 Jul 2010 11:30:09 -0500 (CDT)
Date: Fri, 9 Jul 2010 11:18:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Message-ID: <20100709111811.4e239e4b@schlenkerla.am.freescale.net>
In-Reply-To: <E0D806F7-A109-4AAF-9899-429659E2C3D9@kernel.crashing.org>
References: <1278614421.1801.0@antares>
	<DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
	<20100708150904.79feffdd@schlenkerla.am.freescale.net>
	<E0D806F7-A109-4AAF-9899-429659E2C3D9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Albrecht =?ISO-8859-1?B?RHJl3w==?= <albrecht.dress@arcor.de>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 9 Jul 2010 14:59:09 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >>> Actually, this is something which might need closer attention -
> >>> and maybe some support in the device tree indicating which read or
> >>> write width a device can accept?
> >>
> >> There already is "device-width"; the drivers never should use any
> >> other access width unless they *know* that will work.
> >
> > Wouldn't you want to use "bank-width" instead?
> 
> We were talking about single devices.  But, sure, when you have
> multiple devices in parallel the driver needs to know about that.
> 
> > It would be nice to have a device tree property that can specify
> > that all access widths supported by the CPU will work, though.
> 
> Oh please no.  A device binding should not depend on what CPU there
> is in the system.  There could be multiple CPUs of different
> architectures, even.

What I meant by that was that the flash interface was claiming that it
is not the limiting factor in which access widths are useable -- it
would be a way to claim that it is as flexible as ordinary memory in
that regard.

If there is a transaction size that is capable of being presented to
this component that it cannot handle, it would not present this
property.

> To figure out how to access a device, the driver looks at the device's
> node, and all its parent nodes (or asks generic code to do that, or
> platform code).

"looks" or "should look"? :-)

If there are transaction sizes supported by the CPU that won't work
with a given device through no fault of that device (or the interface
to that device for which we don't have a separate node), then in
theory, yes, it should be described at a higher level.

In reality, device tree parsing code is not AI, so rather than say "the
driver looks at this and figures it out" it would be better to provide
a more specific proposal of how a device tree might express this and
what the driver would look for, if you think the simple solution is
not expressive enough.

-Scott
