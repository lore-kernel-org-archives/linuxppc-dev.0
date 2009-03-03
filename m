Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7E465DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 14:27:18 +1100 (EST)
Date: Tue, 3 Mar 2009 14:19:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig
Message-Id: <20090303141905.52dbf9b1.sfr@canb.auug.org.au>
In-Reply-To: <20090302185514.2cc73512.akpm@linux-foundation.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Mar_2009_14_19_05_+1100_rxD/dD9nQb.7F01N"
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Mar_2009_14_19_05_+1100_rxD/dD9nQb.7F01N
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2 Mar 2009 18:55:14 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> Using built-in specs.
> Target: powerpc64-unknown-linux-gnu
> Configured with: /home/axboe/crosstool-0.43/build/powerpc64-unknown-linux=
-gnu/gcc-4.1.0-glibc-2.3.6/gcc-4.1.0/configure --target=3Dpowerpc64-unknown=
-linux-gnu --host=3Dx86_64-host_unknown-linux-gnu --prefix=3D/opt/crosstool=
/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu --disable-multilib --wit=
h-sysroot=3D/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gn=
u/powerpc64-unknown-linux-gnu/sys-root --with-local-prefix=3D/opt/crosstool=
/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/powerpc64-unknown-linux-=
gnu/sys-root --disable-nls --enable-threads=3Dposix --enable-symvers=3Dgnu =
--enable-__cxa_atexit --enable-languages=3Dc --enable-shared --enable-c99 -=
-enable-long-long
> Thread model: posix
> gcc version 4.1.0
>=20
> > I suspect you have a 64 bit only compiler and allnoconfig produces a 32
> > bit kernel.  Is this a new error?
>=20
> 2.6.28 does the same thing.  I don't recall having tested allnoconfig
> for ages if at all, so I don't know if it's a regression.

Right, you have a 64 bit only compiler. Also it is version 4.1.0 which we n=
ow black ban (I think).  You need to either build a biarch cross compiler (=
--enable-targets=3Dall) or try:

$ cat >xxx <<EOF
CONFIG_PPC64=3Dy
EOF
$ KCONFIG_ALLCONFIG=3Dxxx make allnoconfig
$ make vmlinux

let us know if that works :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Mar_2009_14_19_05_+1100_rxD/dD9nQb.7F01N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmsoakACgkQjjKRsyhoI8z0FQCff6E72o0f7AXV5z9P/lXFT1aE
MlYAoJdJAixLA6YQsndcJErsfOoD6gM9
=AXF4
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Mar_2009_14_19_05_+1100_rxD/dD9nQb.7F01N--
