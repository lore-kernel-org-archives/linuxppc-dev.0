Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id AFCFADDFE2
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 01:07:01 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Fri, 28 Mar 2008 15:06:58 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<20080327153952.GC18728@ld0162-tx32.am.freescale.net>
	<200803281458.56766.laurentp@cse-semaphore.com>
In-Reply-To: <200803281458.56766.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1305032.ugIBDnBvYY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803281506.58988.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1305032.ugIBDnBvYY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 28 March 2008 14:58, Laurent Pinchart wrote:
> On Thursday 27 March 2008 16:39, Scott Wood wrote:
> > On Thu, Mar 27, 2008 at 10:10:33AM +0100, Laurent Pinchart wrote:
> > > On Wednesday 26 March 2008 17:59, Scott Wood wrote:
> > > > This breaks the bootwrapper console.
> > >=20
> > > And of course I forgot about that :-)
> > >=20
> > > The boot wrapper code doesn't have any dpram allocator. Any objection=
=20
against=20
> > > using a chunk of dpram at a fixed location ? What about at the beginn=
ing=20
of=20
> > > the dpram ? The DTS muram node would then exclude a chunk of dpram at=
=20
offset=20
> > > 0x0000 instead of 0x1100.
> >=20
> > I'm not entirely comfortable with using a chunk outside of what's in the
> > muram node, and assuming that it's for the SMC pram -- what if there's
> > microcode or something there?
> >=20
> > Since udbg is only for debugging, and is marked as potentially dangerou=
s,
> > how about just using the end of muram (as described in the device tree)=
?=20
> > If the muram is fully allocated, it won't happen until after the real
> > serial console is initialized.
>=20
> Very good idea. I'll prepare a new patch.

arch/powerpc/boot/cpm-serial.c stores the udbg buffer descriptors at the=20
beginning of the muram. Should I move them at the end as well ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1305032.ugIBDnBvYY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH7PuC8y9gWxC9vpcRAmd9AKCAMrmnIU1xZafbH1qZLuAgBIuf8gCgiYRE
lVlZ804tZ+CewdR6X9WpRpo=
=GH7h
-----END PGP SIGNATURE-----

--nextPart1305032.ugIBDnBvYY--
