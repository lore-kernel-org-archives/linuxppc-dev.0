Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0DC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:03:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E820652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nayzij9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TNsB38k7zF3CW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:03:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nayzij9Y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nayzij9Y"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TNn144SnzF3Cj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 01:59:33 +1100 (AEDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6ED4F20882
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539010771;
 bh=JYPRKDNjCRjW6GaFap/e8HNXQ5zt8EhA69Cv409eUoc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nayzij9Y9zJ8GPZ0UG/lly41eKJsV5vinxs9rfdR9DvRsS3ZQaulQvLvh0W4NI+xq
 Pxn4m0X1Az4IyCB4+IIechkN5WxMgfj85CcIXcyNliKOzSns7kaM8osbbCd6yVsm70
 FRSyURuxzOoHCD2cIm+c3uWJ+/G9FdsNKjpub42Q=
Received: by mail-qt1-f177.google.com with SMTP id o17-v6so5317580qtr.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 07:59:31 -0700 (PDT)
X-Gm-Message-State: ABuFfohCWI4LxfmweC/HGLc4mJeu8D60KrXVj7/vKMrg3cc1Al/pEqcd
 3f4IhnkeXEwu5hnvY3iEG4UNWdlLnL2rZnidjw==
X-Google-Smtp-Source: ACcGV63N3sq9OVVMnu+MjbPqN8/5FhVlGKQzy+5SIDuPNCyz2hqV/jHwtBjj+KociYzUYKKCY+XtD1gFLa4zEGyeWWw=
X-Received: by 2002:ac8:190e:: with SMTP id
 t14-v6mr19370298qtj.327.1539010770633; 
 Mon, 08 Oct 2018 07:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
 <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
In-Reply-To: <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 09:59:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
Message-ID: <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
Subject: Re: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Simon Horman <horms@verge.net.au>
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
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 2:05 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> > In preparation to convert board-level bindings to json-schema, move
> > various misc SoC bindings out to their own file.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Looks good to me, but needs a rebase, as the PRR section has been extended
> in -next.

Is this something you all can apply still for 4.20?

Rob
