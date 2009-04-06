Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6A50DDE9F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 22:57:23 +1000 (EST)
Subject: Re: [PATCH] powerpc: Print information about mapping hw irqs to
	virtual irqs
From: Michael Ellerman <michael@ellerman.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090406123001.GA3044@pengutronix.de>
References: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
	<20090406123001.GA3044@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dGiOfVfA2htHEu0GGU9m"
Date: Mon, 06 Apr 2009 22:57:22 +1000
Message-Id: <1239022642.6643.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-dGiOfVfA2htHEu0GGU9m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-04-06 at 14:30 +0200, Wolfram Sang wrote:
> On Mon, Apr 06, 2009 at 12:05:02PM +1000, Michael Ellerman wrote:
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 5576147..8c1a496 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -672,11 +672,13 @@ unsigned int irq_create_mapping(struct irq_host *=
host,
> >  			return NO_IRQ;
> >  		}
> >  	}
> > -	pr_debug("irq: -> obtained virq %d\n", virq);
> > =20
> >  	if (irq_setup_virq(host, virq, hwirq))
> >  		return NO_IRQ;
> > =20
> > +	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n=
",
> > +		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
> > +
>=20
> Are you replacing the pr_debug because you want to drop the
> DEBUG-dependency?

Yes. Several people have been confused by the value in /proc/interrupts
not matching what they expected - so I want there to be something in
dmesg by default that will hopefully make it clear to people what's
going on.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-dGiOfVfA2htHEu0GGU9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknZ/DIACgkQdSjSd0sB4dIe0wCfUVmQWAF1z1FD2OIDLiVnhHZx
PB4AoLiytRJVxSUd+Nrie4zqUlZFuJLm
=oweM
-----END PGP SIGNATURE-----

--=-dGiOfVfA2htHEu0GGU9m--
