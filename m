Return-Path: <SRS0=LYYN=BU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8DEC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:59:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4EE2070B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Aa9uvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4EE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQ8z604ZczDqFH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 18:59:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::741;
 helo=mail-qk1-x741.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=d7Aa9uvk; dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQ8rp2Z5fzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 18:53:46 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id b14so7657114qkn.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
 b=d7Aa9uvkgM7oBz+js2KgV6ryeTcBKg1+nuyabNAVpCSEqUIVRt494wY2baViHTGqKZ
 aF8nGJPx0RtjOgE/N1sdXrZ5LC0r/EHlwHUFetfeuk2Shc5Vgs2rX7/rFOfAJ9fOSvZX
 c03EyDruLop4NtSphCrDRGpVngIJMJJhzgRS8dseZLs8U/scj0te95vbIW8mYJqoro1t
 cIgFamiIKdggQQ8iXVxxwWkmWuXVpJkxyQRerU5lir3AWhL1OVYlRUkI5PFHFweMQssu
 f5lmFSUmVMWE08JFuNHHPBbwf+uMCMnNuki5SkOm8ov4A5AFAwy2zcaornwwpbm+zdOD
 5hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
 b=Fj//HvSMsNI19LAINZr3yTvRi72ycdVRbwxfeGhS5CJTIkOexlhYscu2V9Lio8Hnys
 JsuvRv6CyfPW3CDzCTGQbVFTiq1kscizIFkORNYCqAz5pZkLeYW0/BhF24m5sYqH6AFr
 X08M31ILbeV9QzzUNItRChqMY7XR4EJsTE2Drg5tbt1oJBMs1iAjtMpv4q/WI806UmfH
 JAMHenXuagLetk4o4ZwFTQ9tZlYGTXktS+8w57Kj1NfGTY2VV7lfUJPXOFRcQS3yTI7J
 6eEqvP7XtEvi+D2lMw5gdpXbSoCufQ7+UTelkDBW1QvOiY+QZTGXXc7Isz0WAGbcDU+1
 mqtg==
X-Gm-Message-State: AOAM532BPKOrWB0S8d7yvWJYPEroABh/FRno7vrovtPzXvl/rbDkpSRE
 GqpVGMcJfPkaWcHH2rP4cbhbcTXyt6VJXvnNvTQ=
X-Google-Smtp-Source: ABdhPJw4PLTjbhjwDy6EiKaJ7HTrl8YRVLWi1NAyqs9jnrxv1KPWBcnGXX4x7q7HcmegO6cIZyeDvkpZWdqQjLRd+WU=
X-Received: by 2002:a37:e92:: with SMTP id 140mr24720492qko.121.1597049622701; 
 Mon, 10 Aug 2020 01:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
 <20200810080018.GA13408@Asurada-Nvidia>
In-Reply-To: <20200810080018.GA13408@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 10 Aug 2020 16:53:31 +0800
Message-ID: <CAA+D8AP6thymUXN_OTGMxz6Xun0c8Ep0s1-LKj6b0odoBQ0K=g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
To: Nicolin Chen <nicoleotsuka@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 10, 2020 at 4:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> > Regmap initialization may return -EPROBE_DEFER for clock
> > may not be ready, so check -EPROBE_DEFER error type before
> > start another Regmap initialization.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index a22562f2df47..eb933fe9b6d1 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -927,7 +927,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >                       "bus", base, &fsl_sai_regmap_config);
> >
> >       /* Compatible with old DTB cases */
> > -     if (IS_ERR(sai->regmap))
> > +     if (IS_ERR(sai->regmap) && PTR_ERR(sai->regmap) != -EPROBE_DEFER)
> >               sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> >                               "sai", base, &fsl_sai_regmap_config);
> >       if (IS_ERR(sai->regmap)) {
>
> In that case, might need a !EPROBE_DEFER check for this
> fallback devm_regmap_init_mmio_clk at "sai" clock too?

No, I think it is ok for this fallback to return directly with
EPROBE_DEFER.

best regards
wang shengjiu
