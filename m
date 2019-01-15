Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A825C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:00:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AD820656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y6LjAJFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AD820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fD6j4v1LzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:00:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="y6LjAJFc"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fD4p0vfnzDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 01:59:05 +1100 (AEDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x0FEweje019099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 23:58:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0FEweje019099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547564321;
 bh=8UDmBSl+gjzoSWclaFcvO3xDYwUdpY9ay/TXvDz5OEM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=y6LjAJFcPAOXNvCm5WIxLGO/FoW3ZcPy2YXBYrMXY5HxNMwPZUaxpAHXTyy5Dud9j
 j//GPp8jtJZxZoQCvWz0CeneAlXC9cljgtWhSafPY9punWcOc70oLO1mkbElO3k/Wk
 iCzLasb5Ssxy3jZjvA8uzTtQFNtzXOt6HwYGtBAXgFKkdA2Z56HbuB1eKm9QaK89o2
 sKy5mODeQGlhnkE69rFtpVe58MnQSmg+nRR0skpg8VTvt9D8s0db9nLRG/QMwvJuKI
 C5ceXamv/fzCcoF9rH9QE/Ykgg/ZoqcXxhWYh/l90JbOqJ4Xe/JBcrQJDNg4lY+j/G
 Kfe+C/rfAzArA==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id h128so644517vkg.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 06:58:40 -0800 (PST)
X-Gm-Message-State: AJcUukfk634bSdXCU8VFkWkDCa6CmKO/j2rbf8QC7rgHXL1FhCtB5u6c
 2G2Gj9AcSMYu2EAHf4NHlH9XkCdJjo2RshkkNkQ=
X-Google-Smtp-Source: ALg8bN6AhjSqVLCYdHcGvvdOgCSQLWIaZZAKNEz68MSaIKAyf8HD/9Czf7kruZpGeJOiOC6pBlub1zAcmMUN1ZRbips=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr1640605vkb.34.1547564319674; 
 Tue, 15 Jan 2019 06:58:39 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUsz5_6JqATZ4sAdUOWfr5sgeTjo8q7ArPL6nTmYK818E4Q@mail.gmail.com>
In-Reply-To: <CA+7wUsz5_6JqATZ4sAdUOWfr5sgeTjo8q7ArPL6nTmYK818E4Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 15 Jan 2019 23:58:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+YAfHQkSWDEnuLv869VTy3iaXoYpmZSOBbPrVAaF0Cw@mail.gmail.com>
Message-ID: <CAK7LNAS+YAfHQkSWDEnuLv869VTy3iaXoYpmZSOBbPrVAaF0Cw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module
 build
To: Mathieu Malaterre <malat@debian.org>
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
 LKML <linux-kernel@vger.kernel.org>,
 "linux-stable # v4 . 20" <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 7:35 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Tue, Jan 15, 2019 at 8:22 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> > caused kernel panic on PowerPC if an external module is used with
> > CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> > for the external module build.
> >
> > Commit e07db28eea38 ("kbuild: fix single target build for external
> > module") turned it into a build error because the 'prepare' target is
> > now executed but the 'prepare0' target is missing for the external
> > module build.
> >
> > External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> > also broken in the same way.
> >
> > Move 'PHONY += prepare0' to the common place. Make is fine with missing
> > rule for phony targets.
> >
> > I minimize the change so it can be easily backported to 4.20.x
> >
> > To fix v4.20 for external modules of PowerPC, please backport
> > e07db28eea38 ("kbuild: fix single target build for external module"),
> > and then this commit.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> > Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> > Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> > Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> > Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> > Cc: linux-stable <stable@vger.kernel.org> # v4.20
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 499b968..789b332 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -955,6 +955,7 @@ ifdef CONFIG_STACK_VALIDATION
> >    endif
> >  endif
> >
> > +PHONY += prepare0
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> >  core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> > @@ -1061,8 +1062,7 @@ scripts: scripts_basic scripts_dtc
> >  # archprepare is used in arch Makefiles and when processed asm symlink,
> >  # version.h and scripts_basic is processed / created.
> >
> > -# Listed in dependency order
>
> The above comment may need to be tweaked a bit

The comment is wrong irrespective of this patch,
and less important.

Do you have any suggestion how to tweak it?


> > -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> > +PHONY += prepare archprepare prepare1 prepare2 prepare3
> >
> >  # prepare3 is used to check if we are building in a separate output directory,
> >  # and if so do:
> > --
> > 2.7.4
> >



-- 
Best Regards
Masahiro Yamada
