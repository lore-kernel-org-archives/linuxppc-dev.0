Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l0q60GS8zF3Yf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 22:48:01 +1000 (AEST)
Date: Mon, 14 May 2018 07:47:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
 robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 gregkh@linuxfoundation.org, hch@lst.de, joro@8bytes.org,
 m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com
Subject: Re: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Message-ID: <20180514124757.GA253589@bhelgaas-glaptop.roam.corp.google.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When you add the changleog, please also fix the subject typo:

- bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
               ^^^^^^^
+ bus: fsl-mc: support dma configure for devices on fsl-mc bus

On Mon, Apr 30, 2018 at 11:57:20AM +0530, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev = dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev = dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
>  	.name = "fsl-mc",
>  	.match = fsl_mc_bus_match,
>  	.uevent = fsl_mc_bus_uevent,
> +	.dma_configure  = fsl_mc_dma_configure,
>  	.dev_groups = fsl_mc_dev_groups,
>  };
>  EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  		mc_dev->icid = parent_mc_dev->icid;
>  		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>  		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>  		dev_set_msi_domain(&mc_dev->dev,
>  				   dev_get_msi_domain(&parent_mc_dev->dev));
>  	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  			goto error_cleanup_dev;
>  	}
>  
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>  	/*
>  	 * The device-specific probe callback will get invoked by device_add()
>  	 */
> -- 
> 1.9.1
> 
