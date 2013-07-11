Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 592B12C0302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:22:02 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id uo1so7696912pbc.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 02:21:59 -0700 (PDT)
Date: Thu, 11 Jul 2013 17:21:48 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: enable the math emulation for the
 corenet64_smp_defconfig
Message-ID: <20130711092148.GB22910@pek-khao-d1.corp.ad.wrs.com>
References: <1373420992-25167-1-git-send-email-haokexin@gmail.com>
 <1373492403.8183.234@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
In-Reply-To: <1373492403.8183.234@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 04:40:03PM -0500, Scott Wood wrote:
> On 07/09/2013 08:49:52 PM, Kevin Hao wrote:
> >I got the following error on my t4240qds board.
> >  ntpd[2713]: unhandled signal 4 at 0fd5b448 nip 0fd5b448 lr
> >0fd5b424 code 30001
> >
> >The root cause is that the float point instruction 'fsqrt' is used.
> >But this instruction is not implemented on e6500 core. Even this
> >does seem a gcc bug, I would like to enable the math emulation
> >in the kernel to workaround this kind of issue.
>=20
> I'll apply this, but we should add PPC_WARN_EMULATED to math-emu so
> that people know when their toolchain is emitting things that
> require emulation.

Sure.

>=20
> It'd also be nice if we had an option to only include the portions
> of math-emu that are known to be missing in some CPUs (excluding
> CPUs that are missing the entire FPU, of course).  Besides its
> effect on kernel image size, in my experience math-emu adds a
> non-trivial amount of time to a kernel build.

Sounds reasonable. I will give it a try.

Thanks,
Kevin

>=20
> -Scott

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR3nksAAoJEJNY7TDerrFxorEH/0sirlmctvpITnwY5b2Zci6p
tFuUpxzIvpy8fbURWnDGgf4IR3V6gZStfww49vuXrvyZFqccHq5a3FU81vom8lU4
hevol1mfi3gz/ZooN6mGWbczXz+/IaW2pH1N++wPjLVOKIP81yp6wEZTlIo43tlZ
Jl/07yJ7iDwiBkq22wdpjaKJp2ynjAQRjU5n7aEzrovsGa5BvAypYL2wbMxgLguG
Vi9sSNMgWxuu0HgZRilrj4PNhrIzP0YM1EXI+fVxJaY/ycStL3j7y4NwgaqUgTK6
2FpRmBPYdLqPfA6gdjpb2C0bLUh2XKuZQVSMeAGch304LLiWdyMcMOHjRyMESaE=
=FbgG
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
