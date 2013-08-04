Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 513442C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 10:43:00 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id 15so1930316pdi.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 17:42:58 -0700 (PDT)
Date: Sun, 4 Aug 2013 08:42:43 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 4/8] powerpc/fsl_booke: set the tlb entry for the
 kernel address in AS1
Message-ID: <20130804004243.GC19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-5-git-send-email-haokexin@gmail.com>
 <1374881830.30721.38@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
In-Reply-To: <1374881830.30721.38@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 06:37:10PM -0500, Scott Wood wrote:
> On 07/04/2013 07:54:10 AM, Kevin Hao wrote:
> >--- a/arch/powerpc/kernel/head_fsl_booke.S

<snip>

> >+++ b/arch/powerpc/kernel/head_fsl_booke.S
> >@@ -1172,6 +1172,87 @@ __secondary_hold_acknowledge:
> > #endif
> >
> > /*
> >+ * Create a tbl entry
>=20
> s/tbl/tlb/

Fixed.

>=20
> >diff --git a/arch/powerpc/mm/fsl_booke_mmu.c
> >b/arch/powerpc/mm/fsl_booke_mmu.c
> >index 5fe271c..8f60ef8 100644
> >--- a/arch/powerpc/mm/fsl_booke_mmu.c
> >+++ b/arch/powerpc/mm/fsl_booke_mmu.c
> >@@ -222,7 +222,9 @@ void __init adjust_total_lowmem(void)
> > 	/* adjust lowmem size to __max_low_memory */
> > 	ram =3D min((phys_addr_t)__max_low_memory,
> >(phys_addr_t)total_lowmem);
> >
> >+	i =3D switch_to_as1();
> > 	__max_low_memory =3D map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> >+	restore_to_as0(i);
>=20
> Wouldn't it be simpler to just run out of AS1 from the end of
> fsl_booke_entry_mapping.S, similar to what U-Boot does?  With ESEL
> being changed to something non-conflicting, of course.

This pair of functions will be used by the codes in the following patch.

Thanks,
Kevin
>=20
> -Scott

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR/aODAAoJEJNY7TDerrFxA+sH/1esrP6hgWwQ/gobJ4HgeaM3
1dGPLE3Hx99cUh6I7h1C+xIpJ3aJzQ1dWQgMb4vK/hZvnmVYYmoHt8AEQyEZ1QF5
pWMjiaLRHXXxIWT8c4IWRZWolxG+K5/zXuU5bl88OehajSDlaY1tgHcKC9Q1Fkb3
UNGACdodn1P9sgtt3If5Wm+YOoT6zmW/bxUD2XYiTkQJ6fm+qiO5ITXUDtm2dhxp
59nZQ+R2e1UDTCN0FjNOULTYalx/0VKwlXff4RcA3eXF6iRHziDbmkTlp6jf/j/b
vkBayYiQw3yCRWqZYuZqZ5nC8T2HHRPJCCny7fRG46rnaTvwqty/XhpGc+nq+PU=
=LEn2
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
