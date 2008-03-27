Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A040CDDFD6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:10:36 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Thu, 27 Mar 2008 10:10:33 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803261220.43039.laurentp@cse-semaphore.com>
	<47EA80ED.1030202@freescale.com>
In-Reply-To: <47EA80ED.1030202@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1268159.VsJLtvUgYu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803271010.33825.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1268159.VsJLtvUgYu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 26 March 2008 17:59, Scott Wood wrote:
> Laurent Pinchart wrote:
> > @@ -138,7 +137,7 @@
> >  				device_type =3D "serial";
> >  				compatible =3D "fsl,mpc8248-smc-uart",
> >  				             "fsl,cpm2-smc-uart";
> > -				reg =3D <0x11a80 0x20 0x1100 0x40>;
> > +				reg =3D <0x11a80 0x20 0x87fc 2>;
> >  				interrupts =3D <4 8>;
> >  				interrupt-parent =3D <&PIC>;
> >  				fsl,cpm-brg =3D <7>;
>=20
> This breaks the bootwrapper console.

And of course I forgot about that :-)

The boot wrapper code doesn't have any dpram allocator. Any objection again=
st=20
using a chunk of dpram at a fixed location ? What about at the beginning of=
=20
the dpram ? The DTS muram node would then exclude a chunk of dpram at offse=
t=20
0x0000 instead of 0x1100.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1268159.VsJLtvUgYu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH62SJ8y9gWxC9vpcRAsCrAKC0znmlNLFvK/nVohhfU5yr3nt5SgCdF5SZ
tz6p8HH3UM0fE6joWl3N8rc=
=crr8
-----END PGP SIGNATURE-----

--nextPart1268159.VsJLtvUgYu--
