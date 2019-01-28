Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC5DC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF3F21741
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF3F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pDX362XnzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 02:46:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pDSf5YhzzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 02:44:02 +1100 (AEDT)
Received: by mail-vs1-f66.google.com with SMTP id h78so9986489vsi.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 07:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x2wa+K5YNPI9+zY5xomP72xSduPXvimTTHXp1XsjO7E=;
 b=joTn14hVgW+1HUQs7l8Tz2gPtwqcbNbU21htie0UUmIvRhD1d4qGwEhPjRAbuvfL3O
 b3axS7ZEcTXGV8T8DMj0DF3WzWiZ/lTC+GvolCMKTB30aPY31bT4GId6i8Kiz/odzOfB
 b6eOtC+lxm9uwuRgMYvXUCUVQnxEfdt7Tiii64xypBl9VAtXdGorpgc7WcqCqYovyKoH
 Ifhq/AMWmK4ZAMO/4dbatV+4SGJXfuQLjcLXHxIKVXhKyEqDWJH6spJJ7da887GcKJlt
 a1DPTFA6YD87lktPA7UA4pkvBzz2TSKAXVbSyFQPuUMyRVGmGfhZ/mZyg9bPoqC1XBHV
 76bA==
X-Gm-Message-State: AHQUAuZRGLzwa6Js9yf+9u9VZssdfOTE3CX7Xrv2bAAKjxVC57zUaVlQ
 ppbrJnaVezUXGzKcsaQSES/xc+eqGH0voIPYc3E=
X-Google-Smtp-Source: AHgI3IaCNqFqxYF5jcFRcCRr3F8u3p45e8vOxEGJ+OqOd1kuIKX0RovOS/tgzMJSBqB2qpmVtJ11sRlLqYSVlIaIAgE=
X-Received: by 2002:a67:c202:: with SMTP id i2mr148070vsj.11.1548690240249;
 Mon, 28 Jan 2019 07:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
 <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
 <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
In-Reply-To: <CAL_JsqKG8d+yONY2ikeiCaORYBfWhLe_rAsir11R8zRAD84MmA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 16:43:47 +0100
Message-ID: <CAMuHMdWy2D-keyOuKtgCLe0_76qR74Jk7Aa=_FzxvEG7rfKpCA@mail.gmail.com>
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

On Mon, Jan 28, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Jan 28, 2019 at 3:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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

> > BTW, what are the CONFIG dependencies for this to work?
> > E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:
>
> I generally use allmodconfig which enables building all DTs.
>
> Yes, there's a dependency on CONFIG_DTC which isn't always enabled
> with CONFIG_OF. Maybe it should be. The only other solutions I've

Oh, didn't think of CONFIG_DTC.

> thought of are either always build dtc or make the targets conditional
> on CONFIG_DTC. The latter would only change the error message.

Making the target conditional may make it more obvious to the user
what's going on. Cfr. "make modules_install" giving a nice explanation
when CONFIG_MODULES=n.

Thanks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
