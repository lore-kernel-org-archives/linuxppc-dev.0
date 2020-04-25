Return-Path: <SRS0=123t=6J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B586C55185
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 07:51:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083DD20706
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 07:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnG+O4+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083DD20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 498NXW5rl5zDqYP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 17:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f43;
 helo=mail-qv1-xf43.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=CnG+O4+o; dkim-atps=neutral
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 498NV45wy3zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 17:49:31 +1000 (AEST)
Received: by mail-qv1-xf43.google.com with SMTP id q2so5903822qvd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BgbYCAeNQS+0nZ7Fig9vtQKe5K6A7aPPzIrm8C7qsUo=;
 b=CnG+O4+oOV8iNbmiQlvDFqsA7UGQFM7lwHR/uXwOIq6fSWfg2UihtiYQvVvwKZGx80
 Oo7g3L9ILVnmm5FwSeZY3gPrXkK0x0hKBv0KvYXigh7O7th8Xndn4PWCvbqj0KVonEwu
 7ZR6VvHhK8Y0iZpK4n8s/J/ZkqUk9y3WHmiAHGQpaiSYPo+UKeZbyMN5qIo0bCEXZHMH
 zlHBWaEJeARsiEeEZghohFYg80MeDVwSj2BFoUU3kWX1HB0hp7A4BRvjYthgzHQDjg4r
 drAS+b42bIPzFf97etG2yohqn/G9A+6z2EEISXi97Uk1SdMhllxp+siZqfwVq31dXTQ4
 rStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BgbYCAeNQS+0nZ7Fig9vtQKe5K6A7aPPzIrm8C7qsUo=;
 b=A6l4ZbqsZtLIPTkWVQrCIOBFohliD4ZCY+YTTomHEsCY0aRy7jwbrMKM/UWzMZr1j8
 bOudjA1y02jFvw8JCX5jmQNZSvlvFJTogwQQGjju3P/VcoZ91Hlh6suUf/Kgwusj0CD+
 PuOMLrYWQHSiHicIAIUWGZULWfjVZo7Gb7UfaxkP+p5MwxwLKws8fqsYvVCwWoMQPMXr
 5z5W2imVZg0TSPwcQaJj1FG8oJ+pYbbFzvk6ixNlCtVvgUpBSnCVF9oCAnl8MWaoXNFs
 di57CdKNtGn2WtMckWNDNCY2LWZNI9MeFkj9kZK+9zFZxw3cPCnSlxrjhaAG/Zpd5Xwm
 I94g==
X-Gm-Message-State: AGi0PubD7N//UokC5RFGR2x7n9zsvvmubwNO4CFvFO5NSuo1pemcaMoG
 lHWVRj2Z38CLujgRH0fimJyLPIZkEISDkth6o+g=
X-Google-Smtp-Source: APiQypIZ9cAxzqkKEzDmAZGMWki+YHf3qfiPJ4v1ZBfa7GRLio9jmFZpssBeF/e7X4lg8j6LVxO9uU8x48sUYrDjy4s=
X-Received: by 2002:a0c:a9c2:: with SMTP id c2mr12947457qvb.23.1587800967701; 
 Sat, 25 Apr 2020 00:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
In-Reply-To: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sat, 25 Apr 2020 15:49:16 +0800
Message-ID: <CAA+D8APuhgO0DF74GtCcR1AXTU0ZRR+Njupr0VP4o5jNgTQ3ew@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before
 dereferencing "ctx" in fsl_easrc_hw_free()
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 perex@perex.cz, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 25, 2020 at 3:30 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote=
:
>
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:
>
> sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
> warn: variable dereferenced before check 'ctx' (see line 1527)
>
> sound/soc/fsl/fsl_easrc.c
>   1526          struct fsl_asrc_pair *ctx =3D runtime->private_data;
>   1527          struct fsl_easrc_ctx_priv *ctx_priv =3D ctx->private;
>                                                       ^^^^^
> Dereference
>
>   1528
>   1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream=
))) {
>                     ^^^
> This check is too late, to prevent a NULL dereference.
>
>   1530                  ctx_priv->ctx_streams &=3D ~BIT(substream->stream=
);
>   1531                  fsl_easrc_release_context(ctx);
>
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Sorry=EF=BC=8CI forgot the changes:
changes in v2:
- refine the commit subject.

best regards
Wang shengjiu

>  sound/soc/fsl/fsl_easrc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 97658e1f4989..20326bffab64 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1524,9 +1524,14 @@ static int fsl_easrc_hw_free(struct snd_pcm_substr=
eam *substream,
>  {
>         struct snd_pcm_runtime *runtime =3D substream->runtime;
>         struct fsl_asrc_pair *ctx =3D runtime->private_data;
> -       struct fsl_easrc_ctx_priv *ctx_priv =3D ctx->private;
> +       struct fsl_easrc_ctx_priv *ctx_priv;
>
> -       if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       ctx_priv =3D ctx->private;
> +
> +       if (ctx_priv->ctx_streams & BIT(substream->stream)) {
>                 ctx_priv->ctx_streams &=3D ~BIT(substream->stream);
>                 fsl_easrc_release_context(ctx);
>         }
> --
> 2.21.0
>
