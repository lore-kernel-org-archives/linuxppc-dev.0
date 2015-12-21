Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AA8C1A0C38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 18:34:37 +1100 (AEDT)
Received: by mail-pa0-x235.google.com with SMTP id wq6so95359529pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 23:34:37 -0800 (PST)
Date: Sun, 20 Dec 2015 23:34:32 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Timur Tabi <timur@tabi.org>, kernel-janitors@vger.kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: imx-pcm-dma: add NULL test
Message-ID: <20151221073431.GD3524@Asurada-CZ80>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450610153-7746-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450610153-7746-2-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 20, 2015 at 12:15:50PM +0100, Julia Lawall wrote:
> Add NULL test on call to devm_kzalloc.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x;
> @@
> 
> * x = devm_kzalloc(...);
>   ... when != x == NULL
>   *x
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> 
> ---
>  sound/soc/fsl/imx-pcm-dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index 1fc01ed..f3d3d1f 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -62,6 +62,8 @@ int imx_pcm_dma_init(struct platform_device *pdev, size_t size)
>  
>  	config = devm_kzalloc(&pdev->dev,
>  			sizeof(struct snd_dmaengine_pcm_config), GFP_KERNEL);
> +	if (!config)
> +		return -ENOMEM;
>  	*config = imx_dmaengine_pcm_config;
>  	if (size)
>  		config->prealloc_buffer_size = size;
> 
