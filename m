Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2F6F1A02A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 09:56:01 +1100 (AEDT)
Received: by mail-pd0-f175.google.com with SMTP id v10so4054632pde.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 15:55:59 -0700 (PDT)
Date: Fri, 17 Oct 2014 06:55:52 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] clk: ppc-corenet: don't use platform_driver to init
 the clock device
Message-ID: <20141016225552.GC9593@pek-khao-d1.corp.ad.wrs.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-3-git-send-email-haokexin@gmail.com>
 <1413496523.7417.12.camel@aoeu.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
In-Reply-To: <1413496523.7417.12.camel@aoeu.buserror.net>
Cc: Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 11:55:23PM +0200, Scott Wood wrote:
> On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/power=
pc/platforms/85xx/corenet_generic.c
> > index e56b89a792ed..7677cfecb787 100644
> > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kdev_t.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/clk-provider.h>
> > =20
> >  #include <asm/time.h>
> >  #include <asm/machdep.h>
> > @@ -188,11 +189,17 @@ static int __init corenet_generic_probe(void)
> >  	return 0;
> >  }
> > =20
> > +static void __init corenet_gen_init(void)
> > +{
> > +	of_clk_init(NULL);
> > +}
>=20
> Why is this board-specific?

I have thought about to put it in a more common place such as time_init(),
but this will be in conflict with mpc512x board. How about add an
arch_initcall(mpc85xx_clk_init) in arch/powerpc/platforms/85xx/common.c?

Thanks,
Kevin

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQEz4AAoJEJNY7TDerrFx6sIIALugMQ/0w/FxEdD+FtbbN4V+
EfHgtbOHN5k80uxK5GvFlrjqixbuQx2cOzbOvM7gnFaYn+3sWciQmoNok/joIboW
4VV7wLW5NA11Y/5cmtHu94Fcg63rFzoQCelTtYBmfvoElj21vZyDus7tUAaAbSv5
WC81eV4pZKdCjH8t4NHQ8/RFD0W9KWEz+EF3fuxr01Ujig+0JppxVHOzzI3MXNJ4
peXTRHIWDXsTtWoI7KXSisADA6ECZiLoyrkK9XZff55zvxp5/HqDQ3oniqgiG/XZ
LDQUS9Uh0dc3OfN6xxGrwBTJCqQBLQpbP3zUHyfKVy4DQkc1MZMI9/E20CEqXRk=
=hR3R
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
