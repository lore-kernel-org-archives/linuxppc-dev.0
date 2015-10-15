Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id D86B81A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 18:11:48 +1100 (AEDT)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "scottwood@freescale.com" <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: devicetree and IRQ7 mapping for T1042(mpic)
Date: Thu, 15 Oct 2015 07:11:43 +0000
Message-ID: <1444893103.28972.68.camel@transmode.se>
References: <1444851451.28972.59.camel@transmode.se>
 <1444867898.5185.213.camel@freescale.com>
In-Reply-To: <1444867898.5185.213.camel@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-14 at 19:11 -0500, Scott Wood wrote:
> On Wed, 2015-10-14 at 19:37 +0000, Joakim Tjernlund wrote:
> > I am trying to figure out how to describe/map external IRQ7 in the=20
> > devicetree.
> >=20
> > Basically either IRQ7 to be left alone by Linux(becase u-boot already s=
et=20
> > it up)
> > or map IRQ7 to sie 0(MPIC_EILR7=3D0xf0) and prio=3D0xf(MPIC_EIVPR7=3D0x=
4f0000)
> >=20
> > There is no need for SW handler because IRQ7 will be routed to the DDR=
=20
> > controller
> > and case an automatic Self Refresh just before CPU reset.
> >=20
> > I cannot figure out how to do this. Any ideas?
> >=20
> > If not possible from devicetree, then can one do it from board code?
>=20
> The device tree describes the hardware.  Priority is configuration, and t=
hus=20
> doesn't belong there.  You can call mpic_irq_set_priority() from board co=
de.

Right.

>=20
> Likewise, the fact that you want to route irq7 to sie0 is configuration, =
not=20
> hardware description.  At most, the device tree should describe is what i=
s=20
> connected to each sie output.  There's no current Linux support for routi=
ng=20
> an interrupt to sie or anything other than "int".

That explains why I could not find any mpic function for that ..

I found mpic dev. trees property "protected-sources" which might do what I =
want, just
leave the the irq alone but I cannot figure out what value to write there.
Could you give me any example how to calculate dev. tree irq number for IRQ=
7?

The mpic.txt mentions "Interrupt Source Configuration Registers" but google=
 did
not turn up anything useful for me.

 Jocke=
