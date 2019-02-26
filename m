Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:12:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BC72173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPE3Gx2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BC72173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4487k46fn4zDqLg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:12:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPE3Gx2z"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4487hB6LcxzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 06:11:06 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id q206so6657875pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=14n38KjudBqlY/3LnajxvBJ8ldxjmT/XRuWel8EJz0E=;
 b=jPE3Gx2z7AE5lOW/gUuEPN4G7sZKX70pIIGhL7B+tUN/pkJQnthQ/L2Th6JHOGuAQ+
 Jb/CIPHcYWyL4ik0VK+A5Pm3b5n765zte9it7PMGM7GC+PEELdbKk17HmOK1NJ7OuLli
 vMowSYHl2x+JJvCaYrFqczHhF8QJUDd9U8WTvnPIDDCts/IWsaMQg5f42QRI/EVXZ6wa
 oJF5LHrReM1AcHnocIw1+UnF1MqqZ7nxW4Y7V+s/OjqIxKtbzNW9jzqKr+foek6IoHRW
 WiGXkCLocxKtddxCcSA6OBOgPYcZRgsTaNVpEtYMikw6X83EpdhhzeoHBSdQh0nKi1or
 teeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=14n38KjudBqlY/3LnajxvBJ8ldxjmT/XRuWel8EJz0E=;
 b=JZulLK8NjBFuKSmHBVhbvGZVWupHBZG8lhO66ws+X4cecGXbA3Uboup1Yuc4b/hE+m
 0PP9mckQg+UJBEMrprVtPLclFf+mpdcii7EOoqw3NQC5vd8oeSdbOlANzctXVD7Z19Zb
 jlpx3Dldy4evhRkqR9miKVLZgQhizJz9NC+5Ka6XTLmPQmM2BVs8Mla7LnUqGlFYhyNe
 dUmqW0IB6QZoQ44SlEHojkgU0nSL0iwKhQ6ZJ5uzvmFqD/VLCcINmayYuq7HDmS5WVX3
 GhC6ReY2dWfLa/QN+0cqmv/ORoq3nap+L3pA7zrJwZVu5RcCnu2uBjHvqGumVz7+4Vfu
 Q/YA==
X-Gm-Message-State: AHQUAuZldUWQI7/bYNfXSrssGMqui5ofHTNuuIq0RDBftUTGzENuskP2
 s41TI+bhc3nXPxpHR2WhX2M=
X-Google-Smtp-Source: AHgI3IaTdxW53tZQGTDaMzs3XmbLNIGIYcoYEt9Y8yP2iHvQj3ybqAdEE9gsUFn9W6Z3apJsV6JxQw==
X-Received: by 2002:a63:d442:: with SMTP id i2mr25549301pgj.246.1551208263289; 
 Tue, 26 Feb 2019 11:11:03 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id l12sm21421693pgn.83.2019.02.26.11.11.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 11:11:02 -0800 (PST)
Date: Tue, 26 Feb 2019 11:10:58 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Message-ID: <20190226191057.GA24082@Asurada-Nvidia.nvidia.com>
References: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
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

Hi Shengjiu,

Two more trivial comments inline.

On Tue, Feb 26, 2019 at 03:12:25AM +0000, S.j. Wang wrote:
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
> Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> Cc: <stable@vger.kernel.org>
> Re> @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	esai_priv->slot_width = slot_width;
>  	esai_priv->slots = slots;
> +	esai_priv->tx_mask    = tx_mask;
> +	esai_priv->rx_mask    = rx_mask;

Not necessary to have tabs before "="s.

> @@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
>  				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
> +		mask = tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> +

Please add a line of brief comments for the reason why we are doing
this here, something similar to the commit log, but should have:
1) Clear xSMA/B 2) Set TE/RE before xSMA/B 3)Set xSMB before xSMA.

Apparently having this mask settings in the trigger() does not look
very common, so I believe a line of comments would help a lot.

You may add my Acked-by in your next version:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

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
