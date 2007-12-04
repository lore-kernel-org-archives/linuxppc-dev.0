Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Li <r64360@freescale.com>
In-Reply-To: <1196672870.14353.21.camel@Guyver>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fhlH4ov68J6MotXgbRry"
Date: Tue, 04 Dec 2007 16:38:09 +1100
Message-Id: <1196746689.20158.4.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fhlH4ov68J6MotXgbRry
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-12-03 at 17:07 +0800, Li Li wrote:
> Hi Michael,
>=20
> I emulate mpic to write this IPIC MSI routines. :)
>=20
>=20
> > > diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc=
/platforms/83xx/mpc837x_mds.c
> > > index 6048f1b..dbea34b 100644
> > > --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > > +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c

> > > +
> > > +#define	ipic_msi_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
> >=20
> > What's wrong with virq_to_hw() ?
> >=20
>=20
> viqr_to_hw is not __inline__.

Hmm, ok. The three places you use it you also take a spin lock, so I'm
not sure the function call's really going to kill you performance wise.

> > > +
> > > +static void ipic_msi_compose_msg(struct ipic_msi *msi, int hwirq,
> > > +						struct msi_msg *msg)
> > > +{
> > > +	unsigned int srs;
> > > +	unsigned int ibs;
> > > +
> > > +	srs =3D hwirq / msi->int_per_msir;
> > > +	ibs =3D hwirq - srs * msi->int_per_msir;
> > > +
> > > +	msg->address_lo =3D msi->msi_addr_lo;
> > > +	msg->address_hi =3D msi->msi_addr_hi;
> > > +	msg->data =3D (srs << 5) | (ibs & 0x1F);
> > > +
> > > +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> > > +		__FUNCTION__, srs, ibs);
> > > +
> > > +}
> > > +
> > > +static int ipic_msi_setup_irqs(struct pci_dev *pdev, int nvec, int t=
ype)
> > > +{
> > > +	struct ipic_msi *msi =3D ipic_msi;
> > > +	irq_hw_number_t hwirq;
> > > +	unsigned int virq;
> > > +	struct msi_desc *entry;
> > > +	struct msi_msg msg;
> > > +
> > > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > > +		hwirq =3D ipic_msi_alloc_hwirqs(msi, 1);
> > > +		if (hwirq < 0) {
> > > +			pr_debug("%s: fail allocating msi interrupt\n",
> > > +					__FUNCTION__);
> > > +			return hwirq;
> > > +		}
> > > +
> > > +		/* This hwirq belongs to the irq_host other than irq_host of IPIC
> > > + 		 * So, it is independent to hwirq of IPIC */
> > > +		virq =3D irq_create_mapping(msi->irqhost, hwirq);
> > > +		if (virq =3D=3D NO_IRQ) {
> > > +			pr_debug("%s: fail mapping hwirq 0x%lx\n",
> > > +					__FUNCTION__, hwirq);
> > > +			ipic_msi_free_hwirqs(msi, hwirq, 1);
> > > +			return -ENOSPC;
> > > +		}
> > > +		set_irq_msi(virq, entry);
> > > +		ipic_msi_compose_msg(msi, hwirq, &msg);
> > > +		write_msi_msg(virq, &msg);
> > > +
> > > +		hwirq++;
> >=20
> >                   ^^^^ this looks like my bug
>=20
> I have a question here. Do we support more MSI interrupts on ONE pci
> device?

I'm not sure what you mean? For MSI there is only one MSI per device,
but this code is used also for MSI-X which supports > 1 MSI per device.

Either way we shouldn't be incrementing hwirq by hand, it's reassigned
at the top of the loop. I think that's left over from old code that
allocated nvec hwirqs in a block and then created virq mappings for each
one, whereas the new code allocates each hwirq separately.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fhlH4ov68J6MotXgbRry
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHVOfBdSjSd0sB4dIRAjuxAKDIoMAtG1dGAauwSWPOjU3s8vbXpACeMc2p
H2NusdsNj40FT95eBaJw1TQ=
=oNqi
-----END PGP SIGNATURE-----

--=-fhlH4ov68J6MotXgbRry--
