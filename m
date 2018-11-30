Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B9C64EB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 18:08:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6196220867
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR6nWM3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4362S33g8QzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 05:08:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fR6nWM3w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fR6nWM3w"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4362H84B82zDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 05:00:20 +1100 (AEDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B42F02147D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543600817;
 bh=/QpuGKJw2ddCeYOK3BoT6q8Eh45edi10/QgSRj8sg4I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fR6nWM3wBm1dMxNyAUPSbwdj1Q+K/XNmHKVIxb+tfplFWTz5Hf9UQePJG9BlCS+qO
 Bf+tw27Vw48FA0mSJiQ4QVwrMDXC1EEGZj3XbJh6TVqZe+eC0hdOB2ibCvO4cXY5VB
 hS0wpOT5xwQYG6bMvsnZX/wBPyPmQm8uSOExBHd4=
Received: by mail-qt1-f179.google.com with SMTP id z16so6875659qtq.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 10:00:17 -0800 (PST)
X-Gm-Message-State: AA+aEWY/08SOf3j9ocr2Z3KsKQs1/tOuanF2ryOaSRnLWYCSIFjLf/ao
 4zVMutxlfTw5fIqHAWxcwjkL2EOAq9ENga0lkA==
X-Google-Smtp-Source: AFSGD/UiLGFEHfl3xFMRQ6BqqrGeqaokngd70FI9UTO2I8nWvpdwvFH4mj26CvCmZOH7gYUq10ZoErtWi8ZQJGhpW+0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr6546459qts.144.1543600816930; 
 Fri, 30 Nov 2018 10:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
In-Reply-To: <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Nov 2018 12:00:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
To: Michal Simek <michal.simek@xilinx.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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
Cc: devicetree@vger.kernel.org, Kumar Gala <kumar.gala@linaro.org>,
 Grant Likely <glikely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rini <trini@konsulko.com>, Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-mediatek@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Rob,
>
> On 05. 10. 18 18:58, Rob Herring wrote:
> > Convert ARM CPU binding to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> >  2 files changed, 503 insertions(+), 490 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml

[...]

> I have take a look at xilinx part of this and try to build it for arm64
> platforms and I see errors coming from this cpu description.
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)

Thanks for actually giving this a spin!

> Based on grep this is used in a lot of places
> compatible = "arm,cortex-a53", "arm,armv8";
>
> Should this be moved to just simple?
> compatible = "arm,cortex-a53";

I'd normally go with the majority which would be to keep it. However,
'arm,armv8' is of questionable value, isn't actually documented, and
doesn't exist for any other version of the architecture. So we should
kill it IMO.

Paging Mark Rutland and other arm folks...

Rob
