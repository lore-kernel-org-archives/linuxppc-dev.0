Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF5f90H0SzF0RB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 04:55:12 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id c194so3052169pga.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jan 2018 09:55:12 -0800 (PST)
Date: Sun, 7 Jan 2018 09:55:03 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH -next] ASoC: fsl_ssi: Fix build error
Message-ID: <20180107175503.GA5148@Asurada>
References: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 07, 2018 at 09:05:50AM -0800, Guenter Roeck wrote:
> powerpc:mpc85xx_defconfig fails to build with the following errors.
> 
> sound/soc/fsl/fsl_dma.c: In function 'fsl_soc_dma_probe':
> sound/soc/fsl/fsl_dma.c:916:34: error: 'CCSR_SSI_STX0' undeclared
> sound/soc/fsl/fsl_dma.c:917:34: error: 'CCSR_SSI_SRX0' undeclared
> 
> Fixes: a818aa5f967b ("ASoC: fsl_ssi: Rename registers and fields macros")
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Cc: Timur Tabi <timur@tabi.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I would suggest to merge this patch into the offending patch to preserve
> bisectability.
> 
>  sound/soc/fsl/fsl_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 0c11f434a374..8c2981b70f64 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -913,8 +913,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
>  	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
>  
>  	/* Store the SSI-specific information that we need */
> -	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
> -	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
> +	dma->ssi_stx_phys = res.start + REG_SSI_STX0;
> +	dma->ssi_srx_phys = res.start + REG_SSI_SRX0;
>  
>  	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
>  	if (iprop)
> -- 
> 2.7.4
> 
