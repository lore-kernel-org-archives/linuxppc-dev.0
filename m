Return-Path: <Heinz.Wrobel@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93FB3DE1BC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 00:40:43 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3OEecIV008447
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 07:40:38 -0700 (MST)
Received: from zuk35exm20.fsl.freescale.net (zuk35exm20.ea.freescale.net
	[10.210.1.54])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3OEeaDI021911
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 09:40:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: removing get_immrbase()??
Date: Fri, 24 Apr 2009 15:40:34 +0100
Message-ID: <AAE514D00E55E6438B7F5186462A54520226355D@zuk35exm20.fsl.freescale.net>
In-Reply-To: <76E4F93E-F75F-4CDC-A281-F4703275BEC1@kernel.crashing.org>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org><ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com><49EF7B11.2000006@freescale.com>
	<49EF7B1C.2080105@freescale.com><282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org><49EF8E3A.4060304@freescale.com><5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org><20090423022610.GA19376@yookeroo.seuss><49F066DC.402@freescale.com><20090423135005.GA18462@oksana.dev.rtsoft.ru><49F07509.8030603@freescale.com>
	<76E4F93E-F75F-4CDC-A281-F4703275BEC1@kernel.crashing.org>
From: "Wrobel Heinz-R39252" <Heinz.Wrobel@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Tabi Timur-B04825" <timur@freescale.com>
Cc: Wood Scott-B07421 <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > We've run into plenty of situations where customers will update the=20
> > kernel, but insist that U-Boot and the device tree remain unchanged.
>=20
> when?  I'm not aware of any significant # of cases that=20
> customer is willing to update kernel & not dts.  Usually if=20
> they are willing to update kernel they tend to be willing to=20
> update everything.

I recently fried a U-Boot flash on a machine at home when upgrading and
the machine sits there and is dead of course. Luckily that machine
doesn't have to be up 24x7, so I can wait until I have time to fix the
situation ... and I can either pull the socketed flash or hook up a JTAG
debugger.

But Freescale or other eval(!) boards or isolated Power Architecture
based home use machines like my fried one should not be a reference for
this kind of discussion.

I see a very common scenario with Telecom/Networking customers. They
have a boot flash with firmware and basic startup/BIST SW which they do
not really ever want to touch at all even if they should after it
shipped. If a remote upgrade on just a few out of <n> installed systems
fails, they can send technicians to Mars to pull the board(s), and
service guarantees, and profit, are out the window then. That makes
U-Boot and/or subsequent ultra-low-level startup/BIST SW from the same
boot source *very* firm. If a device-tree is served from there for
whichever reason, then you have a *very* firm device-tree, too.

Then these customers either have a second flash with a filesystem or
more volatile images in the sense that they see that other flash as
upgradable (if they have to), or a physical link to some remote fs that
serves them the kernel and application load. They still do not like
upgrades too much as any upgrade can have service impact. But they do
them when necessary because they know they have a way to revert to
previous or fixed releases remotely as they can always depend on the
original boot loader to be there.

It would not be smart to prohibit any change ever, but we also shouldn't
cause device-tree changes a lot just because we felt like it today. Both
seems a bit extreme.

There must be some middle ground, err'ing towards the conservative side.
A change affecting "lower" levels than the kernel should be very well
thought through, and if it is necessary, we should strive to keep
compatibility to a level that makes sense and possibly eases a
transition over some time.

If a few clearly marked code lines (with a possibly marked planned max
lifetime) ease compatibility and transition, they should be considered.

Hope this helps

Heinz
