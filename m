Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31921C4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:13:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5830D2075E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xX3/HJVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5830D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SP7v5xTWzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="xX3/HJVi"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SP5z4c6JzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:11:18 +1100 (AEDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x2P6B3L2021923
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:11:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2P6B3L2021923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553494264;
 bh=M5yB2IL6rUVfb6KdDylKlG225AGtoW93SAI13OU0scI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xX3/HJVi67ZE7O+YgUqY300T00eUjNmJmXP8bCXfoQHa5Air4JM6GFt/6oBaczpj/
 u11TINIB7G2truNMRO5GcWSbfQSL1zf1IeAED2pmVCAzEPfwkett3y4nd6iZ8G0rHD
 gDwKNHBAnpvcqHz+cUlBgFdd2Dt3ZqYf/800h8o4bipHysPCxBBgReoo84esXAs2tE
 v3YifwN1shxb3mR95hOrNLP5oiGOjTO08WNyZOUo6iwL49DbeCPGekShiCb62o+ahl
 JdPg0gXqHCc2MEe1FgcA9Dnz0Zr7qfil5TTERII2lmrZR2L0Qb27qhVxDYEF1d632b
 o0O0IBkTWJ30Q==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id k64so1699573vke.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 23:11:04 -0700 (PDT)
X-Gm-Message-State: APjAAAXXzYxQRvKwy1eaZCPTKnNmhrJi9yOLLrmKzyEEQb2Y+tK0FNTV
 9FolkHKsuLaBQrCfO4Hx6+LFMqKba9sxZQFJC2M=
X-Google-Smtp-Source: APXvYqz8qUhdfpRv8vBpRrajP0ICg/lHdRAAg6gG/ToNJOJ/LPtsBzM8huHn1TCODJl7fUVHytYK1YSBZrnQ8QJK2r0=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr13352129vkd.84.1553494263012; 
 Sun, 24 Mar 2019 23:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
In-Reply-To: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:10:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
Message-ID: <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,




On Wed, Mar 20, 2019 at 10:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I've added your patch to my randconfig test setup and will let you
> > know if I see anything noticeable. I'm currently testing clang-arm32,
> > clang-arm64 and gcc-x86.
>
> This is the only additional bug that has come up so far:
>
> `.exit.text' referenced in section `.alt.smp.init' of
> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
>
> diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> index 201100226301..84b12e33104d 100644
> --- a/arch/arm/kernel/atags.h
> +++ b/arch/arm/kernel/atags.h
> @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
>  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
>         unsigned int machine_nr);
>  #else
> -static inline const struct machine_desc *
> +static __always_inline const struct machine_desc *
>  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
>  {
>         early_print("no ATAGS support: can't continue\n");
>


I do not know why to reproduce it,
but is "__init __noreturn" more sensible than
"__always_inline" here?


-- 
Best Regards
Masahiro Yamada
