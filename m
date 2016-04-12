Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ql2Hr30TwzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 08:52:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id r187so2422124pfr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 15:52:08 -0700 (PDT)
Date: Tue, 12 Apr 2016 15:52:32 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: fsl: imx-pcm-fiq: use correct format specifier
Message-ID: <20160412225232.GA30229@Asurada-Nvidia>
References: <1460494263-14805-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460494263-14805-1-git-send-email-xypron.glpk@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2016 at 10:51:03PM +0200, Heinrich Schuchardt wrote:
> Documentation/printk-formats.txt has
> size_t: use %zu or %zx
> 
> runtime->dma_bytes is of type size_t.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-pcm-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index e63cd5e..dac6688 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -220,7 +220,7 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
>  	ret = dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
>  			  runtime->dma_addr, runtime->dma_bytes);
>  
> -	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
> +	pr_debug("%s: ret: %d %p %pad 0x%08zx\n", __func__, ret,
>  			runtime->dma_area,
>  			&runtime->dma_addr,
>  			runtime->dma_bytes);
> -- 
> 2.1.4
> 
