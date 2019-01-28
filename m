Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A1C282CB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:45:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C8721736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C8721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p4Vm4WhmzDqDZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:45:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.65; helo=mail-vs1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p4Sq2ds7zDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 20:43:39 +1100 (AEDT)
Received: by mail-vs1-f65.google.com with SMTP id e7so9359651vsc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 01:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I7v2CVhzSApSnN73x2sP5/c9efgR0kyTQcHVcX3dt8I=;
 b=Z//eIIznTQ/H2gg6CCzVcQWLqBhqF21zlxkR6uy/xvg+BshHYN7KkxNy3ybFCki+YM
 V+7GgbgtY5kYJNWHkk8t/qQuyqOXXcfrrxszqz38VfoWlhxw6lY2bsTqYeyqt8wQxTC6
 +sPCzceWZUxDbvnANz9oeQLGlOM+grxPwUatRapJSeFGpwMg2rAZ1R1XRO0qZy7EzVgq
 1gQVy0bXIueBAFUkY88KkTGggY+3b4EIZ2USORop7vey9639bRk1hSrqKx/6kYwJWMNy
 E/IrtriWzoVGTaq9Xszh821HqhQTO64PWXjJ9+vR3DNKGrdL2Lp34iBGsuqaezM3YKde
 g+7w==
X-Gm-Message-State: AJcUukfP7u/ptZic2Rh6WAWNnz7tu/yO7ReRpCD6SFm2xq77t6n6THtM
 6VTmkvs3BmtCEnYdvNra0cEoY3nyOUABJQ1E6rY=
X-Google-Smtp-Source: ALg8bN762N4hfLRHQtO9IsXp0QGWHGsVqfaF50zLAbLpKMuStIzjLEcZvyXnYM8xWjxpj+QEIGLDs/D7L8pc0VRBDvk=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr8815146vsm.152.1548668616811; 
 Mon, 28 Jan 2019 01:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
In-Reply-To: <20181211202406.27721-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 10:43:25 +0100
Message-ID: <CAMuHMdUdGvBUX7EsOrwJM4_LzR_Pe2exJ1Pfo48Vt5_scrdy0w@mail.gmail.com>
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

On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> This adds the build infrastructure for checking DT binding schema
> documents and validating dts files using the binding schema.
>
> Check DT binding schema documents:
> make dt_binding_check
>
> Build dts files and check using DT binding schema:
> make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Currently, the validation targets are separate from a normal build to
> avoid a hard dependency on the external DT schema project and because
> there are lots of warnings generated.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-doc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

BTW, what are the CONFIG dependencies for this to work?
E.g. defconfig on x86_64 fails, even after enabling CONFIG_OF:

$ make dt_binding_check
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  CHKDT   Documentation/devicetree/bindings/arm/primecell.yaml
  ...
  CHKDT   Documentation/devicetree/bindings/trivial-devices.yaml
make[1]: *** No rule to make target
'Documentation/devicetree/bindings/arm/primecell.example.dtb', needed
by '__build'.  Stop.

Obviously it does work for arm/arm64.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
