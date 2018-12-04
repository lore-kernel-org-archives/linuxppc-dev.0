Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C23C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 14:47:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5AE2081C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Kj3r0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5AE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Pq94tR3zDqCc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 01:47:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I9Kj3r0o";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="I9Kj3r0o"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Pm33R0szDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 01:45:07 +1100 (AEDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61DB12087F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543934705;
 bh=hVb8TID6cd1Olg3jtzdBexIhOrCiR/d52f5IOpnmACI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I9Kj3r0o3/KmrFHvG5GA+pHQ+dy7Ck2z0nBok1uWJCjEzruGA59yQo0y1FUoCsswk
 o1aUEqebWNFZ+Ip6QC3hVzUmt5fPdbbp1IG8/nQbMgOSbjkGWOSY/gCtPmTyidtwMS
 Yy/BeYZ28OHA5lgEi9DmgXTRG0r6SrbtOljEJnKM=
Received: by mail-qt1-f177.google.com with SMTP id t13so18275220qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 06:45:05 -0800 (PST)
X-Gm-Message-State: AA+aEWaTxLDpBKH8eJnj19cus5Mx0ALNpytmQcl/WTLFUj8VKDHApMNJ
 zfZ+XMxJw89mEdPWz7+xOu1ZXHgO0SpHhOBlZA==
X-Google-Smtp-Source: AFSGD/WGVWJioClsa0lvQGJtAOGi8FkeeWgHBEl1fwnzno8/vkh5RpuvYCjALLTG0ebaUzuRMqN9CWkjmLCc7SNclL4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr19931119qtf.26.1543934704526; 
 Tue, 04 Dec 2018 06:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
In-Reply-To: <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 08:44:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Rob,
>
> You forgot linux-amlogic in CC...
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Amlogic SoC bindings to DT schema format using json-schema.
> >
> > Cc: Carlo Caione <carlo@caione.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---

[...]

> > +      - items:
> > +          - enum:
> > +              - amlogic,s400
> > +          - const: amlogic,a113d
> > +          - const: amlogic,meson-axg
> > +      - items:
> > +          - enum:
> > +              - amlogic,u200
> > +          - const: amlogic,g12a
>
> but all this feels wrong for me.
>
> First of all, this yaml description is not human friendly and not intuitive at all,
> and secondly with this conversion we loose all the comments about the SoC family relationship
> with the compatible strings !
>
> I really understand the point to have automated verification, but really it's a pain to read
> (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> I feel it will be a real pain to write !

What do you suggest that would be easier? Is it the YAML itself or the
json-schema vocabulary? For the former, we could use {} and [] to make
things more json style. But I imagine it is the latter.

There is some learning curve for json-schema and is certainly a
concern I have, but there would be a learning curve for anything. Our
choices are use some existing schema language or invent one. All the
previous efforts (there's been about 5 since 2013) have been inventing
one, and they've not gone far. There will be far few resources
available to train people with if we do something custom.

> Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> and it should be easy to extract a yaml description from a text document without pain and
> keep all the human description, no ?

Yes. Please go look at the annotated example in patch 2.

> What will be the case for all the bindings with ASCII art to describe the architecture of the
> HW ? will you simply drop it to replace it with cold yaml description ?

No, you can have literal blocks and/or comments with however much
description you like. In fact, there's some notion to write the
descriptions in sphinx and extract them to generate documentation, but
that's a ways off. That's just the extent of what is possible.

Rob
