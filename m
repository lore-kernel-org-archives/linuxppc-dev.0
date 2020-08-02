Return-Path: <SRS0=CfD8=BM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC7EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 06:46:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DAF2075A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 06:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVwzdDzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DAF2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKBP31dRbzDqQj
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 16:45:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NVwzdDzr; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKBLx0pBmzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Aug 2020 16:44:08 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so9289225pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2020 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=X2aoqAI7ZyUC5Rm/QGa/RZ2mj9QoixqrEf8FBg4wiIE=;
 b=NVwzdDzrwGuTsH/vRGeNQFdLRqkgojk4/9Jlwet5zvG3h2zgFl7ZbxGfHRg8wffHUV
 1a/LFn1ZW7JNnr8JoVOER9hf2rBtohqBMf8T6rO54OBH+FuZOrRXdtqfQvvN0WPJ1W5k
 Q3ouXMqZXP7rj9EkRoqITzgshE5MVGBVCcl21FdPO4zv5GMcYT+AqefwIS03y+4sabBG
 u8MBuDWOZ6IoFpbrYGAQN9NyDt0kipob/5m0LYS2Nn5n+AMRR6tqwuWoauLGMtweZa5a
 30eeof/z+kPgHfve/tQG/b1IwEPqGVu6hzjIGyw67PY5Dex6SiMMHxTwzthlayu1G/A5
 MZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=X2aoqAI7ZyUC5Rm/QGa/RZ2mj9QoixqrEf8FBg4wiIE=;
 b=iWU4cGDwCBZB/JAE30RGC40c0XmQItwJi9qTDDBjRq+Zxu9n9QKVCnqx5uf506Tsbr
 qPXgoFgf6RGwOup232sm7FRYHF1nP/a5k/wwKaHf12NTDByRO+7XHMzaYOXCx0qVs78r
 ButRpFM7rzSxxQZ2ccePkk2Akv/XBsjoHq99K/OTPpdiL/o4dZUpdn4IG9ETvnXg7q9s
 yZ5F/CHacuTuIT2NSbxAnow/eDTRZ79pl3tBovwna39JvjbVnKIlZ89oKigqbzyPssBf
 611Jv4Le+2b14/qSASegMwq0jEhEEAk5psGMGEys70WDhfdVTKGFfLzqftx7xVzd/E7W
 C7MQ==
X-Gm-Message-State: AOAM5302ysD8ky9Ytb1USo7CIBBSEhDl09cBqMtpb/6UyppMw3DiYxC9
 iEYYbrL5uA7/fAz5ydAmxPk=
X-Google-Smtp-Source: ABdhPJzT67tILFTVcT+5Nq4nLiq/ChOlKvzNLIZhqH09UIVzSNlqRhHDagQVesDQEPfSG0+9p5y7aQ==
X-Received: by 2002:a17:90a:6285:: with SMTP id
 d5mr11743122pjj.85.1596350642900; 
 Sat, 01 Aug 2020 23:44:02 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f18sm15347558pgv.84.2020.08.01.23.44.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 01 Aug 2020 23:44:02 -0700 (PDT)
Date: Sat, 1 Aug 2020 23:43:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Remove
 fsl_asoc_card_set_bias_level function
Message-ID: <20200802064351.GA24213@Asurada-Nvidia>
References: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com>
 <20200801075954.GA19629@Asurada-Nvidia>
 <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Aug 02, 2020 at 10:22:35AM +0800, Shengjiu Wang wrote:

> > > +     /* Specific configuration for PLL */
> > > +     if (codec_priv->pll_id && codec_priv->fll_id) {
> > > +             if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
> > > +                     pll_out = priv->sample_rate * 384;
> > > +             else
> > > +                     pll_out = priv->sample_rate * 256;
> > > +
> > > +             ret = snd_soc_dai_set_pll(asoc_rtd_to_codec(rtd, 0),
> > > +                                       codec_priv->pll_id,
> > > +                                       codec_priv->mclk_id,
> > > +                                       codec_priv->mclk_freq, pll_out);
> > > +             if (ret) {
> > > +                     dev_err(dev, "failed to start FLL: %d\n", ret);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
> > > +                                          codec_priv->fll_id,
> > > +                                          pll_out, SND_SOC_CLOCK_IN);
> >
> > Just came into my mind: do we need some protection here to prevent
> > PLL/SYSCLK reconfiguration if TX/RX end up with different values?
> >
> Sorry,  not really catching your point. could you please elaborate?
> Why do TX/RX end up with different values?

If TX and RX run concurrently but in different sample rates or
sample formats, pll_out would be overwritten to PLL/SYSCLK?

I remember imx-wm8962 uses SSI, having symmetric flags for rates/
channels/samplebits, but fsl-asoc-card might have (or will have)
other use case.

If all existing combinations don't have any problem, we can add
a protection later when we need.
