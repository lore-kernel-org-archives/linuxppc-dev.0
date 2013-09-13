Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D099D2C03B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 11:11:40 +1000 (EST)
Received: by mail-pd0-f179.google.com with SMTP id v10so551796pde.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 18:11:38 -0700 (PDT)
Date: Fri, 13 Sep 2013 09:11:28 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: introduce cornet_generic machine
Message-ID: <20130913011128.GA1859@pek-khao-d1.corp.ad.wrs.com>
References: <1378969993-14991-1-git-send-email-haokexin@gmail.com>
 <1378969993-14991-2-git-send-email-haokexin@gmail.com>
 <1379011486.2536.46.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <1379011486.2536.46.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2013 at 01:44:46PM -0500, Scott Wood wrote:
> On Thu, 2013-09-12 at 15:13 +0800, Kevin Hao wrote:
> > In the current kernel, the board files for p2041rdb, p3041ds, p4080ds,
> > p5020ds, p5040ds, t4240qds and b4qds are almost the same except the
> > machine name. So this introduces a cornet_generic machine to support
> > all these boards to avoid the code duplication.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > This patch is based on http://patchwork.ozlabs.org/patch/274390/
> >=20
> >  arch/powerpc/platforms/85xx/Kconfig      | 10 ++++
> >  arch/powerpc/platforms/85xx/Makefile     |  8 +--
> >  arch/powerpc/platforms/85xx/b4_qds.c     | 97 ------------------------=
--------
> >  arch/powerpc/platforms/85xx/corenet_ds.c | 86 ++++++++++++++++++++++++=
++++
> >  arch/powerpc/platforms/85xx/p2041_rdb.c  | 87 ------------------------=
----
> >  arch/powerpc/platforms/85xx/p3041_ds.c   | 89 ------------------------=
-----
> >  arch/powerpc/platforms/85xx/p4080_ds.c   | 87 ------------------------=
----
> >  arch/powerpc/platforms/85xx/p5020_ds.c   | 93 ------------------------=
------
> >  arch/powerpc/platforms/85xx/p5040_ds.c   | 84 ------------------------=
---
> >  arch/powerpc/platforms/85xx/t4240_qds.c  | 93 ------------------------=
------
> >  10 files changed, 97 insertions(+), 637 deletions(-)
> >  delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
> >  delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c
>=20
> Why not merge patch 2/2 with this?

OK. I will fold the patch 2 into this one.

>=20
> Did you use -M -C with git format-patch?

For this case, using '-M -C' or not would generate the same patch.

>=20
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platfor=
ms/85xx/Kconfig
> >  config TQM85xx
[...]
> >  	bool
> > +
> > +config CORENET_GENERIC
> > +	bool
>=20
> Why do we need separate kconfig symbols for each board, if they all
> select the same code?

I thought it would be more obvious for the board support if we have a separ=
ate
option for each board. We can also use this option for some board specific
configuration if we have. Yes, it does seem a bit redundant. If you prefer I
can drop these boards options.

>=20
> > +define_machine(corenet_generic) {
> > +	.name			=3D "CORENET GENERIC",
>=20
> No allcaps please.

How about "CORENET Generic"?

BTW with these changes the file name "corenet_ds.c" seems not accurate anym=
ore?
How about change it to "corenet_generic.c"?

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSMmZAAAoJEJNY7TDerrFx+tQH/3Zg03RboPt0va8JWwhHpqsQ
woKRLw0lZAfObuKJmL7qeHM8NOW9cli7n5gpBSm3oqJ7H3LU+JGPLsXzwGGKHSBL
+oCITLvFAQskKzDTfRjOP2qYmkSQpUgFbylhLf2wP0g20+Yhq4aYWt1jKVLFp0q7
eFn33Ow/Xdw30UjUBNZ+J9EUZ9x0cqI3sFibiVMqW4to46hkkjahP4cw8+avCZyD
p0kHw+tKcy/YXGjlVqzEaYyfif00yb4rLQI+SN52GjtRu0XzazQpIVByHfl6H9sU
obd+ByEA5wV3efIMS2ks8xsFKNkGKUA6AohHYqguJEt1Y4NikSmvOyvGnvy1DRg=
=/EHX
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
