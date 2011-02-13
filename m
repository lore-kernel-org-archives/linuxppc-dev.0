Return-Path: <michael@ellerman.id.au>
Subject: Re: arch/powerpc/kernel/cacheinfo.c: Possible null pointer dereference
From: Michael Ellerman <michael@ellerman.id.au>
To: David Binderman <dcb314@hotmail.com>
In-Reply-To: <BLU154-w1013E8541813DF8B7564CD9CEE0@phx.gbl>
References: <BLU154-w1013E8541813DF8B7564CD9CEE0@phx.gbl>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-o5YMBenEG4v3alVjz3CH"
Date: Mon, 14 Feb 2011 10:24:30 +1100
Message-ID: <1297639470.9492.11.camel@concordia>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-o5YMBenEG4v3alVjz3CH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2011-02-12 at 10:08 +0000, David Binderman wrote:
> Hello there,
>=20
> I just tried out cppcheck-1.47 on the linux-2.6.38-rc4 source code.
>=20
> It said
>=20
> [arch/powerpc/kernel/cacheinfo.c:380]: (error) Possible null pointer
> dereference: cache - otherwise it is redundant to check if cache is
> null at line 382
>=20
> The source code is
>=20
>     WARN_ONCE(cache && cache->level !=3D level,
>           "cache level mismatch on lookup (got %d, expected %d)\n",
>           cache->level, level);
>=20
>     if (!cache)
>=20
> I agree with cppcheck. Suggest code rework.

It's wrong.

The code is essentially:

if (cache && cache->level !=3D level)
	printf("cache level mismatch on lookup (got %d, expected %d)\n", cache->le=
vel, level);

if (!cache)
	cache =3D cache_do_one_devnode(node, level);


Which looks fine to me?

cheers

--=-o5YMBenEG4v3alVjz3CH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1YaCsACgkQdSjSd0sB4dJWeQCfQXAdlRWmsmOpRUXe9qm8TgRt
AU8An2ZiAjjFur3U/LP+2rDeTf+GZqna
=x9Gs
-----END PGP SIGNATURE-----

--=-o5YMBenEG4v3alVjz3CH--
