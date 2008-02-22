Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id 66A62DDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 01:50:35 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: debian-powerpc@lists.debian.org
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Date: Fri, 22 Feb 2008 15:50:24 +0100
References: <200802031729.12069.bernhard@intevation.de>
	<20080205093820.5918a216@zod.rchland.ibm.com>
	<20080218205248.1af469d4@zod.rchland.ibm.com>
In-Reply-To: <20080218205248.1af469d4@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7727612.qq1kpQPdsC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802221550.27093.bernhard@intevation.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7727612.qq1kpQPdsC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 19 February 2008 03:52, Josh Boyer wrote:
> My apologies for taking so long on this.  Digging through gcc history
> isn't exactly fun :)

No problem. Thanks for tackling the issue.

> Ok, so it seems -mcpu=3D440 was added in gcc 3.4.  The -mcpu=3D405 option
> has been around since 2001.  Seeing as how there really isn't anything
> 440 specific in the files effected, we should be able to pass -mcpu=3D405
> for everything and have it still work.
>
> Bernhard, can you try the patch below?=20

I will test it in the next days.

The short test for my sarge compiler makes me optimistic:

dpkg -l gcc | grep gcc
ii  gcc            3.3.5-3        The GNU C compiler
bernhard@burn:~/tmp$ gcc -mcpu=3D440 x.c
cc1: error: bad value (440) for -mcpu=3D switch
bernhard@burn:~/tmp$ gcc -mcpu=3D405 x.c
bernhard@burn:~/tmp$

> -$(obj)/cuboot-katmai.o: BOOTCFLAGS +=3D -mcpu=3D440
> +$(obj)/4xx.o: BOOTCFLAGS +=3D -mcpu=3D405


=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart7727612.qq1kpQPdsC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHvuEyh9ag3dpKERYRAq2vAJ469VYp6a4WIIB6mWksk0+G0l8kbwCfW191
FNSnRrudzTRWg3i3T2jnkHI=
=cLEL
-----END PGP SIGNATURE-----

--nextPart7727612.qq1kpQPdsC--
