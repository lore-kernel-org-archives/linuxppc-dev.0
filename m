Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33B672C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 10:30:16 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id q10so1911529pdj.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 17:30:12 -0700 (PDT)
Date: Sun, 4 Aug 2013 08:30:03 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/8] powerpc/fsl_booke: protect the access to MAS7
 with MMU_FTR_BIG_PHYS
Message-ID: <20130804003003.GA19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-2-git-send-email-haokexin@gmail.com>
 <1374880440.30721.36@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
In-Reply-To: <1374880440.30721.36@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 06:14:00PM -0500, Scott Wood wrote:
> On 07/04/2013 07:54:07 AM, Kevin Hao wrote:
> >diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> >b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> >index a92c79b..2201f84 100644
> >--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> >+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> >@@ -88,9 +88,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
> > 1:	mflr	r7
> >
> > 	mfspr	r8,SPRN_MAS3
> >-#ifdef CONFIG_PHYS_64BIT
> >+BEGIN_MMU_FTR_SECTION
> > 	mfspr	r23,SPRN_MAS7
> >-#endif
> >+MMU_FTR_SECTION_ELSE
> >+	li	r23,0
> >+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
> > 	and	r8,r6,r8
> > 	subfic	r9,r6,-4096
> > 	and	r9,r9,r7
> >diff --git a/arch/powerpc/kernel/head_fsl_booke.S
> >b/arch/powerpc/kernel/head_fsl_booke.S
> >index d10a7ca..a04a48d 100644
> >--- a/arch/powerpc/kernel/head_fsl_booke.S
> >+++ b/arch/powerpc/kernel/head_fsl_booke.S
> >@@ -82,7 +82,11 @@ _ENTRY(_start);
> > 	and	r19,r3,r18		/* r19 =3D page offset */
> > 	andc	r31,r20,r18		/* r31 =3D page base */
> > 	or	r31,r31,r19		/* r31 =3D devtree phys addr */
> >+BEGIN_MMU_FTR_SECTION
> > 	mfspr	r30,SPRN_MAS7
> >+MMU_FTR_SECTION_ELSE
> >+	li	r30,0
> >+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
>=20
> Code patching hasn't been done yet at this point.

Indeed. I overlooked this. I will change it to #ifdef CONFIG_PHYS_64BIT.

Thanks,
Kevin

>=20
> -Scott

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR/aCLAAoJEJNY7TDerrFxpB8IAJpO1ueQRkP7VhN4XI18nK8j
xTVHruPCaClvaH15O4BTMdTRfaidOVlq9Ot46PnjLey4DXJcqQbexxV6BacdGjkl
SikUJ9UkEn5p5F/CGxUvfX6xpU3keNNh6NidgWY6sss3DpCZLfdDAajpRl346VGA
An5PZ7tMk6lqbUNZD6xahhbDhaog+6HuxLS7ZWS9S0zp8XemUpOcDcrGGAjH0z1J
aly/EGtIPigqaau+f62u10zaClIuRfi58hdbjslIVw/oeKpDKf/xLQ0aUsmbZWXb
n+6NaaHi0I0tyHpzA2LyC+HlvsN2waPTCN3m/mJEF2NgdHvukG3YKsHuv3oc1cY=
=5k5r
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
