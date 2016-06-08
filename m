Return-Path: <jonathanh@nvidia.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPhT62yndzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 18:30:18 +1000 (AEST)
Subject: Re: [PATCH 8/8] dmaengine: Remove site specific OOM error messages on
 kzalloc
To: Peter Griffin <peter.griffin@linaro.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel@stlinux.com>, <vinod.koul@intel.com>, <linus.walleij@linaro.org>,
 <dan.j.williams@intel.com>, <leoli@freescale.com>, <zw@zh-kernel.org>,
 <baohua@kernel.org>, <maxime.ripard@free-electrons.com>, <wens@csie.org>,
 <ldewangan@nvidia.com>, <swarren@wwwdotorg.org>, <thierry.reding@gmail.com>,
 <gnurou@gmail.com>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
CC: <lee.jones@linaro.org>, <dmaengine@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5757D5DB.5030401@nvidia.com>
Date: Wed, 8 Jun 2016 09:22:51 +0100
MIME-Version: 1.0
In-Reply-To: <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07/06/16 18:38, Peter Griffin wrote:
> If kzalloc() fails it will issue it's own error message including
> a dump_stack(). So remove the site specific error messages.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/dma/amba-pl08x.c        | 10 +---------
>  drivers/dma/bestcomm/bestcomm.c |  2 --
>  drivers/dma/edma.c              | 16 ++++------------
>  drivers/dma/fsldma.c            |  2 --
>  drivers/dma/k3dma.c             | 10 ++++------
>  drivers/dma/mmp_tdma.c          |  5 ++---
>  drivers/dma/moxart-dma.c        |  4 +---
>  drivers/dma/nbpfaxi.c           |  5 ++---
>  drivers/dma/pl330.c             |  5 +----
>  drivers/dma/ppc4xx/adma.c       |  2 --
>  drivers/dma/s3c24xx-dma.c       |  5 +----
>  drivers/dma/sh/shdmac.c         |  9 ++-------
>  drivers/dma/sh/sudmac.c         |  9 ++-------
>  drivers/dma/sirf-dma.c          |  5 ++---
>  drivers/dma/ste_dma40.c         |  4 +---
>  drivers/dma/tegra20-apb-dma.c   | 11 +++--------
>  drivers/dma/timb_dma.c          |  8 ++------
>  17 files changed, 28 insertions(+), 84 deletions(-)

[snip]

> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 7f4af8c..032884f 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -300,10 +300,8 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
>  
>  	/* Allocate DMA desc */
>  	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
> -	if (!dma_desc) {
> -		dev_err(tdc2dev(tdc), "dma_desc alloc failed\n");
> +	if (!dma_desc)
>  		return NULL;
> -	}
>  
>  	dma_async_tx_descriptor_init(&dma_desc->txd, &tdc->dma_chan);
>  	dma_desc->txd.tx_submit = tegra_dma_tx_submit;
> @@ -340,8 +338,7 @@ static struct tegra_dma_sg_req *tegra_dma_sg_req_get(
>  	spin_unlock_irqrestore(&tdc->lock, flags);
>  
>  	sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
> -	if (!sg_req)
> -		dev_err(tdc2dev(tdc), "sg_req alloc failed\n");
> +
>  	return sg_req;
>  }
>  
> @@ -1319,10 +1316,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  
>  	tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
>  			sizeof(struct tegra_dma_channel), GFP_KERNEL);
> -	if (!tdma) {
> -		dev_err(&pdev->dev, "Error: memory allocation failed\n");
> +	if (!tdma)
>  		return -ENOMEM;
> -	}
>  
>  	tdma->dev = &pdev->dev;
>  	tdma->chip_data = cdata;

For the tegra portion ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
