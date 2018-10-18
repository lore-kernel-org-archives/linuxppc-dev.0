Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F8C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:06:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19432098A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PhPYYbfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19432098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bTnT2HNCzF3KQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:06:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="PhPYYbfV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=verge.net.au
 (client-ip=202.4.237.240; helo=kirsty.vergenet.net;
 envelope-from=horms@verge.net.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="PhPYYbfV";
 dkim-atps=neutral
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 42bTgn2K3yzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:01:08 +1100 (AEDT)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 9FDCA25BE28;
 Fri, 19 Oct 2018 00:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1539867668; bh=nlzSdoM3o1Q1qB6ObE17iQR0UbnfF5kWb9Wkm1Aa7YU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PhPYYbfVQIXstV12IDRbD+CWnQUyBuz0xw0v/HNjUFpdieiiuRphxxvDXIC2ZxZe5
 OiVJodeAHE5MM0fsS7+o0mRmeblnEXSPHHLzS7WMdsiJT9UChmi3T3VGqQjU4B5BJv
 7mC4RK8G+eDL1izXnVtTSRWmfoGzCLevxKEHMWqc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 83B96940162; Thu, 18 Oct 2018 15:01:05 +0200 (CEST)
Date: Thu, 18 Oct 2018 15:01:05 +0200
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181018130105.2guhavajp754qbnk@verge.net.au>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
 <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
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

On Mon, Oct 08, 2018 at 09:05:58AM -0500, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 3:02 AM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Fri, Oct 05, 2018 at 11:58:41AM -0500, Rob Herring wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This seems fine to me other than that it does not seem
> > to apply cleanly to next.
> >
> > shmobile.txt sees a couple of updates per release cycle so from my point of
> > view it would ideal if this change could hit -rc1 to allow patches for
> > v4.21 to be accepted smoothly (already one from Sergei will need rebasing).
> 
> When we get to the point of merging (which isn't going to be 4.20),
> you and other maintainers can probably take all these patches. Other
> than the few restructuring patches, the only dependency is the build
> support which isn't a dependency to apply it, but build it. I plan to
> build any patches as part of reviewing at least early on. OTOH, the
> build support is small enough and self contained that maybe it can
> just be applied for 4.20.

Thanks, understood.

My preference would be to, as you suggest, take changes like
this through the renesas tree.
