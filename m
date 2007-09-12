Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0897ADDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 18:22:00 +1000 (EST)
Subject: Re: [PATCH 1/3] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18151.1452.702936.394284@cargo.ozlabs.ibm.com>
References: <20070905220607.GA11330@ld0162-tx32.am.freescale.net>
	<18151.1452.702936.394284@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ygqjjQjgzt/afkpTOVys"
Date: Wed, 12 Sep 2007 10:23:21 +0200
Message-Id: <1189585401.6161.34.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ygqjjQjgzt/afkpTOVys
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-09-12 at 07:16 +1000, Paul Mackerras wrote:

> > +/* Overrides the weak version in kernel/power/main.c */
> > +void arch_suspend_disable_irqs(void)
> > +{
> > +	if (ppc_md.suspend_disable_irqs)
> > +		ppc_md.suspend_disable_irqs();
> > +	else
> > +		generic_suspend_disable_irqs();
>=20
> Any particular reason why we need a ppc_md hook here?  Do we expect
> some platform to need to do something different?

Yes, we need to hook into these for the PMU and platform functions on
powermac. Once I get to convert that to the generic infrastructure...

johannes

--=-ygqjjQjgzt/afkpTOVys
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG56H5/ETPhpq3jKURAiqyAJ4kFaKzDdYNkA3XkvK7S3HPdkrK9ACgrJGp
KQPEfpQbir/GcKmLby5fn8w=
=594n
-----END PGP SIGNATURE-----

--=-ygqjjQjgzt/afkpTOVys--
