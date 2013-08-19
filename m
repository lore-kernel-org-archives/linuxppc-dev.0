Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B6122C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 21:50:48 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr4so4857372pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 04:50:44 -0700 (PDT)
Date: Mon, 19 Aug 2013 19:50:29 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add the missing required isync for the coherent
 icache flush
Message-ID: <20130819115029.GD20146@pek-khao-d1.corp.ad.wrs.com>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376883397.25016.60.camel@pasglop>
 <1376883437.25016.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
In-Reply-To: <1376883437.25016.61.camel@pasglop>
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 01:37:17PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-19 at 13:36 +1000, Benjamin Herrenschmidt wrote:
>=20
> > The semantic of this function is to make data executable. Even if the
> > implementation has a snooping icache, it *still* needs to make sure
> > prefetched code is tossed out of the pipeline which is what isync
> > should provide.
> >=20
> > The architecture actually specifies that.
>=20
> In fact, on P5 and later, I think we are supposed to do a single dummy
> icbi followed by sync and isync.

Do you mean something like this? But why?

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index d74fefb..8fcdec7 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -69,6 +69,8 @@ PPC64_CACHES:
=20
 _KPROBE(flush_icache_range)
 BEGIN_FTR_SECTION
+	icbi	0,r3
+	sync
 	isync
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
@@ -209,6 +211,8 @@ _GLOBAL(flush_inval_dcache_range)
  */
 _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
+	icbi	0,r3
+	sync
 	isync
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
> > Cheers,
> > Ben.
> >=20
> > > >  	blr
> > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > >  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> > > > */
> > > > @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
> > > >   */
> > > >  _GLOBAL(__flush_dcache_icache_phys)
> > > >  BEGIN_FTR_SECTION
> > > > +	isync
> > > >  	blr					/* for 601, do nothing */
> > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > >  	mfmsr	r10
> > > > diff --git a/arch/powerpc/kernel/misc_64.S
> > > > b/arch/powerpc/kernel/misc_64.S
> > > > index 992a78e..d74fefb 100644
> > > > --- a/arch/powerpc/kernel/misc_64.S
> > > > +++ b/arch/powerpc/kernel/misc_64.S
> > > > @@ -69,6 +69,7 @@ PPC64_CACHES:
> > > >=20
> > > >  _KPROBE(flush_icache_range)
> > > >  BEGIN_FTR_SECTION
> > > > +	isync
> > > >  	blr
> > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > >  /*
> > > > --
> > > > 1.8.3.1
> > > >=20
> > > > _______________________________________________
> > > > Linuxppc-dev mailing list
> > > > Linuxppc-dev@lists.ozlabs.org
> > > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > >=20
> >=20
>=20
>=20

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSEgaFAAoJEJNY7TDerrFxWuwH/0dBUb2/9VTtBlcxyCoIsy+D
39p+8Ah91fT6wSA/zqVMzQl89C5Z4OVyJIbI7cYS9vV+qcv5HgvpeyAAA+XBYY6Q
aIrayjzH6OL+cS77Mspt52CieZS4FZszLnI48J0GXJNoNn/BvTnTTNQhIPP7ncB2
hv/nYa6x25GCup8vie4c+8hMgvHbyRKz8BricSI+PURZjzkchzdxRWURMlf5gKTa
r3HdVcwy30pWbUKUo2IsOGKb/Dzxo77GmuhOHs6/k0Br/hUe4Zxxi945lJAia2OA
PcM97uXXHsnvwiH8ywp5xws0RhigxcmJ2q3epUU2fRCKjDsI4Q6pGkl0aHzTr+w=
=KVlB
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
