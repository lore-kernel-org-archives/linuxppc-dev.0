Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7EB28B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 21:46:50 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69954DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 21:46:50 +1000 (EST)
Subject: Re: [PATCH 03/14] powerpc: use printk_once
From: Michael Ellerman <michael@ellerman.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090810080049.GA3132@pengutronix.de>
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
	<1249847649-11631-4-git-send-email-marcin.slusarz@gmail.com>
	<20090810080049.GA3132@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-b4R4lwTYP9ivuci12oa3"
Date: Mon, 10 Aug 2009 21:46:49 +1000
Message-Id: <1249904809.4958.4.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Marcin Slusarz <marcin.slusarz@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-b4R4lwTYP9ivuci12oa3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-08-10 at 10:00 +0200, Wolfram Sang wrote:
> On Sun, Aug 09, 2009 at 09:53:58PM +0200, Marcin Slusarz wrote:
> > Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@ozlabs.org
> > ---
> >  arch/powerpc/kernel/iommu.c      |    6 +-----
> >  arch/powerpc/kernel/irq.c        |    5 ++---
> >  arch/powerpc/sysdev/ppc4xx_pci.c |    9 ++-------
> >  3 files changed, 5 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> > index fd51578..c7fa258 100644
> > --- a/arch/powerpc/kernel/iommu.c
> > +++ b/arch/powerpc/kernel/iommu.c
> > @@ -502,7 +502,6 @@ static void iommu_table_clear(struct iommu_table *t=
bl)
> >  struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
> >  {
> >  	unsigned long sz;
> > -	static int welcomed =3D 0;
> >  	struct page *page;
> > =20
> >  	/* Set aside 1/4 of the table for large allocations. */
> > @@ -523,11 +522,8 @@ struct iommu_table *iommu_init_table(struct iommu_=
table *tbl, int nid)
> > =20
> >  	iommu_table_clear(tbl);
> > =20
> > -	if (!welcomed) {
> > -		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
> > +	printk_once(KERN_INFO "IOMMU table initialized, virtual merging %s\n"=
,
> >  		       novmerge ? "disabled" : "enabled");
> > -		welcomed =3D 1;
> > -	}
> > =20
> >  	return tbl;
> >  }
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index f7f376e..05ebd21 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -231,7 +231,6 @@ skip:
> >  void fixup_irqs(cpumask_t map)
> >  {
> >  	unsigned int irq;
> > -	static int warned;
> > =20
> >  	for_each_irq(irq) {
> >  		cpumask_t mask;
> > @@ -246,8 +245,8 @@ void fixup_irqs(cpumask_t map)
> >  		}
> >  		if (irq_desc[irq].chip->set_affinity)
> >  			irq_desc[irq].chip->set_affinity(irq, &mask);
> > -		else if (irq_desc[irq].action && !(warned++))
> > -			printk("Cannot set affinity for irq %i\n", irq);
> > +		else if (irq_desc[irq].action)
> > +			printk_once("Cannot set affinity for irq %i\n", irq);
>=20
> Maybe we should add a loglevel to this printk (and the other one in fix_i=
rqs)
> while we are here?

I think you should drop it, it's stupid. If we actually care about irqs
that don't have a set affinity we should keep a count and report that at
the end of the loop.

cheers

--=-b4R4lwTYP9ivuci12oa3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqACKUACgkQdSjSd0sB4dJc9QCgxfYeLYd+d9Gj6snPN2g5a16M
SBEAoMXV6MsfT7MTtqZKhK1oNoEMngFB
=Ah65
-----END PGP SIGNATURE-----

--=-b4R4lwTYP9ivuci12oa3--
