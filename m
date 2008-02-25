Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id 1F3D6DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 22:56:41 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: debian-powerpc@lists.debian.org
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Date: Mon, 25 Feb 2008 12:56:35 +0100
References: <200802031729.12069.bernhard@intevation.de>
	<20080218205248.1af469d4@zod.rchland.ibm.com>
	<200802221550.27093.bernhard@intevation.de>
In-Reply-To: <200802221550.27093.bernhard@intevation.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7826250.S5V96hAe1l";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802251256.41037.bernhard@intevation.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7826250.S5V96hAe1l
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 22 February 2008 15:50, Bernhard Reiter wrote:
> > Ok, so it seems -mcpu=3D440 was added in gcc 3.4. =A0The -mcpu=3D405 op=
tion
> > has been around since 2001. =A0Seeing as how there really isn't anything
> > 440 specific in the files effected, we should be able to pass -mcpu=3D4=
05
> > for everything and have it still work.
> >
> > Bernhard, can you try the patch below?
>
> I will test it in the next days.

Done. Looks good.
(I did _not_ do a full rebuild and installation, only a build test.
I will do a full blown test with 2.6.24.3.)

> The short test for my sarge compiler makes me optimistic:
>
> dpkg -l gcc | grep gcc
> ii =A0gcc =A0 =A0 =A0 =A0 =A0 =A03.3.5-3 =A0 =A0 =A0 =A0The GNU C compiler
> bernhard@burn:~/tmp$ gcc -mcpu=3D440 x.c
> cc1: error: bad value (440) for -mcpu=3D switch
> bernhard@burn:~/tmp$ gcc -mcpu=3D405 x.c
> bernhard@burn:~/tmp$
>
> > -$(obj)/cuboot-katmai.o: BOOTCFLAGS +=3D -mcpu=3D440
> > +$(obj)/4xx.o: BOOTCFLAGS +=3D -mcpu=3D405

Note: Your original did not fully apply, I think it had lines like
=2D$(obj)/cuboot-taishan.o: BOOTCFLAGS +=3D -mcpu=3D440
=2D$(obj)/cuboot-katmai.o: BOOTCFLAGS +=3D -mcpu=3D440
which I did not have in my 2.6.24.
Probably because you've used a git version of linux.
What I did was to change the similiar occurances from 440 to 405.

Bernhard

=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart7826250.S5V96hAe1l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHwqz4h9ag3dpKERYRAlOOAKCaIqBGTA1xnNXSEQI3JqyjKgH4ygCfa5HO
oArFU7vK1xBRCBTFqs3YPdw=
=GwZ9
-----END PGP SIGNATURE-----

--nextPart7826250.S5V96hAe1l--
