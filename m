Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id E3A43DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 04:27:18 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: debian-powerpc@lists.debian.org
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Date: Mon, 3 Mar 2008 18:26:58 +0100
References: <200802031729.12069.bernhard@intevation.de>
	<200802221550.27093.bernhard@intevation.de>
	<200802251256.41037.bernhard@intevation.de>
In-Reply-To: <200802251256.41037.bernhard@intevation.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2923048.3CGoAZ7C13";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803031827.00992.bernhard@intevation.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2923048.3CGoAZ7C13
Content-Type: multipart/mixed;
  boundary="Boundary-01=_kTDzHN8i1sRzeHa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_kTDzHN8i1sRzeHa
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 25 February 2008 12:56, Bernhard Reiter wrote:
> On Friday 22 February 2008 15:50, Bernhard Reiter wrote:
> > > Ok, so it seems -mcpu=3D440 was added in gcc 3.4. =A0The -mcpu=3D405 =
option
> > > has been around since 2001. =A0Seeing as how there really isn't anyth=
ing
> > > 440 specific in the files effected, we should be able to pass -mcpu=
=3D405
> > > for everything and have it still work.
> > >
> > > Bernhard, can you try the patch below?
> >
> > I will test it in the next days.
>
> Done. Looks good.
> (I did _not_ do a full rebuild and installation, only a build test.
> I will do a full blown test with 2.6.24.3.)

Worked fine for me with the attached patch.
Thanks again.

> Note: Your original did not fully apply, I think it had lines like
> -$(obj)/cuboot-taishan.o: BOOTCFLAGS +=3D -mcpu=3D440
> -$(obj)/cuboot-katmai.o: BOOTCFLAGS +=3D -mcpu=3D440
> which I did not have in my 2.6.24.
> Probably because you've used a git version of linux.
> What I did was to change the similiar occurances from 440 to 405.


=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--Boundary-01=_kTDzHN8i1sRzeHa
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="linux-2.4.24-fix-ppcbuild-josh-boyer2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="linux-2.4.24-fix-ppcbuild-josh-boyer2.diff"

=2D-- linux-2.6.24.3/arch/powerpc/boot/Makefile.org	2008-02-26 22:48:00.709=
872603 +0100
+++ linux-2.6.24.3/arch/powerpc/boot/Makefile	2008-02-26 22:48:17.509876780=
 +0100
@@ -35,8 +35,8 @@
=20
 BOOTCFLAGS	+=3D -I$(obj) -I$(srctree)/$(obj)
=20
=2D$(obj)/4xx.o: BOOTCFLAGS +=3D -mcpu=3D440
=2D$(obj)/ebony.o: BOOTCFLAGS +=3D -mcpu=3D440
+$(obj)/4xx.o: BOOTCFLAGS +=3D -mcpu=3D405
+$(obj)/ebony.o: BOOTCFLAGS +=3D -mcpu=3D405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS +=3D -mcpu=3D405
=20
 zlib       :=3D inffast.c inflate.c inftrees.c

--Boundary-01=_kTDzHN8i1sRzeHa--

--nextPart2923048.3CGoAZ7C13
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHzDTkh9ag3dpKERYRAlQpAJ9/i/8W3rFQdTizN4B1XQOH7r2NgQCgs3PK
I16f8EV0g1N1678J0WOM2q4=
=rJb6
-----END PGP SIGNATURE-----

--nextPart2923048.3CGoAZ7C13--
