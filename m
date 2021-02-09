Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD675C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 09:18:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABEF64EB4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 09:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABEF64EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZckP0m9jzDrQY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 20:18:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::831;
 helo=mail-qt1-x831.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tnKURcRD; dkim-atps=neutral
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZchc36FszDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 20:16:30 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id v3so12449423qtw.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2021 01:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UCCWDHu0sYSquKe4LwEXk0kUehGPBZCaQ+gPrhz2B70=;
 b=tnKURcRDMsX6KiDYyAtN3ScVm4Xp3sVDTWZQKtuJnUh3KGUrksRRRmet2qx+mEjT1Y
 Zgpj6m0XBE1jPTA/ISmoEhBqNEGLjcjfrYz9RYjjbdW1bOVkR8WJUvBwwXuH2XYBv1Ot
 cD4e4JVB5h00iD4b8COz3OM4fX1NmMfXTeFPG7F64PuyWj/VNJT579c9TP9OZ/sKetnY
 UL4jEkoesboHATyk8jB+ZuwLqHUgiBemu1v9dn8CLnNNA6GLG13X+YYI3Qmf480tNcTW
 e1CuEtTNIEXMrXK6Z911F09dY/V4GuXNrk8TlhuoseP0TL/3s0Jy+jXl4EcYNLKnK06X
 dHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UCCWDHu0sYSquKe4LwEXk0kUehGPBZCaQ+gPrhz2B70=;
 b=ddk6XdZ6J5LkTk68FPKWrIRzZ3xqV4u9vkP3N1oj4qBhgyLGnvkm39d/JukZaFaPT9
 NjqmuN3Y+LCDK4g8Z/z+RfeQ1fR1sgRiBURYDOEHikNzA9KvCa8xJD3DV1wUzplRbtO6
 IQWVEth07EaHQBeMAVDEpOwpNiD4WLXaL8U1CVwfjac15KyT4wVAtG0uIAHhXlPt7EIO
 JfM8G9CAJHEY1CKR4dNTvf4ppnIdkJ2h7gj0HjG0OSYgKvj+T5Qz0l+i+yAtYxlbU8Un
 hKAVBS6mXj8q/lqPDHwXEb89QQQ7k83DhObwUfY+faOHx97c9CgTc03Ptyubo2hdMLfy
 eXvw==
X-Gm-Message-State: AOAM532veCziWddwiKimNYNDdW3x+3wJwpTxqF7QecpQ5GsDUoU+nLrf
 9bENwfAscrMK8ZgRn6jpdTPXJSGgriQHuv9TOfQ=
X-Google-Smtp-Source: ABdhPJxk7JApErbcYd9iIq2ywHmycgjkc6ZN9v2FM3gZNbGEGB6G4khg1FgLHMytyhFDNZEL3y9l+4+oq0VpDadZElI=
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr18524155qtp.292.1612862187116; 
 Tue, 09 Feb 2021 01:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
 <20210208115112.GD8645@sirena.org.uk>
In-Reply-To: <20210208115112.GD8645@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 9 Feb 2021 17:16:16 +0800
Message-ID: <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base
 on rpmsg
To: Mark Brown <broonie@kernel.org>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Feb 07, 2021 at 06:23:50PM +0800, Shengjiu Wang wrote:
>
> > +static int fsl_rpmsg_hw_params(struct snd_pcm_substream *substream,
> > +                            struct snd_pcm_hw_params *params,
> > +                            struct snd_soc_dai *dai)
> > +{
>
> ...
>
> > +     ret = clk_prepare_enable(rpmsg->mclk);
> > +     if (ret)
> > +             dev_err(dai->dev, "failed to enable mclk: %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int fsl_rpmsg_hw_free(struct snd_pcm_substream *substream,
> > +                          struct snd_soc_dai *dai)
> > +{
> > +     struct fsl_rpmsg *rpmsg = snd_soc_dai_get_drvdata(dai);
> > +
> > +     clk_disable_unprepare(rpmsg->mclk);
>
> hw_params() can be called multiple times and there's no need for it to
> be balanced with hw_free(), I'd move this to a different callback (DAPM
> should work well).

Which callback should I use? Is there an example?

best regards
wang shengjiu
