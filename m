Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B323DC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 16:14:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E675206BB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaaHvC5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E675206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZZ2C2Tl2zDqYq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 03:14:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="PaaHvC5S"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZZ0P22vgzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 03:12:37 +1100 (AEDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D5EF2183F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547050355;
 bh=0ewnFeC4FHEcj3A7zvP6jyGEqueFxUiBiflRWniyQXc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PaaHvC5SP+i6GMQmpw0obVdFYkjcvV2PeHjc001a+JP9ks+YhfO8/KmWDAxJ8pEJV
 3mkqgCmls74Qet9z2bsIVInWzuB/x5g7MsItPYiO57nHx6NiL6So6HifJmpc8JK5hJ
 ZpSLn6d0p6yV/jTyD7m7xnXZ3qlwbVk5/wx4jdc8=
Received: by mail-qt1-f175.google.com with SMTP id l12so8852553qtf.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 08:12:35 -0800 (PST)
X-Gm-Message-State: AJcUukdkrKLAAmFB0oW40xMLSkZ7yZylrZw0zgQ9F18Z4GpifXdvORgn
 ivMvPZVkz/jzg5pDCVW1BGIyhONqKR9+JSBYEQ==
X-Google-Smtp-Source: ALg8bN4pu0jO5c5wx1wRb8Wdh/XxBNbWH/RA4JA1FVu26NTXWub+M5FQs5XxXlnpfvGYzWG+9gQUlDCyV6XWzoSBpIg=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr6044903qta.38.1547050354186; 
 Wed, 09 Jan 2019 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
 <7hr2ewbxd4.fsf@baylibre.com>
 <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 9 Jan 2019 10:12:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2yN_h0FUJ_F79OBMNkpOH=ou-o4iBHffoRt4XRP8mYA@mail.gmail.com>
Message-ID: <CAL_JsqJ2yN_h0FUJ_F79OBMNkpOH=ou-o4iBHffoRt4XRP8mYA@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move
 'amlogic,meson-gx-ao-secure' binding to its own file
To: Kevin Hilman <khilman@baylibre.com>
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
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 10:18 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 7:01 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Rob Herring <robh@kernel.org> writes:
> >
> > > It is best practice to have 1 binding per file, so board level bindings
> > > should be separate for various misc SoC bindings.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Carlo Caione <carlo@caione.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-amlogic@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
> > >  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
> > >  2 files changed, 28 insertions(+), 29 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> >
> > Acked-by: Kevin Hilman <khilman@baylibre.com>
> >
> > But this isn't really related to the schema series is it?  If you
> > prefer, I can just queue this one separately via my tree.
>
> Yes, you can take it.

Hey Kevin, doesn't look like this got applied.

Rob
