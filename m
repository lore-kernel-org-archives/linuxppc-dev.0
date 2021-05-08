Return-Path: <SRS0=PWqZ=KD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DEAC433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 11:11:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8031D6105A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 11:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8031D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fcl4z3tSyz2ymJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 21:11:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Ni+FkHxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::835;
 helo=mail-qt1-x835.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ni+FkHxQ; dkim-atps=neutral
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fcl4R46qHz2yXN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 May 2021 21:11:18 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id y12so8519051qtx.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 May 2021 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yfDuILVJ/qrRaqU8xHoH2Xwtecz2dupT4Jbb53C42Yk=;
 b=Ni+FkHxQ5UDdVFDKXHv70m55YzCQW5Wexb2/Mt8KAgEzMEg81c/6zElDN0EHYdFNc7
 GTj3fwc2wpxevfQNbFUym2Ac+Hy+JnDvYMWjKV6jNjo8+vhod+bP+V6q7ZnGiJKidlOg
 psAH9gYK/UzDdRy/5j/blUNcU7DRpA2nhzofTJxZKMH4s6NLI8Etr0weALwYJX2ryVyC
 2Lmu7ebHjumSK7e3I2/aJfc7O+yFVc1HpUJaFK6ZbQy8IjSfJKgHALIbA7KugiLMxTFT
 nxe0yA7tnGbrkY4bYtcnaK5YEcG2MNjmUdq0n6Cup85+o+B3pPmzUGTGEv6oRabZec8z
 rZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yfDuILVJ/qrRaqU8xHoH2Xwtecz2dupT4Jbb53C42Yk=;
 b=oWrTI80MORW7586bSruPlRKDdStI82i0NoTeohwjaDr2gaAqVeHE02qYpZMzE82N5K
 wSQi/fZbFP7Mw1acA6mvNZlRTgLYehpSCiUGzigpbee8ON6K6fAfNCOWHT6a9npVFSPS
 vV6zpXSbEBdrTN3EWZRbN+zpmkVIPdnGb8Xw/dQEp5kkXPQIrPFdXHr86BjzoalJi0fP
 n1b6QLFAn0voJ7kCWPOJs+aUk4UhRewIdie6kRaYbCME0+2f3f95ZTRG9zvypboHRJNM
 PLufl5CAKYg1DiLy5tmo7kUuDYeagoVrNWQi4T3K0YxQL6CFulLZzilqY70B2GhY3Bj/
 QkGw==
X-Gm-Message-State: AOAM5322Gvsoal69Md1QpULEbji3GZgVeNuLjj3WnNwPsYxUVlA2nsiU
 N55xYaXF2uNIJINX09BOXR6z4PSGo/9IGheFHHU=
X-Google-Smtp-Source: ABdhPJxoEslillAXm4KdMahYQZppkAGITUmkSjIpfL9o/fSNmiaqygZFF7zP3VcYAKQyGtzP0pX6x86BuieDRgbJ2x4=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr13176229qtr.292.1620472275009; 
 Sat, 08 May 2021 04:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
 <20210504065736.bcnatgmy2gczynsr@pengutronix.de>
In-Reply-To: <20210504065736.bcnatgmy2gczynsr@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sat, 8 May 2021 19:11:04 +0800
Message-ID: <CAA+D8AMzfj1QY-uXd6Ew7wCXomyDSdokHa-ReP6ucZjVnvYHGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: imx-akcodec: Add imx-akcodec machine driver
To: Marco Felsch <m.felsch@pengutronix.de>
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
 Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

On Tue, May 4, 2021 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 21-04-23 13:51, Shengjiu Wang wrote:
> > Add machine driver for i.MX boards that have
> > AK4458/AK5558/AK4497/AK5552 DAC/ADC attached to
> > SAI interface.
>
> Why? Does simple-audio-card don't fit?

No.  We need to support asrc->sai->codec case,
but simple-audio-card don't support it. simple-audio-card
needs the cpu dai is dummy on BE. And we need to
support the DSD format, this driver help to switch
the dai fmt from pdm to i2s according to the DSD or non-DSD.

best regards
wang shengjiu
