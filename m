Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C817C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:12:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E6D20859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+7P1ki6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E6D20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nT7d3wmDzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:11:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u+7P1ki6"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nT5G0r6MzDqRH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 11:09:53 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id b3so5026200plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PYjkYcNTZnFMpLl1Ud45Nz+rQvZvAbAY0HkqRk3d/w4=;
 b=u+7P1ki6TX3QOwwlvqXhU4Wx4+40w2bznUai3u5nQchIwh2RxXIttP/KfEGh+q+UDU
 dt6FMgkNTnKUcYOCUi4zXgYLtIhjiEi53cIZDJ3yKw5SAh6b95khiWrhbb8W0EYT+JGp
 tnS5XIlun7uUjrEu/dXuDX1UEBe/oA679fFJ38P00IDeqce0n2schXUiQuEW0XePGgIO
 YojSpAQvgJndT/0M8CZs8SUKinWvZRoqPM+7prOymEx4T+4/dwNz/RrFCEr93grxG57j
 C8O8N2HbLmnwxM/QS2q/q6NhNE3eIQmnGE7sbdyn0jO0kRjYjdNujMfhblbuky8r9nBU
 IC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PYjkYcNTZnFMpLl1Ud45Nz+rQvZvAbAY0HkqRk3d/w4=;
 b=PvBFMb4+8jFtel9BtepbsXbNt7JkGHm+jb4i7YGRl5crUgXMr1lLyG3fk6tb2CE9lx
 wsKmVebAaOVnNHaJu4cGR7eu/0xUQWNB2ZgRgyCSnIzH1QHv01lOR7unzQFfCMWxy+s9
 1iey91nPVZLsbsIlmtI9j3MY3ITsIAZlItUtRH0w1UVLxVQZvvXRdArmAYYaheR2Ff8S
 Dn1p2S3qF9mTJSbpuOUuY78dEvy8HmSjNuncu6UQGNG3/pzkK7RupH7ds5f7qgRNVJ1d
 UCmOcEsO5p3DLTQC7CMt3NDCrV+i2hWGlnbhoM0HlOkHFputqx6M5utRDuudaks8oDhe
 Puwg==
X-Gm-Message-State: APjAAAXhJs4AbFkb3gGXI2+TqpvsZHMpUOnlABf/aJ6e5uygIZ3nmmjr
 RiJncLjk8NgZ+z3KQD0ak6A=
X-Google-Smtp-Source: APXvYqytCei3XKWWbcucBiYP0cznKxL5+Vkt66ofnt1jiHbcf+8CxVBOLdCfxjVqDznWddsRo4ubEg==
X-Received: by 2002:a17:902:2d04:: with SMTP id
 o4mr17638908plb.88.1555895391183; 
 Sun, 21 Apr 2019 18:09:51 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 c3sm14691763pfo.2.2019.04.21.18.09.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 18:09:50 -0700 (PDT)
Date: Sun, 21 Apr 2019 18:09:46 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Message-ID: <20190422010945.GB8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> Basically the same actions as for system PM, so make use
> of pm_runtime_force_suspend/pm_runtime_force_resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d9df98975cf8..8623b7f882b9 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -9,6 +9,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> @@ -900,6 +901,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
>  			&fsl_sai_dai, 1);
>  	if (ret)
> @@ -911,6 +914,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>  }
>  
> +static int fsl_sai_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", },
>  	{ .compatible = "fsl,imx6sx-sai", },
> @@ -919,8 +927,8 @@ static const struct of_device_id fsl_sai_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int fsl_sai_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -930,7 +938,7 @@ static int fsl_sai_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int fsl_sai_resume(struct device *dev)
> +static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -942,14 +950,18 @@ static int fsl_sai_resume(struct device *dev)
>  	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
>  	return regcache_sync(sai->regmap);
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops fsl_sai_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
> +	SET_RUNTIME_PM_OPS(fsl_sai_runtime_suspend,
> +			   fsl_sai_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static struct platform_driver fsl_sai_driver = {
>  	.probe = fsl_sai_probe,
> +	.remove = fsl_sai_remove,
>  	.driver = {
>  		.name = "fsl-sai",
>  		.pm = &fsl_sai_pm_ops,
> -- 
> 2.17.1
> 
