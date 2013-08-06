Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3EC92C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 11:23:15 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id uo5so4022026pbc.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 18:23:13 -0700 (PDT)
Date: Tue, 6 Aug 2013 09:23:01 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
Message-ID: <20130806012301.GC24317@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
 <1374884277.30721.39@snotra>
 <20130804005035.GE19141@pek-khao-d1.corp.ad.wrs.com>
 <1375747806.13074.106.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
In-Reply-To: <1375747806.13074.106.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 07:10:06PM -0500, Scott Wood wrote:
> On Sun, 2013-08-04 at 08:50 +0800, Kevin Hao wrote:
> > On Fri, Jul 26, 2013 at 07:17:57PM -0500, Scott Wood wrote:
> > > >diff --git a/arch/powerpc/mm/fsl_booke_mmu.c
> > > >b/arch/powerpc/mm/fsl_booke_mmu.c
> > > >index 8f60ef8..dd283fd 100644
> > > >--- a/arch/powerpc/mm/fsl_booke_mmu.c
> > > >+++ b/arch/powerpc/mm/fsl_booke_mmu.c
> > > >@@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
> > > >
> > > > 	i =3D switch_to_as1();
> > > > 	__max_low_memory =3D map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> > > >-	restore_to_as0(i);
> > > >+	restore_to_as0(i, 0, 0);
> > >=20
> > > The device tree virtual address is zero?
> >=20
> > No. But if the __pa(PAGE_OFFSET in AS0) is equal to __pa(PAGE_OFFSET in=
 AS1),
> > that mean we don't need to do another relocation and the device tree vi=
rtual
> > address is useless in this case.
>=20
> The documentation of restore_to_as0() should make it clear that r5 is
> ignored if r4 is zero.

OK, will add.

Thanks,
Kevin

>=20
> -Scott
>=20
>=20
>=20

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSAE/1AAoJEJNY7TDerrFxRjQIAMy9a98apGAJQNzz+YZGdrD8
hdvGEy3p+oNgGyQi4ukh+7oou52lonR96reyNca5afhwN3yz/G9zwafwtMpOUO/Y
3OYtgXC/X7v5hEInNDWu+gl7+m5lSI5kNUZT7CgyiKKkEoVQfGLabEzDBPpuowfl
gNmKdkJ8noSvufGB84qmqnPzggRyOKLvkQe2FAIbzYQG9GPzM8SA4FK1P2EId5uU
RdA/F1l2+4cyWxj2+nOkHWBfxZHOmh6D4LovoPP0r+alvbrurqa8pRNVJPojWatw
AR+BzXLH0TDcuQEBLQor+S3UHIo8PH3ybkTDeVL3X1eznYuk6rk3ZBsN9qa1Up4=
=w2iL
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
