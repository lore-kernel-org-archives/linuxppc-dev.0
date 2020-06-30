Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E880C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 14:30:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7B920672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok0vl9Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7B920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49x6GZ0PGtzDqpq
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 00:30:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ok0vl9Ax; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49x5rV0LZkzDqpJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 00:11:34 +1000 (AEST)
Received: by mail-lj1-x241.google.com with SMTP id h22so15592864lji.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
 b=ok0vl9AxjEtaqLYePLsNsU1F7UuQ/mCyacTbBucXkiBM5MoPdlgeD8vCjscO6H/YoO
 g1Y3tdvyyEKK9q2yfyRX9/W8woqV+6qqe1GPTYjJkO9URBKyG+2vC45bHjhFP+Sighy2
 dcI8F8s5Vfo8GRj3oMeByIZH7a/604pe6LCm/s6p1IQsq5+qrX/E6xr9jj/E9WES9Zng
 GiWCiezZOrh0uh1CoZcuMKEdEiqSdgeXf23b5DujkEjlrgSSWrX93szxwsGoC+pad/wM
 3rIglYZoPvhcbPpRVHCSSeoloCgm6pd895s39sP/y8I08clro7W8b/Nj6lHf1jboCDy2
 6uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
 b=KNAW18By0S+5914zqlES5/stsYPaTnkGdomZSy5RXKoikGXIBX/BMd1xPK0xyZSNKq
 JGgBkAI69RxJ5RDwJ5lEyLaYZPrgH58dZ5eVGvHifDccDG45OYEd/SCDeMQa0vfkyUdp
 qdc64nFFtbJ4zY4cpROPZzwBpTbmZ9+2ULawe5Fh4eqX1h79cqBdrqkRI6mROMhtWZRN
 McMSdfQ3uAhd96CZij45IH1CoDhyeAhp2Y3F0IT+qZiOd6cOztrrlH5dCOgIHhMTJZHy
 T4Mqr2u8rNFE8SqQuseQHOtruDH1sBr9BHsfzf2YsHweN5+q6MFXLoOjlgat32baxjmu
 SSLA==
X-Gm-Message-State: AOAM531FBNeLoIZV693qY+XEfDRHlYHcTyXhpB3iLLAA5P1w+ncZ//1B
 HSUOQE/IFS7Z0R0KdzQ6wNyBO31iTpZhxXU703c=
X-Google-Smtp-Source: ABdhPJz5MIpXGlHgP1fvLS1Lh6z16GezmdUmGLLPMdcG9JOfzkS5KaVN414xdFAZLh68lRYnPXjkaFaK/PAFHUS7YMU=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr978719ljh.218.1593526288891; 
 Tue, 30 Jun 2020 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jun 2020 11:11:17 -0300
Message-ID: <CAOMZO5CZ2NhbFJJj8OAeJonA--ZfbfUWqhWCYRqeJE_v8QdKFQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal ratio
 mode
To: Shengjiu Wang <shengjiu.wang@nxp.com>
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
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 30, 2020 at 11:07 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
>
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
>
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
>
> With change, the ideal ratio mode is not the only option for user.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
