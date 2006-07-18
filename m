Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9086267B83
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 17:40:34 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6I8w7bI017496
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 02:58:07 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6I7eUfK017467
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 02:40:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add USB to MPC8349 PB platform support
Date: Tue, 18 Jul 2006 15:40:51 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0509EB@zch01exm20.fsl.freescale.net>
In-Reply-To: <71D808D5-8227-4B0D-AF41-FADFC4B12463@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Dan Malek" <dan@embeddedalley.com>
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
> Sent: Tuesday, July 18, 2006 5:39 AM
> To: Dan Malek
> Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org;
linux-usb-devel@lists.sourceforge.net
> Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
>=20
>=20
> On Jul 17, 2006, at 3:17 PM, Dan Malek wrote:
>=20
> >
> > On Jul 17, 2006, at 3:16 PM, Kumar Gala wrote:
> >
> >> I disagree.  You are coming from this from a board that does
> >> everything under the sun.  I'd like to avoid having this type of
> >> initialization in the kernel.  There is a whole additional kitchen
> >> sink that could move into the kernel as well.
> >
> > Well, I'm going to have to disagree with your disagreement :-)
> > The kernel should not assume things are properly initialized
> > and rely on the boot rom to do such things.  I have several
> > reasons for this.  One is that we are always pressed to make
> > embedded systems boot more quickly, and taking time to
> > initialize things in the boot rom just makes that a totally
> > inflexible system design.  We don't need to initialize things
> > we don't use, or can postpone until later.  Two, it makes
> > us dependent upon a particular boot rom, or boot rom
> > behavior, that not all boards may choose to support.
> > Three, board designs may have external logic that requires
> > a certain start up sequence or control register access
> > that complicates the boot rom in it's ability to share
> > code or implementation.
>=20
> Well, I think there is a coupling that exists between whatever your
> boot rom is and the kernel.  If you are trying to optimize boot time
> I'd say one thing you would want is to avoid multiple writing the
> same configuration registers.
>=20
> I dont have an issue if a fixed function board decides to do these
> things in their kernel init instead of their boot rom.  I however,
> don't want thousand and one config options to support all the various
> ways one can configure the Freescale board.

We won't have the thousand and one config options, making use of the
device
tree.  So this is not a problem.
>=20
> > There are more, but I think you see the trend.  In my
> > years of doing this kind of development, you can't
> > assume a boot rom is going to do much more than initialize
> > memory and load the kernel.  I prefer the flexibility
> > to be in the kernel, and not in the boot rom, because it
> > is so much easier to develop and control.
>=20
> - kumar
