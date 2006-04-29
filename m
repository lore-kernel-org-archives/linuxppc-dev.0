Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C8F6A679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 13:16:47 +1000 (EST)
Date: Sat, 29 Apr 2006 13:16:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: sign extension for 32bit syscalls on ppc64
Message-Id: <20060429131640.6f79e0d3.sfr@canb.auug.org.au>
In-Reply-To: <17490.53377.898206.21369@cargo.ozlabs.ibm.com>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
	<17490.53377.898206.21369@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Apr_2006_13_16_40_+1000_zaKJyRlRRmoJOlLr"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Apr_2006_13_16_40_+1000_zaKJyRlRRmoJOlLr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Apr 2006 12:33:37 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Stephen Rothwell writes:
>=20
> > They do need to be sign extended for the new *at syscalls where you can=
 pass
> > a sepecial value AT_FDCWD (-10) to represent the current directory ...
>=20
> So, compat_sys_openat() in fs/compat.c looks wrong to me then, if
> AT_FDCWD is part of the ABI and not just an internal thing.  And I'm
> now not sure whether some of the other *at syscalls do in fact need
> compat wrappers...

AT_FDCWD (actually -100, sorry) is not protected by __KERNEL__ in
include/linux/fcntl.h and sys_openat does not stop it being passed, so I
assume it is part of the user ABI.

The existence of AT_FDCWD is what stopped me from wiring up all the *at
syscalls earlier.  It also sparked another discussion to try to formulate
some generic wrappers for the compat routines.

Has any testing been done on these interfaces that involves 32 bit
processes passing AT_FDCWD on 64 bit kernels (I realise that it will work
for some architectures but I suspect not ppc64).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Apr_2006_13_16_40_+1000_zaKJyRlRRmoJOlLr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUtqYFdBgD/zoJvwRAoGAAJ9UBfihIuZDGftOvy9CtPdi/tFnbQCcCgei
TK2zW5bEdCifqZQDTL8SXsk=
=ihu/
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_13_16_40_+1000_zaKJyRlRRmoJOlLr--
