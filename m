Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1ACC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:15:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5306A2075C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 15:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5306A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TP6y2rnFzF3BW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 02:15:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.67; helo=mail-vs1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TP4m36LBzF3Bx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 02:13:12 +1100 (AEDT)
Received: by mail-vs1-f67.google.com with SMTP id g201so11593384vsd.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 08:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HmOabBNqDMjWcmsiNHkPzhwfgz/jRpqNu7y2U3BkQoI=;
 b=kblPtVtEJ7+YJwIB6lOIwEvJZgx6C016aGTfiM6Y2prR/rOnHccTkx3M+ueeGOHJKn
 bjFpTsbzH3bgFeREM3+QlX1DzEByjK5TsNERRsVXS0Nis7t1VQttaxLsI4qB8Zr5Hme8
 t5os4YuPk23fg82C8Yq4D0H2IHwvaEDX0vqfsakCctHQDMn20KACkVjSxFvWP0iRBM2/
 k3BiB2kpEj2LVxkSic1w5cRIUYztXCn5BirdpB3c9h1/ppdt6KOD7dHYlYRTYxgiHwjg
 ZxuwnXEaDgRSdMS2gwElc7i9wOKUgroMUaX/XunfCRzaFfqyxFcO7Bv38nxDAaIWMxkA
 vVuQ==
X-Gm-Message-State: ABuFfogByZWXQv1jb3nXpnrkVEpRKQtXFsRCwYskZDEaeZKzMTOKhbEz
 3FBhGUFZ7P4Is1shxy9zzopO3kAIUDbLxkMx+eM=
X-Google-Smtp-Source: ACcGV620Zl5vJ9xzKDLqnc0NRHrBMVjmgYMWqKpLGCo7ur7fwyTF1afoq6FT5oEuvVO7TU4mEoqbidKdD6XcFxLkQ5Y=
X-Received: by 2002:a67:d69e:: with SMTP id o30mr6235265vsj.11.1539011589275; 
 Mon, 08 Oct 2018 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
 <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
In-Reply-To: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Oct 2018 17:12:56 +0200
Message-ID: <CAMuHMdVtuKkytpHxJfWHw=-R09_AMZ8Tn=ixjPSSRydQL6qK2g@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Rob Herring <robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
 Grant Likely <glikely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rini <trini@konsulko.com>, Simon Horman <horms@verge.net.au>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On Mon, Oct 8, 2018 at 4:57 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > > @@ -0,0 +1,205 @@

> > > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > > +        items:
> > > +          - const: shimafuji,kingfisher
> > > +          - enum:
> > > +              - renesas,h3ulcb
> > > +              - renesas,m3ulcb
> > > +          - enum:
> > > +              - renesas,r8a7795
> > > +              - renesas,r8a7796
> >
> > This looks a bit funny: all other entries have the "const" last, and
> > use it for the
> > SoC number. May be correct, though.
> > To clarify, this is an extension board that can fit both the [HM]3ULCB
> > boards (actually also the new M3NULCB, I think).
>
> This being Kingfisher?

Correct.

> I wrote this based on dts files in the tree. There's 2 combinations that I see:
>
> "shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
> "shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"
>
> The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
> other combinations are possible. If not, then we could rewrite this as
> 2 entries with 3 const values each.

I expect there will soon be a third one:

    "shimafuji,kingfisher", "renesas,m3nulcb", "renesas,r8a77965"

Technically, {h3,m3,m3n}ulcb are the same board (although there may be
minor revision differences), with a different SiP mounted.
But they are called/marketed depending on which SiP is mounted.

And on top of that, you can plug in a Kingfisher daughterboard. Could be an
overlay ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
