Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D389D1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 21:08:25 +1000 (EST)
Date: Fri, 27 Jun 2014 18:58:09 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, <vinod.koul@intel.com>,
 <s.hauer@pengutronix.de>
Subject: Re: [RFC][PATCH 1/2] dma: imx-sdma: Add device to device support
Message-ID: <20140627105808.GB2506@MrMyself>
References: <cover.1402653667.git.nicoleotsuka@gmail.com>
 <42744e778ce8a4b424d5642f86d18ef047bcc7cd.1402653667.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <42744e778ce8a4b424d5642f86d18ef047bcc7cd.1402653667.git.nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com,
 b42378@freescale.com, b02247@freescale.com, grant.likely@linaro.org,
 devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b38343@freescale.com, robh+dt@kernel.org, dan.j.williams@intel.com,
 perex@perex.cz, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org, galak@codeaurora.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 13, 2014 at 06:07:04PM +0800, Nicolin Chen wrote:
> This patch adds DEV_TO_DEV support for i.MX SDMA driver to support data
> tranfer between two peripheral FIFOs. The per_2_per script requires two
> peripheral addresses and two DMA requests. So this patch also adds them
> into private structure.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Excuse me, the patch has been here for two weeks. Could anyone please
give a comment or an Ack on it?

Thank you,
Nicolin

> ---
>  drivers/dma/imx-sdma.c                | 40 ++++++++++++++++++++++++++++++-----
>  include/linux/platform_data/dma-imx.h |  1 +
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 85561dc..5af1a69 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -258,8 +258,9 @@ struct sdma_channel {
>  	struct sdma_buffer_descriptor	*bd;
>  	dma_addr_t			bd_phys;
>  	unsigned int			pc_from_device, pc_to_device;
> +	unsigned int			device_to_device;
>  	unsigned long			flags;
> -	dma_addr_t			per_address;
> +	dma_addr_t			per_address, per_address2;
>  	unsigned long			event_mask[2];
>  	unsigned long			watermark_level;
>  	u32				shp_addr, per_addr;
> @@ -696,6 +697,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  
>  	sdmac->pc_from_device = 0;
>  	sdmac->pc_to_device = 0;
> +	sdmac->device_to_device = 0;
>  
>  	switch (peripheral_type) {
>  	case IMX_DMATYPE_MEMORY:
> @@ -770,6 +772,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  
>  	sdmac->pc_from_device = per_2_emi;
>  	sdmac->pc_to_device = emi_2_per;
> +	sdmac->device_to_device = per_2_per;
>  }
>  
>  static int sdma_load_context(struct sdma_channel *sdmac)
> @@ -782,11 +785,12 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	int ret;
>  	unsigned long flags;
>  
> -	if (sdmac->direction == DMA_DEV_TO_MEM) {
> +	if (sdmac->direction == DMA_DEV_TO_MEM)
>  		load_address = sdmac->pc_from_device;
> -	} else {
> +	else if (sdmac->direction == DMA_DEV_TO_DEV)
> +		load_address = sdmac->device_to_device;
> +	else
>  		load_address = sdmac->pc_to_device;
> -	}
>  
>  	if (load_address < 0)
>  		return load_address;
> @@ -850,6 +854,12 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
>  		sdma_event_enable(sdmac, sdmac->event_id0);
>  	}
>  
> +	if (sdmac->event_id1) {
> +		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
> +			return -EINVAL;
> +		sdma_event_enable(sdmac, sdmac->event_id1);
> +	}
> +
>  	switch (sdmac->peripheral_type) {
>  	case IMX_DMATYPE_DSP:
>  		sdma_config_ownership(sdmac, false, true, true);
> @@ -880,7 +890,12 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
>  		/* Watermark Level */
>  		sdmac->watermark_level |= sdmac->watermark_level;
>  		/* Address */
> -		sdmac->shp_addr = sdmac->per_address;
> +		if (sdmac->direction == DMA_DEV_TO_DEV) {
> +			sdmac->shp_addr = sdmac->per_address2;
> +			sdmac->per_addr = sdmac->per_address;
> +		} else {
> +			sdmac->shp_addr = sdmac->per_address;
> +		}
>  	} else {
>  		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
>  	}
> @@ -974,6 +989,7 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  
>  	sdmac->peripheral_type = data->peripheral_type;
>  	sdmac->event_id0 = data->dma_request;
> +	sdmac->event_id1 = data->dma_request2;
>  
>  	clk_enable(sdmac->sdma->clk_ipg);
>  	clk_enable(sdmac->sdma->clk_ahb);
> @@ -1213,6 +1229,19 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  			sdmac->watermark_level = dmaengine_cfg->src_maxburst *
>  						dmaengine_cfg->src_addr_width;
>  			sdmac->word_size = dmaengine_cfg->src_addr_width;
> +		} else if (dmaengine_cfg->direction == DMA_DEV_TO_DEV) {
> +			sdmac->per_address = dmaengine_cfg->src_addr;
> +			sdmac->per_address2 = dmaengine_cfg->dst_addr;
> +			/*
> +			 * For per_2_per sciprt, register r7 requires two
> +			 * watermark levels: the lower placed at bits [0-7]
> +			 * and the higher one placed at bits [16-23].
> +			 */
> +			sdmac->watermark_level =
> +				dmaengine_cfg->src_maxburst & 0xff;
> +			sdmac->watermark_level |=
> +				(dmaengine_cfg->dst_maxburst & 0xff) << 16;
> +			sdmac->word_size = dmaengine_cfg->dst_addr_width;
>  		} else {
>  			sdmac->per_address = dmaengine_cfg->dst_addr;
>  			sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
> @@ -1433,6 +1462,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  	data.dma_request = dma_spec->args[0];
>  	data.peripheral_type = dma_spec->args[1];
>  	data.priority = dma_spec->args[2];
> +	data.dma_request2 = 0;
>  
>  	return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7aa0e89..6a1357d 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -51,6 +51,7 @@ enum imx_dma_prio {
>  
>  struct imx_dma_data {
>  	int dma_request; /* DMA request line */
> +	int dma_request2; /* secondary DMA request line */
>  	enum sdma_peripheral_type peripheral_type;
>  	int priority;
>  };
> -- 
> 1.8.4
> 
