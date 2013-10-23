Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 779BE2C016A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:55:04 +1100 (EST)
Message-ID: <1382525674.6315.9.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Missing _restvr_20 and _savevr_20 subroutines for
 lib/raid6/altivec8.o
From: Ben Hutchings <ben@decadent.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Oct 2013 11:54:34 +0100
In-Reply-To: <9A520C29-492E-4FFF-9A0C-190182428FBE@kernel.crashing.org>
References: <1382221463.2794.87.camel@deadeye.wl.decadent.org.uk>
 <9A520C29-492E-4FFF-9A0C-190182428FBE@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-znsxcqGFYzcF7m20KbIr"
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-znsxcqGFYzcF7m20KbIr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-10-23 at 00:28 -0500, Kumar Gala wrote:
> On Oct 19, 2013, at 5:24 PM, Ben Hutchings wrote:
>=20
> > When building lib/raid6/altivec8.o with gcc 4.8 on Debian, the compiler
> > is generating references to two new runtime subroutines which are
> > apparently not included in the kernel:
> >=20
> > ERROR: "_restvr_20" [lib/raid6/raid6_pq.ko] undefined!
> > ERROR: "_savevr_20" [lib/raid6/raid6_pq.ko] undefined!
> >=20
> > The save/restore subroutines are specified in
> > http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.7.1.html#S=
AVE-RESTORE
> > and we do have the _restgpr_* and _savegpr_* subroutines in
> > arch/powerpc/boot/crtsavres.S.  I'm not sure whether these subroutines
> > should be added or whether this indicates the compiler is doing
> > something wrong.
> >=20
> > A configuration that triggers this is included below.
> >=20
> > Ben.
>=20
> Try with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dn.  A feature was added to gcc
> for -Os to "outline" the save/restore routines.  I'm surprised this
> hasn't shown up sooner.

That does avoid the problem, thanks.

Ben.

> Well need to add _restvr_* / _savevr_* to the version in lib/crtsaveres.S=
.
>=20
> http://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob_plain;f=3Dlibgcc/config/rs60=
00/crtrestvr.S;hb=3DHEAD
> http://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob_plain;f=3Dlibgcc/config/rs60=
00/crtsavevr.S;hb=3DHEAD
>=20
> - k

--=20
Ben Hutchings
friends: People who know you well, but like you anyway.

--=-znsxcqGFYzcF7m20KbIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUmeq6ue/yOyVhhEJAQrI4xAArNS6hShPyYFVZTqxEWkZo+s7Fxn89Kmu
hwaSB0rrN5j4y+5l/uUV6YLn7a/Ex/wVhJXcCyDqFPonogI6GTDCad0kYLdMPEJJ
xSA6vHV9xtMwp1bj+RELokbUdXko05jcI2g2YLNK90Kr0lUAHAqkkoJLJLw8DGu1
t5S6xeWO2uGTikut20qePQrA74gOnK0AEVI4Os1cJH7CvKb+2+lK0FcgzOrzzPum
1QbPGBhVV/y98IfWaIJHmkdL18uWAj0yV9W2E5X5fUaf26uQKjygQt26TSKEj1zl
L3Il8s7BUHPV0ubkeu19V7ZAoL6+bqXqtENN4MABu9Zpa0WG4UTkRgF95zT/G6cZ
uVNcnx/UZeb+LSKzu//fFtDwgBwWWcoaNar/vA5i09kpJay8SWo0PwsuOkrVgroN
rbN759v4/T19zVcODfm4gOmwtZrMUrQosI/pc4mp7QZyAB7ddq7bpUOvZe5hf9F7
ApJ6Be3M9Y/KJlPH3xvfLmLvU6E1luU5JT/agNHhIj2qbhzZqb5R4OzsDHbk19up
276QOOt3PD1NsZdJXxq+z7PUJcv1o0tpwucj7AAB4JLhOWwVUv6aMZinZgXO0kuD
QLgMQCsV2iy95RzaGlR1R0tUx4WDnEEB7hGNAzW93ZZC4onUcWO89J3ztwqEVQju
enixvE6oALk=
=EwJF
-----END PGP SIGNATURE-----

--=-znsxcqGFYzcF7m20KbIr--
