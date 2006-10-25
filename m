Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id DAD6867BEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 22:47:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
Date: Wed, 25 Oct 2006 14:47:33 +0200
Message-ID: <CAB1644F1C94A24BAC68B05D0F9774635CC913@VIECLEX01.frequentis.frq>
In-Reply-To: <95309226-07A8-43E0-A03B-7D7E828D4429@freescale.com>
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


andy, dan, thanks for your replies!=20

> Look at the driver in drivers/net/phy/fixed.c.

i did that w/o luck. the results are 100% the same compared to the
'remove phy/mdio support' approach. i therefore assume that the source
of the problem must be something else.

debugging around gfar_start_xmit() i made the following observations:

1) dumping skb->data i see correct frame data.

2) dumping txbdp->bufPtr (using a bdi) i sometimes see correct frame =
data,
sometimes the corrupted frame data as i see it on the wire.

3) regardless of 2) the data of these frames is always corrupted on the=20
wire.

on the 1st look this seems to be some kind of caching effect, but then =
...

thanks
-h

> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com]=20
> Sent: Dienstag, 24. Oktober 2006 20:15
> To: KRONSTORFER Horst
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
>=20
> Look at the driver in drivers/net/phy/fixed.c.  It probably=20
> needs some documentation, and Vitaly implied it needed a=20
> little tweaking, but it provides the basics of what you need=20
> (and what Dan mentioned).  Essentially, you need to fake the=20
> PHY.  However, if you wanted, you could also get smarter and=20
> write a new mdiobus driver, which handles configuring and=20
> using the switch.
>=20
> I'm not quite sure why your approach isn't working, but I=20
> agree with Dan's suspicions that removing the PHY code=20
> doesn't just work.
>=20
> One thing to check is the adjust_link() function.  You need=20
> to make sure that you have the carrier on, and that the MAC=20
> is set to MII mode, rather than GMII mode.
>=20
> Andy
>=20
> On Oct 24, 2006, at 04:16, KRONSTORFER Horst wrote:
>=20
> > hi!
> >
> > in our design we use an mpc8343 with the 2 tsecs connected to a=20
> > zarlink zl50411 eth switch in mii mode. the 2 ports of the=20
> switch are=20
> > running in phy mode (reverse mii) w/o mdio. we're currently running=20
> > kernel 2.6.17.13.
> >
> > i therefore 'simply' removed the mdio bus and phy support=20
> and tested=20
> > with ping over tsec0. result: i can see arp requests which=20
> are some-=20
> > what malformed (dest mac addr is not bcast, source ip addr is=20
> > incorrect, etc ...) btw: i used the same approach in u-boot and it=20
> > works fine.
> >
> > i then checked the content of the sk_buff handed over to=20
> > gfar_start_xmit which is correct (mac addrs, ip addrs, ...)
> >
> > i'm currently out of ideas, any kind of help is appreciated!
> >
> > thanks
> > -h
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
