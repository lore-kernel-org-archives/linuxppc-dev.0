Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B7C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 19:38:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F55D205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDgaLYpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F55D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mFr34fzTzF3PB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 06:38:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDgaLYpI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="aDgaLYpI"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mFhw11CQzF3Nw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 06:32:32 +1100 (AEDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC2F62082E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541100748;
 bh=/x7S6wOFLQr8W3UDRcyWSs0Pz9v1coUTlDM/AkRrcxA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aDgaLYpIBaFFLpQpRfHzTttNxmSf76DT07+GB1LRCOJ7QosM1oP+h0/VKEjHr8HsQ
 9pgLlxbnWI/yk14E0rGvb1mDQY2oLU6CMSmVuXA0i+DLgttmQK7a8Fc4JTIkSjGX8Y
 73wHVUfEknan10S9vXrb3ToiUGg67F2OglIOh3mw=
Received: by mail-qk1-f169.google.com with SMTP id v68-v6so13132059qka.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 12:32:27 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJcaFm1K6NXfyfA1dv6NP8CzMtwhwkEdq0B7NQX4Evrvbczf5y6
 /MVESIp3e5otPDlRKRltwWxQzhhkAl1YYlyz3Q==
X-Google-Smtp-Source: AJdET5fZTGJGL+FIAeOcyrSMk/63EwuYM5K3XvuDEugOn3TDRJWlPs+FR3PYDr/iUceerCdQiWwU851OBn49EgkjnZI=
X-Received: by 2002:aed:29a5:: with SMTP id o34mr1170272qtd.257.1541100747137; 
 Thu, 01 Nov 2018 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
In-Reply-To: <20181009115713.GE6248@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Nov 2018 14:32:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
Message-ID: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To: Will Deacon <will.deacon@arm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Rob,
>
> On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
> > Convert ARM PMU binding to DT schema format using json-schema.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
> >  .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
> >  2 files changed, 96 insertions(+), 70 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
>
> [...]
>
> > -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > -               interrupt (PPI) then 1 interrupt should be specified.
>
> [...]
>
> > +  interrupts:
> > +    oneOf:
> > +      - maxItems: 1
> > +      - minItems: 2
> > +        maxItems: 8
> > +        description: 1 interrupt per core.
> > +
> > +  interrupts-extended:
> > +    $ref: '#/properties/interrupts'
>
> This seems like a semantic different between the two representations, or am
> I missing something here? Specifically, both the introduction of
> interrupts-extended and also dropping any mention of using a single per-cpu
> interrupt (the single combined case is no longer support by Linux; not sure
> if you want to keep it in the binding).

In regards to no support for the single combined interrupt, it looks
like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
have only a single interrupt. Though the interrupt gets routed to MPIC
which then has a GIC PPI. So it isn't supported or happens to work
still since it is a PPI?

Rob
