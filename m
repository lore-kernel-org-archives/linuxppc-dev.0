Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id AD22567CD7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Nov 2006 03:38:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
Date: Fri, 3 Nov 2006 17:38:09 +0100
Message-ID: <CAB1644F1C94A24BAC68B05D0F977463633925@VIECLEX01.frequentis.frq>
In-Reply-To: <CAB1644F1C94A24BAC68B05D0F9774635CC913@VIECLEX01.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: "Andy Fleming" <afleming@freescale.com>,
	"Dan Malek" <dan@embeddedalley.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi!

> on the 1st look this seems to be some kind of caching effect, but then =
...

setting CONFIG_NOT_COHERENT_CACHE=3Dy fixed the problems. what baffles =
me is
that on my
mpc8349emds, which has afaik the same core (e300), =
CONFIG_NOT_COHERENT_CACHE
is _not_
defined and eth comm works fine.

any clues?

thanks
-h

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+hkronsto=3Dfrequentis.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+hkronsto=3Dfrequentis.com@ozla
> bs.org] On Behalf Of KRONSTORFER Horst
> Sent: Mittwoch, 25. Oktober 2006 14:48
> To: Andy Fleming; Dan Malek
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
>=20
>=20
> andy, dan, thanks for your replies!=20
>=20
> > Look at the driver in drivers/net/phy/fixed.c.
>=20
> i did that w/o luck. the results are 100% the same compared=20
> to the 'remove phy/mdio support' approach. i therefore assume=20
> that the source of the problem must be something else.
>=20
> debugging around gfar_start_xmit() i made the following observations:
>=20
> 1) dumping skb->data i see correct frame data.
>=20
> 2) dumping txbdp->bufPtr (using a bdi) i sometimes see=20
> correct frame data, sometimes the corrupted frame data as i=20
> see it on the wire.
>=20
> 3) regardless of 2) the data of these frames is always=20
> corrupted on the wire.
>=20
> on the 1st look this seems to be some kind of caching effect,=20
> but then ...
>=20
> thanks
> -h
>=20
> > -----Original Message-----
> > From: Andy Fleming [mailto:afleming@freescale.com]
> > Sent: Dienstag, 24. Oktober 2006 20:15
> > To: KRONSTORFER Horst
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
> >=20
> > Look at the driver in drivers/net/phy/fixed.c.  It probably=20
> needs some=20
> > documentation, and Vitaly implied it needed a little=20
> tweaking, but it=20
> > provides the basics of what you need (and what Dan mentioned). =20
> > Essentially, you need to fake the PHY.  However, if you wanted, you=20
> > could also get smarter and write a new mdiobus driver,=20
> which handles=20
> > configuring and using the switch.
> >=20
> > I'm not quite sure why your approach isn't working, but I=20
> agree with=20
> > Dan's suspicions that removing the PHY code doesn't just work.
> >=20
> > One thing to check is the adjust_link() function.  You need to make=20
> > sure that you have the carrier on, and that the MAC is set to MII=20
> > mode, rather than GMII mode.
> >=20
> > Andy
> >=20
> > On Oct 24, 2006, at 04:16, KRONSTORFER Horst wrote:
> >=20
> > > hi!
> > >
> > > in our design we use an mpc8343 with the 2 tsecs connected to a=20
> > > zarlink zl50411 eth switch in mii mode. the 2 ports of the
> > switch are
> > > running in phy mode (reverse mii) w/o mdio. we're=20
> currently running=20
> > > kernel 2.6.17.13.
> > >
> > > i therefore 'simply' removed the mdio bus and phy support
> > and tested
> > > with ping over tsec0. result: i can see arp requests which
> > are some-
> > > what malformed (dest mac addr is not bcast, source ip addr is=20
> > > incorrect, etc ...) btw: i used the same approach in=20
> u-boot and it=20
> > > works fine.
> > >
> > > i then checked the content of the sk_buff handed over to=20
> > > gfar_start_xmit which is correct (mac addrs, ip addrs, ...)
> > >
> > > i'm currently out of ideas, any kind of help is appreciated!
> > >
> > > thanks
> > > -h
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
> >=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
