Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A8C65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:57:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBBA20858
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqmw3cem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBBA20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TRNq3pyyzF3F3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 03:57:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dqmw3cem";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dqmw3cem"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TRL66hpCzF3CZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 03:54:54 +1100 (AEDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3E6D21479
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539017692;
 bh=T05h9mmNjIzCxCA8ih41bZoXJcOSt7z8Y0uiPOjn0T4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Dqmw3cemvPVW/3tj2PFDVegszgjHVScyO/LKZg8C9jBCJAVmr52QYBOzuGj72nEJl
 NL6ILpRm4E7J/jNoab1TiP+KVAy4ybkWO6fUxnMpwNXDv44slUqn+TfY9KKv15kfMf
 rCZc9BLhgTWOU2JLqyVDTkiJ6utSUDp0/a+ihO1g=
Received: by mail-qk1-f173.google.com with SMTP id 12-v6so5598335qkj.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 09:54:52 -0700 (PDT)
X-Gm-Message-State: ABuFfog2z4wbh260MAISqr516z0JKAIdnIvhpGGbow2/oWQ9u5p5DntJ
 TqqsSJEBsNgCWnGWtKINEf03m9V5QB6c1YLV2A==
X-Google-Smtp-Source: ACcGV62vWiL9PqL0hCfNL+kOwEtmWWHMKd+uBSZVRuVOjwsyyQJOaIIGhX+3QCmw6pxp7Rt04CXhem113T0zqHUKAA0=
X-Received: by 2002:a37:12d1:: with SMTP id
 78-v6mr19519749qks.147.1539017691827; 
 Mon, 08 Oct 2018 09:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
 <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
 <CAMuHMdVtuKkytpHxJfWHw=-R09_AMZ8Tn=ixjPSSRydQL6qK2g@mail.gmail.com>
In-Reply-To: <CAMuHMdVtuKkytpHxJfWHw=-R09_AMZ8Tn=ixjPSSRydQL6qK2g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Oct 2018 11:54:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOc_cTh7rkeQ9auhcFR2Ein+CUQWXBQS74tNBYVSQBig@mail.gmail.com>
Message-ID: <CAL_JsqJOc_cTh7rkeQ9auhcFR2Ein+CUQWXBQS74tNBYVSQBig@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
 Simon Horman <horms@verge.net.au>, Frank Rowand <frowand.list@gmail.com>,
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

On Mon, Oct 8, 2018 at 10:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 8, 2018 at 4:57 PM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > > > Convert Renesas SoC bindings to DT schema format using json-schema.
>
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > > > @@ -0,0 +1,205 @@
>
> > > > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > > > +        items:
> > > > +          - const: shimafuji,kingfisher
> > > > +          - enum:
> > > > +              - renesas,h3ulcb
> > > > +              - renesas,m3ulcb
> > > > +          - enum:
> > > > +              - renesas,r8a7795
> > > > +              - renesas,r8a7796
> > >
> > > This looks a bit funny: all other entries have the "const" last, and
> > > use it for the
> > > SoC number. May be correct, though.
> > > To clarify, this is an extension board that can fit both the [HM]3ULCB
> > > boards (actually also the new M3NULCB, I think).
> >
> > This being Kingfisher?
>
> Correct.
>
> > I wrote this based on dts files in the tree. There's 2 combinations that I see:
> >
> > "shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
> > "shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"
> >
> > The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
> > other combinations are possible. If not, then we could rewrite this as
> > 2 entries with 3 const values each.
>
> I expect there will soon be a third one:
>
>     "shimafuji,kingfisher", "renesas,m3nulcb", "renesas,r8a77965"
>
> Technically, {h3,m3,m3n}ulcb are the same board (although there may be
> minor revision differences), with a different SiP mounted.
> But they are called/marketed depending on which SiP is mounted.
>
> And on top of that, you can plug in a Kingfisher daughterboard. Could be an
> overlay ;-)

We probably shouldn't have put kingfisher as a top-level compatible
then. But we did, so not really much point to discuss that now.

As to whether there's a better way to express it in the schema, I'm
not sure. I don't think there's a way with json-schema to express a
list, but the 1st item is optional.

Rob
