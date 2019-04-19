Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF3C282E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD7C204EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvP10dfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m4Jv6XDkzDqW9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 04:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvP10dfs"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m4Gr4hzyzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 04:28:19 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id y3so2973813pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ONT5+2CVkj6hhrYr8uWDTX1Rkzzw8yLeZIpjJqMpjY0=;
 b=PvP10dfsssoEwVuVGPSsDItBuLoNejtOxSAekgSyrDu81+aFomxA7AAm5XNUVHWMHb
 CH3AuYdpeLXnxnHx8pKlCwf7BglN8b7FFuuTSMoRLxdRVMiShgysz9XmHN/3ufYD6j8f
 Gb15kSDSpN5e03RQZd36eUWqf2fHKL79qyZm5oslfSAilc3K21Djqht9HBBe2ZgNDbN/
 AGo4bY9XFVIS1xjDDto7O8kMPt6zEPVl5ToqrQanfQIPApz+DGWqqBh3W719QhVjtew6
 9qE0xHdyKlp1n9wodh05AanIgIFEZ9Z47SM2HbChPlVloODQVNgrneYvMhI3nqvG9TFX
 JbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ONT5+2CVkj6hhrYr8uWDTX1Rkzzw8yLeZIpjJqMpjY0=;
 b=SIQHsv5ANmIC4Gbfze/l4+TUjIksgX0I9V7tanbUv/Nb5w9YQf45D/C0P2bPDNtTsp
 9fqIs77bPWgHpGaZnbo1FOICMBOTVdlZpJ3pLr6jjsozQOVSthl7UhUQfBqxjYmJLQDO
 MZPyr0lC9E/oi1wVkiB6mQfb1oZrlVw4j0OEU7WVm6W9a0S2IpBl6nNfGQTvxjcloyNH
 haZMpD+vjudkv7a4dqPesUgB8QxC+M1EhCPXIYbJ6CE/Npjr55sfof+pcabszpQNKXRK
 ntuLFmDb+15NwDVsMfIGQ592rmuzEZvLIqQKq4eybiK2OeRdTfByk7jJFed4MgPv2ndg
 WpIg==
X-Gm-Message-State: APjAAAWkr3vSk4niccXFcS1Tm5LddnkDdFHBwiE7k2JMv5uNaW2O1BN2
 vmmWVaU8nMwHs3L/R3rtm/w=
X-Google-Smtp-Source: APXvYqxOZDlhdHXIyQAfJzT3kfqLbILpkD0tXAUB5zcEOxBPI836iychiUOwMplbjzAl3G8Gtx39wQ==
X-Received: by 2002:a63:5c43:: with SMTP id n3mr5188956pgm.163.1555698496395; 
 Fri, 19 Apr 2019 11:28:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f2sm8558920pgc.30.2019.04.19.11.28.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Apr 2019 11:28:15 -0700 (PDT)
Date: Fri, 19 Apr 2019 11:28:13 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190419182812.GC1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 19, 2019 at 10:23:56AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the
> 12kHz/24kHz/128kHz to the support list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 2c4bbc3499db..0d06e738264a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -27,13 +27,14 @@
>  	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
>  
>  /* Corresponding to process_option */
> -static int supported_input_rate[] = {
> -	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
> -	96000, 176400, 192000,
> +static unsigned int supported_asrc_rate[] = {
> +	5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
> +	64000, 88200, 96000, 128000, 176400, 192000,
>  };
>  
> -static int supported_asrc_rate[] = {
> -	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
> +static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints = {
> +	.count = ARRAY_SIZE(supported_asrc_rate),
> +	.list = supported_asrc_rate,
>  };
>  
>  /**
> @@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	ideal = config->inclk == INCLK_NONE;
>  
>  	/* Validate input and output sample rates */
> -	for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> -		if (inrate == supported_input_rate[in])
> +	for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> +		if (inrate == supported_asrc_rate[in])
>  			break;

Not sure if we still need it upon having hw_constraint. Maybe m2m
needs it?
