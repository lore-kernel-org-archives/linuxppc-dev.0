Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFE1E2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 18:11:19 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id bj3so10363588pad.28
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 01:11:14 -0700 (PDT)
Date: Sun, 14 Jul 2013 16:11:04 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Matt Helsley <matthltc@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/math-emu: move the flush FPU state function
 into do_mathemu
Message-ID: <20130714081103.GA13793@pek-khao-d1.corp.ad.wrs.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-2-git-send-email-haokexin@gmail.com>
 <20130712003445.GC14599@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <20130712003445.GC14599@us.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 05:34:45PM -0700, Matt Helsley wrote:
> On Thu, Jul 11, 2013 at 08:21:54PM +0800, Kevin Hao wrote:
> > By doing this we can make sure that the FPU state is only flushed to
> > the thread struct when it is really needed.
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/kernel/traps.c  | 9 ---------
> >  arch/powerpc/math-emu/math.c | 9 +++++++++
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index bf33c22..58a8065 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -1131,15 +1131,6 @@ void __kprobes program_check_exception(struct pt=
_regs *regs)
> >  	 * instruction or only on FP instructions, whether there is a
> >  	 * pattern to occurrences etc. -dgibson 31/Mar/2003
> >  	 */
> > -
> > -	/*
> > -	 * If we support a HW FPU, we need to ensure the FP state
> > -	 * if flushed into the thread_struct before attempting
> > -	 * emulation
> > -	 */
> > -#ifdef CONFIG_PPC_FPU
> > -	flush_fp_to_thread(current);
> > -#endif
> >  	switch (do_mathemu(regs)) {
> >  	case 0:
> >  		emulate_single_step(regs);
> > diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
> > index 3fe8e35..18ce6a7 100644
> > --- a/arch/powerpc/math-emu/math.c
> > +++ b/arch/powerpc/math-emu/math.c
> > @@ -420,6 +420,15 @@ do_mathemu(struct pt_regs *regs)
> >  		goto illegal;
> >  	}
> >=20
> > +	/*
> > +	 * If we support a HW FPU, we need to ensure the FP state
> > +	 * if flushed into the thread_struct before attempting
>=20
> As long as you're moving the comment you could fix up the spelling
> error: s/if/is/

Fixed. Thanks Matt.

Kevin

>=20
> Cheers,
> 	-Matt Helsley
>=20

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR4l0XAAoJEJNY7TDerrFxY0YH/RNV/G2O+XIC7Oa7z/l3Kodg
ZJpqXXF50Ai70Ee8qwK/dFdMlFPIpAoWk5v1UdgLHTPhRYYuYprkkWxiJEuSA+LR
awI2B6ZIRJ/XX4JL7kq/77D14WQ5ajZReWQXkV3H7M7Bygjw5wRDBGgAXkTu22K+
DtuXR29LCmp+FpMmj5H54lSldcBh7Sb2tf4bTVWu+Q8AVHk4xEWRzWPG+Ql4hlRv
gvpda4+9TqhCozRY3FBX693vWw5xfT7e8sP0FE/zU+MSwpVOWdasGlYZfRbOS5MD
bF0CXJ0Dl7dsUEnPrYZlJi/IqzQjVaiDfUx0liINGmjBvZtl2Y7qqwef5kZVyQE=
=XKSO
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
