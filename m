Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21EC48BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:26:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2958260C3E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2958260C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1Pq66rR5z3c2v
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:26:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=I2eukyki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2d;
 helo=mail-qv1-xf2d.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=I2eukyki; dkim-atps=neutral
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Ppd2fc9z2xvG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 12:26:01 +1000 (AEST)
Received: by mail-qv1-xf2d.google.com with SMTP id u14so12892888qvq.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7FsXY/TbSGUUDENZzS6CIpHdUvNAOKNKXgpKq5u4rXU=;
 b=I2eukykiphXFQViXcXYmNXYcayHQieCzV49bgZWYLDdkww6G3d2j0qfqzxreHlnYSI
 v/HEDSDf02kjpLsUckDsFqDTQoVG0g4s04oX/4cCJ+iN8hs/Ar1nRZ+2CaodIEbP/CQR
 fBL9nAbihtMYVpgNmymE0y4FaiGGHXBr5JQipolDQ9y1duTTcuOn1biEoOsaWsk4ts0H
 oBQkD6Wvsz/4nkbP9EEfgsDmbAwS0Voq6kY6jTBaCKZBdIGolFuD8IdP0ZJF3nvQq/sa
 zglPT+b/jLnTA8hkzYcjo6OcDop+++rp4rdNR5Tk3ceiqO8ntyN9mf6+Ae87R3jMbJI4
 +t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7FsXY/TbSGUUDENZzS6CIpHdUvNAOKNKXgpKq5u4rXU=;
 b=UAdAXdfMM2gQMp3GgyIHdVlXdOTHinYUWpAP9pyHlydwmCDYY08YMQABcxL8uglWJy
 B5iFaZ8DIOdDir2ADY62c4gdmJZF1N6KwYlyV8YfJt1+WpmL8x2ptY7wxaKgKlNLR7d2
 b4Gp+t3i5rbVtJzSsTs6HdJqmpV4CKUOjNzML1WuWkcCqmvasc9O9TsKdTTn4pyzk/4t
 e1ND6/PzVQ2OqWXsqwHxiJdZybAOzLKOenOehwzdr4jAvg2ZH9KkFFAUJsWbjhwW1yTh
 OV1Gz0Jb/YwwipOjYdpgu2daBBo2gPMwI6okikCe+TCllioQYLXkd2g7YBrzRi8JsDgi
 6wFA==
X-Gm-Message-State: AOAM533dIx+df5X7gPWA1nhGCzsj3W2LLLhHwqaBI8z/v/prK/Ks3I16
 lXWmfnDUjrCXutDgXYizQMtWrz6WC8NISvbbYhU=
X-Google-Smtp-Source: ABdhPJxT+CsEUPgmUbbvvdovqN50qvrZPZs4VXtBZa26L9aij/35ZW5rkX2cu6uMHZw3aT20weyVwPl2f64lDccacTM=
X-Received: by 2002:ad4:576c:: with SMTP id r12mr2699884qvx.28.1623378357051; 
 Thu, 10 Jun 2021 19:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210610040037.1064-1-hbut_tan@163.com>
In-Reply-To: <20210610040037.1064-1-hbut_tan@163.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 11 Jun 2021 10:25:46 +0800
Message-ID: <CAA+D8AOseYcjf6erSObjkpAhZGJW0VGio-T91kFZ7q0f3PhQPA@mail.gmail.com>
Subject: Re: [PATCH] ASoC:fsl_spdif:Remove superfluous error message around
 platform_get_irq()
To: Zhongjun Tan <hbut_tan@163.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Tan Zhongjun <tanzhongjun@yulong.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 10, 2021 at 12:02 PM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Tan Zhongjun <tanzhongjun@yulong.com>
>
> The platform_get_irq() prints error message telling that interrupt is
> missing, hence there is no need to duplicated that message.
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 2a76714eb8e6..29cefd459241 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1368,10 +1368,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>
>         for (i = 0; i < spdif_priv->soc->interrupts; i++) {
>                 irq = platform_get_irq(pdev, i);
> -               if (irq < 0) {
> -                       dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> +               if (irq < 0)
>                         return irq;
> -               }
>
>                 ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
>                                        dev_name(&pdev->dev), spdif_priv);
> --
> 2.17.1
>
