Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7FC65C1B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 20:13:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B492086D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 20:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZYB6Pxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B492086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Svnn66GvzF38T
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JZYB6Pxq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="JZYB6Pxq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42SvlD0fXMzF36b
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 07:11:19 +1100 (AEDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BEEC2089D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Oct 2018 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538943077;
 bh=dgFy1AiGiANm/Ym2ioekXxDyRet8pPPlqlCfBFrivds=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JZYB6PxqO/BHu8QAK4Phgg2HcJBZEd0LLr4uQJ3jTRwAK4RNPER2sZpivdIx/4qaF
 LWZfZYhxN2F4PirKS8t8UZErFfm6mLZ8b3n0fE3WLAdn88/Wcgvu+KNCCWdo4ZWHp6
 tPgsjwOLm4+4Q4lBf1A6K87yon4QCGjQtRK8+Pco=
Received: by mail-qt1-f172.google.com with SMTP id l41-v6so6451171qtl.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Oct 2018 13:11:17 -0700 (PDT)
X-Gm-Message-State: ABuFfoi7pa8CATaK7QTYH6yNcV10bPh89+hwogCyYsGMWRxU31rgOg5p
 PYIlcDEonM/H1lWgJce75j4U5Ed1s73G0Cb+yg==
X-Google-Smtp-Source: ACcGV6387Kr7ZUbVftFd1KMdECkBbnlmYm3CVgx3BzpBYqQ0E/9UFWuiGRXbd4CCQl6rR8fxx+CXsllFRSSWld+/ACk=
X-Received: by 2002:ac8:148b:: with SMTP id
 l11-v6mr17291430qtj.27.1538943076484; 
 Sun, 07 Oct 2018 13:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-16-robh@kernel.org>
 <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
In-Reply-To: <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Sun, 7 Oct 2018 15:11:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiSz+a4s4=ZGokm5bNVw-hrZAnO=uHO3oLm=T-5U=z0A@mail.gmail.com>
Message-ID: <CAL_JsqKiSz+a4s4=ZGokm5bNVw-hrZAnO=uHO3oLm=T-5U=z0A@mail.gmail.com>
Subject: Re: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 6, 2018 at 5:40 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Hi Rob,
>
> Am 05.10.18 um 18:58 schrieb Rob Herring:
> > Convert Actions Semi SoC bindings to DT schema format using json-schema=
.
>
> This sounds like the next Yanny vs. Laurel... I fail to see any json. ;)

Read the docs in patch 8.

> Also, it may help my understanding to be CC'ed on the cover letter, too?

Sorry, trying to avoid a huge Cc list.

> > Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
> >  .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
> >  2 files changed, 34 insertions(+), 56 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Docume=
ntation/devicetree/bindings/arm/actions.txt
> > deleted file mode 100644
> > index d54f33c4e0da..000000000000
> > --- a/Documentation/devicetree/bindings/arm/actions.txt
> > +++ /dev/null
> > @@ -1,56 +0,0 @@
> > -Actions Semi platforms device tree bindings
> > --------------------------------------------
> > -
> > -
> > -S500 SoC
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Required root node properties:
> > -
> > - - compatible :  must contain "actions,s500"
> > -
> > -
> > -Modules:
> > -
> > -Root node property compatible must contain, depending on module:
> > -
> > - - LeMaker Guitar: "lemaker,guitar"
> > -
> > -
> > -Boards:
> > -
> > -Root node property compatible must contain, depending on board:
> > -
> > - - Allo.com Sparky: "allo,sparky"
> > - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> > - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemak=
er,guitar"
> > -
> > -
> > -S700 SoC
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Required root node properties:
> > -
> > -- compatible :  must contain "actions,s700"
> > -
> > -
> > -Boards:
> > -
> > -Root node property compatible must contain, depending on board:
> > -
> > - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> > -
> > -
> > -S900 SoC
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Required root node properties:
> > -
> > -- compatible :  must contain "actions,s900"
> > -
> > -
> > -Boards:
> > -
> > -Root node property compatible must contain, depending on board:
> > -
> > - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> > diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Docum=
entation/devicetree/bindings/arm/actions.yaml
> > new file mode 100644
> > index 000000000000..af9345a228b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> > @@ -0,0 +1,34 @@
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> 404 for the schema. Where does one find an explanation?

In the docs. This could someday actually be hosted on devicetree.org,
but for now only the path, not the host, matters.

>
> > +
> > +title: Actions Semi platforms device tree bindings
> > +
> > +maintainers:
> > +  - Andreas F=C3=A4rber <afaerber@suse.de>
>
> Mani is now officially reviewer and the closest I have to a
> co-maintainer.

Okay, NP.

> I suggest we add him here in some form. I assume this is
> independent of MAINTAINERS patterns though, or will get_maintainers.pl
> parse this, too?

It is independent. Not really ideal, but the bindings don't live just
in the kernel. (And lots are missing a maintainer anyways).

> > +
> > +description: |
>
> Does the | have any meaning, or a stray typo?

Explained in other patch.

> > +  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions =
Semi
> > +  S900 is a quad-core ARM Cortex-A53 SoC.
>
> You forgot the S700 as another quad-core Cortex-A53 SoC.
> Also, arm or Arm rather than ARM these days?

I was going to say it's just copied out from the old file, but that
doesn't seem to be the case here. I am sure I didn't spend time on
nice descriptions. :)

> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - lemaker,guitar-bb-rev-b
> > +          - enum:
> > +              - lemaker,guitar
> > +              - allo,sparky
> > +              - cubietech,cubieboard6
> > +          - const: actions,s500
> > +        minItems: 2
> > +        maxItems: 3
> > +        additionalItems: false
>
> Objection. You've managed to turn a perfectly human-comprehensible text
> into a machine-parseable representation incomprehensible for humans.
>
> First, there should remain some free-text explanation of the values
> defined here. Are comments allowed after the value or indented maybe?

Yes, both. Comments are the major reason for using YAML over JSON file form=
at.

> Alternatively we could have a per-vendor file =C3=A0 la vendor-prefixes.t=
xt,
> but that would seem inefficient.

You mean per board vendor files? We'd have to duplicate the SoC
compatibles then as you can't really split the schema to 2 files.

There's 2 SoC families doing per board vendor files: Atmel (only one
vendor though) and i.MX. This series makes those 2 a single file like
all other SoCs. I don't really care which way it is done, but I think
we should be consistent and I'm not going to convert everyone's
bindings to per board vendor files.

> Next, the above items construct is horrible. What about nested oneOf:
>
> +      - items:
> +          - oneOf:
> +              - items:
> +                  - enum:
> +                      - lemaker,guitar-bb-rev-b
> +                  - const: lemaker,guitar
> +              - items:
> +                  - enum:
> +                      - allo,sparky
> +                      - cubietech,cubieboard6
> +          - const: actions,s500

That's not actually doing what you think. That's saying the first item
is a list of items (1 or 2 items). For example, you'd have to have
data like this to be valid:

[ [ allo,sparky ], actions,s500 ]

(Note that [] are more json style list format, but allowed in yaml too.)

Probably the best thing to do here is separate the 2 and 3 item cases.
That also would eliminate some combinations here that are allowed, but
not valid.

>
> This grouping is much clearer to me and hopefully to anyone adding
> further base boards for the module.
> We will have the same issue for the BPi-S64 module with S700 below.
>
> > +      - items:
> > +          - const: cubietech,cubieboard7
> > +          - const: actions,s700
> > +      - items:
> > +          - const: ucrobotics,bubblegum-96
> > +          - const: actions,s900
>
> Please make the board compatible an enum, even if only one is listed
> today. That makes it clearer where/how (and easier) to add new boards.

Yes, I did that in most cases, but not here some reason.

Rob
