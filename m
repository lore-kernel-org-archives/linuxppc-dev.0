Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3888EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 18:58:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEBE20700
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz6ORlbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEBE20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZFjV645dzDqKD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 05:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cz6ORlbo"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZFgm3ZqXzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 05:57:24 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id i2so8764532pgj.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xu+XskpwY4U2GGRXW9BfLUZ28aBRiexPt0T6bpbry0I=;
 b=cz6ORlboik2oZy6iAst8+0uL9I+weClQf4QrJSuYChW/ITpEEbzNmPmMARUrdsUUC2
 XzVmqUBiStBH+TSnoKsbnrxI84yyYWebubn+Ufyv8wfVDtl1AmSITTaB/UyJ71SZHP31
 Q3ugIpPJ3+l7cCzVyNzJwbyLlzG5QMA3akK7Mrb0gwrwR/asI7yYlWl6QaJ5gvBiUTlD
 b+rmMHbkqhQVjx5f4kVPYuGPDCACmINWS/2ZwaBoWhv2sKru2/8xlpyrgpmmnU8yaEls
 V3tah+eY4if8/Zxo3MUFsQLwnfowp4PJepD7hCUtbDww5SkyffqJ1KZcEoYTyJ6d4Gp1
 FUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xu+XskpwY4U2GGRXW9BfLUZ28aBRiexPt0T6bpbry0I=;
 b=SWDUyX7bsXCb2AwjUSSjlEc6b354+gtJqEE+bHIJ+VFLnQcRZnHXQWfR9ErdkfmCHI
 NVb5LK/gMrsPUjNrrqevY0L3RCkaseJV4DNnuZf1lNLBWVMVzMI3wdjTRLpo3GSBdtCc
 1iBwYwIiMwaICBCKIwo8tv5c8fckIN2dejtO5sVBsMKCqp4A5itfZr//UMepq4xRHdmS
 8yUFI/yW5MU2OWN19kbCZwGBhKGT+EbOTem3fhq6VNphvR84zoI4i0x7J2pYjNni+sd4
 gxnjMSaZvmK4Ze6rXX3k+VbTW6WYx3ZqG5kWXK8/+mdxAQuRlyvO9St3MSXJJAnJWVPI
 1HYQ==
X-Gm-Message-State: APjAAAVJuSByRACV11bSKRabPgJG6SUDS3M5LglI8rmbkNaXi/Kn8pMj
 XPiLpEpsYKkHlxGQ/wGVmCM=
X-Google-Smtp-Source: APXvYqwoJ/CFjHrdMbxcSlXlIcAejeRoTgFVYigVggEfV3plx+zga7JAHAYkjAoumvZHs5Ecz56cKw==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr1267933pgq.175.1554317840848; 
 Wed, 03 Apr 2019 11:57:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n65sm53987436pfb.160.2019.04.03.11.57.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Apr 2019 11:57:20 -0700 (PDT)
Date: Wed, 3 Apr 2019 11:57:16 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Message-ID: <20190403185716.GA5130@Asurada-Nvidia.nvidia.com>
References: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
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

This looks better :)

On Wed, Apr 03, 2019 at 10:07:40AM +0000, S.j. Wang wrote:
> @@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  {
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
>  	struct clk *clksrc = esai_priv->extalclk;
> -	bool tx = clk_id <= ESAI_HCKT_EXTAL;
> +	bool tx = (clk_id <= ESAI_HCKT_EXTAL || esai_priv->synchronous);
>  	bool in = dir == SND_SOC_CLOCK_IN;
>  	u32 ratio, ecr = 0;
>  	unsigned long clk_rate;
> @@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		ecr |= ESAI_ECR_ETI;
>  		/* fall through */

Btw, I am also wondering if the fall through here is a bug....
Because I don't recall that there is a specific reason to fall
through here. Can you please help confirm? Perhaps we need to
submit a separate fix as well by replacing it with a "break;".

>  	case ESAI_HCKR_EXTAL:
> -		ecr |= ESAI_ECR_ERI;
> +		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
>  		break;
>  	default:
>  		return -EINVAL;

> @@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  
>  	bclk = params_rate(params) * slot_width * esai_priv->slots;
>  
> -	ret = fsl_esai_set_bclk(dai, tx, bclk);
> +	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
>  	if (ret)
>  		return ret;
>  
> +	mask = ESAI_xCR_xSWS_MASK;
> +	val = ESAI_xCR_xSWS(slot_width, width);
> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
> +	/* Recording in synchronous mode needs to set TCR also */
> +	if (!tx && esai_priv->synchronous)
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
> +
>  	/* Use Normal mode to support monaural audio */
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
> @@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);
>  
> -	mask = ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
> -	val = ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
> -
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
> +	if (tx)
> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +					ESAI_xCR_PADC, ESAI_xCR_PADC);

Mind aligning the indentation here like the one below?
		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
				   ESAI_xCR_PADC, ESAI_xCR_PADC);

Once you fix the indentation, add this:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
