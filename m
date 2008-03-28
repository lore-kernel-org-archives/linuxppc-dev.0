Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E86BCDDF6E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 00:59:02 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Fri, 28 Mar 2008 14:58:52 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803271010.33825.laurentp@cse-semaphore.com>
	<20080327153952.GC18728@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080327153952.GC18728@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1483509.KHFmEjznlb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803281458.56766.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1483509.KHFmEjznlb
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
> > The boot wrapper code doesn't have any dpram allocator. Any objection a=
gainst=20
> > using a chunk of dpram at a fixed location ? What about at the beginnin=
g of=20
> > the dpram ? The DTS muram node would then exclude a chunk of dpram at o=
ffset=20
> > 0x0000 instead of 0x1100.
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

Very good idea. I'll prepare a new patch.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1483509.KHFmEjznlb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH7Pmg8y9gWxC9vpcRAizfAJ9PT3auWhBHqfhDe6ydXxAYOz24gQCeNaag
ESOhreJHhEAHLxUjyFZoUI0=
=ZDn4
-----END PGP SIGNATURE-----

--nextPart1483509.KHFmEjznlb--
