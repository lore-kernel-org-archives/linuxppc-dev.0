Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BEEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:22:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8042184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOei8pJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8042184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LKqQ6QJSzDqSK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 20:22:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOei8pJn"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LKnk2kwtzDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 20:21:13 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id v12so6060023pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vP7HZTMw3xRHh76+TCwb0U6+oiCWOhG2I8JYAfF4nA0=;
 b=SOei8pJnsaW43FbpvZduNG+4jWxkM7xcc7L+G98+cRCFjIs9+jRSv6NgYn12+/hcnO
 Nv5t6dQSp5S4qOnya8Nz+e6lxpCJDfklC+B7DBECUAFBwF1Zt9UDu6HEhrMEEM5ZgcDD
 fx0/o+dEGLX1N3SMoufM884L7yK8+sETv3q4SaLyA7GPLh18HLp+IawpViPHdWEyKbB3
 sMA67i4YV5on1gQlLeMPE5mNI5uWv2NjH4FzqFK/7Q4YwhqmtFJPMPcrKJ2Ecifri3cR
 Kh6ufQfpXmWTIHt6CLPFOcHpyhVU5u+0uazsZjxllUR7IitazXDo/3f2Wh7MZzFkmq7v
 xRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vP7HZTMw3xRHh76+TCwb0U6+oiCWOhG2I8JYAfF4nA0=;
 b=pnb1Dfm+setJkQUGqyAMdG/2xQ77WhYP90AX64k0p4wLWthyy5PlnaaVtloqi5zCfX
 KBgDFT1srWwWAe7ubBTV2+qXyMGMlA/CJtKPkhrwSRwFt5+crhAdcFt6xZ7FMoL+clMD
 qobJwCxgopO7R0/0/uoWS2wUUix9Gjl7tbohQyKcFtKKcKRmitfJcPoBW1bqJSUesWe3
 B2QG5PxMqmfBwlo2qDDOFIFT7l+oJzsY40Sf5wr1/8gUhCiBJkdrUQuozKzg1obh8SF1
 F6apnUW97V70T6izuDqdrOzZBcuWyhfDNuSJJbt5N9wv7/6HusJ8dNBvEg1bYyCVno9M
 2MoQ==
X-Gm-Message-State: APjAAAVv6UUq2YHuFmQCet6Vn3z07AiYBSrIBZjdJVUX1rgfHVrkwIxm
 ewmGhBll421QYcWR98t5pLgNIlqOKSOnEuQMmYY=
X-Google-Smtp-Source: APXvYqz22UdJCSLKoxzdhZyS+ZKRgJLsXLsNZvh1TNAN2h3MOiCuU1bniKwYs5STgwn2sTImZFs0w9oRUeE9wLHRHUc=
X-Received: by 2002:a63:d442:: with SMTP id i2mr2427933pgj.246.1552641670454; 
 Fri, 15 Mar 2019 02:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
In-Reply-To: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2019 11:20:58 +0200
Message-ID: <CAHp75Vf+f-b+px__ekdDZPFHtmMwoBVw-itoTtxfELesfSciXg@mail.gmail.com>
Subject: Re: serial driver cleanups v2
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
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
Cc: linux-arm-msm@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, macro@linux-mips.org,
 Peter Korsgaard <jacmet@sunsite.dk>, Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 David Brown <david.brown@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, slemieux.tyco@gmail.com,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 11:12 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 15, 2019 at 12:40 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
> > here's v2 of my serial cleanups queue - part I:
> >
> > essentially using helpers to code more compact and switching to
> > devm_*() functions for mmio management.
> >
> > Part II will be about moving the mmio range from mapbase and
> > mapsize (which are used quite inconsistently) to a struct resource
> > and using helpers for that. But this one isn't finished yet.
> > (if somebody likes to have a look at it, I can send it, too)
>
> Let's do that way you are preparing a branch somewhere and anounce
> here as an RFC, since this was neither tested nor correct.
> And selling point for many of them is not true: it doesn't make any
> difference in the size in code, but increases a time to run
> (devm_ioremap_resource() does more than plain devm_iomap() call).

And one more thing, perhaps you can run existing and / or contribute
to coccinelle since this all scriptable and maintainers can decide if
this or that coccinelle script is useful.

-- 
With Best Regards,
Andy Shevchenko
