Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C589C10F00
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:14:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9492184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okjVpbyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9492184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LKdT419xzDqSR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 20:14:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="okjVpbyl"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LKbh5K3LzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 20:12:32 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id r124so6029896pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TjtM6fVwWqEdIaS+4mof0Rz3Fnpu6pGIwmPSNX9Z0Hs=;
 b=okjVpbylXBvFVCgkvxV1qQmJLa4zjX+Ltn4hpXcPdxJgbI4G5M8CxOy7IUSJBTSaK1
 lxTdnqMoxPigmmFidAq79xK4vwU9t3E/R8inl0zU+u1AG/tT9Yr0/QzYVmYFIfglML2s
 dQxrMA99JHHiMsSodWcXcpVheixmZ0q1hXwJQUtCTcxuqMTGYnyJ0Mk0IrjBx9eupZdT
 HESaQGWDyHsvQPzIz3IxXh3xHFJpC+dtVICGacrmmGO3E97Nwsycj02hZpvWn5ApnqQY
 LwwbOQjSdBHZV1aRF81dZhRikWHqpOduNjsSVpgxAaD84jXKWXuyYmTF4Y6/9aVBgenP
 7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TjtM6fVwWqEdIaS+4mof0Rz3Fnpu6pGIwmPSNX9Z0Hs=;
 b=q+6bxkItDCOn8zBVjtx4vevRS+6Ge9TFWJaaGFspl035rSlvO1fUQ9VS2nHXkuAvCC
 EFi3BYYBk+0d+sFVoIkY5nvyTrDUb8Xe8Wp/aih/jx00vZGfwY3xtXVZV8DmpzyK2kB8
 uAMiyfda4jGtLV+FFZBA07WGBvrEaTwTfg1m+SATeHS52vOC/EcgsOc1B94kGM9dGpWe
 zVZip4oCGS4Ot9qKpmfcS3Dt7kjMXgOSMYEYAAuZ0T5QtTZGCDGEGMAShyhrT6jkT0ZN
 d0XARA938ukyoo5LFiRuRfSLs7yriXojn1Ro30kkPKnJcSOmPxdmuFb689vuYwcAVEri
 /KZw==
X-Gm-Message-State: APjAAAX7PnOkZSdVozW3MUR4vFskYpzfWHEFao4dbLef27fewYBQoekP
 0Iq7NlGzBGF6BK/peflhNYQqeMpvY3cQ5xsjwKw=
X-Google-Smtp-Source: APXvYqw4y5j6ogWahBv8cySNjqKMeUi5/6fyFYUM4L+/k48yar3AiX4XyVZiz3kwzFzdtM4+cPOsKYAEcr34phMbA2M=
X-Received: by 2002:a17:902:a9c8:: with SMTP id
 b8mr3156666plr.12.1552641149781; 
 Fri, 15 Mar 2019 02:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2019 11:12:17 +0200
Message-ID: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 12:40 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> here's v2 of my serial cleanups queue - part I:
>
> essentially using helpers to code more compact and switching to
> devm_*() functions for mmio management.
>
> Part II will be about moving the mmio range from mapbase and
> mapsize (which are used quite inconsistently) to a struct resource
> and using helpers for that. But this one isn't finished yet.
> (if somebody likes to have a look at it, I can send it, too)

Let's do that way you are preparing a branch somewhere and anounce
here as an RFC, since this was neither tested nor correct.
And selling point for many of them is not true: it doesn't make any
difference in the size in code, but increases a time to run
(devm_ioremap_resource() does more than plain devm_iomap() call).

-- 
With Best Regards,
Andy Shevchenko
