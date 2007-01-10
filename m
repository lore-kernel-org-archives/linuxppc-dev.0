Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 588FBDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 00:13:20 +1100 (EST)
Date: Wed, 10 Jan 2007 16:11:45 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: bwarren@qstreams.com
Subject: Re: Using fixed_phy with gianfar
Message-ID: <20070110161145.3d8b0c77@localhost.localdomain>
In-Reply-To: <1168385038.3964.44.camel@saruman.qstreams.net>
References: <1168385038.3964.44.camel@saruman.qstreams.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_J.xSU+_IJnIbe2vjjL6Oqp4;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
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

--Sig_J.xSU+_IJnIbe2vjjL6Oqp4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jan 2007 18:23:58 -0500
Ben Warren wrote:

> Hello,
>=20
> My custom board has a couple of Ethernet switches attached via RvMII
> to the 'Gianfar' controllers of an MPC8349 CPU.  We're using SPI
> instead of MDIO for control of the switches, and it looked like the
> 'fixed.c' PHY driver was the right thing to use.  BTW, I'm using a
> 2.6.19 kernel.
>=20
> When I 'ifconfig up' one of the interfaces, the Gianfar driver tries
> to find a device on the MDIO bus of the variety bus_id:phy_id, where
> both bus_id and phy_id are numeric (defined in fsl_devices.h).  The
> Fixed PHY driver creates devices on the MDIO bus with a bus_id that
> is a string, for example "fixed_1@100:1".  Obviously, these will
> never match up.  The very crude hack I made to get things working was
> to modify the Gianfar driver to match the "fixed" string. =20
>=20
> I'm sure I'm missing something, and am wondering what the correct way
> to do this is.  Should I have board-specific code that creates PHY
> devices conforming to the Gianfar expectations instead of calling
> 'fixed_mdio_register_device()', or something else?
No, you do not miss - this is an issue. In fact MDIO bus was changed for nu=
meric for gianfar-stuff, and has been remaining string for fs_enet. I think=
 it makes sense to average this up, and will try to do that once will get 8=
349-mitx which is gianfar+ fixed user.

The point is that fixed should be updated to numeric MDIO address encoding.=
 This has to come through netdev, so I'll try to get it fixed by the next m=
erge window.

--
Sincerely, Vitaly

--Sig_J.xSU+_IJnIbe2vjjL6Oqp4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpOYSuOg9JvQhSEsRAhnBAJ9Ty3j/wnrDKRZGjBThPzV4ARTX/QCfQa3V
f4qVepR68aLsoRN+EkGhVuY=
=gtCf
-----END PGP SIGNATURE-----

--Sig_J.xSU+_IJnIbe2vjjL6Oqp4--
