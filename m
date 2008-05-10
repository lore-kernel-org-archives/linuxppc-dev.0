Return-Path: <michael@ellerman.id.au>
Subject: Re: MPC5200b external interrupt registration problem
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080509190218.GA32008@ld0162-tx32.am.freescale.net>
References: <169407.5661.qm@web88102.mail.re2.yahoo.com>
	<20080509190218.GA32008@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nJAw3Vq71a6xc9X9C2DX"
Date: Sat, 10 May 2008 17:30:51 +1000
Message-Id: <1210404651.22483.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nJAw3Vq71a6xc9X9C2DX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-09 at 14:02 -0500, Scott Wood wrote:
> On Fri, May 09, 2008 at 02:49:04PM -0400, Nick wrote:
> > I am writing a driver to service an interrupt from our fpga.  I am call=
ing request_irq in the open
> > function of my driver.  The fpga is connected to external interrupt 1. =
 I am using interrupt
> > number 65 in the request_irq but the function is failing.
>=20
> request_irq takes a virtual IRQ number, not a hardware IRQ number.  You
> need to get the virtual IRQ number from irq_of_parse_and_map(), or from
> irq_create_mapping().
>=20
> This would probably confuse far fewer people if we used pointers in the
> API rather than virtual IRQ numbers...

I'll do the core changes if you fix all the drivers .. ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nJAw3Vq71a6xc9X9C2DX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIJU8rdSjSd0sB4dIRAu+2AKCvy9x2TAwDksmO8LAq7btl2wlc8gCcDjj6
cx0VXUIKL4ns7FtFGnFp9rs=
=N0vi
-----END PGP SIGNATURE-----

--=-nJAw3Vq71a6xc9X9C2DX--
