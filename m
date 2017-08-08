Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRKbn2Y8XzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 13:28:05 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y192so1963827pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 20:28:05 -0700 (PDT)
Date: Mon, 7 Aug 2017 20:27:43 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH v3] ASoC: fsl: Convert to using %pOF instead of full_name
Message-ID: <20170808032742.GA10188@Asurada>
References: <20170807232919.30247-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170807232919.30247-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2017 at 06:29:18PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Timur Tabi <timur@tabi.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: alsa-devel@alsa-project.org
> ---
> v3: Split ASoC changes to separate patch
> 
>  sound/soc/fsl/fsl_dma.c    |  4 ++--
>  sound/soc/fsl/imx-audmux.c | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index ccadefceeff2..ed8ea002902d 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -897,8 +897,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
>  
>  	ret = of_address_to_resource(ssi_np, 0, &res);
>  	if (ret) {
> -		dev_err(&pdev->dev, "could not determine resources for %s\n",
> -			ssi_np->full_name);
> +		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
> +			ssi_np);
>  		of_node_put(ssi_np);
>  		return ret;
>  	}
> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index fc57da341d61..392d5eef356d 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -268,13 +268,13 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
>  
>  		ret = of_property_read_u32(child, "fsl,audmux-port", &port);
>  		if (ret) {
> -			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%s\"\n",
> -					child->full_name);
> +			dev_warn(&pdev->dev, "Failed to get fsl,audmux-port of child node \"%pOF\"\n",
> +					child);
>  			continue;
>  		}
>  		if (!of_property_read_bool(child, "fsl,port-config")) {
> -			dev_warn(&pdev->dev, "child node \"%s\" does not have property fsl,port-config\n",
> -					child->full_name);
> +			dev_warn(&pdev->dev, "child node \"%pOF\" does not have property fsl,port-config\n",
> +					child);
>  			continue;
>  		}
>  
> @@ -292,15 +292,15 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
>  		}
>  
>  		if (ret != -EOVERFLOW) {
> -			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
> -					i, child->full_name);
> +			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %pOF\n",
> +					i, child);
>  			continue;
>  		}
>  
>  		if (audmux_type == IMX31_AUDMUX) {
>  			if (i % 2) {
> -				dev_err(&pdev->dev, "One pdcr value is missing in child node %s\n",
> -						child->full_name);
> +				dev_err(&pdev->dev, "One pdcr value is missing in child node %pOF\n",
> +						child);
>  				continue;
>  			}
>  			imx_audmux_v2_configure_port(port, ptcr, pdcr);
> -- 
> 2.11.0
> 
