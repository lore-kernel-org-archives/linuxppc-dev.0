Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
From: Michael Ellerman <michael@ellerman.id.au>
To: Jin Zhengxiong <Jason.Jin@freescale.com>
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208758907.9955.4.camel@concordia>
	<CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ocgc/OhmyhuxlhqdhTgB"
Date: Tue, 22 Apr 2008 14:35:16 +1000
Message-Id: <1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ocgc/OhmyhuxlhqdhTgB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-04-21 at 18:01 +0800, Jin Zhengxiong wrote:
> Hi, Michael,
>=20
> Thank you very much for you input, please see my inline answer.

No worries.

> > > +static int fsl_msi_reserve_dt_hwirqs(struct fsl_msi *msi)
> > > +{
> > > +	int i, len;
> > > +	const u32 *p;
> > > +
> > > +	p =3D of_get_property(msi->of_node, "msi-available-ranges", &len);
> > > +	if (!p) {
> > > +		pr_debug("fsl_msi: no msi-available-ranges=20
> > property found \
> > > +				on %s\n", msi->of_node->full_name);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (len & 0x8 !=3D 0) {
> > > +		printk(KERN_WARNING "fsl_msi: Malformed=20
> > msi-available-ranges "
> > > +		       "property on %s\n", msi->of_node->full_name);
> > > +		return -EINVAL;
> > > +	}
> >=20
> > Do you really want a bitwise and with 0x8?
> >=20
> The range for the msi interrupt can be seperated to several part.=20
> This can used to check the if the ranges is correct.=20

I don't see how. AFAIK the "msi-available-ranges" property is just a
list of u32 pairs, so the only thing that makes sense is to check that
the length is a multiple of 8, not that it has the 3rd bit set.

> > > +static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> > > +				  struct msi_msg *msg)
> > > +{
> > > +	unsigned int srs;
> > > +	unsigned int ibs;
> > > +	struct fsl_msi *msi =3D fsl_msi;
> > > +
> > > +	srs =3D hwirq / INT_PER_MSIR;
> > > +	ibs =3D hwirq % INT_PER_MSIR;
> > > +
> > > +	msg->address_lo =3D msi->msi_addr_lo;
> > > +	msg->address_hi =3D msi->msi_addr_hi;
> > > +	msg->data =3D (srs << 5) | (ibs & 0x1F);
> >=20
> > Is the 5 and 0x1F independent of the INT_PER_MSIR value? Given the
> > current values isn't this a no-op, or am I missing something?
> >=20
> Do you mean there're another way to get the msg->data from the hwirq? =20

No I mean I'm confused about the maths here. If we pull out the
variables it boils down to:

data =3D ((hwirq / 32) << 5) | ((hwirq % 32) & 0x1F)

Which doesn't seem to actually do anything?

> > > +static int fsl_setup_msi_irqs(struct pci_dev *pdev, int=20
> > nvec, int type)
> > > +{
> > > +	irq_hw_number_t hwirq;
> > > +	int rc;
> > > +	unsigned int virq;
> > > +	struct msi_desc *entry;
> > > +	struct msi_msg msg;
> > > +	struct fsl_msi *msi =3D fsl_msi;
> >=20
> > A couple of places you put this into a local called "msi"=20
> > which is not the
> > greatest name in the world IMHO :)
> >=20
> Thank you, I'll try to use another name, Do you have any suggestion?

Oh I dunno, maybe msi_data or msi_state ?=20


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ocgc/OhmyhuxlhqdhTgB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDWsEdSjSd0sB4dIRAgtHAJ4hIClhb6FjwKiyCXrg6kGMud597QCfZLgp
X/ytrougFs/TKmkeJDmo04I=
=WaPZ
-----END PGP SIGNATURE-----

--=-ocgc/OhmyhuxlhqdhTgB--
