Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4157867C31
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 15:44:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7O5uai8012790
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 22:56:36 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7O5iM09025097
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:44:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] Adapt ipic driver to new host_ops interface,
	addset_irq_type to set IRQ sense
Date: Thu, 24 Aug 2006 13:44:52 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC2F3@zch01exm20.fsl.freescale.net>
In-Reply-To: <1156391081.8433.164.camel@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +static int ipic_host_map(struct irq_host *h, unsigned int virq,
> > +			 irq_hw_number_t hw)
> > +{
> > +	struct ipic *ipic =3D h->host_data;
> > +	struct irq_chip *chip;
> > +
> > +	/* Default chip */
> > +	chip =3D &ipic->hc_irq;
> > +
> > +	set_irq_chip_data(virq, ipic);
> > +	set_irq_chip(virq, chip);
> > +
> > +	return 0;
> >  }
>=20
> Shouldn't you call set_irq_type() (or at least set a handler) here to
> setup a default type ? The common code will only call set_irq_type()
if
> an explicit non-default and different than the current setting handler
> is set.

But for IRQ with a specified type, set_irq_type() will be called two
times continuously.  Why not call the set_irq_type() in any case in
irq_create_of_mapping()?
