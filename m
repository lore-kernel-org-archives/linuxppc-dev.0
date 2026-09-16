Return-Path: <linuxppc-dev+bounces-27453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48CDC88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 03:30:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl4Cr0qVZz2y2B;
	Wed, 16 Sep 2026 13:30:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::11" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789529448;
	cv=pass; b=gKrmJ8lgM6n6bER7z4gqJjnCeTI8iRelnHdGQfapj4MIuIroVqbWf/X/fiJ3tIakcZcfLOY+9aXfMZVxd9VneKpgBIVCSe3OI/JmxWXw59oTwmLw5J6/5A6WE+VMdp3+te4g0hPEfoJIsgs+94HiQZ8xLvV3IukodrWtm06U76CQB+DxtHn2ZYy5Osdjw8IH6hLixP3c05AlESrZKrPLJC1FuxI16jxvAJwZcM1tcgPyIgFFI0N35upctfnWYdqB7LR8NfMKlR/nJKx1UIABxbJhmkvLBUiRxpS8EO/PtUGEf6Hig6NHzcfkzaVeek587bbhizE4VOrmaaU/dQg0ew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789529448; c=relaxed/relaxed;
	bh=oQBcZLRQSJNhtU+t6MQeVLZ2u/wOeujIUGm2gsEJiuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDkYERVi4h4iYTI+u6r+LLR7MJ+n8uMl9rd89rC8paB89C3dFLY47ysZqizLhG4Ch3bBZmap/RV/VpoUu9ZN9XgtW4siiYBSYte7QrfnneSDukmpnA3PYSki0ZHJH2LzNR3TGjo+TAXpsW6LjsT7YGvV7rsI0aEJsgVGU3+hnlQ/RKGQevzXnJpR+6obS9+sON2K3GVlKLaihN7r7c9AWTkM1cOvugw/EKLq0mtuMhTUpWQVdOg5mPDk7v6BAj3lD4O0kU9dxJ5yIQuX+9PRRvZNQf47kxybzL5ZMwAAPorOUmD7wcSxOIxK5oNMQ+YvNSq83FwC+aIZuLpRDL0hvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OiK5qtYX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OiK5qtYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl4Cp6cPcz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 13:30:45 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2dd88a115c1so4900405ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789529443; cv=none;
        d=google.com; s=arc-20260327;
        b=drnXQnYYxDxaFh//OKv4fnq5ma9LNdArmS7Gvz+4C+uGFiu8jQ7xfAP1NrgfGXIQLZ
         iLY49YjpEVCCQlXhATGMTuO87qjGv8g3WhNTfqLjcp/TK4hLzRkx6agrGjxMClguY2u6
         SG1vu3UuubTb1oWW7jU2onjeCxqYczZuZClVdJ1Mg/wuDQQGW4U9mskcnx/2UoaNUGxC
         YjdKiAseG2Qoy+tTm9wKupfT6N6J52kS4QI4yCB+GZEtzB7Gf2hxn2pnD9GgYrVBRAg3
         2EQam53f9/ElZhSXggIXiV+BmdK3izd2lVcxocpHVjdohpWGw+ad4Ce+3t8hGr2oeyt3
         ljxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oQBcZLRQSJNhtU+t6MQeVLZ2u/wOeujIUGm2gsEJiuY=;
        fh=nJEO9V14uaplCLVnxBi6jFrRgeBtBMptah60Q7yJJlE=;
        b=g6wes5zGFRLyQ4Ea4/uShOuc0hwNPeNt1XzvuYK0yH4aNAcc0HFWRvGjZvQHne2anE
         +eFbXeNjWqdLKM4F00bjw+45qIprTqPEgqbz85K2Cw4Koh4BG7VuPM0FQQI6cpbI65Eq
         UYAL4vpN3j7b75ReyRjAY0fh8B6aliVzQQa75TJXWdSNv+IiUxaPA86A/0o2jHR1FVka
         EHU1vPk+n588h/ddiNcHRLdSRGHnUMiK7pb4fYPqjLkLCj/dAY2Xow8vFu34KWwmum7u
         /YFHH9DcJn0TQ/Giqtz/evFDhJ0pQnj00Kdzk7Z+F2I8pWIDiOWCK9buPedFHXgfb/Xo
         v8zw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789529443; x=1790134243; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQBcZLRQSJNhtU+t6MQeVLZ2u/wOeujIUGm2gsEJiuY=;
        b=OiK5qtYXLeEqN909aNKu+On/HudBxBkUfRZMRTktiN/08FhMlzIjQXF03+kyBkKA+0
         s+9ox7EDU5u6o7SHre6ht3mNWXr48xk+SZX/Yw8hVA2UBNWwj+yBynC8JE7CYQqVJb/v
         7QxCIP1UoOFe/b46r1bW9GX1QKGzc6YmMYYpbnbZc2vCGV644kzbYmyFBoOgJky092TV
         whrNX1qSi9oLBk/SI2Wz+lj+dAksjLxVlVfOK4OBDusUsaaFN3LunYPZXyTiHQ0XnHF1
         9j9QHN8BmduCAvsDjWDFQn1iOcTOYjbhzIKTNibkdNkMdUGrowLaEOmkBgMf8KMWQDzf
         +kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529443; x=1790134243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQBcZLRQSJNhtU+t6MQeVLZ2u/wOeujIUGm2gsEJiuY=;
        b=drhTfaj4z19eBH+TKbjpZb/6Lv3lHCuXdFVuo2B2n0UvUz5w7M0FoGa36LpVWUU/hs
         yKJoeFzHzakO2zbIVJpe0UAcevgsV9AvM+iaanFM1zIvoQ4DyQcRobwXkUDNeCngbc1a
         VFiZgBh521ctS61qbvoi+ohgvjsSKRcMfJuSDLhPkXv8okvjCuRGcbqAvFzL8xohYfHn
         S/oQw/lARgpJk+sUwvxXHl3AAKZsf2xaMdmxWIHlqw60s3NjHFFdRf4drdcc1ujCEKrr
         mVGEWe1GR3nuACDk3OaTFdrd/p+/eZTjkKv4/PVl3/wdZKdKDLAZAVOMvu/4goxS6hPn
         mQCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMiKXHEtwvV8PT3FxnU9fN7BuMB0uGjZFlizyTZ7Rw2Cw/iIzP0nu/wQ1aTlkyA5uDQM1Q38CwGBUPAMw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nK34DfolxMM/nyifg3TC3j9wiPj1Wj6v7JSC94ooVqRRxVUraZ
	ctYCt06rUB7S7ILRqsElJZ2tI20cH5H30xwwTJdcm7xZykA4qKadONgbWXfihe+m9SEieOGg5RK
	64iZbbl/jyt3v/+E90y8sWSmLgHVUhZ8=
X-Gm-Gg: AYBFou30qNfQm/uS7oNCtfxDlKhUWGMihlZVkiGMxJy5etx8yOyYOrEagRynWrjAgmR
	h0DQaZhMc7fGapy/MTu8E/FRFq9stxV15J3Asar37IEI4e6/L7pQRHCs23Fl26TffWH3RTMWr4b
	Kctau/T3YrumGnMN3/H6tc4crulAonoAGJnrXo487FC88pPkUy/v7XBVuY23M07Ng1r4iozwGjd
	UNoS67nILtsZ2fx57qUoUSquBcrA7UYQHCowVfVqRetfXa+WLArv8a3pBeO91E2sKb+JELOSzJl
	P9sXDJn8DRNk81gV2tkYPFirvudu6MIxS4ib1dyDHMQ121x9BOUqboqtKR0719zwkKg=
X-Received: by 2002:a17:903:1ac5:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2dd8e003302mr22506815ad.6.1789529443281; Tue, 15 Sep 2026
 20:30:43 -0700 (PDT)
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
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com> <20260915100931.3593242-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260915100931.3593242-6-andriy.shevchenko@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 16 Sep 2026 11:30:15 +0800
X-Gm-Features: AcwNN1XutB8iZg2AF0p02q4kvkV9mnifXUYQQ4fzj9LiCitjAIk_rhIx4BZpDsc
Message-ID: <CAA+D8APje43K1vNagzzH4yX=q1fx0Ntwa28fuFfyhYt5MRCkbg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] ASoC: fsl_asrc: Replace dma_request_slave_channel()
 by dma_request_chan()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, bui duc phuc <phucduc.bui@gmail.com>, 
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Dave Penkler <dpenkler@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_asrc.c     |  2 +-
>  sound/soc/fsl/fsl_asrc_dma.c | 13 +++++++------
>  sound/soc/fsl/fsl_asrc_m2m.c |  8 ++++----
>  sound/soc/fsl/fsl_easrc.c    |  2 +-
>  4 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index b24737add001..ae682bf450f6 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -638,7 +638,7 @@ static struct dma_chan *fsl_asrc_get_dma_channel(stru=
ct fsl_asrc_pair *pair,
>
>         sprintf(name, "%cx%c", dir =3D=3D IN ? 'r' : 't', index + 'a');
>
> -       return dma_request_slave_channel(&asrc->pdev->dev, name);
> +       return dma_request_chan(&asrc->pdev->dev, name);
>  }
>
>  static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 2f662bdf14d0..5cd12781c604 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -191,9 +191,10 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_com=
ponent *component,
>         dma_params_fe->maxburst =3D dma_params_be->maxburst;
>
>         pair->dma_chan[!dir] =3D asrc->get_dma_channel(pair, !dir);
> -       if (!pair->dma_chan[!dir]) {
> +       ret =3D PTR_ERR_OR_ZERO(pair->dma_chan[!dir]);
> +       if (ret) {
>                 dev_err(dev, "failed to request DMA channel\n");
> -               return -EINVAL;
> +               return ret;
>         }
>
>         ret =3D snd_dmaengine_pcm_prepare_slave_config(substream, params,=
 &config_fe);
> @@ -404,9 +405,9 @@ static int fsl_asrc_dma_startup(struct snd_soc_compon=
ent *component,
>
>         /* Request a dummy dma channel, which will be released later. */
>         tmp_chan =3D asrc->get_dma_channel(pair, dir);
> -       if (!tmp_chan) {
> +       ret =3D PTR_ERR_OR_ZERO(tmp_chan);
> +       if (ret) {
>                 dev_err(dev, "failed to get dma channel\n");
> -               ret =3D -EINVAL;
>                 goto dma_chan_err;
>         }
>
> @@ -497,9 +498,9 @@ static int fsl_asrc_dma_pcm_new(struct snd_soc_compon=
ent *component,
>
>         /* Request a dma channel, which will be released later. */
>         chan =3D asrc->get_dma_channel(pair, IN);
> -       if (!chan) {
> +       ret =3D PTR_ERR_OR_ZERO(chan);
> +       if (ret) {
>                 dev_err(dev, "failed to get dma channel\n");
> -               ret =3D -EINVAL;
>                 goto dma_chan_err;
>         }
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index 4bc40f328f58..e440cc083ebb 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -503,16 +503,16 @@ static int fsl_asrc_m2m_comp_task_create(struct snd=
_compr_stream *stream,
>
>         /* Request dma channels */
>         pair->dma_chan[IN] =3D asrc->get_dma_channel(pair, IN);
> -       if (!pair->dma_chan[IN]) {
> +       ret =3D PTR_ERR_OR_ZERO(pair->dma_chan[IN]);
> +       if (ret) {
>                 dev_err(dev, "[ctx%d] failed to get input DMA channel\n",=
 pair->index);
> -               ret =3D -EBUSY;
>                 goto err_dma_channel_in;
>         }
>
>         pair->dma_chan[OUT] =3D asrc->get_dma_channel(pair, OUT);
> -       if (!pair->dma_chan[OUT]) {
> +       ret =3D PTR_ERR_OR_ZERO(pair->dma_chan[OUT]);
> +       if (ret) {
>                 dev_err(dev, "[ctx%d] failed to get output DMA channel\n"=
, pair->index);
> -               ret =3D -EBUSY;
>                 goto err_dma_channel_out;
>         }
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index aced16d1228a..d30cc3e90215 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1433,7 +1433,7 @@ static struct dma_chan *fsl_easrc_get_dma_channel(s=
truct fsl_asrc_pair *ctx,
>         /* Example of dma name: ctx0_rx */
>         sprintf(name, "ctx%c_%cx", index + '0', dir =3D=3D IN ? 'r' : 't'=
);
>
> -       return dma_request_slave_channel(&easrc->pdev->dev, name);
> +       return dma_request_chan(&easrc->pdev->dev, name);
>  };
>
>  static const unsigned int easrc_rates[] =3D {
> --
> 2.50.1
>

