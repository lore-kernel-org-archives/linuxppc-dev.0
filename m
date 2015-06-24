Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 568CC1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 17:00:45 +1000 (AEST)
Received: by pdcu2 with SMTP id u2so24156970pdc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 00:00:42 -0700 (PDT)
Date: Wed, 24 Jun 2015 00:00:37 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl: Add dedicated DMA buffer size for each cpu dai
Message-ID: <20150624070037.GA2926@Asurada-CZ80>
References: <1435055033-12608-1-git-send-email-shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435055033-12608-1-git-send-email-shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2015 at 06:23:53PM +0800, Shengjiu Wang wrote:
> As the ssi is not the only cpu dai, there are esai, spdif, sai.
> and imx_pcm_dma can be used by all of them. Especially ESAI need
> a larger DMA buffer size. So Add dedicated DMA buffer for each cpu
> dai.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_esai.c    |    2 +-
>  sound/soc/fsl/fsl_sai.c     |    2 +-
>  sound/soc/fsl/fsl_spdif.c   |    2 +-
>  sound/soc/fsl/fsl_ssi.c     |    2 +-
>  sound/soc/fsl/imx-pcm-dma.c |   25 +++++++++++++++++++++----
>  sound/soc/fsl/imx-pcm.h     |    9 +++++++--
>  sound/soc/fsl/imx-ssi.c     |    2 +-
>  7 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 5c75971..8c2ddc1 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -839,7 +839,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = imx_pcm_dma_init(pdev);
> +	ret = imx_pcm_dma_init(pdev, IMX_ESAI_DMABUF_SIZE);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to init imx pcm dma: %d\n", ret);
>  
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 5c73bea..a18fd92 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -791,7 +791,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (sai->sai_on_imx)
> -		return imx_pcm_dma_init(pdev);
> +		return imx_pcm_dma_init(pdev, IMX_SAI_DMABUF_SIZE);
>  	else
>  		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>  }
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 8e93221..d1e9be7 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1255,7 +1255,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = imx_pcm_dma_init(pdev);
> +	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
>  	if (ret)
>  		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
>  
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index c7647e0..e122dab 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1257,7 +1257,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
>  		if (ret)
>  			goto error_pcm;
>  	} else {
> -		ret = imx_pcm_dma_init(pdev);
> +		ret = imx_pcm_dma_init(pdev, IMX_SSI_DMABUF_SIZE);
>  		if (ret)
>  			goto error_pcm;
>  	}
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index 0db94f49..1fc01ed 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -40,7 +40,7 @@ static const struct snd_pcm_hardware imx_pcm_hardware = {
>  		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_PAUSE |
>  		SNDRV_PCM_INFO_RESUME,
> -	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
> +	.buffer_bytes_max = IMX_DEFAULT_DMABUF_SIZE,
>  	.period_bytes_min = 128,
>  	.period_bytes_max = 65535, /* Limited by SDMA engine */
>  	.periods_min = 2,
> @@ -52,13 +52,30 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
>  	.pcm_hardware = &imx_pcm_hardware,
>  	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
>  	.compat_filter_fn = filter,
> -	.prealloc_buffer_size = IMX_SSI_DMABUF_SIZE,
> +	.prealloc_buffer_size = IMX_DEFAULT_DMABUF_SIZE,
>  };
>  
> -int imx_pcm_dma_init(struct platform_device *pdev)
> +int imx_pcm_dma_init(struct platform_device *pdev, size_t size)
>  {
> +	struct snd_dmaengine_pcm_config *config;
> +	struct snd_pcm_hardware *pcm_hardware;
> +
> +	config = devm_kzalloc(&pdev->dev,
> +			sizeof(struct snd_dmaengine_pcm_config), GFP_KERNEL);
> +	*config = imx_dmaengine_pcm_config;
> +	if (size)
> +		config->prealloc_buffer_size = size;
> +
> +	pcm_hardware = devm_kzalloc(&pdev->dev,
> +			sizeof(struct snd_pcm_hardware), GFP_KERNEL);
> +	*pcm_hardware = imx_pcm_hardware;
> +	if (size)
> +		pcm_hardware->buffer_bytes_max = size;
> +
> +	config->pcm_hardware = pcm_hardware;
> +
>  	return devm_snd_dmaengine_pcm_register(&pdev->dev,
> -		&imx_dmaengine_pcm_config,
> +		config,
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
>  EXPORT_SYMBOL_GPL(imx_pcm_dma_init);
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index c79cb27..133c4470a 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -20,6 +20,11 @@
>   */
>  #define IMX_SSI_DMABUF_SIZE	(64 * 1024)
>  
> +#define IMX_DEFAULT_DMABUF_SIZE	(64 * 1024)
> +#define IMX_SAI_DMABUF_SIZE	(64 * 1024)
> +#define IMX_SPDIF_DMABUF_SIZE	(64 * 1024)
> +#define IMX_ESAI_DMABUF_SIZE	(256 * 1024)
> +
>  static inline void
>  imx_pcm_dma_params_init_data(struct imx_dma_data *dma_data,
>  	int dma, enum sdma_peripheral_type peripheral_type)
> @@ -39,9 +44,9 @@ struct imx_pcm_fiq_params {
>  };
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
> -int imx_pcm_dma_init(struct platform_device *pdev);
> +int imx_pcm_dma_init(struct platform_device *pdev, size_t size);
>  #else
> -static inline int imx_pcm_dma_init(struct platform_device *pdev)
> +static inline int imx_pcm_dma_init(struct platform_device *pdev, size_t size)
>  {
>  	return -ENODEV;
>  }
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index 461ce27..48b2d24 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -603,7 +603,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
>  	ssi->fiq_params.dma_params_tx = &ssi->dma_params_tx;
>  
>  	ssi->fiq_init = imx_pcm_fiq_init(pdev, &ssi->fiq_params);
> -	ssi->dma_init = imx_pcm_dma_init(pdev);
> +	ssi->dma_init = imx_pcm_dma_init(pdev, IMX_SSI_DMABUF_SIZE);
>  
>  	if (ssi->fiq_init && ssi->dma_init) {
>  		ret = ssi->fiq_init;
> -- 
> 1.7.9.5
> 
