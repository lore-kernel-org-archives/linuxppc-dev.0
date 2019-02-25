Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351DC4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157702147C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN9JF5Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157702147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447ZXW1F9rzDqMn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EN9JF5Q7"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447ZTP5VcBzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 08:14:49 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id e17so3016649pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NfMnZUTKo3oeNIQksAdalm/3O+wiOQKUjySMWuXpGZc=;
 b=EN9JF5Q7oI1GF811QXe9K2QaCKJqyTav667MKJ2/jnicEv3sAckhwFg/C90E17QlwZ
 hpWv3BgSdOApyppwAQyo0P4Sv8WNe27PX985JyxZvCDXzt092py1rqPDHR39I/4eO+na
 6NYTEck+v6IC06t8yONoEamfxnixxtAW3RxEHkUdnSMJi7oFNIy4Z5SVctjxCx5OYTe4
 c4zK/L3r1edltY5IKo87MORyBJLFL3b+GpziGwLW8y0oRP5Rj4C/nquplYf1X9zts9GX
 IzxCaU960o6TM+3ZxokN7Sb1SyN8/kGJMW7RfE5VDPgYlXGvv0fijJRRrnZj+eK3IwMg
 cFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NfMnZUTKo3oeNIQksAdalm/3O+wiOQKUjySMWuXpGZc=;
 b=WgEaNaSRiDO3UhQNU6pi88nEAdMk4QsbtH/WiDYVSMFIWkG7Qly3iBFZLuN+W5xzgf
 xX4sDv4gixZLCTlJOoTJTLeCRr49qyMnW6Y1/yqd3wiibL3GS2X4lWVwmrEhvlauWNCv
 Kw6ghjvyvkljfGWoC+wBOTGQF/T/7Ay0hSVT/qkqCjuDtMTZA90gc7zP/dSNgpooIRzs
 0iXSyTVKumtvuxd1wi4ARLAMTTvUoj/GHNJxZCwnBROrgg9utykv6WEYRwQmmNfamcG5
 4J+LBxWeE3+vXriGqceXIxkEvogjlI/jZQ24DZsqrTNYIEYjPukUdOy8oPwZT4y3FEHX
 4WvA==
X-Gm-Message-State: AHQUAuZdrwL7JSf5vUJJVDGr/2EG89mtwYZiz25Xai33ZQTUi+KvHpyE
 sHRfYW0Xi54OJEaqaWE+iPk=
X-Google-Smtp-Source: AHgI3IZM3xnAe4WN/84X2M9NHv4h1Ohc/PpN+sT+Iib2W4YiLuGUhnXl5EygOK5pr1zVl6yfMbjKzg==
X-Received: by 2002:a65:5788:: with SMTP id b8mr20344953pgr.8.1551129286088;
 Mon, 25 Feb 2019 13:14:46 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id k17sm32713198pfj.92.2019.02.25.13.14.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 13:14:45 -0800 (PST)
Date: Mon, 25 Feb 2019 13:14:41 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Message-ID: <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 25, 2019 at 02:48:18AM +0000, S.j. Wang wrote:
> There is very low possibility ( < 0.1% ) that channel swap happened
> in beginning when multi output/input pin is enabled. The issue is
> that hardware can't send data to correct pin in the beginning with
> the normal enable flow.
> 
> This is hardware issue, but there is no errata, the workaround flow
> is that: Each time playback/recording, firstly clear the xSMA/xSMB,
> then enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
> before xSMA). Which is to use the xSMA as the trigger start register,
> previously the xCR_TE or xCR_RE is the bit for starting.
> 
> Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Changes in v2
> - update commit comments.
> 
>  sound/soc/fsl/fsl_esai.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index afe67c865330..23bd0ad4ac31 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -54,6 +54,8 @@ struct fsl_esai {
>  	u32 fifo_depth;
>  	u32 slot_width;
>  	u32 slots;
> +	u32 tx_mask;
> +	u32 rx_mask;
>  	u32 hck_rate[2];
>  	u32 sck_rate[2];
>  	bool hck_dir[2];
> @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
>  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
>  
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
> -
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
>  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
>  
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
> -
>  	esai_priv->slot_width = slot_width;
>  	esai_priv->slots = slots;
> +	esai_priv->tx_mask    = tx_mask;
> +	esai_priv->rx_mask    = rx_mask;

The two masks only got values here. If a machine driver doesn't
have a set_dai_tdm_slot() call, they will be remained as 0 and
then will seemly clean those four registers.

Thanks
Nicolin

>  
>  	return 0;
>  }
> @@ -596,6 +590,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	u8 i, channels = substream->runtime->channels;
>  	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
> +	u32 mask;
>  
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> @@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
>  				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
> +		mask = tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> +
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
> +
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK, 0);
>  
>  		/* Disable and reset FIFO */
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
> @@ -906,6 +912,12 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Clear the TSMA, TSMB, RSMA, RSMB */
> +	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
> +
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_esai_component,
>  					      &fsl_esai_dai, 1);
>  	if (ret) {
> -- 
> 1.9.1
> 
