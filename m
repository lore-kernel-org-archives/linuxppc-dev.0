Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6780CC4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 18:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3E22255F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 18:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3E22255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwRK02gCRzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Dec 2020 05:16:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CwRGx3z7GzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2020 05:14:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.a=rsa-sha256
 header.s=dec2015msa header.b=Jg2yBT00; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CwRGw5Czdz8tY6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2020 05:14:16 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CwRGw2tKBz9sTK; Wed, 16 Dec 2020 05:14:16 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kernel.org (client-ip=202.248.20.74;
 helo=condef-09.nifty.com; envelope-from=masahiroy@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.a=rsa-sha256
 header.s=dec2015msa header.b=Jg2yBT00; 
 dkim-atps=neutral
X-Greylist: delayed 279 seconds by postgrey-1.36 at bilbo;
 Wed, 16 Dec 2020 05:14:15 AEDT
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
 by ozlabs.org (Postfix) with ESMTP id 4CwRGv5nkZz9sTv
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2020 05:14:15 +1100 (AEDT)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-09.nifty.com
 with ESMTP id 0BFI3s1k009010
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2020 03:03:54 +0900
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0BFI3EmR006592
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2020 03:03:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0BFI3EmR006592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1608055395;
 bh=hRbbP1gSckX8XPWd6JzuoVQqV6APPmMBfgaa1frUAsI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Jg2yBT00oUm5m+txsNC4H5cZTHBmxLZhs0XibWSR+Ona07yWk+z2QvCeuv1XSos49
 gcYXdSQmoRFpSd86htZUbKbCK9TwDe+5bHXXwLwKSzNAJiZXGI0HB0yi8TNeUOy3xw
 cbVvER+0kd7aOuSBV1k9eGkKaYUGtfZM6XkZlW0erb1cAH/2Ve8Iw4mjEl0UxJ20rl
 BJrT0V+3jLsLVJmw050Acy+w2RmfWsMs2w+FC3+HcwDwjBsSPY9ElcbRc/yMnyeODf
 +T3gYRPfi27I3u85gcvFLujtPj/YAiu6yetb/JfzGe8eikxfnkucGm4GYbhcChJpjQ
 Qb+qAwJD6cfzg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id x12so10977640plr.10
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2020 10:03:14 -0800 (PST)
X-Gm-Message-State: AOAM530lKN8hmzHppUaaYBwxmk2xDgpc97x2wZ8XsRItmtOFHhPdn0O0
 Y4T31ce4d6hu8B/hNyvvbXLG2Hodg4eVjPvl3hA=
X-Google-Smtp-Source: ABdhPJzKJDHfupgxVe+oQgfgP2vq+IK0siLu9U9Tj6Yj/09fsLpqXmjOkaGZgBftcx+lU2wwLFjaGrsOBA4Wsj4S4nY=
X-Received: by 2002:a17:90a:c910:: with SMTP id
 v16mr70004pjt.198.1608055393961; 
 Tue, 15 Dec 2020 10:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20201215032906.473460-1-mpe@ellerman.id.au>
In-Reply-To: <20201215032906.473460-1-mpe@ellerman.id.au>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 16 Dec 2020 03:02:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJcp=U9sKo9FVdkGNWXu7TGDL2zE-hFQymtfvUhY5+wA@mail.gmail.com>
Message-ID: <CAK7LNASJcp=U9sKo9FVdkGNWXu7TGDL2zE-hFQymtfvUhY5+wA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Fix build of dts/fsl
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 15, 2020 at 12:29 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The lkp robot reported that some configs fail to build, for example
> mpc85xx_smp_defconfig, with:
>
>   cc1: fatal error: opening output file arch/powerpc/boot/dts/fsl/.mpc8540ads.dtb.dts.tmp: No such file or directory
>
> This bisects to:
>   cc8a51ca6f05 ("kbuild: always create directories of targets")
>
> Although that commit claims to be about in-tree builds, it somehow
> breaks out-of-tree builds. But presumably it's just exposing a latent
> bug in our Makefiles.
>
> We can fix it by adding to targets for dts/fsl in the same way that we
> do for dts.
>
> Fixes: cc8a51ca6f05 ("kbuild: always create directories of targets")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/boot/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 68a7534454cd..c3e084cceaed 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -372,6 +372,8 @@ initrd-y := $(filter-out $(image-y), $(initrd-y))
>  targets        += $(image-y) $(initrd-y)
>  targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
>                 $(patsubst $(x).%, dts/%.dtb, $(filter $(x).%, $(image-y))))
> +targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
> +               $(patsubst $(x).%, dts/fsl/%.dtb, $(filter $(x).%, $(image-y))))
>
>  $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>
> --
> 2.25.1
>


Some freescale dts files are right under arch/powerpc/boot/dts/,
but some are in the fsl/ subdirectory.
I do not understand the policy.


If "fsl/" is a very special case,
I just thought we could add a new syntax, fslimage-y,
but I do not mind either way.


fslimage-$(CONFIG_MPC8540_ADS) += cuImage.mpc8540ads

targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
               $(patsubst $(x).%, dts/fsl/%.dtb, $(filter $(x).%,
$(fslimage-y))))


This Makefile is wrong over-all anyway.




-- 
Best Regards
Masahiro Yamada
