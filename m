Return-Path: <SRS0=qk5f=QD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28DC282C7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 03:02:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0E321903
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 03:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnHAFGAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E321903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43nHc44P43zDqNV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jan 2019 14:02:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OnHAFGAZ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43nHZ74FCGzDqKb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2019 14:00:30 +1100 (AEDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D73B21909
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jan 2019 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548558028;
 bh=VQZ9p5D0SjFbMo7+hJBCYP4JqQfOx1wEolKfSx+wZwI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OnHAFGAZgzXIyZqT+g4jjiJKbgFOMZ5tVZGorAneODvYXAbnF++XmCbdha+HsDAfL
 QG4hvFL6gZ3ryA+6bxYykz9SJ57Z8mdvtnVyx+tnYCQudufzFJA+iNSoV+2n/wfA2e
 eEQNNkcSNRCWK7Y0O0iD2qU+STnoObBx6AYj2qSQ=
Received: by mail-qk1-f179.google.com with SMTP id o8so7617822qkk.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 19:00:28 -0800 (PST)
X-Gm-Message-State: AJcUukdj9kanYCHavocH6pZ5EFLWT4gwWc6LhJ/2/5+IavsRuuoMhOJP
 SPL6197rD5N9wc5az4yAHOtglPBFl9HVQW00VA==
X-Google-Smtp-Source: ALg8bN4jf4q7gzMidj4mMrXVcLr7bxoeZvYw6qytdthD58afqiisLh4HxHLUZEeywpFTlVr/F9bqu62NPHmWrvLDXuA=
X-Received: by 2002:a37:a483:: with SMTP id
 n125mr14681058qke.184.1548558027423; 
 Sat, 26 Jan 2019 19:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 26 Jan 2019 21:00:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
 arm-soc <arm@kernel.org>, Sean Hudson <darknighte@darknighte.com>,
 Jonathan Corbet <corbet@lwn.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <grant.likely@arm.com>, Michal Marek <michal.lkml@markovi.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Currently, the validation targets are separate from a normal build to
> > avoid a hard dependency on the external DT schema project and because
> > there are lots of warnings generated.
>
> Thanks, I'm giving this a try, and get errors like:
>
>       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
>     FATAL ERROR: No markers present in property 'cpu0' value
>
> and
>
>       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
>     FATAL ERROR: No markers present in property 'audio_clk_a' value
>
> Do you have a clue?

That's really strange because those aren't even properties. Are other
dts files okay? This is the in tree dtc?

The only time you should be missing markers is if you did a dts -> dts
-> dt.yaml.

Rob
