Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:40:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2589920675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UeiglUNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2589920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fqct1xTFzDqnD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:40:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="UeiglUNB"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fqVJ75gDzDqSx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:34:48 +1100 (AEDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x0GEYC0C021654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 23:34:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0GEYC0C021654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547649253;
 bh=LeZvenWAyFhQpFAc6vVeaym8dil5fWgTRHvB0UI5JKo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UeiglUNBUHfrtsie89ag31RuIsIVtxplGQ6nRZTeEkq6WOihkzHEX8Sg/cmvqFl72
 /ofxuZfbR66yI6pMmPekiRmIF+3U56Dr6uXuAqc6XqMDZLc4C8tj1FZt4sdXN0lG2F
 VgEGJ3QMEAr3zH51VfE/1i7GyjJNLtJ6+aFeQcyk991HP0EfT8Hzlt8ziHPkYxfOg5
 eXW0FrYXqQX3e2Bp4FGyDtoneycWW8GM65HfF3jgiiJQAdmP2G75VJ70/gsQKOO4Ha
 J+e7Cq+N9BsLx3bnCXVOxGzlQzI+ImfL0pnxdP+Cbr6Nq4Gc/QprbzCeyIkXG+4bzf
 lndOFGNoS3c8Q==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id s184so1457564vkd.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 06:34:13 -0800 (PST)
X-Gm-Message-State: AJcUukfzOWNCGT9Hz9uhELJ1mDxAxdydHz142XGvQnkAFOu7k5+NNZ1f
 eFWRgErH8STPTtEEi2x1nVGEtLp8CHgIXfbHc/s=
X-Google-Smtp-Source: ALg8bN48zfMaV+AYClsEiSt7txS7WccQZ9Pp9d2+4k0CSh3ouq2pbZgy1dZWwsRLrOuyeCFnNqfUwZHIK9K/ocgjusw=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr3627366vkd.64.1547649251970; 
 Wed, 16 Jan 2019 06:34:11 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 16 Jan 2019 23:33:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Message-ID: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module
 build
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Samuel Holland <samuel@sholland.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-stable # v4 . 20" <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 5:07 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> caused kernel panic on PowerPC if an external module is used with
> CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> for the external module build.
>
> Commit e07db28eea38 ("kbuild: fix single target build for external
> module") turned it into a build error because the 'prepare' target is
> now executed but the 'prepare0' target is missing for the external
> module build.
>
> External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> also broken in the same way.
>
> Move 'PHONY += prepare0' to the common place. Make is fine with missing
> rule for phony targets.
>
> I minimize the change so it can be easily backported to 4.20.x
>
> To fix v4.20 for external modules of PowerPC, please backport
> e07db28eea38 ("kbuild: fix single target build for external module"),
> and then this commit.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20
> Reported-by: Samuel Holland <samuel@sholland.org>
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.


>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 499b968..789b332 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -955,6 +955,7 @@ ifdef CONFIG_STACK_VALIDATION
>    endif
>  endif
>
> +PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
>  core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> @@ -1061,8 +1062,7 @@ scripts: scripts_basic scripts_dtc
>  # archprepare is used in arch Makefiles and when processed asm symlink,
>  # version.h and scripts_basic is processed / created.
>
> -# Listed in dependency order
> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
