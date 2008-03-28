Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 08A0FDE50C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:26:51 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Fri, 28 Mar 2008 17:26:42 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803271010.33825.laurentp@cse-semaphore.com>
	<20080327153952.GC18728@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080327153952.GC18728@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1309258.YfJdhfPsSN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803281726.47566.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1309258.YfJdhfPsSN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 27 March 2008 16:39, Scott Wood wrote:
> On Thu, Mar 27, 2008 at 10:10:33AM +0100, Laurent Pinchart wrote:
> > On Wednesday 26 March 2008 17:59, Scott Wood wrote:
> > > This breaks the bootwrapper console.
> >=20
> > And of course I forgot about that :-)
> >=20
> > The boot wrapper code doesn't have any dpram allocator. Any objection
> > against using a chunk of dpram at a fixed location ? What about at the
> > beginning of the dpram ? The DTS muram node would then exclude a chunk =
of
> > dpram at offset 0x0000 instead of 0x1100.
>=20
> I'm not entirely comfortable with using a chunk outside of what's in the
> muram node, and assuming that it's for the SMC pram -- what if there's
> microcode or something there?
>=20
> Since udbg is only for debugging, and is marked as potentially dangerous,
> how about just using the end of muram (as described in the device tree)?=
=20
> If the muram is fully allocated, it won't happen until after the real
> serial console is initialized.

Locating the end of the muram isn't as straightforward as it could be. As t=
he=20
current code already uses the beginning of the muram to store the BDs and=20
data buffers, should I really bother locating the end or can I store the SM=
C=20
parameter ram at the beginning as well ?

If I'm not mistaken, once the SMC parameter ram gets relocated to the=20
beginning/end of the muram, the boot loader preallocated space can be=20
reclaimed and can be added to the muram in the device tree like I did in my=
=20
previous patch. Is that correct ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1309258.YfJdhfPsSN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH7RxH8y9gWxC9vpcRAmbSAKDcmNEkILKd+z/LONMn41C2AiYc8QCfd3If
8an+P7TcWoO3GxuWSb+WuI8=
=wBDl
-----END PGP SIGNATURE-----

--nextPart1309258.YfJdhfPsSN--
