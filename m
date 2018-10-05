Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDAC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB3B208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiZ+idpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB3B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rf230fhpzF3gn
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OiZ+idpX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OiZ+idpX"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RdfZ24kLzF3cl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 04:32:53 +1000 (AEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6AC8421473
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538764371;
 bh=L7aZR9bc4bx416Kcx3JUEW4vGf0RwmDJdJ0uKLgpASM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OiZ+idpX4QxLI1Wnukl67lLVJZRlzobgRIT3DdYu+vZpOcs+5F4sbx5yBgYS1iHme
 qrKrX42KtQbvdMmuvtM3FC1z33iXHocjtp5JJwmaQ2uEqeghyI/Ow14oZdRDPERZXf
 QOPeCZQqc88ZZ4+irO2SbHAu3S4ATdnGgSP7AOGM=
Received: by mail-qt1-f180.google.com with SMTP id x23-v6so14855506qtr.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 11:32:51 -0700 (PDT)
X-Gm-Message-State: ABuFfojOPYKsBPmOMyAldKanhM2qezEC/a9rycKOpgaxZbDR8RQVpBIQ
 Z/YTAD12lHSFBIaoo1GW5cVNnV9gyhJaHk0OSA==
X-Google-Smtp-Source: ACcGV63HX2zbcJlDZAtDgJDXMEzwREemvWoN9VcT34aMnZvXQt0FQ7Z1xKkSE7QN8Ct0AKR4OfbEHGIsu7eP+q5/xEY=
X-Received: by 2002:ac8:148b:: with SMTP id
 l11-v6mr10739551qtj.27.1538764370602; 
 Fri, 05 Oct 2018 11:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-20-robh@kernel.org>
 <20181005180725.GH5626@piout.net>
In-Reply-To: <20181005180725.GH5626@piout.net>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Oct 2018 13:32:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBRaNf73feHzG4aYyEMxWso8a7Wt6L0JZJLGWecymoUg@mail.gmail.com>
Message-ID: <CAL_JsqJBRaNf73feHzG4aYyEMxWso8a7Wt6L0JZJLGWecymoUg@mail.gmail.com>
Subject: Re: [PATCH 19/36] dt-bindings: arm: Convert Atmel board/soc bindings
 to json-schema
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
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
 Nicolas Ferre <nicolas.ferre@microchip.com>,
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

On Fri, Oct 5, 2018 at 1:07 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 05/10/2018 11:58:31-0500, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > new file mode 100644
> > index 000000000000..f788315b94fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: None
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/atmel-at91.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel AT91 device tree bindings.
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>
> Jean-Christophe has not been active for years, I'd mention Ludovic
> instead.

Will update. I generated these out of git log. I didn't use
get_maintainers.pl because it seems lots of files don't have
maintainers listed (other than Mark and me) and I didn't want to be
it.

>
> > +description: |
> > +  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: atmel,at91rm9200
> > +      - items:
> > +          - enum:
> > +              - olimex,sam9-l9260
> > +          - enum:
> > +              - atmel,at91sam9260
> > +              - atmel,at91sam9261
> > +              - atmel,at91sam9263
> > +              - atmel,at91sam9g20
> > +              - atmel,at91sam9g45
> > +              - atmel,at91sam9n12
> > +              - atmel,at91sam9rl
> > +              - atmel,at91sam9xe
> > +          - const: atmel,at91sam9
> > +
> > +      - items:
> > +          - enum:
> > +              - atmel,at91sam9g15
> > +              - atmel,at91sam9g25
> > +              - atmel,at91sam9g35
> > +              - atmel,at91sam9x25
> > +              - atmel,at91sam9x35
> > +          - const: atmel,at91sam9x5
> > +          - const: atmel,at91sam9
> > +
> > +      - items:
> > +          - const: atmel,sama5d27
> > +          - const: atmel,sama5d2
> > +          - const: atmel,sama5
> > +
> > +      - description: Nattis v2 board with Natte v2 power board
> > +        items:
> > +          - const: axentia,nattis-2
> > +          - const: axentia,natte-2
> > +          - const: axentia,linea
>
> Shouldn't we have the board specific compatibles in a separate file to
> avoid mixing everything with the SoC compatibles?

You can't validate it that way. I have to say "must be compatible A,
B, C and in that order" and you can't if A, B, and C are in different
files. We could do board vendor files, but then we have to duplicate
the SoC compatibles. I don't think there's any board vendor with
enough boards to justify that. The only place I've found that the
compatible lists get kind of messy is when platforms have a variable
number of compatible strings.

We generally have not split things this way for most platforms except
i.MX which this series changes. Looks like I forgot to remove the
axentia.txt for Atmel.

Rob
