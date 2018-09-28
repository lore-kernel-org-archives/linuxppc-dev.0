Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A10C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:55:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9E2206B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5sGWtOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9E2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MLFL3KVtzF3JN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 04:44:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p5sGWtOV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="p5sGWtOV"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MLBR0FZLzF3JD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 04:42:07 +1000 (AEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0351E2073F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538160125;
 bh=ucBQEM+GHr4wAfjxvfsvuLdN+zja3rG4l1rL7brbDIY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=p5sGWtOVBYzRX3YeiYkYHsnI08BN0g8wERLt6VVK8LZWF4/Y3wkdziAgpjxdphtVB
 iBbQMg7K8EUeBhsEFrRVJnV2rHyZcD2wh2G0b+JynCnXXnPoFm7N7T/maVa943FDRJ
 WpA4cLMKkyCu0xaThXZdCdYPgTYXYoms8w8LgLRw=
Received: by mail-qk1-f180.google.com with SMTP id q20-v6so4441308qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 11:42:04 -0700 (PDT)
X-Gm-Message-State: ABuFfoiM2Sjj9+/T8twP2HzQWimI+JWH1M1ZZKDLCvG9O6zc7586NQUZ
 nIBWB/RZPmC9heiBDpxGVjVcQ3omfLOWn/T1VQ==
X-Google-Smtp-Source: ACcGV621ZkVMH2JDxjibLp+pDwz3KJn7xglLxR2Ca15PWxniRLjeSUc+Io2a4Km0KoyI6YxAzRAeW+wnTH0sratRei4=
X-Received: by 2002:a37:ddcf:: with SMTP id
 u76-v6mr12468517qku.184.1538160123207; 
 Fri, 28 Sep 2018 11:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
In-Reply-To: <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Sep 2018 13:41:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
Message-ID: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 devicetree@vger.kernel.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Michal Marek <michal.lkml@markovi.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 12:21 PM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Hi Geert,
>
> Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> Even x86 can enable OF and OF_UNITTEST.
> >>
> >> Another solution might be,
> >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> >>
> >> This is actually what ACPI does.
> >>
> >> menuconfig ACPI
> >>         bool "ACPI (Advanced Configuration and Power Interface) Suppor=
t"
> >>         depends on ARCH_SUPPORTS_ACPI
> >>          ...
> >
> > ACPI is a real platform feature, as it depends on firmware.
> >
> > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platfor=
m,
> > even if it has ACPI ;-)
>
> How would loading a DT overlay work on an ACPI platform? I.e., what
> would it overlay against and how to practically load such a file?

The DT unittests do just that. I run them on x86 and UM builds. In
this case, the loading source is built-in.

> I wonder whether that could be helpful for USB devices and serdev...

How to load the overlays is pretty orthogonal to the issues to be
solved here. It would certainly be possible to move forward with
prototyping this and just have the overlay built-in. It may not even
need to be an overlay if we can support multiple root nodes.

Rob
