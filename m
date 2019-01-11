Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDADC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:15:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D8220872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 19:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPsT3Ngy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D8220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bsxz5DqxzDr1Q
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 06:15:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aPsT3Ngy"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bsvt6wx2zDqxq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 06:13:14 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id u18so7165158plq.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=16mOFIrgq9qvlgahtvjFRJUWsQwKf4nzaXkL4ESzLV4=;
 b=aPsT3Ngy3IefUanD691TLd4DMxIM4JrXP9BMHrFS7V5nlAOk59E8wXyFE0P2lv58At
 7s4fpmzbNvKXkFZBXLgUoxDnn7spTVY4kc1Z5nc+kINWxb/1e6/5YTfcKsSI81cy2PWP
 Y1O2ClGC91Riy+IcwkbThdhPUseNo3wPDtHeQguYX4TcA4UIK++Or+1QTsYlKzMel2EV
 q0qnQSNCuxXfG/f9K+w8FYCn5mMrXoq0ALRSnKKhF6qjDRru+Af4RLDz3lHEqR1hjJOv
 qJCj5VeK6H0eMUAYwm//yrv/7Y+7ZxZCvptijDnz8kQnRHuk4+GJXKIXas1PHIDWb8qg
 9xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=16mOFIrgq9qvlgahtvjFRJUWsQwKf4nzaXkL4ESzLV4=;
 b=qkJwSgVkFQzaWpYDFqbL8Cfz2tkrJllXxu/pP2gXtoRiIYeSlNydgnmmQV5YvbUGVZ
 T0QR2kVToGc19OkYjDomu/+wp7VFHRN33oiCiMtAEc1iaP0vBif105X0o+pRn/Krfbak
 XcFeMy5usHvIXhsO3AzcCtbXiljs/+ZxLA1sOHpa7n4xVVI8IeiXhYqyd6jsk6dU0hbJ
 8yjeK67nzTBr4ZR/EXGa/LuCLwCQSUD+lcE4KFg2YMYuiwCLHE17KD3wVtfC0AanVRGO
 v1rApM7+5YFHYQVCMl74dlVqp5ucZpB9oSDfgXYwX0fwdF0bB3kqxjT3i4egNRtzGeRK
 Zbjw==
X-Gm-Message-State: AJcUukcHcIseRDfdUiCMvVqrZ/ftUDtEdx7CQyFGoAbkxntt+XrCym+G
 NDupJO7Aih5mzMLZWRzwntw=
X-Google-Smtp-Source: ALg8bN7JxPMKRx3wni+Mtxt3F59/lQPjcb8Xynb2edI12ZqRDYx10kx25q8ZUoYW0ioNVwKFT/Gq5A==
X-Received: by 2002:a17:902:8607:: with SMTP id
 f7mr15378748plo.123.1547233992086; 
 Fri, 11 Jan 2019 11:13:12 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r4sm159594554pgn.54.2019.01.11.11.13.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:13:11 -0800 (PST)
Date: Fri, 11 Jan 2019 11:13:07 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190111191306.GA8463@Asurada-Nvidia.nvidia.com>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Viorel Suman <viorel.suman@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 08, 2019 at 01:05:43PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.
> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (4):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
>   ASoC: add imx-audmix DT binding Documentation

For this series,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  44 ++
>  .../devicetree/bindings/sound/imx-audmix.txt       |  24 +
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 101 ++++
>  sound/soc/fsl/imx-audmix.c                         | 328 ++++++++++++
>  7 files changed, 1069 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
