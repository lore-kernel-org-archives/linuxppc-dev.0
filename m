Return-Path: <linuxppc-dev+bounces-21703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C79CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 09:21:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRdCl42cNz2yQH;
	Fri, 29 May 2026 19:21:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780046515;
	cv=none; b=hmixjgCPkUKYytY3ydbTIC1p79pIuNQ5CGjO+JU6dloyDeG5FV0lWjE/LY6TqPefCgfOHtHK3NvyCZ6Xu2VDcLQEq1GoJK349vrh+YL5cYpwAwmUTI6w5q4hnviPOyXPzArH5sGOxOtPySVpNattzTPUnzpwgqO/BgCwwrZD0qDC5+peNcBSq/cQcjAXCpZ870FOIFW7UlNlMiQWR1Km6XEaKfKcPF+hv9iUDULDwGW63CVWxvXry9ZCMqJzw18V+ptYRPKbqeLspk70/nFozxB4nAlu/+AxqRjNj4pxMAOLg5hI2bqEixquLqYz9iDUy0piK8XEDIEBlckGDXxKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780046515; c=relaxed/relaxed;
	bh=URAm25BpcfH+MJ/3jqio7OXT3NwLezv3H50Eqja7FMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQraTMNSsGR1t7e3snpJpMeFDNQEjGMlUxK6JBAbA5ySmKf6TX9J8YpFPSFv5b09CwQ7BET7DYDYQYarNCB0mHPey8f6it7ZO0i9HPkTXG82rt9VyauYsF9tltgvNjx/BoyPk6/J+gVrFOZG1I8cmTxJMMf16cpeIPtPl7J0zKFoZZl3vO9FVoCzqbJb9mE6aU5zG9nWU75YICv2itwPkKcCOrJpy6e5c8RBe506ER6+MvTtjLgNuZbd3sKQW/X+UCwNz2nSXSAMOtiXA13SRXjjnGE8R/bH2doPZQm1QAn07NgqDf+gZGEFaIoyj6dUwFxcjvB2xQkNMft14D1u0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8/wX8ya; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8/wX8ya;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRdCk6zhGz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 19:21:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 042BD446AB;
	Fri, 29 May 2026 09:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A97C1F0089A;
	Fri, 29 May 2026 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780046512;
	bh=URAm25BpcfH+MJ/3jqio7OXT3NwLezv3H50Eqja7FMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j8/wX8ya3tGZwfFrg4IWB9rdazMJOYKxTcKmcuiUansaIfmt1zCT5m8LvZeFiowr1
	 zmdPNQtpvTWPK3iH5EGcOtwLZcMK7qaLQ+OjDx3Etn97TIQMcppNIPdLRxRLvlJMPC
	 foN6WnFuskTHTemkWNj3uMqAkKzqsjMYtOHEeluWDs74IhuyYC7H6FgIjJhUp/VdnE
	 SI4sJU2VHkGIYUlnI+O/YRMEQhDx+rrtCOgA+pJKtLET89DYXVcwdbHaqjOb/vioGH
	 nB5q6dyOaynMveMT5gXiPzDClB9u5sR/n6s8aapMTb7HlHmzx7+hk13Qhodd6lzQTq
	 1fQPTUVFF2ySw==
Message-ID: <c5591024-0d8e-4c41-9e35-56689fa94731@kernel.org>
Date: Fri, 29 May 2026 11:21:47 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift
 UB in xMR write
To: Chancel Liu <chancel.liu@nxp.com>, shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260529085020.3727790-1-chancel.liu@nxp.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260529085020.3727790-1-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/05/2026 à 10:50, Chancel Liu a écrit :
> When configuring 32 slots TDM (channels == slots == 32), the xMR
> (Mask Register) write used:
> ~0UL - ((1 << min(channels, slots)) - 1)
> 
> The literal '1' is a signed 32-bit int. Shifting it by 32 positions is
> undefined behaviour which may set this register to 0xFFFFFFFF, masking
> all 32 slots.
> 
> Use 1ULL so the shift is carried out in 64 bits. For 32 slots this
> produces a zero mask after truncation to the 32-bit register:
> ~0ULL - ((1ULL << 32) - 1)
>    = 0xFFFFFFFFFFFFFFFF - (0x100000000 - 1)
>    = 0xFFFFFFFFFFFFFFFF - 0xFFFFFFFF
>    = 0xFFFFFFFF00000000
>    -> Truncates to 0x00000000
> Behaviour for fewer than 32 slots is unchanged.

Why not use macro GENMASK_U32() instead ?

> 
> Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>   sound/soc/fsl/fsl_sai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d6dd95680892..821e3bd51b6e 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>   				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);
>   
>   	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> -		     ~0UL - ((1 << min(channels, slots)) - 1));
> +		     ~0ULL - ((1ULL << min(channels, slots)) - 1));
>   
>   	return 0;
>   }


