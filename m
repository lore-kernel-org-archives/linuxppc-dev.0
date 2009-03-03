Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D5398DDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 15:40:48 +1100 (EST)
Date: Tue, 3 Mar 2009 15:40:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig
Message-Id: <20090303154043.fee7902e.sfr@canb.auug.org.au>
In-Reply-To: <20090302200809.26b5d5bb.akpm@linux-foundation.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Mar_2009_15_40_43_+1100_ne7/44fnBVjbqZ8o"
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Mar_2009_15_40_43_+1100_ne7/44fnBVjbqZ8o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2 Mar 2009 20:08:09 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> > Right, you have a 64 bit only compiler. Also it is version 4.1.0 which =
we now black ban (I think).
>=20
> Probably.  But I only use it for compilation testing, so the `Your
> version of gcc miscompiles the __weak directive' thing is a pointless
> PITA, so I patch it out.

Ah, ok.

> > let us know if that works :-)
>=20
> didn't.  Oh well.

Rats!

I think we need a better bug report :-)
Kernel version? What error do you get now?

It works for me:

$ /home/sfr/kernels/cross/bin/powerpc64-linux-gcc -v
Using built-in specs.
Target: powerpc64-linux
Configured with: /home/sfr/kernels/tools/gcc-4.3.2/configure --target=3Dpow=
erpc64-linux --enable-targets=3Dall --prefix=3D/home/sfr/kernels/cross --wi=
th-mpfr=3D/usr --enable-languages=3Dc --without-headers --enable-sjlj-excep=
tions --with-system-libunwind --disable-nls --disable-threads --disable-sha=
red --disable-libmudflap --disable-libssp --disable-libgomp --disable-decim=
al-float --enable-checking=3Drelease
Thread model: single
gcc version 4.3.2 (GCC)=20
$ git describe --all
tags/next-20090302

also Linus' recent tree works:

$ git describe
v2.6.29-rc6-216-g778ef1e

> It seems odd that it breaks an allnoconfig build, whereas defconfig and
> allmodconfig are OK.

allmodconfig and defconfig turn CONFIG_PPC64 on.  allnoconfig turns it
off so you are trying to build a 32 bit kernel with a 64 bit compiler.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Mar_2009_15_40_43_+1100_ne7/44fnBVjbqZ8o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmstMsACgkQjjKRsyhoI8wVCwCffDy/j3p6uvsmgTX2lTpp0qjg
9YEAoIS6UR31r1ojMa3CKmpSaa81Houu
=aALt
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Mar_2009_15_40_43_+1100_ne7/44fnBVjbqZ8o--
