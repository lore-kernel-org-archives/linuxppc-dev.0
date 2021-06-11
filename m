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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10145C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:23:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521D560C3E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521D560C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1PlP0FCtz3bx5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:23:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=nJCere7L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72a;
 helo=mail-qk1-x72a.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nJCere7L; dkim-atps=neutral
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Pks46pJz3034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 12:22:44 +1000 (AEST)
Received: by mail-qk1-x72a.google.com with SMTP id j62so15738923qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
 b=nJCere7LOSrhMIfWD9e3SYHFAobt75P+qmj3bZ8wly9ssO30SIjc03f5DOKJZBgIrA
 E1CRT2L2mbWltL8t/yPOo1LFACAc56vOI2yhtRTYFHMnO1tlshUUAkMo/RCMCTWukNAx
 p4jf2YOSVxJkWYq/J1pj5v80b6kvfUsdHzounC04d8n6tv2dT5bTCioZqMeukW6Jhp5t
 vPA9GRhD2pNsr23B0/yiT1HF+mVB/J6gG4E9zuhEXGUvJbg4X4GdhE9/6hiWSmOihT1s
 tF9QNNLxQU4+YpiG3PxT4qDlp7LH/F1LjfsFcEu4eZh9EWvirF6S2KVBZMDC0Pf2mWZW
 tFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
 b=rN/0ShKKETSGF4mWMWP2+tdvD/9+MgudVe+acyYCki/B7aO1ROB5dzIKFfe6c8G2M/
 Idn7izcDsua8ovALFETdZJc5Ns66SsaQxIc7OjduO2pDCZp/2tpWYHDmjrQ0ZgGIpYSh
 He03xFrEe+j8kWbsHdRo/uayRucylKGP8daAmPVCYdeR87QKCNcOEunP+j1M2YhZHWEo
 A8qIPtaraVwgGM7ZJ9FxAa374NuoGx6uwShha3+rArdNeMDZCOvAPlnmyZ5WR5HlpI0J
 UXY9NIOjXc+T14mNnSjF4P+EBZbi5Odcoenh6WvV3hQJiXUuWBvVQ2Pm617rPgAIE+ik
 +Bow==
X-Gm-Message-State: AOAM531uNZNhPcD0oiuBedQbHDPu3v9S4T/zlXPHTRpumo8HYWQ7qIxU
 BU3hL5seUh3SEcTg7kT/HI9zp+w+m5Yt8pI3MdU=
X-Google-Smtp-Source: ABdhPJwVE3MlwWUimCYQvJayxGP7hU75ji8nembIFoLu6+sidUiX6/wx3tIsymXPfJaTimO7t79BV4a5rJbWDLVHbIc=
X-Received: by 2002:a37:af84:: with SMTP id y126mr1725374qke.450.1623378153832; 
 Thu, 10 Jun 2021 19:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125052.1280-1-hbut_tan@163.com>
In-Reply-To: <20210610125052.1280-1-hbut_tan@163.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 11 Jun 2021 10:22:23 +0800
Message-ID: <CAA+D8AOHdArkc2mM--4yLLpGyEzfZb241MWj+10JjezXY_-UZw@mail.gmail.com>
Subject: Re: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around
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

On Thu, Jun 10, 2021 at 8:52 PM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Tan Zhongjun <tanzhongjun@yulong.com>
>
> Clean up the check for irq.dev_err is superfluous as platform_get_irq()
> already prints an error.Remove curly braces to confirm to styling
> requirements.
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_easrc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index b1765c7d3bcd..25747433916e 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
>         }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "no irq for node %pOF\n", np);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
>                                dev_name(dev), easrc);
> --
> 2.17.1
>
>
