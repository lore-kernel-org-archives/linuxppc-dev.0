Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA117DE140
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:16:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3M5Fxdg022478
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 22:15:59 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3M5Fu7u010038
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:15:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
Date: Tue, 22 Apr 2008 13:15:54 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A874EFD@zch01exm27.fsl.freescale.net>
In-Reply-To: <1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208758907.9955.4.camel@concordia>
	<CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
	<1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Tuesday, April 22, 2008 12:35 PM
> To: Jin Zhengxiong
> Cc: linuxppc-dev list; Gala Kumar
> Subject: RE: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
>=20
> On Mon, 2008-04-21 at 18:01 +0800, Jin Zhengxiong wrote:
> > Hi, Michael,
> >=20
> > Thank you very much for you input, please see my inline answer.
>=20
> No worries.
>=20
> > > > +static int fsl_msi_reserve_dt_hwirqs(struct fsl_msi *msi) {
> > > > +	int i, len;
> > > > +	const u32 *p;
> > > > +
> > > > +	p =3D of_get_property(msi->of_node,=20
> "msi-available-ranges", &len);
> > > > +	if (!p) {
> > > > +		pr_debug("fsl_msi: no msi-available-ranges
> > > property found \
> > > > +				on %s\n",=20
> msi->of_node->full_name);
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	if (len & 0x8 !=3D 0) {
> > > > +		printk(KERN_WARNING "fsl_msi: Malformed
> > > msi-available-ranges "
> > > > +		       "property on %s\n",=20
> msi->of_node->full_name);
> > > > +		return -EINVAL;
> > > > +	}
> > >=20
> > > Do you really want a bitwise and with 0x8?
> > >=20
> > The range for the msi interrupt can be seperated to several part.=20
> > This can used to check the if the ranges is correct.=20
>=20
> I don't see how. AFAIK the "msi-available-ranges" property is=20
> just a list of u32 pairs, so the only thing that makes sense=20
> is to check that the length is a multiple of 8, not that it=20
> has the 3rd bit set.
>=20
I found the problem. I'll check the length if it's a multiple of 8.
Thanks

> > > > +static void fsl_compose_msi_msg(struct pci_dev *pdev,=20
> int hwirq,
> > > > +				  struct msi_msg *msg)
> > > > +{
> > > > +	unsigned int srs;
> > > > +	unsigned int ibs;
> > > > +	struct fsl_msi *msi =3D fsl_msi;
> > > > +
> > > > +	srs =3D hwirq / INT_PER_MSIR;
> > > > +	ibs =3D hwirq % INT_PER_MSIR;
> > > > +
> > > > +	msg->address_lo =3D msi->msi_addr_lo;
> > > > +	msg->address_hi =3D msi->msi_addr_hi;
> > > > +	msg->data =3D (srs << 5) | (ibs & 0x1F);
> > >=20
> > > Is the 5 and 0x1F independent of the INT_PER_MSIR value?=20
> Given the=20
> > > current values isn't this a no-op, or am I missing something?
> > >=20
> > Do you mean there're another way to get the msg->data from=20
> the hwirq? =20
>=20
> No I mean I'm confused about the maths here. If we pull out=20
> the variables it boils down to:
>=20
> data =3D ((hwirq / 32) << 5) | ((hwirq % 32) & 0x1F)
>=20
> Which doesn't seem to actually do anything?
>=20
Thanks, The hwirq number can stand for the data to the msiir in this
case.
I'll change this.
