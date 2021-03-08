Return-Path: <SRS0=xkpp=IG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93237C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749CC651C3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749CC651C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvJlZ3r4Mz3clk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 00:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BdHyVo3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BdHyVo3y; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvJl53VKCz3cLZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Mar 2021 00:16:32 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 15so4498956qvp.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Mar 2021 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
 b=BdHyVo3yQuV3DV48f3bJjriWahibIKWTlkYMWIxyjaeMsJ0eLXR8/VVMc34NswrBkC
 nKHr9BKZyu88I8ghJ6Kz0bzo/xOsVeSY5AW9j3eSukKNb6S9EoyrHqodb/q4uU8cCXcN
 Po3Jw1pEtrFsNCNXsPE842EFlS8agYdjp/MUiN2RO/1OWj1wtXDqUBtThXJ0hMa3zYgz
 L6BdI+D+n6aycm+pFueaaDTXSSZycUyibySGKH0sExDhkPr/eT4gnVnPNS+PyzZFXRuo
 sK39l5TRhwHhFKTo/4rbSyBnSv80SmWhlhrQyai6FZws9G78Ok8rJi2z9Xe+Lv8QsLYJ
 ECDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
 b=JsmZ3oQB/UWvyj6066YeyWvwjPLrIr4ztGGGRWzrUMBcR+/fYfnlK45V+cErqz6u3z
 9PLIluG6oVukUAjZmPMkk8f5D0nSajW6N5xvBs5nMVs/1l9hPT06DJlpe4v4Mf821Uz5
 3EZjUy7AfmV9/0cJWsC1hl0JHI+wBfB4qjHDGgoAOjF24nUvk3HaM3+081EsrgdaOkev
 En7y8LdlmuffYKGADqByom32BCeKzM7bWKRTcff5LhR2qEzDDDEktDogofL8k5GWo4XX
 PSB1ATPTugaL04uEvqUgFLCOEh4a3iKNOu9jc2ig3gG7gFt0AAkTpH9uC0G4XQrKSdml
 c7tQ==
X-Gm-Message-State: AOAM5332l+SYAfypFasHX9c2rBsSPWxumvcV/btjAe9KLWYSvF7Faavr
 rS52lN7T280l+eMn8rTd17trz60Zsn37haEzqPc=
X-Google-Smtp-Source: ABdhPJygKdeW7eWlM9tZB3oGSyuFSBjt6ZqB3nTQwnEAkBjDRdfL3US7UMWjWXaXySP+UvXlKsBkA6VqexayPm1FufM=
X-Received: by 2002:a05:6214:76f:: with SMTP id
 f15mr20582682qvz.56.1615209387754; 
 Mon, 08 Mar 2021 05:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
 <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com>
 <20210306203617.GA1164939@robh.at.kernel.org>
In-Reply-To: <20210306203617.GA1164939@robh.at.kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 8 Mar 2021 21:16:16 +0800
Message-ID: <CAA+D8APUVqyRRPc4GDwJqQEcnEPLxQMcZ+VhkbbrOx7hQs1jSA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To: Rob Herring <robh@kernel.org>
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
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Mar 7, 2021 at 4:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 10:52:43AM +0800, Shengjiu Wang wrote:
> > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > core. The Cortex-M core will control the audio interface, DMA and audio
> > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > to communitcate with M core, it is a virtual sound card and don't touch
> > the hardware.
>
> This sounds like 1 h/w block (the interface to the cortex-M), your DT
> should be 1 node. If you need 2 drivers to satisfy the needs of the OS,
> then instantiate one device from the other device's driver.
>

Ok, I will change it in v4.

best regards
wang shengjiu
