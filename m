Return-Path: <stefan.nickl@kontron.com>
Received: from KOM-MAILSRV1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 6E6D768557
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 21:10:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 11 Oct 2005 12:57:59 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E73A8EF@kom-mailsrv1.kontron-modular.com>
From: "Stefan Nickl" <stefan.nickl@kontron.com>
To: "Gerhard Jaeger" <g.jaeger@sysgo.com>
Cc: Stefan Nickl <stefan.nickl@kontron.com>, linuxppc-embedded@ozlabs.org
Subject: RE: Which PHY connection to use on MPC8541...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

about a year ago we resorted to using port pin MDIO in this situation
for the FCCs because the fcc_enet driver and the gianfar driver live
in separate worlds, so to speak.

But in the meantime, Andy Fleming was very active regarding the PHY
abstraction layer. I still haven't seen patches that migrate fcc_enet
to using this layer, but the gianfar driver seems to use this code now.

So I'd say quick solution: use TSEC1 MDIO for TSECs and cpm port pins
for FCC, clean solution: change fcc_enet to use the PHY abstraction
layer.

--=20
Stefan Nickl
Kontron Modular Computers


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Gerhard Jaeger
> Sent: Tuesday, October 11, 2005 12:14 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Which PHY connection to use on MPC8541...
>=20
> Hi list,
>=20
> we're currently designing a custon MPC8541 based board having=20
> three ethernet connections.
> For some reasons, we'd like to use the FCC1 and 2 + TSEC1.=20
> From what I see from the docs, it should be no problem to=20
> connect i.e. a quad phy (for FCC1/2) and a gigabit phy (for=20
> TSEC1) to the EC_MDIO of the TSEC as long as they have=20
> different addresses.=20
> I don't want to use the GPIO stuff for MDIO.
>=20
> The question is, what does this mean to the drivers? For the=20
> gianfar driver this should be okay and from what I see, the=20
> upcoming fs_enet driver supports also a phy connected either=20
> to the GPIOs (bitbanging) or the TSEC MDIO. Is this right, or=20
> am I missing something essential?=20
> Would it be better to use the GPIO-MDIO for the FCC phy and=20
> the TSEC-MDIO for the TSEC phy?
>=20
> TIA
> Gerhard
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
