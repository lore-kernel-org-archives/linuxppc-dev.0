Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ED0B0B7225
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:26:36 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF815DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:26:36 +1000 (EST)
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20090617115917.GD31595@in.ibm.com>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5Rg9Pwn15+VvVi8FWhQm"
Date: Wed, 17 Jun 2009 22:26:35 +1000
Message-Id: <1245241595.4269.15.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-5Rg9Pwn15+VvVi8FWhQm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-17 at 17:29 +0530, M. Mohan Kumar wrote:
> Do not inline putprops function
>=20
> With the recent kexec-tools git tree, both kexec and kdump kernels hang (=
i.e
> kexec -l and kexec -p respectively). This happened after the patch "ppc64=
:
> cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
> reverting each hunk and then found out that retaining following lines in
> fs2dt.c makes kexec/kdump work.
>=20
> -static unsigned *dt_len; /* changed len of modified cmdline
> -                           in flat device-tree */
>=20
> [....]
>=20
> -               dt_len =3D dt;
>=20
> I don't have any clue why removing a unused variable would cause the kexe=
c
> kernel to hang. After further investigation, I observed that if the putpr=
ops
> function is not inlined, kexec/kdump kernel would work even after removin=
g
> the above lines.
>=20
> This patch directs gcc to not inline the putprops function. Now we could
> invoke kexec and kdump kernels.

What compiler version are you using? Does the behaviour change if you
use a newer/older compiler? It sounds to me like there's some deeper bug
and your patch is just papering over it.

cheers

--=-5Rg9Pwn15+VvVi8FWhQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko44PsACgkQdSjSd0sB4dJ5MQCfaDXTPJjZgiB0XajA00U+rBt1
ctAAoKL4oFogfSyYVilZ6ubJziQ9rhtN
=gJIX
-----END PGP SIGNATURE-----

--=-5Rg9Pwn15+VvVi8FWhQm--
