Return-Path: <linuxppc-dev+bounces-22551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463E6CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:37:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcGD959rrz2ykX;
	Fri, 12 Jun 2026 20:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::633" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781260633;
	cv=pass; b=LIaurWI+GZBVgLBSwJbCA5CAbJSWwIdl8tRz9gZ0Vn/6R9YTn0rbFEyo4kV8U4gNoNG2Ph+X5MMjqAYR7G5DrZHRMKM0X5EuXmkQRRvVS2jp2AFX7TGp+fvrCbhP/VtmypKaZTvqCgmxH1h/2tTgwBMS5Ae+IQNna/7DIDsbPRwdveX5OkqC377GM0YgVF/+gjI0Tqcm0fr9zHmrY0hFcdBmAPBCMBwux2P6fBVIVg8NbjyeigG7AzWT85ZrV4w9SkuUUk7OvgAAGpZSuch9KqovjYvshSVDWfmYJ76/vfGW9fBrBCrKDlL00D+3V/dv7wCHz7EPzNBV+JJpgqLz7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781260633; c=relaxed/relaxed;
	bh=yGmOz1V0n8WCv2WsgeGuXHK9MeZUgyY4mCLu4WGLECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfljoqO2EsZTrPNQIJMAW25v97CDPn3eySWafvgDE9XHwj5Zh2Z9Uq/q4sI8iOvNgrcGk9rdkQUElmsdpJ3J+/d6jQOgVUx/8xVXWWZSZNfJgL8Bt7ayG+PPiXfTxCHnF+TBtF+FOL1774ukVNl5uXTGrlFQrR8UjW5+bSFvjoD8JzRL5oUVWvnaSEq1CfB7kx6wOw5UaOS4irZa/RK1AlUMwx9ONeXjX1vCdhRsNrWEa5qEQsEEIfdqALsgilfe+V3fxMP5xTBPTXME/FriJEKBmbEDrMjSeky6BQ150pfPrOaxonZmgSaPmNxUOCFFRlNOhM2DB6NxdiEs/7e0lQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YsxbfXs2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YsxbfXs2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcGD85fgFz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 20:37:11 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2bf30d530bdso8239935ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 03:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781260630; cv=none;
        d=google.com; s=arc-20240605;
        b=PJS4U42QD1t0HNvOQ8y/wNFdzQTo+kvB2hPIK+AcIqIMrAm4NjAoKZimcw9VnLhGzN
         3y6MeXKMXJNZrGXpJ2N4vhjDGkSg0GkqKXPRFawLJbLVURpyMwljFpOizgXi7fbox84I
         2VNttvV5yp5Ys+YX74ZmWMmNHhN71d9HtsiDWFxMds8W/x12vG7RKgVLedh3mCUlO7y9
         lytP2tN6/N0pgsp4nmYryZzlP03f/qalaj3R0QRKzuLpMLY9X0V6fQgo/njqu4M/Uadn
         He/pSgJRIyglB+/vnHm3YKOA7W7Tt3ddqo5o3kRI+Qijhi8/ShN+OnKH0l1b+Il/UaGC
         rptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGmOz1V0n8WCv2WsgeGuXHK9MeZUgyY4mCLu4WGLECg=;
        fh=WdJ4bI/5F5nOfQys/WGwhJSgQXaI2bkRrFACN67BYDI=;
        b=WdeJqghz8m63G0boBGvnXdJ814hlIggsJ8tzwpuynT1CW+qnARw8AW13p6p3HNulxT
         OZkZp0ENLkgnlHEh0qkURHwRHy1sBq0D05M/HYOSgRrXOXl5MjKxXjIHKNesC46x9IBZ
         r9w2A3bgLw66U2esXXU6e+sMzIfwLEorA3fBGlV5qlUO1VPi1I9ZzOwMvGT6g3wUQrEu
         dIblSKUDaujEo56jBRjemTUdkML1ttNXNfHzf1SMtM6mCwNGSCaolg3ejAHkONMbqQBV
         BboXSClU32ulk0WyNj/W04ulQT+RipHYsmzF4TKKymbbBekvbcofGo1+sL0Bg02uw042
         JI/Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781260630; x=1781865430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGmOz1V0n8WCv2WsgeGuXHK9MeZUgyY4mCLu4WGLECg=;
        b=YsxbfXs27gne8awWUfsXjLoVGZQd7Nq75HaCABV1VnshdSd/kFT9qqloB9Gknd9mwP
         wPuyUYIbZp8Msi/8wi53OWbwZsqWU+BRO/Omnh2OB0NSM5BxZVI7LZL4XKPsUNH5RTlm
         d0uFGnQIgnIyQlh2TJjWRXvY3+A8TDg5TsGNBXuzwKr/xK//I48K6QRAtFX2cCoWz+tI
         GYotEpFTapvQ7nd6ohb7+BbpjSG+mkFTif6ZycpdOYd1qzLshfFSvRtZq7BeCCwTT/A5
         dN7Tgm//oBTJ0mqH/A8JeqjngdYwqwR0yNEubZzzEObMP5ZPlLguLMfPPULYvlQdk8rQ
         /tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260630; x=1781865430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGmOz1V0n8WCv2WsgeGuXHK9MeZUgyY4mCLu4WGLECg=;
        b=TP+XQS9seJLRDAznwm6xXIYqrgJ5eZiBPtwzD8l5u3hjDLFJZmdawK0OZouj2xAdJ9
         Xxx56iEkB8C5AgPgl342y7CcKmOcpuziw58vkQQw0U/7eWV6TXVFw1KYa2ECw4tmoggZ
         NBMK4W4TJEHLNMvOy3XzIQUxSGjw1T5LEcnAnKv2mC4hgtTJ70fCLGBDf22cGPrZ9Ozr
         kpI8JKwPAiy7ql/ZL2aU4G8Pm/r1N5towNziXItJ6X2X+fBZSV59Q3NSUkNm6Amzewbl
         bF74c+ovwZ5fyvVld+z29NsFl9ogvRcFi9A3xkv1iIuDK/PJbSFzIOFSgXP+GULZdnm3
         ygOA==
X-Forwarded-Encrypted: i=1; AFNElJ+GaqX+zvFVKqM04x7nNPGUDa94jQ8uZ/QioRFCOwSAsvBjWkQzEe9oUBVfluT9FUq1qleIxzeBrXIQ3hk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhLYrB7QPYfowOuebTt8y+nWRXlsr/rShCgVI5UbP/Jk04CXtt
	k6rt+NXRGSbJoKIgCSUTn9b/4Rw3WYkcl9WMrUTDCSp1tzagSDODgpcpXeL5ZE2OJGuOenThcpE
	QOr4rwgN0evlJLuQ6k85sUQvZRM3BmSY=
X-Gm-Gg: Acq92OFvAdHHzgZHiNJXgeEUjFSMdWhRx5ejMrsWbkz2vMm9mc0meTTgMw5sRJlAt//
	s1M7AZB5o3pmcC4cTbTC6ef4O3HSED0vOzt4+egl6XlFB3L1Dw6Gi/XIib2o01TxjXAQsDEtoTv
	13DRmpo7JysFzOye3SYNkCixKuzFGjkaqJNPfaiaJkXISgEIbTggTU80sndaqO79tfT7RANbDUk
	+/q0Jn98CcuYdcybMaWpoco5hzx8H7MmZYfYYMoDJJlmOL9BXM0s8lmDhckjA7pNCLFlQUDEFq4
	MM/dOnNO8m6AU3i6Kg==
X-Received: by 2002:a05:6a21:350f:b0:3b3:c7e:fda7 with SMTP id
 adf61e73a8af0-3b78406ebe3mr2900723637.39.1781260629920; Fri, 12 Jun 2026
 03:37:09 -0700 (PDT)
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
References: <20260609124317.38046-1-sammiee5311@gmail.com> <20260609124317.38046-4-sammiee5311@gmail.com>
In-Reply-To: <20260609124317.38046-4-sammiee5311@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 12 Jun 2026 18:36:57 +0800
X-Gm-Features: AVVi8CenVHdc3LE6HJevD6aErfCNA_Sk-ZJA5DP2qrNShUhv5CBfoCuI5aCO6Ko
Message-ID: <CAA+D8AN6+oQ6PRNS-KYd42QoS-r1WhGqcafNCewLuXpYsGW4XQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: fsl: fsl_audmix: Validate written enum values
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Viorel Suman <viorel.suman@nxp.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 8:47=E2=80=AFPM HyeongJun An <sammiee5311@gmail.com>=
 wrote:
>
> fsl_audmix_put_mix_clk_src() and fsl_audmix_put_out_src()
> convert the user-provided enum item with snd_soc_enum_item_to_val()
> before checking whether the item is within the enum's item count.
>
> The generic snd_soc_put_enum_double() helper performs that
> validation, but these callbacks use the converted value first: the
> clock-source path tests it with BIT(), and the output-source path
> indexes the prms transition table with it.
>
> Reject out-of-range enum items before converting them.
>
> Fixes: be1df61cf06e ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_audmix.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index 40a3b7432174..f819f33ec46b 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -117,6 +117,9 @@ static int fsl_audmix_put_mix_clk_src(struct snd_kcon=
trol *kcontrol,
>         unsigned int *item =3D ucontrol->value.enumerated.item;
>         unsigned int reg_val, val, mix_clk;
>
> +       if (item[0] >=3D e->items)
> +               return -EINVAL;
> +
>         /* Get current state */
>         reg_val =3D snd_soc_component_read(comp, FSL_AUDMIX_CTR);
>         mix_clk =3D ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
> @@ -157,6 +160,9 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol=
 *kcontrol,
>         unsigned int reg_val, val, mask =3D 0, ctr =3D 0;
>         int ret;
>
> +       if (item[0] >=3D e->items)
> +               return -EINVAL;
> +
>         /* Get current state */
>         reg_val =3D snd_soc_component_read(comp, FSL_AUDMIX_CTR);
>
> --
> 2.43.0
>

