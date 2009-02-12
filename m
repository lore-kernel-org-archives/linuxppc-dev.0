Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 6306DDDDB9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 00:03:41 +1100 (EST)
Date: Thu, 12 Feb 2009 14:00:26 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net
Subject: SPI-Difference between MX1 and MX31
Message-ID: <20090212130026.GC3130@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Cc: linuxppc-dev@ozlabs.org, a.paterniani@swapp-eng.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

while working on a generic SPI-driver for the i.MX-platform I stumbled
over the following:

The MX1 can flush its FIFOs using the enable bit. Documentation says:

"SPI Module Enable - Enables/Disables the serial peripheral interface.
SPIEN must be asserted before an exchange is initiated. Writing 0 to
SPIEN flushes the receive and transmit FIFOs."

Furthermore it has a dedicated reset register:

"Start - Executes soft reset."

However, the MX31 does not have a reset register and the documentation
says this regarding the enable bit:

"SPI Module Enable Control - This bit enables the CSPI. This bit must be
asserted before writing to other registers or initiating an exchange.
Writing zero to this bit disables the module and resets the internal
logic with the exception of the CONREG. The module=E2=80=99s internal clock=
s are
gated off whenever the module is disabled."

So, as I read all this, disabling the enable bit on the MX31 is more
like a soft reset on MX1, right? And there does not seem to be a way to
flush the FIFOs. Can someone imagine what problems might arise if there
is no way to flush the FIFOs? At least, the check for XCH should have
ensured that the TXFIFO is empty...

Looking forward to feedback :)

Regards,

   Wolfram Sang

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUHWoACgkQD27XaX1/VRsk3QCfaosmwPRc8boDwJ0ZF3SE1b/8
BvgAoJbuYSMM0Tqbq/h7hnXEwUAzublA
=aWZH
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
