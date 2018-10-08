Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142FC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:40:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3037A20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKUVvJUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3037A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TM1t21W9zF3Ff
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mKUVvJUB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="mKUVvJUB"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TLpj0qyBzF3Dl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 00:30:52 +1100 (AEDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AAD62087C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539005450;
 bh=Ga+54931F5Dp4fhweeArGpOswihb1FQDHPktxIyMDQQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mKUVvJUBBFZR49VETkxPZZxXQdhScq8rGh0FpGtCuKA0qTE6nvkvXJnGphNjFZMsm
 eh7qJzkO/6TNKWR3GjUdyOP9a07h2FsobxEH/MY2KeYgFrui3cOXJQjEzSBc7ZnAl4
 9KAntnk6sRpyNaZQpZoxdWO+ZwFWDe++hVUW4L3A=
Received: by mail-qk1-f171.google.com with SMTP id 204-v6so12019863qkd.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 06:30:50 -0700 (PDT)
X-Gm-Message-State: ABuFfogYqbw+HU16dLLEIFU1al6psgsZP11oH0c8kM6dLPyMLXMm9bhz
 BP/5v3d9Ethsb4iWSybxbQkV99ZIksL649yXmQ==
X-Google-Smtp-Source: ACcGV60+gkqFHl0OW0BTcEJKlX6KgPXre9Ljbe7MrYkNZBn9Qwdt2cOD0NuVi5gPt2omgV+8IjCm4zQ81/Vg0VIQYAY=
X-Received: by 2002:a37:12d1:: with SMTP id
 78-v6mr18763505qks.147.1539005449747; 
 Mon, 08 Oct 2018 06:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-23-robh@kernel.org>
 <20181008070142.GM3587@dragon>
In-Reply-To: <20181008070142.GM3587@dragon>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 08:30:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJu0AGH7VizWJJVB2UnFhWKwMVTm-EznOfhDVabgQUA_g@mail.gmail.com>
Message-ID: <CAL_JsqJu0AGH7VizWJJVB2UnFhWKwMVTm-EznOfhDVabgQUA_g@mail.gmail.com>
Subject: Re: [PATCH 22/36] dt-bindings: arm: Convert FSL board/soc bindings to
 json-schema
To: Shawn Guo <shawnguo@kernel.org>
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 2:02 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Oct 05, 2018 at 11:58:34AM -0500, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.

> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: i.MX23 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx23-evk
> > +              - olimex,imx23-olinuxino
> > +          - const: fsl,imx23
> > +
> > +      - description: i.MX25 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx25-pdk
> > +          - const: fsl,imx25
> > +
> > +      - description: i.MX27 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx27-pdk
> > +          - const: fsl,imx27
> > +
> > +      - description: i.MX28 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx28-evk
> > +              - i2se,duckbill
> > +              - i2se,duckbill-2
> > +              - technologic,imx28-ts4600
> > +          - const: fsl,imx28
> > +      - items:
>
> The schema is new to me.  This line looks unusual to me, so you may want
> to double check.

It's fine. There's just no description schema on this one as it's a
continuation of the previous one (logically, but not from a schema
perspective). Perhaps add "i.MX28 I2SE Duckbill 2 based boards".

> > +          - enum:
> > +              - i2se,duckbill-2-485
> > +              - i2se,duckbill-2-enocean
> > +              - i2se,duckbill-2-spi
> > +          - const: i2se,duckbill-2
> > +          - const: fsl,imx28
> > +
> > +      - description: i.MX51 Babbage Board
