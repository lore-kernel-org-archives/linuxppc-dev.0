Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C3C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C733220830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="smRGyYhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C733220830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cfhy66NSzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 23:38:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="smRGyYhe"; 
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CffW6B8qzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 23:36:49 +1100 (AEDT)
Received: by mail-yw1-xc41.google.com with SMTP id 189so3928989ywi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2019 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ob8hWZ0HmNwlTXJo/mYlu29SYMoP0D3tHnTBPnurEpc=;
 b=smRGyYheoWgrKBxK4FySqe7WvjpakYuVvISB7ltoRJLyCeitME4JA6Qumxa88B+pn3
 3nMM8Q3/KPrMQYpvcRbdPs2YqnadxOaHZYg2T/22WWiYGqVVsTN3pU76f0jDMIryPuHB
 I0gK0YdNvRO5lIhsF/5go4P5ER6AYkEFyz4b4ULzr8JnJ9TAkmjy/J8lzVBsWlvvXjKh
 HKGUt8hpBqB6Rldtz37WT9w2332qf7UlJjhqOQECmuRdq3b/F9cJ9nJ53MpMtnABxLTq
 INCm+C+cD6ogS8xeEsPy11CGnWCU0qXNSzCuMQTsGu2SFwRPlmKOu/KKzgnjt0id3KNF
 i/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ob8hWZ0HmNwlTXJo/mYlu29SYMoP0D3tHnTBPnurEpc=;
 b=CZ/hjZoFc+JY6gI3vaZMUp8OWh/fHABfqVjsRv9bv1bfelLFIomgVZlOm6yL1zR3+E
 0Z9T5AmI/7iy8MecQinYOlsJj+xVBxBOKeoWddpXDGLDgLfxd8iLIGgMgvy16vllVxwf
 cT5PQxJB04SuqtqVZ/Psf88FQ/Ok+o4DYunsVGXkmY+UZ8LatketrXSEDTGHl2Efh1qE
 6H3VsqNf0843OQnDpRL9lATOXH9Dv1ehU4z0n+HOcXXAoJrrv/luAwM79jQHnXpeedme
 hZWBsconYVSCW7A7bPBBRmSJlIxxBBSeVTVdhKjqMM8EkUJbKcMJ7BqAleT4Z4OoPN4R
 e5Lw==
X-Gm-Message-State: APjAAAUmUznmlh6C24dz2+oYhcVk+/MAD4u7vDl5LDLw+6OC2FnrJBh8
 bTlaMF+u4AD6fUybuO0VN6g1E/LeGUwXCN2V4Hry5w==
X-Google-Smtp-Source: APXvYqxVfOPCjAyP0ik8yPHGWa5ghB1GFgpMDODBfMk1sD3Il17SauW+sZt6b1W6aoYo9GOT9T45U+89TthTCstmbq8=
X-Received: by 2002:a5b:b4d:: with SMTP id b13mr15071149ybr.318.1551703006622; 
 Mon, 04 Mar 2019 04:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
In-Reply-To: <20190220164154.00547a77@archlinux>
From: Patrick Havelange <patrick.havelange@essensium.com>
Date: Mon, 4 Mar 2019 13:36:34 +0100
Message-ID: <CAKKE0ZFs_N+StJ4MQ0peaTy=ADufSVW_tp5zSHsyua2myvMiHQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
To: Jonathan Cameron <jic23@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 5:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
[skipped]
> > +
> > +struct ftm_quaddec {
> > +     struct platform_device *pdev;
> > +     void __iomem *ftm_base;
> > +     bool big_endian;
>
> I'm curious. What is the benefit of running in big endian mode?

It is based on the same behaviour as in drivers/clocksource/timer-fsl-ftm.c
The FlexTimer itself on the board I'm testing it with is working in
big endian mode, so this mode is required.

> > +static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
> > +                             uintptr_t private,
> > +                             struct iio_chan_spec const *chan,
> > +                             const char *buf, size_t len)
> > +{
> > +     struct ftm_quaddec *ftm = iio_priv(indio_dev);
> > +
> > +     /* Only "counter reset" is supported for now */
> > +     if (!sysfs_streq(buf, "0")) {
> > +             dev_warn(&ftm->pdev->dev, "Reset only accepts '0'\n");
> > +             return -EINVAL;
>
> Why not just make the channel attribute itself writeable given we are
> setting it to 0?

Good idea, I'll see if this can be applied in the new subsystem.

[skipped]

All other comments are Acked.
