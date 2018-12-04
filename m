Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F23C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:51:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E609C2082B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w29ShF+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E609C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438cYg6SLSzDqWQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 09:51:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="w29ShF+b";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="w29ShF+b"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438cVd2ZzjzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 09:49:13 +1100 (AEDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6EEB422510
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543963751;
 bh=nAJYNF5exn/7MIzDf+gyUHqeEcWC+Frr1x7qmSLYhyw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w29ShF+bdXzVUKOyWvM4TIxOwLG8xXP4CAen4rtuCdJcFedVIUULLN7NU5HV/y5zd
 w5mcA2Ayx6Q3IQYPL4sfET8nG0VH4LeorZR5k4hTtjLUPDA3sVYSgMPDdtDByiHE2n
 QNO7K2fx5b81rE2nLaTfiiyR/QaC2i10vmzx8I4E=
Received: by mail-qt1-f169.google.com with SMTP id v11so20153533qtc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 14:49:11 -0800 (PST)
X-Gm-Message-State: AA+aEWYRuSI7qb0hdsJjphgIljUwGmtsdKZiz9fPPQfm3LSsMLVfgzal
 G7zYfTvTTEUaknx2IU9wiWm6jv/XIcDusDV8hQ==
X-Google-Smtp-Source: AFSGD/V5FXSz3M1XMujzv3vfX6JjiuiUVj0szW8v6ILDUDw7ehQqjaWH5Tw2r1t6XJQTmzZ0rlxzOodM3Mh8u9BQL08=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr21366933qve.246.1543963750624; 
 Tue, 04 Dec 2018 14:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-16-robh@kernel.org>
 <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
In-Reply-To: <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 16:48:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Subject: Re: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 2:12 AM <Nicolas.Ferre@microchip.com> wrote:
>
> On 03/12/2018 at 22:32, Rob Herring wrote:
> > Convert Atmel SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>
> I'm listed here...
>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Proper email address here...
>
>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
> >   .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
> >   2 files changed, 133 insertions(+), 72 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
> >   create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > deleted file mode 100644
> > index 4bf1b4da7659..000000000000
> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -Atmel AT91 device tree bindings.
> > -================================
>
> [..]
>
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > new file mode 100644
> > index 000000000000..19431f58b906
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel AT91 device tree bindings.
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Ludovic Desroches <ludovic.desroches@atmel.com>
>
> ... and sorry but it's not correct just above ^^^
> - wrong Ludovic's email address
> - wrong Alexander's email address
> - and I'm not part of the game anymore...

Humm, I think get_maintainers.pl says you are as that's where the Cc
list came from. But it could be stale if that changed recently.

>
> So actually our MAINTAINER's entry is up-to-date: please use it.

Sorry, it was generated from git history. Many of cases with
get_maintainers.pl was not correct and ended with me being listed.
Probably should have made the git history a fallback.

Rob
