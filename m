Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83ADC388F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 13:22:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15C220829
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 13:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNh8er+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15C220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CLC6J31hKzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2020 00:22:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f44;
 helo=mail-qv1-xf44.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vNh8er+j; dkim-atps=neutral
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CLC1D56lXzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2020 00:17:33 +1100 (AEDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv1so607431qvb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sv4MSsdbMGxld4Lj23VTm9RmQoViIo/kKrPn4dkU/IY=;
 b=vNh8er+jimshlHNWTbr4gxIBpMpES1VfHM5fklA4+DGxjGBfFZMTBNrnWvRMDNzEfr
 aQrfRcyA0YRlMkbE4iRd8LQFdeArBZ9l5u2mKk4ecgqvSfxudOFqI5447qbLTrmxWVxu
 MZUs1sCVwjcKM77K7xR3A3fPqScf/wNvsOraon9HEj4uf5+0pOLLY0avW/tdBmuAFGze
 2wXlIiRzczDBzOQoZN6yxBFuW/tl1JJMxJ0b5qMqVRTQISZPadZgZF7ZJVsxohgOlICP
 hviF2mSA6Kpe8+FB0P5K1y+aiD2cqurYZzRe5yMm+ivlwi3k21Y19tDzHoSm1qOlOYil
 eUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sv4MSsdbMGxld4Lj23VTm9RmQoViIo/kKrPn4dkU/IY=;
 b=Os9iL+DrJnp0DRpZDGi7Rh9iOYQPaTANnu28WAhEGVkZr+6l0LSjMNGwukZT8th5M2
 jGxqBSmcE8DGNaFpwPhwa4MXckcO8hrLN/3Mw/gr1XiQ6C1YlHihvVCb9XGK9XWQOhmj
 O/U1KxEW1mpJa3NOA7A4iBuoisHVfv7T2gw1SlwHzdy0pAvSz5LiGy6ZFDpmDPJrcw+i
 GW5oT087Vof0r6I6rqAeS0E7n4DzbESrfxNg/hRltKr6mPLdytttP7oYK3PULbLwRLxV
 +/+1NRIWZ2g8yTBqHmtZrSToqn8OQLM8fC5V3iZSmKDVAVG5C10MCJYqAy6KpX6TCVHa
 Zxvw==
X-Gm-Message-State: AOAM533ha4xw8uAPTHX6nhGQcnxD4d5JaV6WSylSWbx8oUAqb1KT7bIg
 2wc2VpEieSJzZTdFbIXej1QLpC9c62/qTv1dtgc=
X-Google-Smtp-Source: ABdhPJw7WHxGGt0QI/QBYgwttvjYmNUbf+/rEv7bpW+TknJBJlrymRHrxafQb7NUmoIIP3EJGVRRlgEZT+IDAOuSO8A=
X-Received: by 2002:a0c:82c4:: with SMTP id i62mr2409110qva.28.1603804648818; 
 Tue, 27 Oct 2020 06:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
 <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com>
 <20201026133003.GD7402@sirena.org.uk>
In-Reply-To: <20201026133003.GD7402@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 27 Oct 2020 21:17:17 +0800
Message-ID: <CAA+D8AMtFh_ZCPrxNDcMmLx2Uqxh9cRX=dX8=tJXt=O72baY5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
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
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 26, 2020 at 9:31 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 06:40:55PM +0800, Shengjiu Wang wrote:
>
> > +static int fsl_aud2htx_hw_params(struct snd_pcm_substream *substream,
> > +                              struct snd_pcm_hw_params *params,
> > +                              struct snd_soc_dai *cpu_dai)
> > +{
> > +     struct fsl_aud2htx *aud2htx = snd_soc_dai_get_drvdata(cpu_dai);
> > +
> > +     /* DMA request when number of entries < WTMK_LOW */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_DT_MASK, 0);
> > +
> > +     /* Disable interrupts*/
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK);
> > +
> > +     /* Configur watermark */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WL_MASK,
> > +                        AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WH_MASK,
> > +                        AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
> > +     return 0;
> > +}
>
> This doesn't look like a hw_params operation - it doesn't appear to
> reference the params at all, or even containt any conditional
> statements.  Shouldn't this be configured just once at driver load?

Ok, I will update it.

best regards
wang shengjiu
