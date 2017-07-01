Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x01Fy6FtNzDr8Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jul 2017 14:51:50 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id e199so19177389pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 21:51:50 -0700 (PDT)
Date: Fri, 30 Jun 2017 21:51:41 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-ssi: add check on platform_get_irq return value
Message-ID: <20170701045140.GA9664@Asurada>
References: <20170630221735.GA17951@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170630221735.GA17951@embeddedgus>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 30, 2017 at 05:17:35PM -0500, Gustavo A. R. Silva wrote:
> Check return value from call to platform_get_irq(),
> so in case of failure print error message and propagate
> the return value.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/imx-ssi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index b95132e..0679061 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -527,6 +527,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  	}
>  
>  	ssi->irq = platform_get_irq(pdev, 0);
> +	if (ssi->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
> +		return ssi->irq;
> +	}
>  
>  	ssi->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(ssi->clk)) {
> -- 
> 2.5.0
> 
