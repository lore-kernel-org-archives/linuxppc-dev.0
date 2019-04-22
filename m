Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B37C204EC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVH7IQE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B37C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nkp95ZLpzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 21:27:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OVH7IQE7"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nkmS04DJzDqNQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 21:26:15 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id g6so9205548edc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PmcqzRYJAi/8nreTg3ExaX3WI1tolmLmFrA1haHMPCc=;
 b=OVH7IQE72/Lxb/raIh9iz3EUtHdzRTrMTptkZpSLGfwG+4tPB5uA4TB6zZR3/eLmNt
 SpzQj+6Fp1GAbEr+c+2DRn6b0kO9A6471NqIEBAYcURpqdE3pXfkKpCC0O2ULL5dqKeo
 ou9ZEXEbc7vhLo9QI7PEO1ychtmNuiT2+9h8Alv/qWFQN2McYXUlLPAutbirsnJEkKuO
 mV/aoM7NxbfM+7w/Gg7//tQg1IhGd0pJmkD22dY1DY4DdAxDtj0AKPabEK+hWJUiJIXM
 MVv1XuTIJy+lM2Eyv6B2eS6ETgQ4ydt1wsF8SUWl/joYEt+eOanH5JiCFDPs475CcJK5
 Gz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PmcqzRYJAi/8nreTg3ExaX3WI1tolmLmFrA1haHMPCc=;
 b=mQKwSxSEJfSjpukhnXESF2uacaN47KRf2tGNpawR/X2PZK9se8amtZvw371c46hGDl
 5qHB+slvl2OQX8zWg5py3Q9QkHoLjW0/wkP+Dlh+4n5fe+gaU3Hr6ebizmIqCor8wjWe
 PJZdgZjct3kKfoZ0tCKpjz8vg1tWRXLFMm6LXrSe2Z/Po5I48ci46ThOiH3okoKYD5Ma
 Jve0/26dKJVxfOqJpBgpQz9oy0T9bziELS9UBPq4l4K6Pc5Xr9Xt71hNr0Yut0ey7KEC
 CHLgNukogJKraX822c0h2wUuu30sx5CbKjKyNK9VaNPihK3mAg0Pn+rnaDKuhZFb5eUK
 CwAA==
X-Gm-Message-State: APjAAAUJcXSUj4dWDMtVd0eoQ5zANthS/u61kL1+2DYYKcH40OyqsbMC
 hG9BT75ewVqC6fX3UPMWEINzGRsTjYq19BqV/64=
X-Google-Smtp-Source: APXvYqy+0/Gu+egkjtx6yfKhgY1pNM+p9HvFgtY4K03YPIg3byruhJvQb671K2g83yWNUrkbPxkh4Zcjn19oQNrSAMc=
X-Received: by 2002:a05:6402:552:: with SMTP id
 i18mr2605656edx.67.1555932371386; 
 Mon, 22 Apr 2019 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-4-daniel.baluta@nxp.com>
 <1555931172.31656.6.camel@nxp.com>
In-Reply-To: <1555931172.31656.6.camel@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 22 Apr 2019 14:25:59 +0300
Message-ID: <CAEnQRZBrpD=mG7JmSFYVarv05hHHgApEDYNu9x2GLHO1NEvRiw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation
 to PM runtime
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 22, 2019 at 2:07 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Daniel,
>
> On Du, 2019-04-21 at 19:39 +0000, Daniel Baluta wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Turn off/on clocks when device enters suspend/resume. This
> > can help saving power.
> >
> > As a further optimization, we turn off/on mclk only when SAI
> > is in master mode because otherwise mclk is externally provided.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 60 ++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 8623b7f882b9..13a462360ed3 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >  {
> >       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> > -     struct device *dev = &sai->pdev->dev;
> >       int ret;
> >
> > -     ret = clk_prepare_enable(sai->bus_clk);
> > -     if (ret) {
> > -             dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
> >                          FSL_SAI_CR3_TRCE);
> >
> > @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> >
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> > -
> > -     clk_disable_unprepare(sai->bus_clk);
> >  }
> >
> >  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> > @@ -932,6 +923,16 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> >  {
> >       struct fsl_sai *sai = dev_get_drvdata(dev);
> >
> > +     if (!sai->is_slave_mode) {
> This check is redundant as the bits in sai->mclk_streams are set/unset for master
> mode only, please check fsl_sai_hw_params and fsl_sai_hw_free functions.

Hi Viorel,

I think you make a very good point here. Will fix and send v3.

Thanks!
