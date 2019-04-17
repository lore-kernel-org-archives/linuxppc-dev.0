Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC0C282DC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B4820652
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ZbGN3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B4820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kmLp3ZzWzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:27:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+ZbGN3h"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kmJp0wMvzDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 01:25:29 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id a6so10093593edv.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gnFTNL0HyeJ5SkvPWRP8h9D5WPZZsEJ+mWryvvEXxhU=;
 b=Z+ZbGN3hV+dwBoWFiVvAJmNPPqsgSmmmllSVTAdsQXc6hKjHEfWwuc9KwYAqkq6xmM
 6DX42pTZdMWIaJviY/f36f7ABimQoVUIco9Py1WOp5izN8D5Zg14NrE+tY3mdMHHEnYZ
 VIiy9XxaP15xQhjmSKGT/fyxWwmFhVyQVhMI3aV/Zo69TV/WeHfnCAIGodrKJ3eQl6w/
 NMy7bozutA972RyLT6zZCGdGHu8jC9NDsSFvLHxAxhw2YEOzGPEJr3yY4fcHP0vw3lWC
 MDAni6Yik2xB4Gr+NuFJwylHVevbfZ10IErb95bLv3SQ+KkECBs4GEaRhZqSl/AtZC+U
 6xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gnFTNL0HyeJ5SkvPWRP8h9D5WPZZsEJ+mWryvvEXxhU=;
 b=E9pxMp9x1nZQKyKc9yHFRRAo0mVCpCRqHsAKAdJB3xQbRGGGMu1TXfr6AtziSj4k7O
 dwM2Vtib1ANiyGJZ/Jz0O5yEKW7lHL7nTyRUIGy3Exm/fr8257YXsOLrUEUqShAv0lJQ
 OKUfuf5sEPDTxSI05+sr4ik8KLOujFz52BDs3aiYXm4wkEibT+ESarZE2oxeG3uvQuCs
 jXYxxoWIyqPtiTeNrh/L2bDW17sGHuN3su5p/APx8aRMMMjyJu27pTzOcEM0v2QQMoo6
 XtmWp0PNn+UlnzRVNldzIVt1hwSv6QLJNGLp0/ygrIduUGyEUhX0VV1VQX+fVqlDaarA
 7KhQ==
X-Gm-Message-State: APjAAAWEhjoWlzt+Bqmr3dS+AZNMrx8ntYSQ20s1zwBphni7Bb49hzow
 SryCzTFSoPsUl1f+nn//Zqsv4lyuXZqLirL9KYQ=
X-Google-Smtp-Source: APXvYqyaUk9/lJvT0nVCL4AvEuY9o+lX5hktcqzxYfNXH5x3PqB1vFxf6j6H6vByhv3gacmnpmAwMGZufgIZ0wiLVdY=
X-Received: by 2002:a17:906:4e88:: with SMTP id
 v8mr23225174eju.160.1555514723678; 
 Wed, 17 Apr 2019 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190417150915.37968-1-yuehaibing@huawei.com>
In-Reply-To: <20190417150915.37968-1-yuehaibing@huawei.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 17 Apr 2019 18:25:11 +0300
Message-ID: <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable
 'osr'
To: Yue Haibing <yuehaibing@huawei.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Yue,

Looks good to me. Just one question for Cosmin:

On Wed, Apr 17, 2019 at 6:10 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> sound/soc/fsl/fsl_micfil.c: In function 'get_clk_div':
> sound/soc/fsl/fsl_micfil.c:154:6: warning: variable 'osr' set but not used [-Wunused-but-set-variable]
>
> It is never used since introduction in
> commit 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/fsl/fsl_micfil.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index 40c07e7..f7f2d29 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
>  {
>         u32 ctrl2_reg;
>         long mclk_rate;
> -       int osr;
>         int clk_div;
>
>         regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);

I noticed now that we also read ctrl2_reg without using it. Is this as intended?

> -       osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
> -                   >> MICFIL_CTRL2_CICOSR_SHIFT);
>
>         mclk_rate = clk_get_rate(micfil->mclk);
>
> --
> 2.7.4
>
>
