Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ACB32DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 10:22:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] Device tree bindings for Xilinx devices
Date: Tue, 16 Oct 2007 17:21:35 -0700
In-Reply-To: <fa686aa40710161236h4cc82edbqfee328bbcb21c752@mail.gmail.com>
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
	<20071016182425.DCBF0BA804F@mail41-fra.bigfish.com>
	<fa686aa40710161236h4cc82edbqfee328bbcb21c752@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071017002156.289E2B58056@mail41-cpk.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au,
	Wolfgang Reissnegger <wre@xilinx.com>, Leonid <Leonid@a-k-a.net>
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
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Tuesday, October 16, 2007 12:36 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; Wolfgang Reissnegger; Leonid;=20
> microblaze-uclinux@itee.uq.edu.au
> Subject: Re: [PATCH v2] Device tree bindings for Xilinx devices
>=20
> On 10/16/07, Stephen Neuendorffer=20
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > > +   n) Xilinx EMAC and Xilinx TEMAC
> > > +
> > > +   Xilinx Ethernet devices.  Uses common properties from
> > > other Ethernet
> > > +   devices with the following constraints:
> > > +
> > > +   Required properties:
> > > +    - compatible : Must include one of: "xilinx,plb-temac",
> > > +                   "xilinx,plb-emac", "xilinx-opb-emac"
> > > +    - dma-mode : Must be one of "none", "simple", "sg" (sg
> > > =3D=3D scatter gather)
> >
> > I think it's going to be a significant headache to remap=20
> things like the
> > dma-mode from the xilinx configurations to something else, and then
> > interpret them correctly in the drivers.
> >
> > Although it lacks a bit in style, perhaps, I'd greatly prefer having
> > something like:
> >
> >         Ethernet_MAC {
> >                 xilinx,C_DMA_PRESENT =3D <1>;
> >             ...
> >       }
> >
> > (which happens to correspond to "none" above)
>=20
> Ugh.  Can't say I'm thrilled about this....
>=20
> But in this case is might be a necessity.  The IP core is already
> parameterized and the best way to describe the device is to use the
> existing parameter names.

I don't really like it either, expecially after thinking about it more.
The problem is that a single IP core might correspond to multiple
logical devices.  The parameters actually need to be from the point of
view of the drivers. That is, they need to be names like in the
xparameters:

	xilinx,DMA_PRESENT =3D <1>;

In this case, the translation looks simple, but it is currently
implemented by a bunch of gnarly .tcl code.  (Don't ask... :)  In the
future, this *could* be simple code, but in the short term, it won't be
any simpler than having pretty names.  Furthermore, the best driver code
that I can come up with for using this essentially looks like:

static int __devinit xenet_of_probe(struct of_device *ofdev, const
struct of_device_id *match)
{
	struct xemac_platform_data pdata_struct;
	struct resource r_irq_struct;
	struct resource r_mem_struct;

	struct resource *r_irq =3D &r_irq_struct;	/* Interrupt resources
*/
	struct resource *r_mem =3D &r_mem_struct;	/* IO mem resources */
	struct xemac_platform_data *pdata =3D &pdata_struct;
	int rc =3D 0;

	printk(KERN_ERR "Device Tree Probing \'%s\'\n",
                        ofdev->node->name);

	/* Get iospace for the device */
	rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
	if(rc) {
		dev_warn(&ofdev->dev, "invalid address\n");
		return rc;
	}

	/* Get IRQ for the device */
	rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
	if(rc =3D=3D NO_IRQ) {
		dev_warn(&ofdev->dev, "no IRQ found.\n");
		return rc;
	}

	pdata_struct.dma_mode           =3D get_u32(ofdev,
"C_DMA_PRESENT");
	pdata_struct.has_mii		=3D get_u32(ofdev, "C_MII_EXIST");
	pdata_struct.has_cam		=3D get_u32(ofdev, "C_CAM_EXIST");
	pdata_struct.has_err_cnt	=3D get_u32(ofdev,
"C_ERR_COUNT_EXIST");
	pdata_struct.has_jumbo		=3D get_u32(ofdev,
"C_JUMBO_EXIST");
	pdata_struct.tx_dre		=3D get_u32(ofdev,
"C_TX_DRE_TYPE");
	pdata_struct.rx_dre		=3D get_u32(ofdev,
"C_RX_DRE_TYPE");
	pdata_struct.tx_hw_csum		=3D get_u32(ofdev,
"C_TX_INCLUDE_CSUM");
	pdata_struct.rx_hw_csum		=3D get_u32(ofdev,
"C_RX_INCLUDE_CSUM");
	memcpy(pdata_struct.mac_addr, of_get_mac_address(ofdev->node),
6);

        return probe_initialization(&ofdev->dev, r_mem, r_irq, pdata);
}

Where probe_initialization contains shares code with the platform_device
version of probe.  This means that the string is still translated into
another name anyway.  Anybody have any better ideas for doing this?

>=20
> I want to be careful though.  Parameters can change from one version
> of an IP core to another.  The driver needs to be able to determine
> what version of the IP core is used so that the parameters make sense.
>  I'm also nervous about adding every possible C_ value to the device
> node for each xilinx IP-core; that could make the device tree quite
> large.  (on the other hand; maybe that doesn't matter... It is
> probably a bigger deal for microblaze than powerpc too.).

Using the xparameters set of values could solve this problem, since only
things that make sense to the driver are actually set.

Steve

>=20
> Cheers,
> g.
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>=20
>=20
