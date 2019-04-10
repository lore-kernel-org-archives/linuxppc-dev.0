Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F183C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:52:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBE22083E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4OuWGjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBE22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fFFk3pGDzDqMy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4OuWGjC"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fFB315NhzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:48:59 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id w3so965881edu.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=flRuh9bHQFZIbByfoeIgE1Z7A8kc8C3hbrbhRaH/cMw=;
 b=l4OuWGjCTqDiCw8tcK3t1wrHcXDHqloHA6+GQyHFpI0xoiBzaME/AeOg1FQ7sGRhuU
 FYzIYiOcQe2SOMFRcIDMkKgNkIShBUWVW/l8KqAtPXYe6gwhIpZAC0QuVH+TN1tDU+V2
 obfn9uy4bmqlBTO7AkvUsJxalkeP1VJFIbKwP8HATya+7miEz3AP31aHsfSn7Thz8quO
 SF7spTas3raK/nop20U90ZPg3plOZZDTqmnrpVOaKquzPFMQIrsf15ShAKmL1RrP5U//
 +Ct7+cj7MGAcLhBrkvkuKJMDZ+ONWJvluQK8rTPBYYZU1kMkTqhn9Bd34PkW2kOiRayO
 f93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=flRuh9bHQFZIbByfoeIgE1Z7A8kc8C3hbrbhRaH/cMw=;
 b=Hb+jXWHqzbeG9Qx3jKFWbP+A7pokp/WFYailG6zL9THYNjdwAmZiryAHjRuPdElHXZ
 GoIfg2tjWPbDrz6XnksX75TzveGopLeUdAKj16Ipd9iou/w6Y66gJ1CJxFFRp9Usa95Z
 hBT8SxsNIqx9Qol5fsnDdoiPTdfAaLwVWOamF3+cGhO1QEo4v3pQN+m/2NLMDVBTJXhl
 oiMhSMKpBjbNxYEhICsZYHd4uhifCwVX2rLCc+oNq20PIzJdHopjtFD2fQU5a/1xqWtQ
 SW3Jrw8XfBvTQSvmFFr0eRTTxfibeEOXfOm1GOOpiP9cZ3BkJWbg3I4c/kKYJ1VEm9Sm
 Nr7g==
X-Gm-Message-State: APjAAAUkhwUZUnU5Nn8KQhGO8u3y7rjlpFmPrrxPEHVJpW1qV5DuGIj4
 QGK1xayxZE8TWL4VM6AaTHuxTDKp6cUV9rK9O1E=
X-Google-Smtp-Source: APXvYqwoahLpsxixg3+GMsNRY6g7PezqJqQLfIljHOC0YMHHGbMfnJx2drSXaeTlK6nJR8F4ejk3aFel+Ja738C6eNs=
X-Received: by 2002:a50:bdc4:: with SMTP id z4mr25711024edh.199.1554878935147; 
 Tue, 09 Apr 2019 23:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
 <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
 <20190410063714.GA4156@Asurada>
In-Reply-To: <20190410063714.GA4156@Asurada>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 10 Apr 2019 09:48:43 +0300
Message-ID: <CAEnQRZAKC93vJnirvSxyJMpaoXdht83ikJz3LYFFbeBd4w__zA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Viorel Suman <viorel.suman@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Viorel Suman <viorel.suman@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 9:37 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Apr 10, 2019 at 09:20:29AM +0300, Daniel Baluta wrote:
> > Hi Nicolin,
> >
> > On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > > Use "of_device_id.data" to specify the machine driver
> > > > instead of "model" DTS attribute.
> > > >
> > > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > >
> > > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > >
> > > > ---
> > > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> > > >  1 file changed, 23 insertions(+), 20 deletions(-)
> > >
> > > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > > > +                                                0);
> > >
> > > Would you please send a separate patch to replace "pdev->dev"?
> >
> > I am not sure exactly how to explain this change in the commit message. It does
> > make code easier to read and avoids dereferencing pdev pointer each time.
> >
> > Is it enough for commit description?
>
> You mean this? https://lore.kernel.org/patchwork/patch/862610/

Yes! Thanks.
