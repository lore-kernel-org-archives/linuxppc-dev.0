Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D1C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 17:27:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379B92171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxaoYZfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379B92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Q0Jg4jllzDqLp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 04:26:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxaoYZfo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxaoYZfo"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Q0Fv6X9HzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 04:24:35 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id c9so20895133itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vDoe0h9uhd83kOri/WUN/6c7QD7cprUiK4aSXchZQo0=;
 b=hxaoYZfodDjQzT8IDOhHSRCeWk4osq4qYKjWUuzgOxN8ybPslCNPo4rPpGFIRqjHfF
 1pQQxLbz3FhGZBL/p8G/4PJ6efpi6BFKHtUqZaR2JXkCumPtwxxmzWgGyQCFCW5c/eQl
 UN4AwGFBwsfi2PcRQMnkNxJpI7FJ0QUdu9jR7qmhLQrGiDTxyD2pD4J40mPpoTpZ27oF
 vVkvilrGOqHTWNNsdei8LzMSJrbF6i11L/Y10Tsu79lBCaNtDZod/IHZ8EZf3wTV8HLo
 oDGBMYgnJGonAIe7+bIsTrTbe/VBEpQp+L2KXABzS7nJWZxkbapcrC0Af9qhYLkVsSdJ
 ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vDoe0h9uhd83kOri/WUN/6c7QD7cprUiK4aSXchZQo0=;
 b=oq79gwOyVoiNHlt9Q2sso/zpjskPndi9WjKG/jZ77ED0YRynKk7F4VdUe6doPDsE9e
 J9SCJucMqXaVKDEzd94pnOFO8kGHIGjxImx/TdmxJwOsKDodN8mteMvc5EKVYUpjbaI9
 HhoJ/p8sL227lY/NeTu6RgjcY1rt/N5EzM70Aq2o/wWW165X0yKpnKvOWLrcWkGZ1jdT
 Jh3vxMJQSQoqkhjCzMZP6OzkbttojyZKIWTxWK+9xcHHGM6ZX/3xQqOPPOZYpeZcNra8
 gfCxmCQAeWbYFD2/NZ3v4AzjhB0v1xZPGipPx0TD+k9n0HwAzEK+cshOdPC5MOzsPKlk
 VKKg==
X-Gm-Message-State: AA+aEWYX1ZaZ+fJ9lH6Cjquw0Ws9dEtrUtLmFUr8V3jpXvIg/kCvOFaz
 jzB10IYTJwzmSAwdrdbMRqeJIO8ewtRyAp9AJhk=
X-Google-Smtp-Source: AFSGD/Vn5D2EX532L9ciOLTTS1oQNGR3iRdiDmFZHJ+LJDlDQ0Rxhh1Owthvyuzdwe0o9MNnE6g+pZC/C5ASx0mLfCo=
X-Received: by 2002:a24:1aca:: with SMTP id 193mr13346521iti.150.1545845073271; 
 Wed, 26 Dec 2018 09:24:33 -0800 (PST)
MIME-Version: 1.0
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 27 Dec 2018 01:24:22 +0800
Message-ID: <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
To: Viorel Suman <viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Viorel,

Sorry for the late response, having been on a long vacation.

The code looks pretty clean. Just some small concerns/questions below.

On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> The Audio Mixer is a on-chip functional module that allows mixing of
> two audio streams into a single audio stream.
>
> Audio Mixer datasheet is available here:
> https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++

I aimn't against the naming here, but it seems to be AUDMIX in RM?

Would it be better to align with that? It's your decision though.

> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> +=================================
> +  - compatible         : Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg                        : Offset and length of the register set for the device.
> +
> +  - clocks             : Must contain an entry for each entry in clock-names.
> +
> +  - clock-names                : Must include the "ipg" for register access.
> +
> +  - power-domains      : Must contain the phandle to the AMIX power domain node
> +
> +Device driver configuration example:
> +======================================
> +  amix: amix@59840000 {
> +    compatible = "fsl,imx8qm-amix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_amix>;
> +  };

From the description of DT and RM, I don't see how it connects to SAIs.

Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be better
to have such information in the doc.

> diff --git a/sound/soc/fsl/fsl_amix.c b/sound/soc/fsl/fsl_amix.c

+static const char
+ *width_sel[] = { "16b", "18b", "20b", "24b", "32b", },
+ *pol_sel[] = { "Positive edge", "Negative edge", },
[...]
+static const struct soc_enum fsl_amix_enum[] = {
+/* FSL_AMIX_CTR enums */
[...]
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTWIDTH_SHIFT, width_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTCKPOL_SHIFT, pol_sel),

Should we handle the width in hw_param()?

Why do we change pol here? It feels like against set_fmt().

> +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +       /* For playback the AMIX is slave, and for record is master */
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +       case SND_SOC_DAIFMT_CBS_CFS:

So it's used either for playback or capture only, not both at same time?

Thanks
Nicolin
