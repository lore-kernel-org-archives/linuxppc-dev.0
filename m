Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DFFC2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:01:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF017206C3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0jnGpAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF017206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48x5dT15SdzDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 09:01:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=N0jnGpAQ; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48x5b774FwzDqkV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 08:59:47 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id h11so468651plk.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QabBQhlHvDhp4mCqAg3c+5phsRTL1odJr+vofj/Jd6U=;
 b=N0jnGpAQZkHqM2qyCjOqgHLclBH0mnCHDoPt2hEx5cT4hQMCCfS7llAe9nHscseUpJ
 M36pwwnl+ap0A9KQ8nuvLFxWLtV9TZRXoNVMF6PLUPb8g90jUoFcpxfghOXwdwslq99v
 DY9sdaA2//pFIAFXL4OXhjlf4fx9Nk2vmjOOX05h4V/vB9WaZPNmHQL7uukQCasVjF9s
 f5Tt7K93PUsZ/BEZaB9B+nydUbQVtYFZAFIaqn92j4FsYNs6UnVHT1qnk8q8+kAYRvI3
 7/dPM94KZRoOcVwKkd0mkF+XEQm3LgglgAgeSeMlUpD/JfZ4P1cDu+b/49TQI5C6QGQB
 vtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QabBQhlHvDhp4mCqAg3c+5phsRTL1odJr+vofj/Jd6U=;
 b=KIEq4f5P+gTYBTW7dl9LayM6IhegADIiHs3F4oVqfEWSpAB9lgMPZtA28cLzq6jdfY
 qre4pmZ6wBiqF7S9XuMdzcJvF3znvisJ5mJCZt2VfxqEA0URgiVNO86AyyR4LSOOEXmp
 fAdzriFMt9z0j6MzZ5XZyhpjBzRFxZG2sgrDo2M26Od6YzgWzquY3I2rChLMjY/F6xEM
 M39oFvW04nWvsgTL9rTpudaZWqDPdL34xoB6Nv9wP9tDxZNxItcx5ca+rV5ItyWv5dWA
 pQLKTqw+a6vY6y1yLGhZ2gQjKhGsnH7RK3BzAU0wK3RcUZ3mY5/WbcsBUhH/YOoYac+n
 So0A==
X-Gm-Message-State: AGi0PuZM8FwvlolLAlsMUmuhq5s9oeIrYEWLVVEXD5ZJ5FAzSCs9rudK
 AKDH+07JlMQukTRRHQdKaLU=
X-Google-Smtp-Source: APiQypJ1B/70Ak3FAawANFmM+3TECFxtBax+d2t7PbnhnVBThvOaaEXHLohLyb1PG3QFqsxDwm3y8A==
X-Received: by 2002:a17:90b:3c4:: with SMTP id
 go4mr1656393pjb.162.1586213985103; 
 Mon, 06 Apr 2020 15:59:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 66sm12650177pfb.150.2020.04.06.15.59.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Apr 2020 15:59:44 -0700 (PDT)
Date: Mon, 6 Apr 2020 15:59:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 3/7] ASoC: fsl-asoc-card: Support new property
 fsl,asrc-format
Message-ID: <20200406225949.GB20891@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <b8d6d9322e865f61f0c9cb17c69a399624e07676.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d6d9322e865f61f0c9cb17c69a399624e07676.1585726761.git.shengjiu.wang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 01, 2020 at 04:45:36PM +0800, Shengjiu Wang wrote:
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl-asoc-card.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index bb33601fab84..a0f5eb27d61a 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -680,17 +680,20 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  
> -		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +		ret = of_property_read_u32(asrc_np, "fsl,asrc-format", &priv->asrc_format);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to get output rate\n");
> -			ret = -EINVAL;
> -			goto asrc_fail;
> -		}
> +			/* Fallback to old binding; translate to asrc_format */
> +			ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +			if (ret) {
> +				dev_err(&pdev->dev, "failed to get output width\n");

Should warn 'format' over 'width', since it's preferable.

> +				return ret;

Should goto asrc_fail as we did prior to the change.

And some of lines are over 80 characters.

Let's try this:
		ret = of_property_read_u32(asrc_np, "fsl,asrc-format",
					   &priv->asrc_format);
		if (ret) {
			/* Fallback to old binding; translate to asrc_format */
			ret = of_property_read_u32(asrc_np, "fsl,asrc-width",
						   &width);
			if (ret) {
				dev_err(&pdev->dev,
					"failed to decide output format\n");
				goto asrc_fail;
			}

			if (width == 24)
				priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
			else
				priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
		}
