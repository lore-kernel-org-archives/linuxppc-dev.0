Return-Path: <Tony.Li@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04B97DDE04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 21:35:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lB4AYug9024678
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 03:34:57 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB4AYtSY027139
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 04:34:56 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [PATCH] Add IPIC MSI interrupt support
Date: Tue, 4 Dec 2007 18:34:52 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635D75588@zch01exm21.fsl.freescale.net>
In-Reply-To: <1196746689.20158.4.camel@concordia>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196746689.20158.4.camel@concordia>
From: "Li Tony" <Tony.Li@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: 2007=C4=EA12=D4=C24=C8=D5 13:38
> To: Li Tony
> Cc: Li Tony; Gala Kumar; linuxppc-dev
> Subject: Re: [PATCH] Add IPIC MSI interrupt support
>=20
> On Mon, 2007-12-03 at 17:07 +0800, Li Li wrote:
> > Hi Michael,
> >=20
> > I emulate mpic to write this IPIC MSI routines. :)
> >=20
> >=20
> > > > diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c=20
> > > > b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > > > index 6048f1b..dbea34b 100644
> > > > --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > > > +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
>=20
> > > > +
> > > > +#define	ipic_msi_irq_to_hw(virq)=09
> ((unsigned int)irq_map[virq].hwirq)
> > >=20
> > > What's wrong with virq_to_hw() ?
> > >=20
> >=20
> > viqr_to_hw is not __inline__.
>=20
> Hmm, ok. The three places you use it you also take a spin=20
> lock, so I'm not sure the function call's really going to=20
> kill you performance wise.
>=20

I am not very sure about spin_lock influence.
But maybe somebody will change the virq_to_hw implementation.
I will take virq_to_hw instead.=20

I see that the virq_to_hw is do inline in 2.6.22.
Why remove it?

> > > > +
> > > > +static void ipic_msi_compose_msg(struct ipic_msi *msi,=20
> int hwirq,
> > > > +						struct=20
> msi_msg *msg)
> > > > +{
> > > > +	unsigned int srs;
> > > > +	unsigned int ibs;
> > > > +
> > > > +	srs =3D hwirq / msi->int_per_msir;
> > > > +	ibs =3D hwirq - srs * msi->int_per_msir;
> > > > +
> > > > +	msg->address_lo =3D msi->msi_addr_lo;
> > > > +	msg->address_hi =3D msi->msi_addr_hi;
> > > > +	msg->data =3D (srs << 5) | (ibs & 0x1F);
> > > > +
> > > > +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> > > > +		__FUNCTION__, srs, ibs);
> > > > +
> > > > +}
> > > > +
> > > > +static int ipic_msi_setup_irqs(struct pci_dev *pdev, int nvec,=20
> > > > +int type) {
> > > > +	struct ipic_msi *msi =3D ipic_msi;
> > > > +	irq_hw_number_t hwirq;
> > > > +	unsigned int virq;
> > > > +	struct msi_desc *entry;
> > > > +	struct msi_msg msg;
> > > > +
> > > > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > > > +		hwirq =3D ipic_msi_alloc_hwirqs(msi, 1);
> > > > +		if (hwirq < 0) {
> > > > +			pr_debug("%s: fail allocating=20
> msi interrupt\n",
> > > > +					__FUNCTION__);
> > > > +			return hwirq;
> > > > +		}
> > > > +
> > > > +		/* This hwirq belongs to the irq_host=20
> other than irq_host of IPIC
> > > > + 		 * So, it is independent to hwirq of IPIC */
> > > > +		virq =3D irq_create_mapping(msi->irqhost, hwirq);
> > > > +		if (virq =3D=3D NO_IRQ) {
> > > > +			pr_debug("%s: fail mapping=20
> hwirq 0x%lx\n",
> > > > +					__FUNCTION__, hwirq);
> > > > +			ipic_msi_free_hwirqs(msi, hwirq, 1);
> > > > +			return -ENOSPC;
> > > > +		}
> > > > +		set_irq_msi(virq, entry);
> > > > +		ipic_msi_compose_msg(msi, hwirq, &msg);
> > > > +		write_msi_msg(virq, &msg);
> > > > +
> > > > +		hwirq++;
> > >=20
> > >                   ^^^^ this looks like my bug
> >=20
> > I have a question here. Do we support more MSI interrupts=20
> on ONE pci=20
> > device?
>=20
> I'm not sure what you mean? For MSI there is only one MSI per=20
> device, but this code is used also for MSI-X which supports >=20
> 1 MSI per device.
>=20
> Either way we shouldn't be incrementing hwirq by hand, it's=20
> reassigned at the top of the loop. I think that's left over=20
> from old code that allocated nvec hwirqs in a block and then=20
> created virq mappings for each one, whereas the new code=20
> allocates each hwirq separately.
>=20
> cheers
>=20
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>=20
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>=20
> We do not inherit the earth from our ancestors, we borrow it=20
> from our children. - S.M.A.R.T Person
>=20
