Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 177E41A023A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Oct 2014 16:52:17 +1100 (AEDT)
Received: by mail-pd0-f169.google.com with SMTP id w10so3058008pde.28
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 22:52:15 -0700 (PDT)
Date: Sun, 19 Oct 2014 13:52:05 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] clk: ppc-corenet: don't use platform_driver to init
 the clock device
Message-ID: <20141019055205.GA13370@pek-khao-d1.corp.ad.wrs.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-3-git-send-email-haokexin@gmail.com>
 <1413496523.7417.12.camel@aoeu.buserror.net>
 <20141016225552.GC9593@pek-khao-d1.corp.ad.wrs.com>
 <1413525535.7417.27.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <1413525535.7417.27.camel@aoeu.buserror.net>
Cc: Gerhard Sittig <gsi@denx.de>, Jingchang Lu <jingchang.lu@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 07:58:55AM +0200, Scott Wood wrote:
> On Fri, 2014-10-17 at 06:55 +0800, Kevin Hao wrote:
> > I have thought about to put it in a more common place such as time_init=
(),
> > but this will be in conflict with mpc512x board. How about add an
> > arch_initcall(mpc85xx_clk_init) in arch/powerpc/platforms/85xx/common.c?
>=20
> Gerhard, does 512x really require of_clk_init() to be called at that
> specific time, or can it be replaced by a common of_clk_init()?

I have took a look at the mpc5121_clk_init() and it seems that the
of_clk_init() is only used to scan the 'fixed-clock' in the DT. So I think
it should be safe to invoke it a bit earlier in a common place. I will crea=
te
v2 to use this method.

Gerhard, please correct me if I am wrong.

Thanks,
Kevin

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQ1GFAAoJEJNY7TDerrFxtvYH/iuOszARN/kN80PF4BsHLHNX
RUfvRng2ZgSYOBpx9WRgsu4Rljqg7JYxVcNoZbkgkR6xzLzHMj+0Fn6wENlc6VfJ
pk5rhnGYJ6Rw41Wu5TPLdCX/0Zoglkt+gsv3EJr3UwTg7D6uXvfvT8r2z/k0ZIn9
KCg9EwwZ4BQY2svAHQVs+JOHnXRn9r2DFh71aFef8j47qhsgy8J0Xpz7TLbqwAwU
3pTMhIdgP0W420UbTiUUstBnIZlFck6Xs7YXQnvK+H3uH389ah/grpsrdbTDgA7X
aCyQiHNKYPauReyNW7qZUNf7wQ91hR9y5TKDCpiFrl2iEPbxKxxjn0yv04a9xEY=
=qPX6
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
