Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id ABE4667BAB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 16:30:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k6J6UJmB020833
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:30:19 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6J6UH8q024492
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 01:30:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add USB to MPC8349 PB platform support
Date: Wed, 19 Jul 2006 14:30:38 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
In-Reply-To: <41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, July 18, 2006 9:53 PM
> To: Li Yang-r58472
> Cc: Dan Malek; linuxppc-dev@ozlabs.org;
linux-usb-devel@lists.sourceforge.net
> Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
>=20
> [snip]
>=20
> >> Well, I think there is a coupling that exists between whatever your
> >> boot rom is and the kernel.  If you are trying to optimize boot
time
> >> I'd say one thing you would want is to avoid multiple writing the
> >> same configuration registers.
> >>
> >> I dont have an issue if a fixed function board decides to do these
> >> things in their kernel init instead of their boot rom.  I however,
> >> don't want thousand and one config options to support all the
various
> >> ways one can configure the Freescale board.
> >
> > We won't have the thousand and one config options, making use of the
> > device
> > tree.  So this is not a problem.
>=20
> I'm talking about opening the door to a ton of options, not that we
> have them now.  For example, your patch doesnt handle the USB PHYs if
> they are on the MDS instead of the SYS board.  It doesn't handle
> setting SCCR properly for different frequency choices.  I'm concerned
> about where to draw the line because of all the ways a user can
> configure the MDS board.

My understanding is that in embedded world only this kind of versatile
development boards needs to have Linux port in mainstream kernel.  A
fixed function customer board used in embedded product will never get
into kernel source.

The reasons for Freescale to provide this kind of boards are: first,
verify functions on chip; second, demonstrate chip functions to
customer; third, validate customer application on reference board;
forth, help customer to build their own product by cutting down the
board and software.

Doing that, we do need some configure options to demonstrate main
functions.  But there won't be too many options to confuse the user.
Only key working modes are needed.  In your example, I think making USB
PHYs configurable for MDS is reasonable, but for SCCR it isn't as it is
well commented in code and is not likely to be modified.  Keep in mind
that our only purpose is making customers easier and faster in
developing their own products.
>=20
> - kumar
