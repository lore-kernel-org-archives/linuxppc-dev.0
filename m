Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1B131A0034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:13:21 +1000 (AEST)
Received: by pdco4 with SMTP id o4so28621729pdc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:13:19 -0700 (PDT)
Date: Fri, 14 Aug 2015 15:13:09 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd
 lock acquiring codes
Message-ID: <20150814071309.GH30310@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-2-git-send-email-haokexin@gmail.com>
 <1439491483.4099.101.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
In-Reply-To: <1439491483.4099.101.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 01:44:43PM -0500, Scott Wood wrote:
> On Thu, 2015-08-13 at 19:51 +0800, Kevin Hao wrote:
> > It makes no sense to put the instructions for calculating the lock
> > value (cpu number + 1) and the clearing of eq bit of cr1 in lbarx/stbcx
> > loop. And when the lock is acquired by the other thread, the current
> > lock value has no chance to equal with the lock value used by current
> > cpu. So we can skip the comparing for these two lock values in the
> > lbz/bne loop.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/mm/tlb_low_64e.S | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64=
e.S
> > index 765b419883f2..e4185581c5a7 100644
> > --- a/arch/powerpc/mm/tlb_low_64e.S
> > +++ b/arch/powerpc/mm/tlb_low_64e.S
> > @@ -308,11 +308,11 @@ BEGIN_FTR_SECTION               /* CPU_FTR_SMT */
> >        *
> >        * MAS6:IND should be already set based on MAS4
> >        */
> > -1:   lbarx   r15,0,r11
> >       lhz     r10,PACAPACAINDEX(r13)
> > -     cmpdi   r15,0
> > -     cmpdi   cr1,r15,1       /* set cr1.eq =3D 0 for non-recursive */
> >       addi    r10,r10,1
> > +     crclr   cr1*4+eq        /* set cr1.eq =3D 0 for non-recursive */
> > +1:   lbarx   r15,0,r11
> > +     cmpdi   r15,0
> >       bne     2f
>=20
> You're optimizing the contended case at the expense of introducing stalls=
 in=20
> the uncontended case.

Before the patch, the uncontended case code sequence are:
1:	lbarx	r15,0,r11
	lhz	r10,PACAPACAINDEX(r13)
	cmpdi	r15,0
	cmpdi	cr1,r15,1	/* set cr1.eq =3D 0 for non-recursive */
	addi	r10,r10,1
	bne	2f
	stbcx.	r10,0,r11
	bne	1b


After the patch:
	lhz	r10,PACAPACAINDEX(r13)
	addi	r10,r10,1
	crclr	cr1*4+eq	/* set cr1.eq =3D 0 for non-recursive */
1:	lbarx	r15,0,r11
	cmpdi	r15,0
	bne	2f
	stbcx.	r10,0,r11
	bne	1b

As you know, the lbarx is a Presync instruction and stbcx is a Presync and
Postsync instruction. Putting the unnecessary instructions in the lbarx/stb=
cx
loop also serialize these instructions execution. The execution latency of
lbarx is only 3 cycles and there are still two instructions after it.
Considering the out of order execution optimization after this patch, do you
really think that new uncontended path will become slower due to this
additional stall?

>  Does it really matter if there are more instructions=20
> in the loop?

I really think we should minimize the window of lbarx/stbcx, for following =
two
reasons:
  - The bigger of this window, the more possible conflicts between the two
     threads run into this loop simultaneously.
  - The reservation used by lbarx may be cleared by another thread due to
     store to the same reservation granule. The smaller the window of
     lbarx/stbcx, the less possibility to be affected by this.

>  This change just means that you'll spin in the loop for more=20
> iterations (if it even does that -- I think the cycles per loop iteration=
=20
> might be the same before and after, due to load latency and pairing) whil=
e=20
> waiting for the other thread to release the lock.

Besides the optimization for the contended case, it also make the code more
readable with these changes:
  - It always seem a bit weird to calculate the lock value for the current
    cpu in the lbarx/stbcx loop.
  - The "cmpdi   cr1,r15,1" seems pretty confusion. It doesn't always do wh=
at
    the comment said (set cr1.eq =3D 0). In some cases, it does set the
    crq.eq =3D 1, such as when running on cpu 1 with lock is acquired by cp=
u0.
    All we need to do just clear the cr1.eq unconditionally.

>=20
> Do you have any benchmark results for this patch?

I doubt it will get any visible difference. Anyway I will gave it a try.

Thanks,
Kevin
>=20
> -Scott
>=20

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzZUFAAoJEJNY7TDerrFx/ZIH/34yABJDyC4w1JDAwJc8XCXb
9vK1pSiH7h9eKneX7Y0zclltoBTMxwc/nIgVY2BN9ejD8eyM4B9R/LQWiXJmJjuW
j1umSAbPPqIxHKHPm4pGj/cyf2uk4vzyBFsFDHH5kFHfHMT1cQjrUSBXYzQoR/IY
+IhDVDCHbAx525DR0o2Zeqx4PrBiWSabCNT7nzpgAJp6ItUb9W4/LC0Me4Pk3cil
iBCJ131bKZtBdaL6xNaT01MrQGSduXHOrHuoXdZJAhxKPMykoY7CvQKy5VTWObSD
Iel/B9Mt5vJGKWv3ZP93uNcwSJ3oNB/2PjE6sQDw5J6TkVbC3RC4DncH6oUyxIo=
=JXXh
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
