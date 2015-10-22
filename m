Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1788E1A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 23:19:30 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so85635912pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 05:19:28 -0700 (PDT)
Date: Thu, 22 Oct 2015 20:19:15 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/e6500: hw tablewalk: make sure we invalidate and
 write to the same tlb entry
Message-ID: <20151022121915.GF24884@pek-khao-d1.corp.ad.wrs.com>
References: <1439884556-11291-1-git-send-email-haokexin@gmail.com>
 <20151017000155.GA15466@home.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
In-Reply-To: <20151017000155.GA15466@home.buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 07:01:55PM -0500, Scott Wood wrote:
> On Tue, Aug 18, 2015 at 03:55:56PM +0800, Kevin Hao wrote:
> > diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64=
e.S
> > index e4185581c5a7..3a5b89dfb5a1 100644
> > --- a/arch/powerpc/mm/tlb_low_64e.S
> > +++ b/arch/powerpc/mm/tlb_low_64e.S
> > @@ -68,11 +68,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> >  	ld	r14,PACAPGD(r13)
> >  	std	r15,EX_TLB_R15(r12)
> >  	std	r10,EX_TLB_CR(r12)
> > +#ifdef CONFIG_PPC_FSL_BOOK3E
> > +BEGIN_FTR_SECTION
> > +	std	r7,EX_TLB_R7(r12)
> > +END_FTR_SECTION_IFSET(CPU_FTR_SMT)
> > +#endif
> >  	TLB_MISS_PROLOG_STATS
> >  .endm
> > =20
> >  .macro tlb_epilog_bolted
> >  	ld	r14,EX_TLB_CR(r12)
> > +#ifdef CONFIG_PPC_FSL_BOOK3E
> > +BEGIN_FTR_SECTION
> > +	ld	r7,EX_TLB_R7(r12)
> > +END_FTR_SECTION_IFSET(CPU_FTR_SMT)
> > +#endif
>=20
> r7 is used outside the CPU_FTR_SMT section of the e6500 TLB handler.

Sorry for the delay response just back from vacation. I will move the load
of TCD_ESEL_NEXT out of CPU_FTR_SMT wrap.

Thanks,
Kevin

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKNQ+AAoJEJNY7TDerrFxwUUH/0EoCXkC86unfjCjzGBfsE88
xZIDLWvJh1VP6+uD0eXxb3RcYvn6CvMZoeXjtqIcTOYkIZKlzMoL121hbAC6+XLI
5ozEM+/1UzMhJRpyYp+2gOiRJo1cwfHf/jheHVj/EgOHx+2Qcyyf4xJa2d/qLiNK
rCjDNkA2isqx9+ScYEdDueIfQiF3rK3qLyoEFpkIqXWMqO0AFvLkMHY7x3OG3Nwf
E2s8GSrqvzu3eY+Q+DSZd4EhmxfHo6YOnkpLps9u+2KC4iH0WWEdUhwFK8tfNLCO
4XSm5LnwBrazYPOUlgm1ppn7RkZsJ8O2pXRG5XJFbmIPC8M7cQF1KE5kNy0YiJA=
=Uf4A
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
