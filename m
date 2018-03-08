Return-Path: <nipun.gupta@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxqfL4Ly4zF1r4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 23:32:39 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Bharat Bhushan
 <bharat.bhushan@nxp.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li
 <leoyang.li@nxp.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Thu, 8 Mar 2018 12:32:28 +0000
Message-ID: <HE1PR0401MB24257DC948C69C7A9080ED66E6DF0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
In-Reply-To: <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, March 08, 2018 4:10
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: will.deacon@arm.com; robin.murphy@arm.com; mark.rutland@arm.com;
> catalin.marinas@arm.com; devicetree@vger.kernel.org; stuyoder@gmail.com;
> Bharat Bhushan <bharat.bhushan@nxp.com>; gregkh@linuxfoundation.org;
> joro@8bytes.org; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.=
org;
> Leo Li <leoyang.li@nxp.com>; iommu@lists.linux-foundation.org; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>; shawnguo@kernel.org; hch@lst.de; linux-
> arm-kernel@lists.infradead.org; m.szyprowski@samsung.com
> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree bi=
nding
>=20
> On Mon, Mar 05, 2018 at 07:59:21PM +0530, Nipun Gupta wrote:
> > The existing IOMMU bindings cannot be used to specify the relationship
> > between fsl-mc devices and IOMMUs. This patch adds a binding for
> > mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31
> ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > index 6611a7c..011c7d6 100644
> > --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware
> objects/devices
> >  such as network interfaces, crypto accelerator instances, L2 switches,
> >  etc.
> >
> > +For an overview of the DPAA2 architecture and fsl-mc bus see:
> > +drivers/staging/fsl-mc/README.txt
> > +
> > +As described in the above overview, all DPAA2 objects in a DPRC share =
the
> > +same hardware "isolation context" and a 10-bit value called an ICID
> > +(isolation context id) is expressed by the hardware to identify
> > +the requester.
> > +
> > +The generic 'iommus' property is cannot be used to describe the relati=
onship
> > +between fsl-mc and IOMMUs, so an iommu-parent property is used to defi=
ne
> > +the same.
>=20
> Why not? It is just a link between 2 nodes.

We have #iommu-cells as '1' i.e. iommu will have one stream ID configured f=
or a device.
Once USB and other devices start to use IOMMU we will also need this iommu-=
cells.

When #iommu-cells is defined as '1' and we have 'iommus=3D<&smmu>' compilat=
ion
reports warning about the mismatch.
In fsl-mc bus case we do not have any stream id associated with the bus.

As suggested by Robin, we can simply use the iommu-map property.

>=20
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +For arm-smmu binding, see:
> > +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> > +
> >  Required properties:
> >
> >      - compatible
> > @@ -88,14 +106,27 @@ Sub-nodes:
> >                Value type: <phandle>
> >                Definition: Specifies the phandle to the PHY device node=
 associated
> >                            with the this dpmac.
> > +Optional properties:
> > +
> > +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> > +  The property specifies the IOMMU behind which the devices on
> > +  fsl-mc bus are residing.
>=20
> If you want a generic property, this should be documented in the common
> binding.

We can use the iommu-map property which is already documented.

>=20
> Couldn't you have more than 1 IOMMU upstream of a MC?

There is no such device currently with which fsl-mc bus uses more than one =
iommu.
Infact, our current systems have only single IOMMU :).

Even in future if such devices are there then we can use iommu-map to speci=
fy
more than one iommu with separate requester ID's (RID's).

Thank you for review...

Regards,
Nipun

>=20
> >
> >  Example:
> >
> > +        smmu: iommu@5000000 {
> > +               compatible =3D "arm,mmu-500";
> > +               #iommu-cells =3D <1>;
> > +               stream-match-mask =3D <0x7C00>;
> > +               ...
> > +        };
> > +
> >          fsl_mc: fsl-mc@80c000000 {
> >                  compatible =3D "fsl,qoriq-mc";
> >                  reg =3D <0x00000008 0x0c000000 0 0x40>,    /* MC porta=
l base */
> >                        <0x00000000 0x08340000 0 0x40000>; /* MC control=
 reg */
> >                  msi-parent =3D <&its>;
> > +                iommu-parent =3D <&smmu>;
> >                  #address-cells =3D <3>;
> >                  #size-cells =3D <1>;
> >
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> >
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&data=3D02%7C01%7Cnipun.gupta%40nxp.com%7Cf64b4fe9c5cf45ce8a9a
> 08d5847c6919%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636560
> 592302736942&sdata=3DiOwv%2Fzd8UTLm7YCapDOWzrtd48VQeYY2vlufck7eYZI
> %3D&reserved=3D0
