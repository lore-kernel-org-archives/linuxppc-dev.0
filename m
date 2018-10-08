Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D0C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26B82075C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B82075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TCF64cQ4zF3Bb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.195; helo=mail-vk1-f195.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
 [209.85.221.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TCBn0cT9zF36t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:47:44 +1100 (AEDT)
Received: by mail-vk1-f195.google.com with SMTP id h20-v6so1661014vke.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 00:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AIElAWjEC4+qiV3Uf4xf+PuGd22N3jcTDz6lLt7BuWM=;
 b=bCioYIGG51a4kHYFyv869FU+rY6pp9MRTxd/YWZPHYbsJ/GDQDjVBlUfdUqaymlcHP
 dndGem+QAAkQID8SxnQOcq/3IIKzJO9237dHT1uQVwoJAdgxKTq/SWlDhNF0CXzFSfgb
 Lqm5Y2WS5vNBK18kfmNWWakI6ICyYMEtv4Cap+XZv5dLzCyXVdp2qhmMciSrIFXhwRy5
 +eaa3KLl6v01GqPMH0qz5nXj9N204FcrAOtmj3C8QbQ2FrHixqr9K72OXXOYMCbULLP1
 2rwD0is4mXjWRtOUIHGO8Wsi3bLyAOuoJbv4+3Te+Wn3J81kiAxI6W+/2que5c9tZDW4
 WvWg==
X-Gm-Message-State: ABuFfojEQuOpl+DhoAgTTm4YdxWx1fjCgu0bag1ldHzr2z8bS/bmatN6
 C0QliTyrNUxL9JF1Er6JQvIBQySNnHHqf9UDQws=
X-Google-Smtp-Source: ACcGV61roA6wLlkVv7sk2NfIm6I4d3sLLnkmtKvKU8cMqiPVN27rjs7bnm1Jeo2z1DhH+O5Fbv/H492gE7znuBqzBIk=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr8394416vkg.40.1538984861844; 
 Mon, 08 Oct 2018 00:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
In-Reply-To: <20181005165848.3474-30-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Oct 2018 09:47:29 +0200
Message-ID: <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

Note that this will need a rebase, as more SoCs/boards have been added
in -next.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: None

The old file didn't have an SPDX header, so it was GPL-2.0, implicitly?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/shmobile.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>

Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)

You had it right in the CC list, though...

> +      - description: RZ/G1M (R8A77430)
> +        items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> +              - iwave,g20d
> +          - const: iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
> +              - iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - description: RZ/G1N (R8A77440)
> +        items:
> +          - enum:
> +              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)

This board belongs under the RZ/G1M section above
(see also the 7743 in the part number).

> +          - const: renesas,r8a7744

> +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> +        items:
> +          - const: shimafuji,kingfisher
> +          - enum:
> +              - renesas,h3ulcb
> +              - renesas,m3ulcb
> +          - enum:
> +              - renesas,r8a7795
> +              - renesas,r8a7796

This looks a bit funny: all other entries have the "const" last, and
use it for the
SoC number. May be correct, though.
To clarify, this is an extension board that can fit both the [HM]3ULCB
boards (actually also the new M3NULCB, I think).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
