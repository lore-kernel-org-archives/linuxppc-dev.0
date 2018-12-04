Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93801C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 15:06:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B83206B7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0PciwId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B83206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438QF12mwyzDqjZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 02:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e0PciwId";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="e0PciwId"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438QB71j3ZzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 02:04:15 +1100 (AEDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A40A20878
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543935852;
 bh=HdctKzxhIzA5Gileog4jo6YzMyxJEoW+jk67LM2xECg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=e0PciwIdhoDNuysl1kaSohuP+ZYFBRyRktiF8bYygxQpi9VKzU0Hg4GLR0921yhE0
 mg+184jpodzPhKcHcaCDQU9FqRuj6GF96QTEMzSD7C8izduABt4szZ1A6uQOaYXSoX
 oWs4vXDrr12lorJBXqmJZdzC3GUlWyLxVnq1/iX8=
Received: by mail-qt1-f180.google.com with SMTP id y20so18308644qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 07:04:12 -0800 (PST)
X-Gm-Message-State: AA+aEWa0K5boIdQqJWFa8gsO5HwKMOSnO9KFLDfqEcXMMfivyFnh3Hjr
 Zo+PHrK9zo57az0doRSCH2DY1B4EdjecBlSqUg==
X-Google-Smtp-Source: AFSGD/UxX00JUXYe4WhcTim/duD5eAOZOjhVmC85JiZHnQ/r6zyx7o/gmpM9vKLumEZGa4Jml4vbfXF/3p7lKwQWe4A=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr20764932qvl.77.1543935851783; 
 Tue, 04 Dec 2018 07:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-25-robh@kernel.org> <3170130.k0DT9deCHj@phil>
In-Reply-To: <3170130.k0DT9deCHj@phil>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 09:04:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Subject: Re: [PATCH v2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To: "heiko@sntech.de" <heiko@sntech.de>
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
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 8:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 3. Dezember 2018, 22:32:13 CET schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > new file mode 100644
> > index 000000000000..3d30ec9adcd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -0,0 +1,251 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/rockchip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip platforms device tree bindings
> > +
> > +maintainers:
> > +  - Beniamino Galvani <b.galvani@gmail.com>
>
> # scripts/get_maintainer.pl -f Documentation/devicetree/bindings/arm/rockchip.txt
>
> doesn't list Beniamino at all and he hasn't been active on Rockchip stuff
> for a number of years, so I'm not really sure where this mention as
> maintainer comes from.

git history. get_maintainers.pl had too many cases where I ended up as
the maintainer.

I'll drop him.

> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
> > +              - asus,rk3288-tinker-s
> > +              - radxa,rock2-square
> > +              - chipspark,popmetal-rk3288
> > +              - netxeon,r89
> > +              - firefly,firefly-rk3288
> > +              - firefly,firefly-rk3288-beta
> > +              - firefly,firefly-rk3288-reload
> > +              - mqmaker,miqi
> > +              - rockchip,rk3288-fennec
> > +          - const: rockchip,rk3288
>
> [...]
>
> > +      - items:
> > +          - enum:
> > +              - firefly,firefly-rk3399
> > +              - firefly,roc-rk3399-pc
> > +              - pine64,rockpro64
> > +              - rockchip,rk3399-evb
> > +              - rockchip,rk3399-sapphire
> > +              - rockchip,rk3399-sapphire-excavator
> > +              - tsd,rk3399-q7-haikou
> > +              - vamrs,ficus
> > +              - vamrs,rock960 # 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> > +          - const: rockchip,rk3399
>
>
> as said before, loosing the description of the boards that get thrown
> into one listing really decreases the usability a lot.

Sorry, I thought I addressed these previous comments.

> Best example is maybe the rk3399 rock960, where the consumer-edition
> board is actually named "ficus" and the description actually brings the
> connection to the product-name.
>
> So here it may increase the machine-readability but definitly descreases
> the human readability of the file itself.
>
> I guess just using the format that all the Google-boards got for all boards
> would just be easiest, so for example the rock960 also would just become:
>
>       - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
>         items:
>           - const: vamrs,ficus
>           - const: rockchip,rk3399
>
>       - description: 96boards RK3399 Ficus (ROCK960 Consumer Edition)
>         items:
>           - const: vamrs,rock960
>           - const: rockchip,rk3399

Sure, you can do this if you like. I prefer the other way as it is a
one line change to add a board. The SoC maintainers can pick whatever
they like. You could split into a file per SoC too if you wanted.

> Looking at other socs, this is likely similar there. Like on Mediatek
> all the MT67xx eval boards loose the mapping to the
> socs marketing name "Helio Foobar" when the description is gone,
> which could've been helpful for people reading the binding.

Generally when we had just 'hello,foobar' with 'Hello Foobar' I
dropped the comment as I didn't think it added much.

Rob
