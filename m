Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD0C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2362082B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtw80NaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2362082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439phZ5C2wzDrVY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:31:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mtw80NaM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mtw80NaM"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439pbm1Lw4zDrQR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 08:27:47 +1100 (AEDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D72E21536
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544131665;
 bh=YUKdoUTdVOsh4ePDuGZ5IkFg5OFwW2rDLrMYKWOZJig=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Mtw80NaMfMVffOW74aj/EI26GoQDEzan0jzuEAo+MAJ6brIQBDlkWQKmd9IWDFEXk
 Tn9/bMPwQS6xTmEYNE5bM/Mg9ql9Q8lAcUMZMtdl1Qw6kzdzwTf4DXTlz+llH2FShD
 9neyDhJX+Xl3B1H4Kz94GaksN4CqAIAXVOkIJlR4=
Received: by mail-qt1-f175.google.com with SMTP id p17so2261146qtl.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 13:27:45 -0800 (PST)
X-Gm-Message-State: AA+aEWbfn2aiyKm5U6FHDbRlcW/6JzjvKUhsUgRVOQXu238TpkEAL1UC
 lyvUNVFJMJjiLst8hDOGJb1URnnMoyViJhXEsA==
X-Google-Smtp-Source: AFSGD/Xq7Y31Py8rddAX76hKx/Dgp6RhHrT1700dFVf7MBtjRNWpyx/brxsFhnAarR60gHdRV/sSlbWPfoSSMDfS4m0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr29894028qvl.77.1544131664335; 
 Thu, 06 Dec 2018 13:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
 <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 15:27:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/34] dt-bindings: arm: Convert Amlogic board/soc
 bindings to json-schema
To: Neil Armstrong <narmstrong@baylibre.com>
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>, Kevin Hilman <khilman@baylibre.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 8:44 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi Rob,
> >
> > You forgot linux-amlogic in CC...
> >
> > On 03/12/2018 22:32, Rob Herring wrote:
> > > Convert Amlogic SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Carlo Caione <carlo@caione.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
>
> [...]
>
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,s400
> > > +          - const: amlogic,a113d
> > > +          - const: amlogic,meson-axg
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,u200
> > > +          - const: amlogic,g12a
> >
> > but all this feels wrong for me.
> >
> > First of all, this yaml description is not human friendly and not intuitive at all,
> > and secondly with this conversion we loose all the comments about the SoC family relationship
> > with the compatible strings !
> >
> > I really understand the point to have automated verification, but really it's a pain to read
> > (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> > I feel it will be a real pain to write !
>
> What do you suggest that would be easier? Is it the YAML itself or the
> json-schema vocabulary? For the former, we could use {} and [] to make
> things more json style. But I imagine it is the latter.
>
> There is some learning curve for json-schema and is certainly a
> concern I have, but there would be a learning curve for anything. Our
> choices are use some existing schema language or invent one. All the
> previous efforts (there's been about 5 since 2013) have been inventing
> one, and they've not gone far. There will be far few resources
> available to train people with if we do something custom.
>
> > Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> > and it should be easy to extract a yaml description from a text document without pain and
> > keep all the human description, no ?
>
> Yes. Please go look at the annotated example in patch 2.

How's this?:

  compatible:
    oneOf:
      - description: Boards with the Amlogic Meson6 SoC
        items:
          - enum:
              - geniatech,atv1200
          - const: amlogic,meson6

      - description: Boards with the Amlogic Meson8 SoC
        items:
          - enum:
              - minix,neo-x8
          - const: amlogic,meson8

      - description: Boards with the Amlogic Meson8m2 SoC
        items:
          - enum:
              - tronsmart,mxiii-plus
          - const: amlogic,meson8m2
