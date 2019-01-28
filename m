Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF5C282CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9B821841
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wzh4I8U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9B821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pDnv1DzpzDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 02:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="wzh4I8U3"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pDZk6jzDzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 02:49:18 +1100 (AEDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E083421852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548690557;
 bh=zb+nISiRI73A+qDN+B8FR5Vq4TOtoLMt5EaVYuqlw3k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wzh4I8U3m/doHXMuJs+U+XcvJZn5zi1aPkPRWnb6CY8m95I8YmDIc6Uw7YnK81NYm
 Mfbr3fYfkAfw4k61uN3DmjPVgzP4Tri3fAkSCon1PPU5/oB2DRqsiSnF/2umkD+A4r
 s45+o7+CeYhBM3T85YQBs94xOMyjKEb3UIlybgHo=
Received: by mail-qt1-f175.google.com with SMTP id k12so18674801qtf.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 07:49:16 -0800 (PST)
X-Gm-Message-State: AJcUukcUo8J79dz8uJrdWfb/dOid9JQxMjgq2SYF4rCWaP5JD5c1gchS
 i2YjXzTmMBc+mF0smFzZW6CPEV+/NF3EGN04zw==
X-Google-Smtp-Source: ALg8bN6aAd3dUU8SPZKh3Ue5xmkf45/Ph2BX3YSHn6GYh7OyqXrJ80LErM0PgHIMouF7sP1yus5diSXLSD4ZYYMcubc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr21234047qtd.257.1548690556001; 
 Mon, 28 Jan 2019 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
 <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
 <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
In-Reply-To: <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Jan 2019 09:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
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

On Mon, Jan 28, 2019 at 2:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Sun, Jan 27, 2019 at 4:00 AM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > > > This adds the build infrastructure for checking DT binding schema
> > > > documents and validating dts files using the binding schema.
> > > >
> > > > Check DT binding schema documents:
> > > > make dt_binding_check
> > > >
> > > > Build dts files and check using DT binding schema:
> > > > make dtbs_check
> > > >
> > > > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > > > use for validation. This makes it easier to find and fix errors
> > > > generated by a specific schema.
> > > >
> > > > Currently, the validation targets are separate from a normal build to
> > > > avoid a hard dependency on the external DT schema project and because
> > > > there are lots of warnings generated.
> > >
> > > Thanks, I'm giving this a try, and get errors like:
> > >
> > >       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
> > >     FATAL ERROR: No markers present in property 'cpu0' value
> > >
> > > and
> > >
> > >       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
> > >     FATAL ERROR: No markers present in property 'audio_clk_a' value
> > >
> > > Do you have a clue?
> >
> > That's really strange because those aren't even properties. Are other
> > dts files okay? This is the in tree dtc?
> >
> > The only time you should be missing markers is if you did a dts -> dts
> > -> dt.yaml.
>
> Found it: make dtbs_check doesn't play well with my local change to
> add symbols for DT overlays:

Now that makes sense.

>     --- a/scripts/Makefile.lib
>     +++ b/scripts/Makefile.lib
>     @@ -285,6 +285,10 @@ cmd_dt_S_dtb=
>              \
>      $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>             $(call if_changed,dt_S_dtb)
>
>     +ifeq ($(CONFIG_OF_OVERLAY),y)
>     +DTC_FLAGS += -@
>     +endif
>     +
>      quiet_cmd_dtc = DTC     $@
>      cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>             $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o
> $(dtc-tmp) $< ; \
>
> Do you see a way to handle that better?

We need to have the code that generates these properties to also add
markers. Or we could drop the __symbols__ nodes on YAML output. Or
ignore the option when doing YAML output.

> Apart from a few expected issues, I'm seeing one other strange message:
>
>     arch/arm/boot/dts/sh73a0-kzm9g.dt.yaml: interrupts: [[2, 4], [3,
> 4]] is too long
>
> This is the interrupts property in the adi,adxl345 node in
> arch/arm/boot/dts/sh73a0-kzm9g.dts.
> Apparently the check complains if more than one interrupt is listed here.
> Is this a known issue?

There are lots of warnings... I've gone thru and checked some to make
sure they are valid, but certainly not all. There's probably some
cases that are too strict too.

This one is because this device is listed in trivial-devices.yaml and
you can't have 2 interrupts for a trivial device (because you need to
define the interrupt order). Looks like we have a binding doc for it
too, so we should just remove it from trivial-devices.yaml.

There are lots of '... is too (long|short)' messages because of how
the dts file property values are bracketed. This used to not matter,
but is significant in the YAML output. I have a dtc patch to give
warnings on all these (and dtc will give source location).

Rob
