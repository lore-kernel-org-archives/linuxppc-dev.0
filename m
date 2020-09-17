Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6BC43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:59:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFF520684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKCLvI75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFF520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsKrw6LZBzF2QF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 11:59:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.193;
 helo=mail-pf1-f193.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kKCLvI75; dkim-atps=neutral
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsKm747xpzDrSN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 11:55:03 +1000 (AEST)
Received: by mail-pf1-f193.google.com with SMTP id f18so197137pfa.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dgnODGIAWL13nIbhEz3ezEHyZ73l+QamiC/feoln9pA=;
 b=kKCLvI754VQRS48l6o9prlDOUU+078HIdKfltH5m2ufXjuitexI7+27BaPPbM7YOID
 U4w8RnHLvpLY6DPhDtH3pQ47Rn2QsEssszplv8yr+YnXJ+rGa7Z5m2m57TcVX7Ak+Oy1
 HsAT+RyItKoLxTRjYInlcUVR46IQszNC9caKIBbvexWbuSURvAc4MRb7ULAPtnXFWxEl
 0SKF+LI7ZsEnX+o8uZzG1pKsT4P50TqHlS4lKHl8Qt/9CH5Q6Y7YqZxoZAf/k5zH6tAb
 TUp/JF4nyi97FbyqS/39j2QdLJ2Vz7Ueo6qTZqvhHjxpgIPFFbbJpThvMPx6urXE0CfF
 SDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dgnODGIAWL13nIbhEz3ezEHyZ73l+QamiC/feoln9pA=;
 b=AHfwb2afwzmqhkVwpSj480e9k4iM4cuCkWBkgWQwQyygtR5WjlzX4JoHhoa+hD5BHL
 JwHnHgULjhHPCbtVk5NUoUq3zikuN/7QphXrsP9Dbt9k5riPDoUrqpV8Gnzw5G7k086x
 wdgVphAYTeDf2X9x4HeHwuSXpMyJOwA6yZQQs+FAPnwpATD+IUwhT0ZEE5NJs87QXQWW
 Z8z+uao7+6s+h6BQOTCD5/9CeNLoyfIMPHzmx7lnu7MibZJEotQwPfmlfW3CDgNsQ44h
 O1VBAXmG9LvKMZTWkStkw984BY+1cNGf3ES2ra8P6JRh67i4ilSbPZUKyFv68XLntiwU
 LuXg==
X-Gm-Message-State: AOAM5313k//kcLBgCIhm0ZS6EvKapf65ICLC44dt7rSNqq40pfrdS7Yk
 Fx4Di9DQ8WgRANwmdbpDsFc=
X-Google-Smtp-Source: ABdhPJxnNOKTfJ7qLfSj/RIBwWtTsFveH5xnCH12xhYaBkeSNyJehUmbC9p4FCNpFJCk1tW0zIOOLg==
X-Received: by 2002:aa7:9635:0:b029:142:2501:3980 with SMTP id
 r21-20020aa796350000b029014225013980mr9025261pfg.69.1600307640882; 
 Wed, 16 Sep 2020 18:54:00 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id gd14sm4050934pjb.0.2020.09.16.18.54.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Sep 2020 18:54:00 -0700 (PDT)
Date: Wed, 16 Sep 2020 18:50:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: Set MCLK input or output direction
Message-ID: <20200917015048.GD22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-4-git-send-email-shengjiu.wang@nxp.com>
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
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 16, 2020 at 06:16:27PM +0800, Shengjiu Wang wrote:
> SAI support select MCLK direction with version.major > 3
> and version.minor > 1, the default direction is input,
> set it to be output according to DT property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 738b4dda7847..5117c1cd5682 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1117,6 +1117,13 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		dev_warn(&pdev->dev, "Error reading SAI version: %d\n", ret);
>  
> +	/* Select MCLK direction */
> +	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
> +	    sai->verid.major >= 3 && sai->verid.minor >= 1) {
> +		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
> +				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
> +	}
> +
>  	pm_runtime_enable(&pdev->dev);
>  	regcache_cache_only(sai->regmap, true);
>  
> -- 
> 2.27.0
> 
