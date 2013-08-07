Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1258E2C0187
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 16:10:02 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id xb4so1468597pbc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Aug 2013 23:10:00 -0700 (PDT)
Date: Wed, 7 Aug 2013 14:09:50 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc: check CPU_FTR_COHERENT_ICACHE in
 __flush_dcache_icache for 64bit kernel
Message-ID: <20130807060950.GC26904@pek-khao-d1.corp.ad.wrs.com>
References: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
 <1375784612-14399-4-git-send-email-haokexin@gmail.com>
 <1375785398.12557.62.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
In-Reply-To: <1375785398.12557.62.camel@pasglop>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 08:36:38PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-06 at 18:23 +0800, Kevin Hao wrote:
> > We don't need to flush the dcache and invalidate the icache on the
> > CPU which has CPU_FTR_COHERENT_ICACHE set.
>=20
> Actually we probably need an isync...

Will add.

Thanks,
Kevin

>=20
> Ben.
>=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/kernel/misc_64.S | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_6=
4.S
> > index a781566..32e78e2 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -207,6 +207,9 @@ _GLOBAL(flush_inval_dcache_range)
> >   *	void __flush_dcache_icache(void *page)
> >   */
> >  _GLOBAL(__flush_dcache_icache)
> > +BEGIN_FTR_SECTION
> > +	blr
> > +END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >  /*
> >   * Flush the data cache to memory=20
> >   *=20
>=20
>=20

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSAeSuAAoJEJNY7TDerrFx0/gIALT2h4FhLIHdxGJfNvM+8wCM
IB2yJ7Dyo7rTyNydcMlUbDfm/4EOzZkh2GOg9tkI8vSW6hE4hnIkL+l13ENbCmde
2XUFmrC8kE23Wgfi4HPlkns7K7i0Q065ltznaDFebl6qvnmVXSCT7UjH7TbSSlYo
dyDV6xDaeWVyGcxPGSBe9Y2wF5awYmWRiqQmnIAij7GwOOxzy1lFjcfAqVAuNSs2
w8O3Pt4SQiAP4Kb9bBCVF2du6kAcvTV10bB02vBctZl7D7lbrC7f9MslEfPnuGPV
hWXiGZBOtooPAaO2w23S7jVRggdPkn7JC5vC8DxNlwd/rdc46LzZDcAvsAnD+vM=
=WTEy
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
