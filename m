Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657CC677D4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:49:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA02D20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccOTgV7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA02D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TMCZ68JtzF3FK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccOTgV7T";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccOTgV7T"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TM8p2tL4zF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 00:46:34 +1100 (AEDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3589521471
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539006392;
 bh=jR8K6sL3dQKFGacRFfiHHdgXPEuNZEpxTMsH2Nu/8+I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ccOTgV7TYbiBJWCJGtXh7k/DwfG9InEyBToMMUv8wZTdVk6eClMoftFOtsYS6mZ28
 /BlMhbhJ/5Kns2zvMKzqKzR2r2JSBfdyy0Bnrx9byavOmbZKgyNweLZs23wVaKXNEq
 1JL1czqe19m6pivUAw/1FWSr7X5M8cYbiALG/aLM=
Received: by mail-qt1-f172.google.com with SMTP id q40-v6so20973470qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 06:46:32 -0700 (PDT)
X-Gm-Message-State: ABuFfoj5n66J3BKk0tUK/lo2ZGb+178R9HMev0qDV+qu7yUxAQcLlHkt
 HEKiwxD4mfGwB1dBHqtMp8Jmt4SfdJcUavlPaw==
X-Google-Smtp-Source: ACcGV62+VTBfdUctckeb/p7WMzKEpe08RdMWyNeUphT8alz+CO97UOPUR9vt5xO/NYVQUAPQMkPziVLS+YHbetHJmtI=
X-Received: by 2002:a0c:d4e5:: with SMTP id y34mr4743931qvh.106.1539006391296; 
 Mon, 08 Oct 2018 06:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-29-robh@kernel.org> <1857752.ZLvpeyYpZr@phil>
In-Reply-To: <1857752.ZLvpeyYpZr@phil>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 08:46:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+79kn8BtL_saZOMGRqJ0kJq14HCekhVPfbFSquBdRAqA@mail.gmail.com>
Message-ID: <CAL_Jsq+79kn8BtL_saZOMGRqJ0kJq14HCekhVPfbFSquBdRAqA@mail.gmail.com>
Subject: Re: [PATCH 28/36] dt-bindings: arm: Convert Rockchip board/soc
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 4:45 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Rob,
>
> either I'm misunderstanding that, or something did go a bit wrong during
> the conversion, as pointed out below:
>
> Am Freitag, 5. Oktober 2018, 18:58:40 CEST schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/rockchip.txt      | 220 ----------------
> >  .../devicetree/bindings/arm/rockchip.yaml     | 242 ++++++++++++++++++
> >  2 files changed, 242 insertions(+), 220 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
> >
>
>
>
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
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
> These are very much distinct boards, so shouldn't they also get
> individual entries including their existing description like the phytec
> or google boards below?

It is grouped by SoC compatible and # of compatible strings. So this
one is all the cases that have 2 compatible strings. It is simply
saying the 1st compatible string must be one of the enums and the 2nd
compatible string must be "rockchip,rk3288".

>
> Similarly why is it an enum for those, while the Google boards get a
> const for each compatible string?

Because each Google board is a fixed list of strings.

> Most non-google boards below also lost their description and where lumped
> together into combined entries. Was that intentional?

If the description was just repeating the compatible string with
spaces and capitalization, then yes it was intentional. If your
description matches what you have for 'model', then I'd prefer to see
model added as a property schema.

Rob
