Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:56:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8BD222A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKBtWqsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8BD222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441Mtw1GHNzDqjG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 05:56:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKBtWqsD"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441Ms64zKlzDqdj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 05:55:22 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so5203170pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FhuKIsZIsDJDbG5qptWoztIH2TZJXaVASxBuYWuJpg8=;
 b=XKBtWqsDcRwVZglFY9U3JSpjNYArFtiHxz5ph+jejCHY335d/k2AHliRso/sqT/zAh
 fIAqhfcFoEG8ib/ZiRmlwmn5d/CryYXUQG+/BpeHrhp+m1OI2lsrZQoLge6DV5tZynJr
 vXTsVRCX6Mb3C1GB5i+5DRMBap8IgSdus9W30aixPK750KGfxmrZ0x/Fd1Wub9LWvXas
 K4FBh9EUW4ij9Ub1OJM+HdR7YraW86GiUWnUgd4UIpryRpodoW6vFkkYW7kwV6nH/dQ4
 LkX+rDtgWMxDSvKRwFVZvrtIaunV3wP+wmKSZZ9nSKrIBJOGG91ypcnk/vRTTwVHA+t6
 hzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FhuKIsZIsDJDbG5qptWoztIH2TZJXaVASxBuYWuJpg8=;
 b=r/C+c29296MUQagLNE0OKNbFoNGkBR7L0XmQjJt31kfVYvjhGJxDA/EjPga+Rvg0eL
 n+4ALaQm2z8ACTtTv1K12JB/2fZr3j2yJOqSEOJm90unNy2EoejNP8juAsoIGPjTvcy0
 isIDmP3NXSPv/iUSJJqU8kTHIbS0gTOW6C39GwVIA+RHCxGzHBZ705gQX4Tm6GuHYzLi
 2BA4kuENvtX53orXhYCKb+EvTns6bjfzOaMqY0z/3rnIf/1N+gw4YrutvuxgTm8brGLc
 aENfz1E52KtTiwTp80YXGDUZbVKux1f8E1wgYJY8h23dTF/0rn+H9UF29rCeW5ssIgJJ
 TwWA==
X-Gm-Message-State: AHQUAubeB1RCUJbiQaJhfP3cj3PdBlRBSq4M5l7/RrEYC/tbd7zp8DWg
 Uv3L/watkkk1z6h7trl5qOI=
X-Google-Smtp-Source: AHgI3IYzhmsmkib8zm8tUDGSHXZ7rqVmzwPWB09sooy6zOO7b86vkdvDzBvtSncR0ljA5G3l7kZ8hQ==
X-Received: by 2002:a63:bf4c:: with SMTP id i12mr6752441pgo.382.1550256920188; 
 Fri, 15 Feb 2019 10:55:20 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id s73sm10108836pfi.124.2019.02.15.10.55.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 10:55:19 -0800 (PST)
Date: Fri, 15 Feb 2019 10:55:15 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Message-ID: <20190215185514.GA19299@Asurada-Nvidia.nvidia.com>
References: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 11:04:38AM +0000, S.j. Wang wrote:
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Would need this for stable kernel too.

Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.

> ---
>  sound/soc/fsl/fsl_esai.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 57b484768a58..afe67c865330 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -398,7 +398,8 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		break;
>  	case SND_SOC_DAIFMT_RIGHT_J:
>  		/* Data on rising edge of bclk, frame high, right aligned */
> -		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
> +		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
> +		xcr  |= ESAI_xCR_xWA;
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* Data on rising edge of bclk, frame high, 1clk before data */
> @@ -455,12 +456,12 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		return -EINVAL;
>  	}
>  
> -	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR;
> +	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR | ESAI_xCR_xWA;
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, xcr);
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR, mask, xcr);
>  
>  	mask = ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCCR_xFSP |
> -		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD | ESAI_xCR_xWA;
> +		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD;
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR, mask, xccr);
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR, mask, xccr);
>  
> -- 
> 1.9.1
> 
