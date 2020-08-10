Return-Path: <SRS0=LYYN=BU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:02:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8AB2073A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6MuEI+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8AB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQ7jn40jlzDqPk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=p6MuEI+X; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQ7gH1X90zDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 18:00:26 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id t6so4517987pjr.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Zdq88gHxCb3jvrnqaljepUUsgAroF2d/K4zFPmR3yOk=;
 b=p6MuEI+XHuECK8OwzYOsOSGvE6HobWjnUYA/dLBvje7ek7CK2RJtTUwabVNR/CPshY
 alZdJZzx3Vum+SuA9bURQqqGZx8Zy8cQapS2hwbPXpmX9dJzmusmKy+1hRZrBty+HaWl
 r1vReZxNdXS2Y2f3U/kqS/I/+q4FXU/3kI9ad6rC5ljw085nCdc7Bz006PvJKbuidbND
 EjQdEVy66f3CuLilBwm+6pDuyytmwrt75zsB9pfBt6tV4KagZBBnO0k1LD8/2YOoww8/
 jj2GOO3ipclZ4+AKuCb5VBhDNM0ksSe0kiUwx9m0Ji+oGK5QJMUgZgDmvoHvGaSxX8Kd
 wXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Zdq88gHxCb3jvrnqaljepUUsgAroF2d/K4zFPmR3yOk=;
 b=QHPFfJawDuyrtrRfSKuC+ho49k7GdGnr0izH/WJYK2MF6yT8Ljt9fLh7P7o7fWjVyt
 x3quD9AJhKkdJ/jmkhel/Dd2s6k7G5cLjtXJWFWT4zxBTpgFXqAejqerREcycQr6ApHG
 O9Ac0ms8j2/sN4DI17fmeQvda2CLANTJG3y8at4cYZSkBF2XRr/zmRVZS1Tu1zQ3kylp
 Q+Q73O77naTq4a8xo524qRxJcGPBlTWZIKqn+K2Y+gskviZfLbKMWJm3s9iwfBscbO3H
 QNsrDVWY33fC5zpYwpbZ7lhsjmR+IoBjM1MpOrcTnvgZ3K7mTmI9d5/pB0Z81kqT91Xt
 3l1g==
X-Gm-Message-State: AOAM531Va3loMucNwtCUcKLHDDonqf6pq7h3YHYZXd6pgNnGXRD6hn8d
 Db0aP3PGvp3RBKrLxDB8LTA=
X-Google-Smtp-Source: ABdhPJz5gK1nHWJYyHM/CxrATPUeMggaRaBYXWAmyQyHAsKFcQ7z9aOcwMDd5eU2YSfcwWQ8LhWD7g==
X-Received: by 2002:a17:90b:255:: with SMTP id
 fz21mr25805953pjb.50.1597046423161; 
 Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f18sm17456266pgv.84.2020.08.10.01.00.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
Date: Mon, 10 Aug 2020 01:00:18 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
Message-ID: <20200810080018.GA13408@Asurada-Nvidia>
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> Regmap initialization may return -EPROBE_DEFER for clock
> may not be ready, so check -EPROBE_DEFER error type before
> start another Regmap initialization.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a22562f2df47..eb933fe9b6d1 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -927,7 +927,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  			"bus", base, &fsl_sai_regmap_config);
>  
>  	/* Compatible with old DTB cases */
> -	if (IS_ERR(sai->regmap))
> +	if (IS_ERR(sai->regmap) && PTR_ERR(sai->regmap) != -EPROBE_DEFER)
>  		sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
>  				"sai", base, &fsl_sai_regmap_config);
>  	if (IS_ERR(sai->regmap)) {

In that case, might need a !EPROBE_DEFER check for this
fallback devm_regmap_init_mmio_clk at "sai" clock too?
