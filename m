Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AA531A09E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 00:42:46 +1100 (AEDT)
Date: Thu, 5 Feb 2015 00:41:34 +1100
From: 'David Gibson' <david@gibson.dropbear.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 0/5] powerpc: Get rid of redundant arch specific swab
 functions
Message-ID: <20150204134134.GB25675@voom.fritz.box>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
 <063D6719AE5E284EB5DD2968C1650D6D1CADA5A5@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CADA5A5@AcuExch.aculab.com>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, "agraf@suse.de" <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, "mdroth@us.ibm.com" <mdroth@us.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 11:54:39AM +0000, David Laight wrote:
> From: David Gibson
> > arch/powerpc/include/asm/swab.h includes some powerpc specific
> > byteswapping functions, which are implemented in terms of powerpc's
> > built in byte reversed load/store instructions.  There are two problems=
 with this:
> >=20
> > 1) They're not necessary - gcc is perfectly capable of generating the
> >    byte-reversed load and store instructions when using the normal,
> >    generic byteswapping functions (tested with gcc (GCC) 4.8.3
> >    20140911 (Red Hat 4.8.3-9))
>=20
> Should you be worrying about older versions of gcc?
> IIRC the internal byteswap 'stuff' is relatively recent (like
> the last couple of years) so people building current kernels
> on older distributions might have issues.

Well.. even then, surely the worst that will happen is that there will
be a few extra instructions to do the byteswap in registers.  Given
that these are mostly used for IO, I find it hard to imagine that
would make a measurable performance difference.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0iGOAAoJEGw4ysog2bOSksoP/3lGsOnomQaPb9OweVOVbahA
uIKCWKuzcaegAzzzkKoe+YK/zCnXuVRYjL5FQN3z6HrPIs7P8+fvSoqx7wUmFGoY
AdCuJWK0XZKT9NjZbbzCB87wc28HyLdyFwKaEHjAMYzmZ9pYb8H+XgmSA8Gye0Lm
d/4WJSio1RKL64lJGcBIYBKpg3PM0rOOqF/ljZ0VYALc1V1CTHcm+QGBHizVeHgs
RlL4HGr+li22d1fN3HQTOLd1Ix+R2DnRljl9Y1eIo1XPhvJYEitWiJ2nMpm3hcPC
mFkIjzkqKsDDBzYnSltabkbhpC1I6Ox/FpDNXOGLvpo2zL2nSxsF7aV5lkGFluVH
T8TjKGWW4hkwegjhEUFpMuSgIG3w+gmtBFMu8se8dOonCb20N3zbzAayvEXW23a2
oP00efPcZy05TqpL7/Bn0uuLzQkcUOcaa0nelxbcz9PF/2LoB+xjqzNsuKG6Olfc
2A0hGqTjSnfOQ1chKH4rEJOY+n9rUB8/kr0gytb2etx053XhIerkjsAdJ9QSwfW5
BBIy2w8oEMLAkCMU6ImPFiUEuFJuvA8VVpkySyQRd0TT6InAbMWyYZzSlk0qJvnt
UoFsAInlHPFK/XBckHVsUYmMgp57sIp/pb9nfcrIYGUxXtUkJ9rle/19ZCEmQP0g
TIyv3czKp4GWLMkzeyY7
=uwGO
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
