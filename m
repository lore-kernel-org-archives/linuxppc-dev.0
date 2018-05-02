Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0078.outbound.protection.outlook.com [104.47.1.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bY6d31hTzF2SB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 19:35:35 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Date: Wed, 2 May 2018 09:35:27 +0000
Message-ID: <5AE98603.6020007@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---

If my understanding is correct, the kbuild error is triggered by this=20
missing dependency patch:

https://patchwork.kernel.org/patch/10370081/

Apart from that, patch looks good to me, so

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

>   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-=
bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, str=
uct kobj_uevent_env *env)
>   	return 0;
>   }
>
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev =3D dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev =3D dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>   static ssize_t modalias_show(struct device *dev, struct device_attribut=
e *attr,
>   			     char *buf)
>   {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type =3D {
>   	.name =3D "fsl-mc",
>   	.match =3D fsl_mc_bus_match,
>   	.uevent =3D fsl_mc_bus_uevent,
> +	.dma_configure  =3D fsl_mc_dma_configure,
>   	.dev_groups =3D fsl_mc_dev_groups,
>   };
>   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_des=
c,
>   		mc_dev->icid =3D parent_mc_dev->icid;
>   		mc_dev->dma_mask =3D FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask =3D &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask =3D mc_dev->dma_mask;
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_de=
sc,
>   			goto error_cleanup_dev;
>   	}
>
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>   	/*
>   	 * The device-specific probe callback will get invoked by device_add()
>   	 */
>=
