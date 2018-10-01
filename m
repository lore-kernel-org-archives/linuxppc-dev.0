Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2AEC64EB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 20:37:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4209A208AE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 20:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KuHSjyCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4209A208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PDcT2QDPzF3F1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="KuHSjyCG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="KuHSjyCG"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PDYq2DRGzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 06:35:26 +1000 (AEST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id w91KYtXX002332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2018 05:34:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w91KYtXX002332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1538426096;
 bh=crINlLoca/1Qw0ty2P7MMy0I1W6bm6wuQCAcy4YHf6U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KuHSjyCGhfzXhhj6+gaC/vT05CXZovTISWav+Lz4kH5tVF+kPHoio3M0OZWkzhklE
 ea2IxzyRcGFFsXDYj0fK+tpTU8qeHRg8JXsJ4oOkcq5p1fv27Cee4F1GFwtUwwX7ma
 tspzF+yE7FTAmb5MiYPumqkYoQ4EcFA5OpU5dyr95qt76XL9Yfnxtm8ZPGAJorOvVY
 q+PbXH8J1CDPVoGjXTpPj5Q/h3oEdRKIPD7ad/Y8hKIJ3Mmsw5c5wUIeOLwWvLAIL6
 sJaddmaTyjai1Pd6LMYkzfTLZF4OrtRweOTiCpnvqbDTMQ89WQB278DNo4+/Iss8qf
 SHxmmeSDgB2sg==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id y128-v6so1473794vky.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 13:34:55 -0700 (PDT)
X-Gm-Message-State: ABuFfojno0KfV7nQmD/Tn+s+Y3DoLNH+QbbPUyGUaM5+rvspUiDitVrf
 ie6ALSw6+5PFh+HSYweJZB/51NBOF82PRfOI8to=
X-Google-Smtp-Source: ACcGV60Pd9WWEg1hsoyzigccquA3CNUAcmf6KrjaELgDyi7k5BYGyye3aWLhUZj0Tuhnyhs/psh9gI9MnOFqGKP5GFk=
X-Received: by 2002:a1f:8f06:: with SMTP id r6-v6mr4916628vkd.0.1538426094648; 
 Mon, 01 Oct 2018 13:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181001152531.3385-1-robh@kernel.org>
 <20181001152531.3385-7-robh@kernel.org>
In-Reply-To: <20181001152531.3385-7-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 2 Oct 2018 05:34:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAG1pAOMbnrFd5VbmUfcN5337tcGdeFrRo92rPWkVWAg@mail.gmail.com>
Message-ID: <CAK7LNAQAG1pAOMbnrFd5VbmUfcN5337tcGdeFrRo92rPWkVWAg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] kbuild: consolidate Devicetree dtb build rules
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

2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 0:26 Rob Herring <robh@kernel=
.org>:
>
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please change this to

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-mips@linux-mips.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>  - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather th=
an
>    CONFIG_OF_EARLY_FLATTREE
>  - Fix install path missing kernel version for dtbs_install
>  - Fix "make CONFIG_OF_ALL_DTBS=3Dy" for arches like ARM which selectivel=
y
>    enable CONFIG_OF (and therefore dtc)




--=20
Best Regards
Masahiro Yamada
