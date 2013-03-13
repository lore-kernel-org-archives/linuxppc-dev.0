Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CAB72C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 18:15:05 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
 errata
Date: Wed, 13 Mar 2013 07:14:53 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C157AA@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1363074482-868-1-git-send-email-B38951@freescale.com>
 <20130313050403.GB9317@concordia>
In-Reply-To: <20130313050403.GB9317@concordia>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]
> Sent: Wednesday, March 13, 2013 1:04 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421
> Subject: Re: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
> errata
>=20
> On Tue, Mar 12, 2013 at 03:48:02PM +0800, Jia Hongtao wrote:
> > The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of
> mpc8544),
> > It causes that neither MSI nor MSI-X can work fine. This is a
> workaround
> > to allow MSI-X to function properly.
>=20
> You say "neither MSI nor MSI-X can work fine", which I take to mean
> "both MSI and MSI-X do not work".
>=20
> But then you say this is a workaround to allow MSI-X to work.
>=20
> So what I think you mean is, the erratum prevents both MSI and MSI-X
> from working. This is a workaround that allows MSI-X to work, and in
> addition
> the patch prevents MSI from being used on chips with the erratum -
> because there is no workaround for MSI.

I'm happy that you understand the patch.

>=20
> > diff --git a/arch/powerpc/sysdev/fsl_msi.c
> b/arch/powerpc/sysdev/fsl_msi.c
> > index 178c994..0dea680 100644
> > --- a/arch/powerpc/sysdev/fsl_msi.c
> > +++ b/arch/powerpc/sysdev/fsl_msi.c
> > @@ -98,8 +98,20 @@ static int fsl_msi_init_allocator(struct fsl_msi
> *msi_data)
> >
> >  static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int
> type)
> >  {
> > +	struct fsl_msi *msi;
> > +
> >  	if (type =3D=3D PCI_CAP_ID_MSIX)
> >  		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
>=20
> Seeing as this patch is enabling a workaround for MSI-X you've obviously
> tested MSI-X, so you should remove the two lines above.

Right, will be removed.

>=20
> > +	else if (type =3D=3D PCI_CAP_ID_MSI)
> > +		/*
> > +		 * MPIC chip with 2.0 version has erratum PIC1. It
> > +		 * causes that neither MSI nor MSI-X can work fine.
> > +		 * This is a workaround to allow MSI-X to function
> > +		 * properly.
> > +		 */
>=20
> This is not a workaround. This is a check to prevent MSI from being used
> on buggy chipsets.

Yes, I will move the comments to the right place.

>=20
> > +		list_for_each_entry(msi, &msi_head, list)
> > +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
> > +				return -EINVAL;
>=20
> I take it you're happy preventing MSI for all devices even if only a
> single chip in the machine has the erratum? In practice you probably
> have all or none with the erratum right?

Need more investigations for this comment.

>=20
> I would suggest brackets on an if with such a large body, even though it
> is OK as it is.
>=20

Actually, I'd like to brackets on *if body* too. I just follow the kernel
*CodingStyle*: "Do not unnecessarily use braces where a single statement wi=
ll do."

In this case, I will use braces to make code clearer.

> >
> >  	return 0;
> >  }
> > @@ -142,7 +154,11 @@ static void fsl_compose_msi_msg(struct pci_dev
> *pdev, int hwirq,
> >  	msg->address_lo =3D lower_32_bits(address);
> >  	msg->address_hi =3D upper_32_bits(address);
> >
> > -	msg->data =3D hwirq;
> > +	/* See the comment in fsl_msi_check_device() */
> > +	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
> > +		msg->data =3D __swab32(hwirq);
> > +	else
> > +		msg->data =3D hwirq;
>=20
> This is the workaround. The comment here should say, "this only works
> for MSI-X, we prevent MSI in on buggy chips in fsl_msi_check_device()".

Very helpful comment.

>=20
> >
> >  	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> >  		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
> > @@ -361,13 +377,43 @@ static int fsl_msi_setup_hwirq(struct fsl_msi
> *msi, struct platform_device *dev,
> >  	return 0;
> >  }
> >
> > +/* MPIC chip with 2.0 version has erratum PIC1 */
> > +static int mpic_has_errata(struct platform_device *dev)
> > +{
> > +	struct device_node *mpic_node;
> > +
> > +	mpic_node =3D of_irq_find_parent(dev->dev.of_node);
> > +	if (mpic_node) {
> > +		u32 *reg_base, brr1 =3D 0;
> > +		/* Get the PIC reg base */
> > +		reg_base =3D of_iomap(mpic_node, 0);
> > +		of_node_put(mpic_node);
> > +		if (!reg_base) {
> > +			dev_err(&dev->dev, "ioremap problem failed.\n");
> > +			return -EIO;
> > +		}
> > +
> > +		/* Get the mpic chip version from block revision register 1
> */
> > +		brr1 =3D in_be32(reg_base + MPIC_FSL_BRR1);
> > +		iounmap(reg_base);
> > +		if ((brr1 & MPIC_FSL_BRR1_VER) =3D=3D 0x0200)
> > +			return 1;
> > +	} else {
> > +		dev_err(&dev->dev, "MSI can't find his parent mpic node.\n");
> > +		of_node_put(mpic_node);
>=20
> You don't need the put here, you know it's NULL (you just checked).

Yes.

>=20
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct of_device_id fsl_of_msi_ids[];
> >  static int fsl_of_msi_probe(struct platform_device *dev)
> >  {
> >  	const struct of_device_id *match;
> >  	struct fsl_msi *msi;
> >  	struct resource res;
> > -	int err, i, j, irq_index, count;
> > +	int err, i, j, irq_index, count, errata;
> >  	int rc;
> >  	const u32 *p;
> >  	const struct fsl_msi_feature *features;
> > @@ -423,6 +469,16 @@ static int fsl_of_msi_probe(struct platform_device
> *dev)
> >
> >  	msi->feature =3D features->fsl_pic_ip;
> >
> > +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D FSL_PIC_IP_MPIC) =
{
> > +		errata =3D mpic_has_errata(dev);
> > +		if (errata > 0) {
> > +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
> > +		} else if (errata < 0) {
> > +			err =3D errata;
> > +			goto error_out;
> > +		}
>=20
> I don't think you need errata here, "rc" would be fine.

Sounds reasonable.

>=20
> cheers

Very grateful for all the constructive comments.
-Hongtao.
