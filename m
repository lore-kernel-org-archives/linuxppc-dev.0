Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CBC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:13:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966792089E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgCU5E+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966792089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rCdV5NfKzDqfc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 22:13:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgCU5E+m"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rCb62mWrzDqg1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 22:11:46 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id w37so2978824edw.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Iv+Qt/L8mJZ+qcF89VURhvr8O3ic6BiHoQtS2O+mf6w=;
 b=KgCU5E+mQUaAngkEPf8GYVsgqKE13B7je9UgwHKl0P6aQOkh12SOT9rGZ4lXG/7OXp
 8EeYa761UjVrsvbrqf4098fXcYb5CL5m3kl+IUhJTHT7NB9pbYn7nnxGeGJIOWn7AgwE
 QviFVg/QJhNo4/HEDWZBgrDpHjigmxreOePeknoFMqGRFVm9w/Xh+RDhtD/ScKPLpWZk
 0YoXcdyapohDn57eiQvYOXRXQWlciTA2IiqEGndjEjYsKMhwaGicwUqFjRyy80bd9lVU
 T1Ls1gTw9aAsqZJThE6575U9o1snUuNn0x9zTPwI1RsAdSXczFQ7eK9Bcp4WvkpgaFx0
 WVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Iv+Qt/L8mJZ+qcF89VURhvr8O3ic6BiHoQtS2O+mf6w=;
 b=YJj7KXdjNP60sslvvf+KHWx51R+yDanom2YpcEURRLv9PPEJx+0IvHskPnkBQ+it7p
 K/02qJ/vulk2ijfzBEU5ac2VRVZaRxl7hf/EkuqBpbyCY+dIZBr2SSPCNDYLjjAygnWV
 9+L4uz9vsasqMlWPTPamaJvcsbdJarXDxTWbuffeQyUAdBkEiaBL3Ez/g/X9TXjLrSQv
 s5IRr+8dRBrJuvTEj0h+eR0NVjjQ1+UdMF176a4OtAA7RsQFBNQ6mjo03m/Ie3uJNExG
 KmNhXjiraJDgW2pA6wpdUk2Rd3HBBdKVDrOIDFim+36ru+Is+NWNRwmrIcVab+ETIg39
 lNXw==
X-Gm-Message-State: APjAAAVP9qTN7GbYFd5zPCr+jPr+9aEw7XUB3hqerf/yOY1zpdXY5xbS
 EKSM0rFURrTjKexWIS8caAcsDGl6NAvSpEJKBwc=
X-Google-Smtp-Source: APXvYqwg1tBQB8xAZ3L8jvxGUswWVPmzCPfBxX5vwnT3za6d2x7T4b6Y67klyNoMzXl9S9A9zAfjFLiLY1eYF1svXSw=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr27861786edb.46.1556280702041; 
 Fri, 26 Apr 2019 05:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
 <20190422190213.30726-4-daniel.baluta@nxp.com>
In-Reply-To: <20190422190213.30726-4-daniel.baluta@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 26 Apr 2019 15:11:30 +0300
Message-ID: <CAEnQRZCK5dPoD7TunxLsf8EXVb-99Vb0OQnaqa2rmAQu3eyWvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ASoC: fsl_sai: Move clock operation to PM runtime
To: Daniel Baluta <daniel.baluta@nxp.com>
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

Hi Mark,

This is the only patch in the series that wasn't applied.

On Mon, Apr 22, 2019 at 10:03 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
>
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 54 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 8623b7f882b9..7fd1a81ec1aa 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  {
>         struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -       struct device *dev = &sai->pdev->dev;
>         int ret;
>
> -       ret = clk_prepare_enable(sai->bus_clk);
> -       if (ret) {
> -               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> -               return ret;
> -       }
> -
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
>                            FSL_SAI_CR3_TRCE);
>
> @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> -
> -       clk_disable_unprepare(sai->bus_clk);
>  }
>
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> @@ -932,6 +923,14 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
>
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +
> +       clk_disable_unprepare(sai->bus_clk);
> +
>         regcache_cache_only(sai->regmap, true);
>         regcache_mark_dirty(sai->regmap);
>
> @@ -941,6 +940,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(sai->bus_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +               if (ret)
> +                       goto disable_bus_clk;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +               if (ret)
> +                       goto disable_tx_clk;
> +       }
>
>         regcache_cache_only(sai->regmap, false);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> @@ -948,7 +966,23 @@ static int fsl_sai_runtime_resume(struct device *dev)
>         usleep_range(1000, 2000);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
>         regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> -       return regcache_sync(sai->regmap);
> +
> +       ret = regcache_sync(sai->regmap);
> +       if (ret)
> +               goto disable_rx_clk;
> +
> +       return 0;
> +
> +disable_rx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +disable_tx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +disable_bus_clk:
> +       clk_disable_unprepare(sai->bus_clk);
> +
> +       return ret;
>  }
>  #endif /* CONFIG_PM */
>
> --
> 2.17.1
>
