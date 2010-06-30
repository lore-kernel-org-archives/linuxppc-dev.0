Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C91D1B7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 09:05:51 +1000 (EST)
Date: Thu, 1 Jul 2010 09:05:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix compile errors in prom_init_check for gcc 4.5
Message-Id: <20100701090546.0b7406ee.sfr@canb.auug.org.au>
In-Reply-To: <4D7DE8D9-B226-4C6A-97FF-A63D272681C5@kernel.crashing.org>
References: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
	<B6229BDC-F290-4A71-9F61-AAA5EC87F0F6@kernel.crashing.org>
	<20100701082756.7dced805.sfr@canb.auug.org.au>
	<4D7DE8D9-B226-4C6A-97FF-A63D272681C5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_Jul_2010_09_05_46_+1000_+=aCF7fA0r8I2fZX"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__1_Jul_2010_09_05_46_+1000_+=aCF7fA0r8I2fZX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Jul 2010 00:50:36 +0200 Segher Boessenkool <segher@kernel.crashin=
g.org> wrote:
>
> >> You probably also need something similar to http://git.infradead.org/
> >> users/segher/linux.git/commitdiff/
> >> 98194f54cc8e19ecd752bc10e2d19ef94074f502
> >> (note: only build-tested, not run-tested).
> >
> > See http://patchwork.ozlabs.org/patch/57379/ submitted yesterday.
>=20
> Yeah saw that right after I hit "send" :-)  Either it's way more
> complete than what I did, or way more complex because we still
> don't link with libgcc :-P

Actually, the 64bit versions of the routines are supplied by the linker,
so the vmlinux links fine.  But for modules, the final link is actually
done by the kernel module loader, thus we need to provide those routines
in this case.  linking against libgcc would not have helped.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_Jul_2010_09_05_46_+1000_+=aCF7fA0r8I2fZX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMK83KAAoJEDMEi1NhKgbsmlMH/2wllNl5RtsJIn0PnLR0w2vq
F7TB++210dG85ES5caFFNoi272Oo69q8X6VyARyRLxyk8Oi9Cxuz1wwtgsWGwgGC
CCw2ojxHaDEa16Xz5fn6wokAo9J3y/zs1SXAsKRgknj/FjyKYbVr3TFjN5JyJtcO
foLvE87aVbGrBhfUW5EGtQJsV0RnwdS+6Uqrj3mGxO3d6rlajYS70ieZx7hzOumJ
T6WjnyNpUdv0JZ/oaGYWGal8To32E/us7C8rHZDGIIX8RlR4v/OpeXXGIHvxyLUs
/J9YLucLJpdePWNVdZjozjEi17hmKx6pxohECPKzzJNmgcITapG5q2kuEF41n20=
=exH+
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Jul_2010_09_05_46_+1000_+=aCF7fA0r8I2fZX--
