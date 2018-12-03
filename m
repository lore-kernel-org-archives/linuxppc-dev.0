Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88C9C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 14:27:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A7D206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 14:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2xTc4dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437nPp0kcrzDqSx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:27:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k2xTc4dx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="k2xTc4dx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437nLl3WpyzDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 01:24:31 +1100 (AEDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 118F62145D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543847069;
 bh=8d6A/eGHeNhO5+5OG/m5ZZxRYdvk4qfOI6WRjYjlRGI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k2xTc4dxX60qJG6sKGGU8Qs+KPM9eRQ8DJwXkP3zzn2UCx7Dt1oZgSe3YNhaCVyrc
 EtxyBpa4+C7sFmTZ4dy2Ympb4JDxmEB88rw0Nxj0cG8wiGlASjLXvMRZ6a/ierWKz7
 ikSQcH52spry8YBsFWGGBgTtVw8eC2lN+gJr0TnI=
Received: by mail-qk1-f182.google.com with SMTP id a132so7409780qkg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 06:24:29 -0800 (PST)
X-Gm-Message-State: AA+aEWb0nMpvstujaLMZVGremr2ZO8M3wWpbBTqCQvCTJR/PWhi7vrOG
 LsP33m9J27w0sKjd77s2Ex5NwSTRAwOs3u9oSg==
X-Google-Smtp-Source: AFSGD/XBzLeYhytEZKv+OGssA8pInF2otOKevKIB4x3x40qwJyrePmSLFFqVh/9zAL5SY2McQdHj3jxWrMzQLoplb4o=
X-Received: by 2002:a37:7682:: with SMTP id r124mr15113528qkc.79.1543847068207; 
 Mon, 03 Dec 2018 06:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
 <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
 <20181203124039.GA25097@arm.com>
In-Reply-To: <20181203124039.GA25097@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 3 Dec 2018 08:24:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLC-1VWoErAteugtGOY-Gk87TBHkA94oyibE4Z+Wjq+DA@mail.gmail.com>
Message-ID: <CAL_JsqLC-1VWoErAteugtGOY-Gk87TBHkA94oyibE4Z+Wjq+DA@mail.gmail.com>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-mediatek@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 3, 2018 at 6:40 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 30, 2018 at 12:00:05PM -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On 05. 10. 18 18:58, Rob Herring wrote:
> > > > Convert ARM CPU binding to DT schema format using json-schema.
> > > >
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-mediatek@lists.infradead.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> > > >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> > > >  2 files changed, 503 insertions(+), 490 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> >
> > [...]
> >
> > > I have take a look at xilinx part of this and try to build it for arm64
> > > platforms and I see errors coming from this cpu description.
> > > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > > cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > > cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> > > unexpected)
> >
> > Thanks for actually giving this a spin!
> >
> > > Based on grep this is used in a lot of places
> > > compatible = "arm,cortex-a53", "arm,armv8";
> > >
> > > Should this be moved to just simple?
> > > compatible = "arm,cortex-a53";
> >
> > I'd normally go with the majority which would be to keep it. However,
> > 'arm,armv8' is of questionable value, isn't actually documented, and
> > doesn't exist for any other version of the architecture. So we should
> > kill it IMO.
>
> I'd prefer to keep it around, since that's what's used to describe the CPUs
> on the fastmodel iirc.

We can and should keep it for that purpose, but do we need it as a
fallback? For real cores though, we have mixture of with and without
and one of those need to be fixed.

Rob
