Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C3C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:01:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FF0207E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FF0207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p3X41Rb2zDqJg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:01:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.68; helo=mail-ua1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p3Tv2lV6zDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 19:59:31 +1100 (AEDT)
Received: by mail-ua1-f68.google.com with SMTP id t8so5337910uap.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 00:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MWXadM6v1/BrjCPM0KXC31G3yYpSsxrtCBcUvwcG1D8=;
 b=RMTrNzV2Iq2HBBSKOf4g3VyXtRE/GpBKLXhzSIGn0ICLmP3J8DXqeb7/i+FaGc6rgF
 rXhv4oAw3+N8aA6ruCX9iRBfUUKKip8OU9IYEsmt5c2DlYwiVeaVFKSOu+ttyDBp5LBD
 ZVimBzq22NCqe5hjYbrQm5O7gBLLfRJUxtmao0FvDUVx+HpwYOPsFl6SofkLGYTasxoa
 0nHsPYDJQxdakX2Wzm0BhjDaUZIrGYlAabj6yZFsIOf+Pw5pmSuOVx5gYxg5vhsb5NZV
 hTL/goWeow99dwMRuH2ick7cyVC+cYQwz5rXy7p53hvVzrmXoUR5+rltoXEwRydSXX5S
 8J+Q==
X-Gm-Message-State: AJcUukeibQhGCPcu78bKp4fUNXFgFKVvxeFeBZtnK29HQ0X5ZYhFZhp7
 U+LHLDlsjt++7xeC8T8KIl+1C7yoGUgXCM4pB2E=
X-Google-Smtp-Source: AHgI3IZCtxnlqEb43WDzFI4/ibLeSYAnaqLRjvAhFCOKh3TgiAmEZ4Zzoj0/nmPt+UCqpb2z7ffEYeRjE4eQi+VGVdo=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr4943200uaa.75.1548665968589; 
 Mon, 28 Jan 2019 00:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
 <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
In-Reply-To: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 09:59:16 +0100
Message-ID: <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
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

Hi Rob,

On Sun, Jan 27, 2019 at 4:00 AM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > > This adds the build infrastructure for checking DT binding schema
> > > documents and validating dts files using the binding schema.
> > >
> > > Check DT binding schema documents:
> > > make dt_binding_check
> > >
> > > Build dts files and check using DT binding schema:
> > > make dtbs_check
> > >
> > > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > > use for validation. This makes it easier to find and fix errors
> > > generated by a specific schema.
> > >
> > > Currently, the validation targets are separate from a normal build to
> > > avoid a hard dependency on the external DT schema project and because
> > > there are lots of warnings generated.
> >
> > Thanks, I'm giving this a try, and get errors like:
> >
> >       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
> >     FATAL ERROR: No markers present in property 'cpu0' value
> >
> > and
> >
> >       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
> >     FATAL ERROR: No markers present in property 'audio_clk_a' value
> >
> > Do you have a clue?
>
> That's really strange because those aren't even properties. Are other
> dts files okay? This is the in tree dtc?
>
> The only time you should be missing markers is if you did a dts -> dts
> -> dt.yaml.

Found it: make dtbs_check doesn't play well with my local change to
add symbols for DT overlays:

    --- a/scripts/Makefile.lib
    +++ b/scripts/Makefile.lib
    @@ -285,6 +285,10 @@ cmd_dt_S_dtb=
             \
     $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
            $(call if_changed,dt_S_dtb)

    +ifeq ($(CONFIG_OF_OVERLAY),y)
    +DTC_FLAGS += -@
    +endif
    +
     quiet_cmd_dtc = DTC     $@
     cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
            $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o
$(dtc-tmp) $< ; \

Do you see a way to handle that better?

Apart from a few expected issues, I'm seeing one other strange message:

    arch/arm/boot/dts/sh73a0-kzm9g.dt.yaml: interrupts: [[2, 4], [3,
4]] is too long

This is the interrupts property in the adi,adxl345 node in
arch/arm/boot/dts/sh73a0-kzm9g.dts.
Apparently the check complains if more than one interrupt is listed here.
Is this a known issue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
