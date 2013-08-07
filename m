Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 828352C011A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 16:09:24 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id fb10so1736597pad.23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Aug 2013 23:09:21 -0700 (PDT)
Date: Wed, 7 Aug 2013 14:09:08 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: move the testing of CPU_FTR_COHERENT_ICACHE
 into __flush_icache_range
Message-ID: <20130807060908.GB26904@pek-khao-d1.corp.ad.wrs.com>
References: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
 <1375784612-14399-2-git-send-email-haokexin@gmail.com>
 <1375785310.12557.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
In-Reply-To: <1375785310.12557.61.camel@pasglop>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 08:35:10PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-06 at 18:23 +0800, Kevin Hao wrote:
> > In function flush_icache_range(), we use cpu_has_feature() to test
> > the feature bit of CPU_FTR_COHERENT_ICACHE. But this seems not optimal
> > for two reasons:
> >  a) For ppc32, the function __flush_icache_range() already do this
> >     check with the macro END_FTR_SECTION_IFSET.
> >  b) Compare with the cpu_has_feature(), the method of using macro
> >     END_FTR_SECTION_IFSET will not introduce any runtime overhead.
>=20
> Nak.
>=20
> It adds the overhead of calling into a function :-)
>=20
> What about modifying cpu_has_feature to use jump labels ?=20

That's a great idea. I would like to gave it a try later.

>It might solve
> the problem of no runtime overhead ... however it might also be hard to
> keep the ability to remove the whole statement at compile time if the
> bit doesn't fit in the POSSIBLE mask... unless you find the right macro
> magic.
>=20
> In any case, I suspect the function call introduces more overhead than
> the bit test + conditional branch which will generally predict very
> well, so the patch as-is is probably a regression.

I don't think so. For the 64bit CPU which has a non-coherent icache,
there is no any effect introduced by this patch since (!cpu_has_feature(CPU=
_FTR_COHERENT_ICACHE))
always yield true at compile time. But for the 64bit CPU which does have
the coherent icache, the following is the asm code before applying this pat=
ch:

  c000000000023b4c:	e9 22 86 68 	ld      r9,-31128(r2)
  c000000000023b50:	e9 29 00 00 	ld      r9,0(r9)
  c000000000023b54:	e9 29 00 10 	ld      r9,16(r9)
  c000000000023b58:	79 2a 07 e1 	clrldi. r10,r9,63
  c000000000023b5c:	41 82 00 94 	beq     c000000000023bf0 <.handle_rt_signa=
l64+0x670>
  ...=20
  c000000000023bf0:	7f 23 cb 78 	mr      r3,r25
  c000000000023bf4:	7f 64 db 78 	mr      r4,r27
  c000000000023bf8:	48 7a 65 99 	bl      c0000000007ca190 <.__flush_icache_=
range>

After applying this patch, the following code is generated:
  c000000000023b48:	7f 23 cb 78 	mr      r3,r25
  c000000000023b4c:	7f 64 db 78 	mr      r4,r27
  c000000000023b50:	48 7a 65 81 	bl      c0000000007ca0d0 <.flush_icache_ra=
nge>


The run path for these two cases are:

        before                              after
  ld r9,-31128(r2)                        mr r3,r25
  ld r9,0(r9)                             mr r4,r27
  ld r9,16(r9)                            bl flush_icache_range
  clrldi. r10,r9,63                       blr
  beq   xxxx

So I don't think this will introduce more overhead than before.
On the contrary, I believe it yield less overhead than before.
Correct me if I am wrong.

>=20
> Did you measure ?

No. I don't have a access to 64bit CPU which has a coherent icache.
For a non-coherent icache 64bit CPU this patch will not cause any effect.

Thanks,
Kevin

>=20
> Ben.
>=20
>=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/cacheflush.h | 3 +--
> >  arch/powerpc/kernel/misc_64.S         | 4 +++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/inclu=
de/asm/cacheflush.h
> > index b843e35..60b620d 100644
> > --- a/arch/powerpc/include/asm/cacheflush.h
> > +++ b/arch/powerpc/include/asm/cacheflush.h
> > @@ -35,8 +35,7 @@ extern void __flush_disable_L1(void);
> >  extern void __flush_icache_range(unsigned long, unsigned long);
> >  static inline void flush_icache_range(unsigned long start, unsigned lo=
ng stop)
> >  {
> > -	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > -		__flush_icache_range(start, stop);
> > +	__flush_icache_range(start, stop);
> >  }
> > =20
> >  extern void flush_icache_user_range(struct vm_area_struct *vma,
> > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_6=
4.S
> > index 6820e45..74d87f1 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -68,7 +68,9 @@ PPC64_CACHES:
> >   */
> > =20
> >  _KPROBE(__flush_icache_range)
> > -
> > +BEGIN_FTR_SECTION
> > +	blr
> > +END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >  /*
> >   * Flush the data cache to memory=20
> >   *=20
>=20
>=20

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSAeSEAAoJEJNY7TDerrFxlBIH/i9CWMtF0JO8mljaf+fnSW+X
L/qTh4ivVbb6yE5pEqlmPXMM9aw3fboVRBd5ZSEs/YwQcjrPAsktWDBr8i+bi/4A
bUl+PP1B7FfyX/7GNVR/PmfNunufUm8Tiys5eKc29nN4mrRh//B41Jr2ELMnxu1O
qRBjrE3cIa1VTsk8wx4vBV3TN1yqJdQncT8EY8BzDIzNrxo3Fvl/aXJYx4waKGcK
8zVUGytfx5jlP5GD/H0vM/a+woAFpQXHMcuDp2mmRO+6+uYUn20/8vfgLfAh7BfF
I4MwYRv9esRbWKmYR+PGmSJcl+5FEzY8/uGzPBy0ItYdMrQkw/8Hkz+7SstDuiU=
=0WU1
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
