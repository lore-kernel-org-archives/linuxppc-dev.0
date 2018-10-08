Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B7C677D4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 14:08:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DB420841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 14:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzZ00aAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DB420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TMf94Jf2zF3Dt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:08:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RzZ00aAz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RzZ00aAz"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TMbS6m4FzF39m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 01:06:12 +1100 (AEDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3069213A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539007570;
 bh=qGvtHr+CMDmWHX/83L83F2IdY3owtawwH/qDYioZ4r0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RzZ00aAzIvkDelqTH9UDyDdngojHbeCEZUwp+PJJ5ulS2sWJ7+nhu9RuNvsoq3AU+
 TK+dQjy/WxjK4dmjjKrn2fK0SnKMnj9HIuZ0b5u4sBYk1P2fZWiQRFjoPSyFdAGDfG
 8pWq/TJc13hnZdnmnBci6SWPk0hDTuHt0LULZbQQ=
Received: by mail-qt1-f179.google.com with SMTP id e10-v6so9946621qtq.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 07:06:10 -0700 (PDT)
X-Gm-Message-State: ABuFfojBeiLBX6KR/SXgfKUQiKJDqXyCRPH7sYeSTa0dkghSxH1Tg7cp
 P8YnHaS8XmbPM3fnVJroZd1lHQyfXQYj5jVifA==
X-Google-Smtp-Source: ACcGV62KsUUpKLXT6piTWeTHL1QHKqJZ3HIWz14HO1selX1eMzsXiqgETACADOTZicacT/pVeWAgcOMP379shaQTGjI=
X-Received: by 2002:a0c:b5d3:: with SMTP id
 o19-v6mr19705377qvf.218.1539007569885; 
 Mon, 08 Oct 2018 07:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
In-Reply-To: <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 09:05:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Message-ID: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Simon Horman <horms@verge.net.au>
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
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 3:02 AM Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, Oct 05, 2018 at 11:58:41AM -0500, Rob Herring wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> This seems fine to me other than that it does not seem
> to apply cleanly to next.
>
> shmobile.txt sees a couple of updates per release cycle so from my point of
> view it would ideal if this change could hit -rc1 to allow patches for
> v4.21 to be accepted smoothly (already one from Sergei will need rebasing).

When we get to the point of merging (which isn't going to be 4.20),
you and other maintainers can probably take all these patches. Other
than the few restructuring patches, the only dependency is the build
support which isn't a dependency to apply it, but build it. I plan to
build any patches as part of reviewing at least early on. OTOH, the
build support is small enough and self contained that maybe it can
just be applied for 4.20.

Rob
