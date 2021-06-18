Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC891C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 11:31:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DA561260
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 11:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA561260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5xZT2X0pz3c2K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 21:31:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ChROJdee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ChROJdee; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5xYv19nRz303n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 21:30:42 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id im10so3356420qvb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
 b=ChROJdeeybN0A0GyVkUZ00DaA0/sv6VhnbBXNK5g+iSZ80gDcQcWfnGzAg4JZ0MVq6
 liR6c2q0zDZH/VmK0Jf73O2BFdCmlWAem8bKGNKceXlXhxkBsdiVv4gXoGG3Dr6nYIb6
 Cp/xouNPB//YGH+e+nqXTO1NY7BF9X6W1uQKwP/GabccnUbgUAX1LtkAySQudBsfap1B
 Hb1wV/CrH+QDRAZe4LUvZdbDQfn++afNzGEkhE7PZxNYIXOWmn6geLdRiQx1HPQWl1G1
 8ltVdJKhKXCHLEx2zElEI/Awa1OT68GUYJYpBOZ0LRGZ0OTwzg5c2Bi7iN6s8VDyP4+C
 ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ci4ihwZuSGYUz/uI1CC0IKXaTwpsvEkfIF44obOzcVo=;
 b=C23q5Ah3K3X8ATeja6eHhSLfq2Vhv2wKe1QP7tatJ1/qTyidhfqKOB8pj3+kJSaGzd
 n3jsWwo/JQIyY+HYcrPl6oz6JVzWiVYUe2pln21EWZT4V44OgBZeHfJzAQn+f8phmwjy
 gylsf0ODC1C3leVG/J+dkSO+ir+gHYmsqINd8oGAFjfe13jyRUCWkZJby3/cT1WkwgI5
 ONAGgYRueXRRh+1vv+wfQH38N2sB3Ed9FA11ac2CbY3GdcChKGAhhGaAZ4DQNyMWC7rS
 8KwDJhqLd1uWDB1B3DB9kQzCDs3djmDpAfJpYrihs8trShGXeRlDDkrlXGCgT6unFsx+
 sT7Q==
X-Gm-Message-State: AOAM531VFtOViFk1f6EtHHOeVudPpRVn0UT2W0XmYl7F/WDPJeforMo/
 m8YZZHRRFcotE4GhrKTIY+Ok114VQWhX8FNKxzg=
X-Google-Smtp-Source: ABdhPJw+VBKBbMWiTjprq1OpB940uynK7mBEANOGQm1YOzX7yGaE4oP+e5A8DcDG6tW5eqdyQLtI1iFpklMBWiD25Bs=
X-Received: by 2002:ad4:576c:: with SMTP id r12mr5209117qvx.28.1624015836116; 
 Fri, 18 Jun 2021 04:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 18 Jun 2021 19:30:25 +0800
Message-ID: <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
To: Fabio Estevam <festevam@gmail.com>
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
 Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Fabio

On Fri, Jun 18, 2021 at 7:21 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Fri, Jun 18, 2021 at 7:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > There is an unhandled interrupt after suspend, which cause endless
> > interrupt when system resume, so system may hang.
> >
> > Disable all interrupts in runtime suspend callback to avoid above
> > issue.
>
> Fixe tag?

ok, I will add it.

>
> > +       ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> > +                                FSL_XCVR_IRQ_EARC_ALL, 0);
> > +       if (ret < 0)
> > +               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> > +
>
> The operations in _suspend() are usually balanced with the ones in _resume().
>
> Shouldn't you enable the interrupts in resume() then?

No,  as you said below, the interrupts are enabled in fsl_xcvr_prepare().
so this change should not block anything.

>
> I see that the interrupts are currently enabled inside fsl_xcvr_prepare().
