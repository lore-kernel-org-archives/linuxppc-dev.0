Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8232EC2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 07:09:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF052206DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 07:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwdFiFV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF052206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48HW3T3PjBzDqC8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 18:09:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jwdFiFV/; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48HW0s6rTFzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 18:07:07 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id f3so768481qtc.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0AxOxOz3N9F0K8mLSxL0hnOp0DZT57bazsTbRp6sLU0=;
 b=jwdFiFV/SfJKDeMxz405XK6dPGTtFwNKTaHgkG0RaH9AAZhyLyb3UYl8lLUBbog+un
 Bxr9qpp0GK52dG6zRcljoyLZac2+nISQ7dsMOoR11skKDkTia4fZdTVXnT2ojDov7f3a
 qDHqO5YuQsucYHMro4CDzLMC624oWN53GIS3OnjhbJqV8sSdmKXvxrTsIVI+tX6Sc2t3
 AgqJxatpZIQVkjXV5PGTTL6g3jUSHqt4xa2Dvu+9sPdyDu8Ay82093uv13ND0BFsBiyO
 VaEv96dr4ZagKvEQxY9Y6mHLYXAm5qMMKrElRAOWBfEp/l7IFg5VDrP+vHA1e5CGcOsC
 TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0AxOxOz3N9F0K8mLSxL0hnOp0DZT57bazsTbRp6sLU0=;
 b=GxuOWTAJaEjbvz7pV9X9odCE5bCfBNSXyZop2JaAiGwy6Z+jDFggXj7E9+QfqmMC1s
 BFmhedjpNOaoZYYUzL/4i4tRGV1e8PwVbdVUiVEMmADPoVNBJFeTQrvzthLPZC7cXcjG
 TYxKzeM/ig+His8zU4+O/qtV8Xsf5rqOroZ6WXHCfXqaZtCxCix3JmLTZZ14aOW3CG34
 GjwkbAZSoyzbLh+RQYT4Q4oqB1dWX8g7YQND9sCZtv3VtAqlFp7IqDRXzq40c9aJS11p
 o4nE9Ltirrcpl0J58Q0m8d68FIKKq5cplaY86+FvlThp8IfzOIQDFIm13VqJ+EVllAwj
 xLyA==
X-Gm-Message-State: APjAAAWGPmQnt8SIHswn8aTcEXYqosJpjFnhdnp6gjuX9xrYw/CJX+Um
 DkL4R4l7XBFynUC3WluJb0/6J8Yj6iMJ/uanbvI=
X-Google-Smtp-Source: APXvYqzFAhN/zmGH/qPNyu/UPaVQNVYCHk9/jtr+7frBaquyjhJMAItJOS022rDz7+Fs6rLuRzdouhsz6E39O1t+j3E=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr18086333qte.204.1581491224261; 
 Tue, 11 Feb 2020 23:07:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
 <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
In-Reply-To: <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 12 Feb 2020 15:06:52 +0800
Message-ID: <CAA+D8ANsA4kaT_48F=3Jey-NjJd5HO+XD38TnQD3XBu9bg2WFQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] Add new module driver for new ASRC
To: Randy Dunlap <rdunlap@infradead.org>
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 12, 2020 at 1:13 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/11/20 8:30 PM, Shengjiu Wang wrote:
> > Add new module driver for new ASRC in i.MX815/865
> >
> > Shengjiu Wang (3):
> >   ASoC: fsl_asrc: Move common definition to fsl_asrc_common
> >   ASoC: dt-bindings: fsl_easrc: Add document for EASRC
> >   ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers
> >
> >  .../devicetree/bindings/sound/fsl,easrc.txt   |   57 +
> >  sound/soc/fsl/fsl_asrc.h                      |   11 +-
> >  sound/soc/fsl/fsl_asrc_common.h               |   22 +
> >  sound/soc/fsl/fsl_easrc.c                     | 2265 +++++++++++++++++
> >  sound/soc/fsl/fsl_easrc.h                     |  668 +++++
> >  sound/soc/fsl/fsl_easrc_dma.c                 |  440 ++++
> >  6 files changed, 3453 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
> >  create mode 100644 sound/soc/fsl/fsl_asrc_common.h
> >  create mode 100644 sound/soc/fsl/fsl_easrc.c
> >  create mode 100644 sound/soc/fsl/fsl_easrc.h
> >  create mode 100644 sound/soc/fsl/fsl_easrc_dma.c
> >
>
> Hi,
>
> Is this patch series missing Kconfig, Makefile, and possibly
> MAINTAINERS patches?
>
yes, Kconfig, Makefile is missed, will add in next version, and
no maintainers patch.

best regards
wang shengjiu
