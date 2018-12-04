Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA55C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6904C2082B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6904C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Q6R6ZzmzDqF7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 02:01:03 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Q2f0mS3zDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 01:57:45 +1100 (AEDT)
Received: by mail-vs1-f67.google.com with SMTP id n10so1130924vso.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 06:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AIcr61O0Nb6BVaATDrV4fKb6Paoy35Rp4VMoCXfkEFQ=;
 b=g6/UiYjYiE0DNtJHXEUFh7+GNqpmSufaQ0KIz86SgKXXVcyC1wQievGAoKL9p/crAI
 V+Gjm0+FOCHHjSu/0AXRjJaqeJfg4WVZpLxr+2me2/xb4LeGUauf/DqPs3+ic3yKpBCD
 1UOJ5LrmfhuaxDmaB1c3vCOCoaVFdFECQIciTN2q9lbQYozYMci/xn6ql9obbcKEX4og
 LmyNok//bzNZ3t1EINJjtqOWjoaD70Ho8to4bQKlm4+prU9Bz11wvGH0S54+D9BgK4/F
 /jBpedhKc8y21c46K3KKPm+ETNpjj+fl26vPC3KQrbUYoywAoCm4EZZF0Nc/59Si8j5G
 j6+Q==
X-Gm-Message-State: AA+aEWa6JgNbXu9eaHz18R0iQqHzmSufzEGy0DVg0Cf9KYV4jLWHBiQc
 C5lDGtm/KskeR1rbWtqa6myrxVyG/BnyXK4ju1g=
X-Google-Smtp-Source: AFSGD/WOv2tdd5tGICH0vrauIUxfXhNRXEiPJ/feJt/qFI5J0CV2mHMh4MIoyBMKmDQwp3vVwzNp3v4HPU6unQOFZNQ=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9062834vsp.166.1543935462650;
 Tue, 04 Dec 2018 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
In-Reply-To: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Dec 2018 15:57:31 +0100
Message-ID: <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 darknighte@darknighte.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm@kernel.org,
 Frank Rowand <frowand.list@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Simon,

On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> >  2 files changed, 218 insertions(+), 151 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
>
> Hi Rob,
>
> what is this based on? I get a conflict when applying the .txt change
> and if I knew the base for this patch it would be rather easy to work
> out what has changed.
>
> Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

Probably even s/shmobile.yaml/renesas.yaml/, while at it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
