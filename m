Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBDC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:15:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1669D2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TBT30hblzDqSL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:15:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.66; helo=mail-vs1-f66.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TBGb66s8zF3KC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:05:59 +1100 (AEDT)
Received: by mail-vs1-f66.google.com with SMTP id v18-v6so10797338vsl.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 00:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=osue1mJgsfaS1EFwpZk49zemL2dWAZG7kJzubCuh1oU=;
 b=TVEG85GJynCtXFurSlM8a2FVmZTjBC2/UhqsTyvtIUqt86TkAIW6UBikwcoh/eEJlE
 zT4uZhgKi4d5+qKoAYvOH6BAzaSYV8PMsyU24KXucY1s7qiDLvuhtd6w33NvjdlSt8Tk
 +mVxQJo8aoID4KBVXVUeHgVo2lGkyzgjc5i8IqmKaXw4QQnkcXosKn3D9u5RJz/IN87z
 A/TQ4GCFCWO+3vyGBSCmG4oVmoq9K3t5dpsqVXPG4pEb7/IxyGTHZlTzQLTrNSFwjvpc
 FmFUadSqSqWL2xoqDjPQFlE/eUbIFQcoa95cvCuE6LwPUguHqcoHfx0oKwmZClJ5zb8H
 7fLA==
X-Gm-Message-State: ABuFfoiJB9O4oqXisAGv3bkc0A+rckl8UfqVOMJeL0hfpmloKIuEcSIA
 Of9e4w9nU87dYRJeEdv5bCLV6zm9u+mI49njLCM=
X-Google-Smtp-Source: ACcGV63O0pQ2gzNbJoy0LYbI3d2s9A8d4XFSj/sseIF/MligeMeHm/bttdlCvYhsl9AqRoEt9ZhUSlCrK5hTfvIa3IE=
X-Received: by 2002:a67:843:: with SMTP id 64mr5388261vsi.166.1538982356908;
 Mon, 08 Oct 2018 00:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
In-Reply-To: <20181005165848.3474-6-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Oct 2018 09:05:45 +0200
Message-ID: <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
Subject: Re: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
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

On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks good to me, but needs a rebase, as the PRR section has been extended
in -next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
