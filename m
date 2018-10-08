Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D1C65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:00:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE6B20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCnhnp4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TNp40Q3SzF3C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:00:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bCnhnp4e";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bCnhnp4e"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TNkt6LP8zF35Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 01:57:42 +1100 (AEDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 835B52087C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539010660;
 bh=1BE0fw0J6LIRJq+p2GmA36rsVMGIZ+lKvwe/cLY4HQ4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bCnhnp4eEYFxEFqoMCY9JW1YwDB+SeXXDDy93WH/q+eQDWTjLvq/gvYJ6N6n07q88
 qLIOnplc7iJ159v2Rokq0QuUIGqWQyKPalB+hBV78PfFQjIzsJSOWWVO5hXRTttpUk
 tYhiwrZwB4Crt04GY7BpI1IclcAD3ZKwyZqR8o5c=
Received: by mail-qt1-f176.google.com with SMTP id q40-v6so21258843qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 07:57:40 -0700 (PDT)
X-Gm-Message-State: ABuFfoiojjPddmQRf7t/ehPaEa7wTVlWNhqyJl3TrfrPYO1MJiRvP5zI
 RsLRsD6lieLG8JxOesTiwezGIAuTqw9oB7KLiA==
X-Google-Smtp-Source: ACcGV63kRvahAnuLfjlkXq4x2Du56g/dNSuTSlLH2jYw0qKttpn+PMNma6684mZPs0FhUPbEiIJvByBxewfeerCkQ5Y=
X-Received: by 2002:a0c:bc03:: with SMTP id
 j3-v6mr19885313qvg.77.1539010659716; 
 Mon, 08 Oct 2018 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 09:57:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
Message-ID: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
 Simon Horman <horms@verge.net.au>, Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> Note that this will need a rebase, as more SoCs/boards have been added
> in -next.
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > @@ -0,0 +1,205 @@
> > +# SPDX-License-Identifier: None
>
> The old file didn't have an SPDX header, so it was GPL-2.0, implicitly?

Right. I meant to update this with something. I'd prefer it be dual
licensed as these aren't just kernel files, but I don't really want to
try to gather permissions from all the copyright holders. And who is
the copyright holder when it is implicit? Everyone listed by git
blame?

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/shmobile.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
>
> Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
> Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
>
> You had it right in the CC list, though...

I generated it here from git log rather get_maintainers.pl because
get_maintainers.pl just lists me for a bunch of them.

> > +      - description: RZ/G1M (R8A77430)
> > +        items:
> > +          - enum:
> > +              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> > +              - iwave,g20d
> > +          - const: iwave,g20m
> > +          - const: renesas,r8a7743
> > +
> > +      - items:
> > +          - enum:
> > +              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
> > +              - iwave,g20m
> > +          - const: renesas,r8a7743
> > +
> > +      - description: RZ/G1N (R8A77440)
> > +        items:
> > +          - enum:
> > +              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)
>
> This board belongs under the RZ/G1M section above
> (see also the 7743 in the part number).

Indeed. Not sure how I screwed that one up.

> > +          - const: renesas,r8a7744
>
> > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > +        items:
> > +          - const: shimafuji,kingfisher
> > +          - enum:
> > +              - renesas,h3ulcb
> > +              - renesas,m3ulcb
> > +          - enum:
> > +              - renesas,r8a7795
> > +              - renesas,r8a7796
>
> This looks a bit funny: all other entries have the "const" last, and
> use it for the
> SoC number. May be correct, though.
> To clarify, this is an extension board that can fit both the [HM]3ULCB
> boards (actually also the new M3NULCB, I think).

This being Kingfisher?

I wrote this based on dts files in the tree. There's 2 combinations that I see:

"shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
"shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"

The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
other combinations are possible. If not, then we could rewrite this as
2 entries with 3 const values each.

Rob
