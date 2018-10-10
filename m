Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 18:54:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A4A2085B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLpS7wTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A4A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VjtZ6B9dzF1Hr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 05:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dLpS7wTu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dLpS7wTu"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vjqw00VmzF10f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 05:51:39 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31F312087D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539197497;
 bh=uB0V0LXSDHhFNqF05cL6wKvYwhMrIvYPYHycqFqFjQI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dLpS7wTunaLo35H+I95aB/AYLeb1pJ8nlV0vaG+JTIx+Dtl4RmmBWjWlOdzoU81rD
 QMfAuo6QPqhQsGmnF/E54dt+XZJq4FjHH/l64TztLpmubWzQF/8AvGpv/o36tqc1ug
 Wf65NJ9hkeBH1JrEn3sRaflE3XTvNHi5CDc1FxWk=
Received: by mail-qt1-f171.google.com with SMTP id c56-v6so6905094qtd.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 11:51:37 -0700 (PDT)
X-Gm-Message-State: ABuFfojqlFmFThQ/6w/qDQxqXuhZQI6anAbWgmXcoRUnOv94m3Al+Ck0
 +KUagDogNpHcg5eyXPPx+sjVlWSBWa5S15n+Ng==
X-Google-Smtp-Source: ACcGV62k9wWDJmYQoromF3HGCJZSRt0KwS84w8BTg9hReJ8u081BXFoBlX0+Uy+drHwkOAh61dHSh/HFb8WUmvv/B1Y=
X-Received: by 2002:ac8:440d:: with SMTP id
 j13-v6mr29073546qtn.257.1539197496400; 
 Wed, 10 Oct 2018 11:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
 <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
 <20181010165048.GB16512@arm.com>
In-Reply-To: <20181010165048.GB16512@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Oct 2018 13:51:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NExxsksmhA6z5_eTutVkm_NFthayvHz-vvq1gkSeXNA@mail.gmail.com>
Message-ID: <CAL_Jsq+NExxsksmhA6z5_eTutVkm_NFthayvHz-vvq1gkSeXNA@mail.gmail.com>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To: Will Deacon <will.deacon@arm.com>
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

On Wed, Oct 10, 2018 at 11:50 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Oct 09, 2018 at 01:14:02PM -0500, Rob Herring wrote:
> > On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
> > > > Convert ARM PMU binding to DT schema format using json-schema.
> > > >
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
> > > >  .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
> > > >  2 files changed, 96 insertions(+), 70 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
> > >
> > > [...]
> > >
> > > > -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > > > -               interrupt (PPI) then 1 interrupt should be specified.
> > >
> > > [...]
> > >
> > > > +  interrupts:
> > > > +    oneOf:
> > > > +      - maxItems: 1
> > > > +      - minItems: 2
> > > > +        maxItems: 8
> > > > +        description: 1 interrupt per core.
> > > > +
> > > > +  interrupts-extended:
> > > > +    $ref: '#/properties/interrupts'
> > >
> > > This seems like a semantic different between the two representations, or am
> > > I missing something here? Specifically, both the introduction of
> > > interrupts-extended and also dropping any mention of using a single per-cpu
> > > interrupt (the single combined case is no longer support by Linux; not sure
> > > if you want to keep it in the binding).
> >
> > 'interrupts-extended' was implied before as it is always supported and
> > outside the scope of the binding. But now it is needed to validate
> > bindings. There must be some use of it and that's why I added it.
> > However, thinking some more about this, I think it may be better to
> > have the tools add this in automatically whenever we have an
> > interrupts property.
>
> To be honest, if you'd included that in the commit message I'd have been
> happy :)
>
> > I guess the single interrupt case is less obvious now with no
> > description (it's the first list item of 'oneOf'). The schema If the
> > single interrupt is not supported, then we can drop it here.
>
> Well the description says "1 interrupt per core" which is incorrect.

You are reading the schema wrong. There are 2 cases supported as
defined by each '-'. The 2nd case is all the keywords until the
indentation decreases. So 'description' is just description of the 2nd
case. The first case is just "maxItems: 1". I probably didn't put a
description because why write in free form text what the schema says
(other than of course no one knows json-schema...).

YAML combines the best of Makefiles and python. You can't have tabs
and Indentation is significant. :)

> I also
> don't understand why maxItems is 8.

Humm, I probably just made that up based on GICv2 limitations. What
should it be? If there's not any inherit maximum, can we put something
reasonable? There's not really any way to express that it should match
the number of cores in the system.

Rob
