Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5779BDDE44
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 20:58:39 +1000 (EST)
Subject: Re: powerpc stacktrace and lockdep support
From: Johannes Berg <johannes@sipsolutions.net>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <468D45CD.1080008@ru.mvista.com>
References: <20070108135458.GA23395@lst.de>
	<1182898073.4769.6.camel@johannes.berg>
	<1182970829.4769.62.camel@johannes.berg>
	<1183047642.3735.0.camel@johannes.berg>
	<468D45CD.1080008@ru.mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Myqp90QvsM4DSznWiTWo"
Date: Fri, 06 Jul 2007 12:59:37 +0200
Message-Id: <1183719577.3818.115.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Myqp90QvsM4DSznWiTWo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sergei, Thanks for your review!

>     I suggest to also remove these 3 lines from the heading comment in th=
is=20
> file -- they're not true anyway:
>=20
>   * This file gets included from lowlevel asm headers too, to provide
>   * wrapped versions of the local_irq_*() APIs, based on the
>   * raw_local_irq_*() macros from the lowlevel headers.

Good point.

> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +#define TRACE_DISABLE_INTS bl .powerpc_trace_hardirqs_off
> > +#else
> > +#define TRACE_DISABLE_INTS
> > +#endif
> > +
>=20
>     Erm, weren't those supposed to be in <asm-powerpc/irqflags.h>?

I guess they could be there. I was mucking my way through ;)

>     The following code seemed over-engineered:

Yeah, perfectly correct. See my last mail to this thread from this
morning.

>     Again, could have been more compact... unless trace_hardirqs_*() call=
s=20
> need to be in certain order WRT writes to PACASOFTIRQEN -- if so, in the =
1st=20
> case that I've pointed out the order was not identical (probably wrong?).=
..

Yeah, there is an ordering requirement and it was wrong in that version
of the patch.

> > +/*
> > + * crappy helper for irq-trace
> > + */
> > +
> > +#include <asm/ppc_asm.h>
> > +#include <asm/asm-offsets.h>
> > +
> > +#define STACKSPACE	GPR0 + 16*8
>=20
>     I guess this should be 16*4 for PPC32.

>     Didn't you forget to add GPR0 to the offsets here?

>     You certainly did. I bet you're clobbering GPR11/12 (if I didn't misc=
ount)...

All correct. That might even be why it didn't work on 32-bit for me and
then I gave up. In any case, I completely rewrote this file.

johannes

--=-Myqp90QvsM4DSznWiTWo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjiCZ/ETPhpq3jKURAjJ2AKCjG0p622sEIqsbBz6JjlpqwhAOVwCfQ6sT
KquAbapmxljjQniHaiBxpzs=
=LKyq
-----END PGP SIGNATURE-----

--=-Myqp90QvsM4DSznWiTWo--
