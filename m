Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B61C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 11:21:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FAD61248
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 11:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FAD61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5xMD1jVTz3c60
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 21:21:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PR0QsGfN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::132;
 helo=mail-lf1-x132.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PR0QsGfN; dkim-atps=neutral
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5xLh4fr8z3bx3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 21:20:59 +1000 (AEST)
Received: by mail-lf1-x132.google.com with SMTP id p7so16008840lfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hnZIrqamucMgtoQRhalXW35f06vviRSLKNiJcGvVIRY=;
 b=PR0QsGfN3ZzRnmtP2GvpRBUfh1fS2bB3MVYoqYFIfQ5y3OtmE1H4Bi5MkHfwqNstN+
 sIdovZvPvvNyNOOE84n6c+/whP9ME8CgCVKNDFDjbmCLV/SJ/Osrr5Dk9vUiGGGnRgDT
 Ulj6kyWju4RyjfaUCvhazK66qs0HhwQiFm/0qOB73JXbK8ooV/OSn1wJ3huEN347SYDR
 g7efyEFPYMBD3p1dbqv+kUsjK5w+L+Ckz33klkhIfqGxyD2HDtU2rRw3BvWSw+bnjNdW
 UQMvQqLSCSV/OqCc61vs4BlSEazhXwNbCMfH6PNCYuVL6dI6ovqzpBzkfjzQve886+lL
 VksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hnZIrqamucMgtoQRhalXW35f06vviRSLKNiJcGvVIRY=;
 b=rscCQDaBKspak6yXxnJ69IGMiQiYJ8d96LSA5vaZADymDNY3c7CX5w2MUgPB8w3R7Y
 fYlG60dro9rZ37+G+saVJC1f9lyG9mIZcQmfyQJ45Wi2ry/vZQrNk5I3uvHzD/l7VzM3
 udSdwW+Y3TKoNnro+4IV9Q4RAgbBh9/027CueGbqLcAZ3pX8wQ9px09W9bc9+DQkF3rH
 sqyhl7voFOX8W39BZgpVzrnSpvtilFeypVRvnFXWUeyC9DvkzuR0DuUy0FrxDjmhkpsy
 vxeBY/UhrQ9At1nFr7FbAK2QwjjXKkqxLp5f6h7x0j/KGIFyx1tOqdUdZu2v66aAJw45
 WdWg==
X-Gm-Message-State: AOAM533MjQpzIbEgTKf3Zdwdk50lMwDs8hPI+w+5s5hCunfjXddLy/k8
 shMl0DBYgwhGh7b66YOXlc0UF/MI/QCAnGbOCgA=
X-Google-Smtp-Source: ABdhPJyIeUNC0wnC3kJcXj8pUsII7RDjnztdAY6DS/4xUuhjoSVZ1NjwJYq3BaF++8TyxD1naFh8F7l7is0XL2Dbiq8=
X-Received: by 2002:a05:6512:15a4:: with SMTP id
 bp36mr2830068lfb.539.1624015249338; 
 Fri, 18 Jun 2021 04:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Jun 2021 08:20:38 -0300
Message-ID: <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
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
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Fri, Jun 18, 2021 at 7:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
>
> Disable all interrupts in runtime suspend callback to avoid above
> issue.

Fixe tag?

> +       ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> +                                FSL_XCVR_IRQ_EARC_ALL, 0);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> +

The operations in _suspend() are usually balanced with the ones in _resume().

Shouldn't you enable the interrupts in resume() then?

I see that the interrupts are currently enabled inside fsl_xcvr_prepare().
