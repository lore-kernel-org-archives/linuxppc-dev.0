Return-Path: <albrecht.dress@arcor.de>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id 5346CDDFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 05:50:35 +1000 (EST)
Received: from antares (xdsl-78-34-255-14.netcologne.de [78.34.255.14])
	by smtp2.netcologne.de (Postfix) with ESMTP id BE5274BDB
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 21:50:32 +0200 (MEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 8701CBA03E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 21:50:32 +0200 (CEST)
Date: Thu, 28 May 2009 21:50:24 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: linuxppc-dev@ozlabs.org
In-Reply-To: <OF508468F5.9BFFC168-ONC12575C4.005846FD-C12575C4.00592585@transmode.se>
	(from joakim.tjernlund@transmode.se on Thu May 28 18:13:43 2009)
Message-Id: <1243540232.3305.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-NLkNG6WYhCi04JC2XIF/"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-NLkNG6WYhCi04JC2XIF/
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.05.09 18:13 schrieb(en) Joakim Tjernlund:
> hmm, these do look a bit unoptimal anyway. Any reason not to write =20
> them something like below(written by me for uClibc long time ago). =20
> You will have to add eieio()/sync

No (and I wasn't aware of the PPC pre-inc vs. post-inc stuff) - I just =20
stumbled over this while fixing mtd accesses to the MPC5200's Local Bus =20
in 16-bit mode which doesn't allow byte accesses.  And I didn't want to =20
go too deep into this as the real fix for me is actually somewhat =20
different...

> /* PPC can do pre increment and load/store, but not post increment =20
> and load/store.
>    Therefore use *++ptr instead of *ptr++. */
[snip]
>  copy_chunks:
> 	do {
> 		/* make gcc to load all data, then store it */
> 		tmp1 =3D *(unsigned long *)(tmp_from+4);
> 		tmp_from +=3D 8;
> 		tmp2 =3D *(unsigned long *)tmp_from;
> 		*(unsigned long *)(tmp_to+4) =3D tmp1;
> 		tmp_to +=3D 8;
> 		*(unsigned long *)tmp_to =3D tmp2;
> 	} while (--chunks);

Is this the same for all PPC cores, i.e. do they all benefit from =20
loading/storing 8 instead of 4 bytes?

Best, Albrecht.

--=-NLkNG6WYhCi04JC2XIF/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKHusHn/9unNAn/9ERAhIDAJwMsPhFIRveLeVH2NTsUmUE48tISACggnx2
KaX1ULtN6ADZkHNDizZN9KU=
=Jrl/
-----END PGP SIGNATURE-----

--=-NLkNG6WYhCi04JC2XIF/--
