Return-Path: <q-funk@pp.fishpool.fi>
Received: from hal.pp.fishpool.fi (hal.fishpool.fi [213.157.66.81])
	by ozlabs.org (Postfix) with ESMTP id 480E22BF07
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 11:31:59 +1100 (EST)
Date: Thu, 23 Dec 2004 01:36:59 +0200 (EET)
From: =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1103739194.5316.1.camel@gaston>
Message-ID: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: Martin-Eric Racine <q-funk@pp.fishpool.fi>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nice to know that work is being done on the pmac ALSA driver. :)

However, I still cannot get ALSA to work at all on this iMac's Burgundy: =
=20
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D306

The old OSS driver still works, so I know that the hardware is not at
fault; this is clearly an ALSA driver problem.

Has anybody managed to get this to work on similar hardware?


On Wed, 22 Dec 2004, Benjamin Herrenschmidt wrote:

> This patch (which will be send upstream separately by the Alsa folks) fix=
es
> an signed vs. unsigned char problem in Alsa which was the cause of the Oo=
ps
> people were experiencing on ppc with OSS emulation and possibly other iss=
ues.
>=20
> Index: linux-work/sound/core/pcm_misc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/sound/core/pcm_misc.c=092004-11-22 01:51:09.000000000=
 +0100
> +++ linux-work/sound/core/pcm_misc.c=092004-12-22 19:11:26.297518336 +010=
0
> @@ -26,10 +26,10 @@
>  #define SND_PCM_FORMAT_UNKNOWN (-1)
> =20
>  struct pcm_format_data {
> -=09char width;=09/* bit width */
> -=09char phys;=09/* physical bit width */
> -=09char le;=09/* 0 =3D big-endian, 1 =3D little-endian, -1 =3D others */
> -=09char signd;=09/* 0 =3D unsigned, 1 =3D signed, -1 =3D others */
> +=09signed char width;=09/* bit width */
> +=09signed char phys;=09/* physical bit width */
> +=09signed char le;=09=09/* 0 =3D big-endian, 1 =3D little-endian, -1 =3D=
 others */
> +=09signed char signd;=09/* 0 =3D unsigned, 1 =3D signed, -1 =3D others *=
/
>  =09unsigned char silence[8];=09/* silence data to fill */
>  };
> =20
>=20
>=20
>=20
>=20

--=20
Martin-=C9ric Racine, ICT Consultant
http://www.iki.fi/q-funk/
