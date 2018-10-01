Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20FC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 07:55:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F8020645
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 07:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F8020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nvhh297JzF37r
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 17:55:16 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Nvfh4JZ5zF35w
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 17:53:31 +1000 (AEST)
Received: by mail-vs1-f66.google.com with SMTP id w16-v6so6929105vso.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 00:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Fse7KpQK4D3pkd1OwWmBP3xPIZzYRxGU9L0taz7PM74=;
 b=YyqoswRYoNu6ZKU8pj8lj4EoSCXJcu6RZXZ4u0qNDX2fi0OaxU7ECaMiHQk+VPNmsh
 5uoxiyjtCdLukNGBhMZ6veUemUgvmFmxnEePBawkyH+aq+ve52fo8iAXCjSfRTd9qXFQ
 6X1EftNiaNeES7ariMn7STbk+A+4kt7tkw7EnaL2kmzW5Fw/l2Xto6kxDpklbYVM/kHo
 xcqXQwUBXQlcUWABRSV2KFVlDuyzRsn1Saz3RXF073EQZo5vxgSlLoIpquaorXZANxot
 TCLptwEHsKcQ5QRNuF9iea6zUcdJ1mi1h1JW0Qwzt4JkIaDPp2+hmCKYSnoXD32F/viv
 +3Fw==
X-Gm-Message-State: ABuFfoinrEeZtptLD1LIeCOKuGaIhnxCP3hlVglhrDLG0duMTOAw4d+N
 JIhlj5PgkNjqiPzhtBRoNIUt109zIo/pwE3YO+Y=
X-Google-Smtp-Source: ACcGV609Lnu4FrPRGnyP3xS+u5v5KhwZ0H6OXDWYS6T9uI8bo8Xc8VsCR1ipQNkeRLUb/myWD7qYgFOZKy5VkxSRMSA=
X-Received: by 2002:a67:68ce:: with SMTP id
 d197-v6mr3626847vsc.152.1538380409478; 
 Mon, 01 Oct 2018 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
 <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
In-Reply-To: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Oct 2018 09:53:15 +0200
Message-ID: <CAMuHMdW_+PNZrh5JXo8MxVwg3YSZL7bszMcUJjCqMFfBz8HDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To: Rob Herring <robh@kernel.org>
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
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, ley.foon.tan@intel.com,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Michal Marek <michal.lkml@markovi.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 8:42 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 28, 2018 at 12:21 PM Andreas F=C3=A4rber <afaerber@suse.de> w=
rote:
> > Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >> Even x86 can enable OF and OF_UNITTEST.
> > >>
> > >> Another solution might be,
> > >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> > >>
> > >> This is actually what ACPI does.
> > >>
> > >> menuconfig ACPI
> > >>         bool "ACPI (Advanced Configuration and Power Interface) Supp=
ort"
> > >>         depends on ARCH_SUPPORTS_ACPI
> > >>          ...
> > >
> > > ACPI is a real platform feature, as it depends on firmware.
> > >
> > > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platf=
orm,
> > > even if it has ACPI ;-)
> >
> > How would loading a DT overlay work on an ACPI platform? I.e., what
> > would it overlay against and how to practically load such a file?
>
> The DT unittests do just that. I run them on x86 and UM builds. In
> this case, the loading source is built-in.
>
> > I wonder whether that could be helpful for USB devices and serdev...
>
> How to load the overlays is pretty orthogonal to the issues to be
> solved here. It would certainly be possible to move forward with
> prototyping this and just have the overlay built-in. It may not even
> need to be an overlay if we can support multiple root nodes.

You indeed need to refer to some anchors for most use cases, although a
simple MMIO device could just be anchored to the root node.

Topologies hanging off a USB device would be my first use case, too,
for serdev, or for e.g. the mcp2210 USB-SPI bridge.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
