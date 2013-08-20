Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F7F62C010C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 22:16:42 +1000 (EST)
Received: by mail-pa0-f46.google.com with SMTP id fa1so643359pad.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 05:16:37 -0700 (PDT)
Date: Tue, 20 Aug 2013 20:16:28 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add the missing required isync for the coherent
 icache flush
Message-ID: <20130820121627.GB18634@pek-khao-d1.corp.ad.wrs.com>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376883397.25016.60.camel@pasglop>
 <1376883437.25016.61.camel@pasglop>
 <20130819115029.GD20146@pek-khao-d1.corp.ad.wrs.com>
 <1376916335.25016.72.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
In-Reply-To: <1376916335.25016.72.camel@pasglop>
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


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 10:45:35PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-19 at 19:50 +0800, Kevin Hao wrote:
> > On Mon, Aug 19, 2013 at 01:37:17PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2013-08-19 at 13:36 +1000, Benjamin Herrenschmidt wrote:
> > >=20
> > > > The semantic of this function is to make data executable. Even if t=
he
> > > > implementation has a snooping icache, it *still* needs to make sure
> > > > prefetched code is tossed out of the pipeline which is what isync
> > > > should provide.
> > > >=20
> > > > The architecture actually specifies that.
> > >=20
> > > In fact, on P5 and later, I think we are supposed to do a single dummy
> > > icbi followed by sync and isync.
> >=20
> > Do you mean something like this? But why?
>=20
> It has to do with making sure prefetched and/or speculated instructions
> are properly tossed.
>=20
> My understanding is that icbi basically tells the ifetch buffers to drop
> it

Dummy question: What does the ifetch buffers mean? The instruction fetch
pipeline or instruction dispatch pipeline? Shouldn't all the prefetched
instructions in these buffers be discarded by isync?


>, sync orders the icbi and isync ensures its execution has been
> synchronized. At least I *think* that's the required sequence, I have to
> dbl check the arch, maybe tomorrow. I wouldn't be surprise if we also
> need a sync before the icbi to order the actual stores to memory that
> might have modified instructions with the icbi.

Doesn't the coherence between icache and dcache be maintained by the snoopi=
ng?

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
> > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_6=
4.S
> > index d74fefb..8fcdec7 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -69,6 +69,8 @@ PPC64_CACHES:
> > =20
> >  _KPROBE(flush_icache_range)
> >  BEGIN_FTR_SECTION
> > +	icbi	0,r3
> > +	sync
> >  	isync
> >  	blr
> >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > @@ -209,6 +211,8 @@ _GLOBAL(flush_inval_dcache_range)
> >   */
> >  _GLOBAL(__flush_dcache_icache)
> >  BEGIN_FTR_SECTION
> > +	icbi	0,r3
> > +	sync
> >  	isync
> >  	blr
> >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >=20
> > Thanks,
> > Kevin
> >=20
> > >=20
> > > Cheers,
> > > Ben.
> > >=20
> > > > Cheers,
> > > > Ben.
> > > >=20
> > > > > >  	blr
> > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > >  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> > > > > > */
> > > > > > @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
> > > > > >   */
> > > > > >  _GLOBAL(__flush_dcache_icache_phys)
> > > > > >  BEGIN_FTR_SECTION
> > > > > > +	isync
> > > > > >  	blr					/* for 601, do nothing */
> > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > >  	mfmsr	r10
> > > > > > diff --git a/arch/powerpc/kernel/misc_64.S
> > > > > > b/arch/powerpc/kernel/misc_64.S
> > > > > > index 992a78e..d74fefb 100644
> > > > > > --- a/arch/powerpc/kernel/misc_64.S
> > > > > > +++ b/arch/powerpc/kernel/misc_64.S
> > > > > > @@ -69,6 +69,7 @@ PPC64_CACHES:
> > > > > >=20
> > > > > >  _KPROBE(flush_icache_range)
> > > > > >  BEGIN_FTR_SECTION
> > > > > > +	isync
> > > > > >  	blr
> > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > >  /*
> > > > > > --
> > > > > > 1.8.3.1
> > > > > >=20
> > > > > > _______________________________________________
> > > > > > Linuxppc-dev mailing list
> > > > > > Linuxppc-dev@lists.ozlabs.org
> > > > > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > > >=20
> > > >=20
> > >=20
> > >=20
>=20
>=20

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSE14bAAoJEJNY7TDerrFxWSMH/2wR6PBfN10UfUJZeuS00w5D
xu3UnUQiHsDHdd63DekQjATxxyuaMHnAuWF7jbrJSuHPzfDmKafMekT5FAWAeAEc
KxcGyB+JgJR5M459qLN3xC4fmYoEAPC5cMm3Es8JvcHJN3kNwS9Q5t2nLBHU27jX
UUlXp3IHSd/kTqAf/U7PR1JYQGjYlHVu8ouESqrUsqsK83wjRbrB7jcTaUoVmAnL
5B1qZxiKQkfOFjoNab3b99nCaubzq+O+0/DHSHrQx6GRFeRSH+p1/pgocOuVuxCz
rxVGu2HFKUgNj1sMB2yTKOAgtNDcUkqkGwyJNMN0cyFKqvtmqnedCz4vSupAeGQ=
=yf8o
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
