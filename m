Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF41C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EFC20896
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo0qE7h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EFC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Y16V3zGwzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 05:27:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lo0qE7h/"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Y0vC5bxszDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 05:17:52 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id p6so5161555pgh.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6i1NQsI6mLuq2jkkumJD6SYgs8Gj6kNRW+EJN56xw/w=;
 b=Lo0qE7h/V2MYtH+3FEMN+Y3w2iiVER4K4yuIAXRQJ08DlWtGNabn2/57LCIycjXxGm
 P0Z380cmWygZC/Gwwyka3v3CK0B/hUsOIxQ/dtpe3DbpOAEJoFEQke7gWBqIfM+RVc6t
 qPVzScaEN/7l5NCLE8Q0ta7olW7Q358PeSQcjtDcEc2s8aje0pWmjUcVeXq0mtF3aGJ9
 +uSLt0bMvtkETLHw404yeprh9y6jQcF0/9k0Bi9EvpYpeyA+FelOKrnBEwvNSnXH7jmm
 PuFWueosgY+ZTJ9TWuXnCDPx1IWC3M6RS6CidipeYmztXou/CEQMWQzwu4OSssvTya38
 ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6i1NQsI6mLuq2jkkumJD6SYgs8Gj6kNRW+EJN56xw/w=;
 b=aLcDE+BFRqRgRn0sGNTNSc+OaiNNEDxixlXbh1h6pxBLYkLCvuYAtTcDmzqB3JqTiw
 HMNxxTWUHG6pXKy57K6BDYfw4K9rDqeirX47sm5yav8q/X6Cv44plmRuLi9RXszw9Dnx
 pjBxwnboLHGezAUkkThe8QJ1bNZRhR8F7wSpx4zPE2SISq9gnITthRH80EDcTpMmx6v0
 6z0LLNUQx0nq9oz1yxV+3bE2AkOr5NGg/OnE/PEqGyKXqdc0ogClKYvPIy7i+dE5tSkQ
 fFEURR/dLjhbbQPOYNoKFd1dAaK/P+GrppMUhGDed5OaakXkOinDvzKydRxpJeIdBYyD
 FH4g==
X-Gm-Message-State: APjAAAUHcmpdFgPRYWUe7TUqdnOn6fD7I2KTuk7qMWxUILLBwrSxVKQS
 YjxmBf50jDqqKvkf3gtxRm8=
X-Google-Smtp-Source: APXvYqyQok54muNYRy+pFF5LwtrVSqF7ZGb2MIBoR5TZnoFXxFq7KwuIRA2okAISy+qXLIYgi5iyNA==
X-Received: by 2002:a62:604:: with SMTP id 4mr28700848pfg.38.1554142669608;
 Mon, 01 Apr 2019 11:17:49 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id t3sm12760914pgv.39.2019.04.01.11.17.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 01 Apr 2019 11:17:48 -0700 (PDT)
Date: Mon, 1 Apr 2019 11:17:44 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Support synchronous mode
Message-ID: <20190401181742.GA21288@Asurada-Nvidia>
References: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
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

Shengjiu,

On Mon, Apr 01, 2019 at 11:39:10AM +0000, S.j. Wang wrote:
> In ESAI synchronous mode, the clock is generated by Tx, So
> we should always set registers of Tx which relate with the
> bit clock and frame clock generation (TCCR, TCR, ECR), even
> there is only Rx is working.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 3623aa9a6f2e..d9fcddd55c02 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -230,6 +230,21 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		return -EINVAL;
>  	}
>  
> +	if (esai_priv->synchronous && !tx) {
> +		switch (clk_id) {
> +		case ESAI_HCKR_FSYS:
> +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_FSYS,
> +								freq, dir);
> +			break;
> +		case ESAI_HCKR_EXTAL:
> +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_EXTAL,
> +								freq, dir);

Not sure why you call set_dai_sysclk inside set_dai_sysclk again. It
feels very confusing to do so, especially without a comments.

> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
>  	/* Bypass divider settings if the requirement doesn't change */
>  	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
>  		return 0;
> @@ -537,10 +552,21 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  
>  	bclk = params_rate(params) * slot_width * esai_priv->slots;
>  
> -	ret = fsl_esai_set_bclk(dai, tx, bclk);
> +	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous ? true : tx, bclk);
>  	if (ret)
>  		return ret;
>  
> +	if (esai_priv->synchronous && !tx) {
> +		/* Use Normal mode to support monaural audio */
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
> +			   ESAI_xCR_xMOD_NETWORK : 0);
> +
> +		mask = ESAI_xCR_xSWS_MASK | ESAI_xCR_PADC;
> +		val = ESAI_xCR_xSWS(slot_width, width) | ESAI_xCR_PADC;
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
> +	}

Does synchronous mode require to set both TCR and RCR? or just TCR?
The code behind this part is doing the same setting to RCR. If that
is not needed any more for a synchronous recording, we should reuse
it instead of inserting a piece of redundant code. Otherwise, if we
need to set both, we should have two regmap_update_bits operations
back-to-back for TCR and RCR (and other registers too).

> +
>  	/* Use Normal mode to support monaural audio */
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?

In case that we only need to set TCR (more likely I feel), it would
feel less confusing to me, if we changed REG_ESAI_xCR(tx) here, for
example, to REG_ESAI_xCR(tx || sync). Yea, please add to the top a
'bool sync = esai_priv->synchronous;'.

Similarly, for ECR_ETO and ECR_ERO:
	(tx || sync) ? ESAI_ECR_ETO : ESAI_ECR_ERO;
