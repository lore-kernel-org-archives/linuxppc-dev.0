Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BADC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 05:52:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F5E206B2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 05:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="X2MVzJlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F5E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nryv44R5zF35T
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:52:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="X2MVzJlJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="X2MVzJlJ"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NrwJ10CyzF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 15:50:07 +1000 (AEST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w915nhCU018862
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 14:49:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w915nhCU018862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1538372984;
 bh=Qnw6nfv2f5Qfhbl6CcKxxBJpYuyhxpkGAFyiVgJV+BE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=X2MVzJlJn2/a1+FprtsEbUVyFee8l4lY0RG8UJgIjEom/1NzC6EUIYq/RS6lHis5c
 jFVdFzePf8tg5WTjx8+xQ2BReCX48uMSMh4ddvoFCJqDjQfxYk3C3n/5zxXkYOMkNp
 CDqz8D4xZUtp2Ii1hmH9UoUMyoMzxh8kXa4MulNqGwTQwblQ/dlHGwTPHYmfQb6Uqq
 dJmpzkfdKV7IzNdeODt9aAzspuAT45rd+0cTC36a+vps8z5nJLm0L6SvsxlQidPoYJ
 RuVXLMikOdN1C/82GeDy0hFBuP3sme/07u2XxBSJdd9UeKoVYFP5jZxFyi+IvJCxl8
 FqaOeD62HAiUQ==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id w193-v6so2701272vke.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 22:49:43 -0700 (PDT)
X-Gm-Message-State: ABuFfojcMQz8mpyz3mi53ZRZtstZLZayTkxGZGLg0CxXoSUjY1T9LqQF
 s8uaBUCM7icOjmfq+ktJCwuGU+Xe+/CRGFwsfyo=
X-Google-Smtp-Source: ACcGV62iRmxiHkB3QMTJljzoGoephgbyQk5RidQoVpOMzclvUjQgLINmFzCENJujD3tHwm/uyOI4PiPdrnFhgJZdJcU=
X-Received: by 2002:a1f:28e:: with SMTP id 136-v6mr3353329vkc.34.1538372982761; 
 Sun, 30 Sep 2018 22:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus>
In-Reply-To: <20180928154150.GA25013@bogus>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 1 Oct 2018 14:49:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Michal Marek <michal.lkml@markovi.net>, Vineet Gupta <vgupta@synopsys.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,


2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 0:43 Rob Herring <robh@kernel=
.org>:

> +#
> -------------------------------------------------------------------------=
--
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree :=3D arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifneq ($(dtstree),)
> +
> +%.dtb : scripts_dtc

%.dtb: prepare3 prepare


because we need to make sure KERNELRELEASE
is correctly defined before dtbs_install happens.


> +       $(Q)$(MAKE) $(build)=3D$(dtstree) $(dtstree)/$@
> +
> +PHONY +=3D dtbs dtbs_install
> +dtbs: scripts_dtc


dtbs: prepare3 scripts_dtc



> +       $(Q)$(MAKE) $(build)=3D$(dtstree)
> +
> +dtbs_install: dtbs


Please do not have dtbs_install to depend on dtbs.

No install targets should ever trigger building anything
in the source tree.


For the background, see the commit log of
19514fc665ffbce624785f76ee7ad0ea6378a527




> +       $(Q)$(MAKE) $(dtbinst)=3D$(dtstree)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +all: dtbs
> +endif
> +
> +endif
> +
> +PHONY +=3D scripts_dtc
> +scripts_dtc: scripts_basic
> +       $(Q)$(MAKE) $(build)=3Dscripts/dtc
> +
>  #
> -------------------------------------------------------------------------=
--
>  # Modules
>


--=20
Best Regards
Masahiro Yamada
