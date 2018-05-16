Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0089.outbound.protection.outlook.com [104.47.1.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m7QX1pSbzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 18:49:05 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>
CC: "hch@lst.de" <hch@lst.de>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Date: Wed, 16 May 2018 08:48:57 +0000
Message-ID: <HE1PR0401MB24253CF729DDCF3F883AC256E6920@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
 <5AF9916E.8000504@nxp.com>
In-Reply-To: <5AF9916E.8000504@nxp.com>
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



> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Monday, May 14, 2018 7:10 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; robin.murphy@arm.com;
> will.deacon@arm.com; mark.rutland@arm.com; catalin.marinas@arm.com
> Cc: hch@lst.de; gregkh@linuxfoundation.org; joro@8bytes.org;
> robh+dt@kernel.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for device=
s
> on fsl-mc bus
>=20
> Hi Nipun,
>=20
> On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-m=
c-
> bus.c
> > index 5d8266c..624828b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> >   	return 0;
> >   }
> >
> > +static int fsl_mc_dma_configure(struct device *dev)
> > +{
> > +	struct device *dma_dev =3D dev;
> > +
> > +	while (dev_is_fsl_mc(dma_dev))
> > +		dma_dev =3D dma_dev->parent;
> > +
> > +	return of_dma_configure(dev, dma_dev->of_node, 0);
> > +}
> > +
> >   static ssize_t modalias_show(struct device *dev, struct device_attrib=
ute
> *attr,
> >   			     char *buf)
> >   {
> > @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type =3D {
> >   	.name =3D "fsl-mc",
> >   	.match =3D fsl_mc_bus_match,
> >   	.uevent =3D fsl_mc_bus_uevent,
> > +	.dma_configure  =3D fsl_mc_dma_configure,
> >   	.dev_groups =3D fsl_mc_dev_groups,
> >   };
> >   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> > @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   		mc_dev->icid =3D parent_mc_dev->icid;
> >   		mc_dev->dma_mask =3D FSL_MC_DEFAULT_DMA_MASK;
> >   		mc_dev->dev.dma_mask =3D &mc_dev->dma_mask;
> > +		mc_dev->dev.coherent_dma_mask =3D mc_dev->dma_mask;
>=20
> This change seems a bit unrelated to the patch subject. I wonder if it
> makes sense to split it it in a distinct patch.

Okay. I will spin a v5 after splitting this patch and adding changelog (Gre=
g's comment), fixing typo (Bjorn's comment).

Regards,
Nipun

>=20
> ---
> Best Regards, Laurentiu
