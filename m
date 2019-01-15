Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAFC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 10:35:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E27020651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 10:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f6DB739rzDqfy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 21:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f6BM2CpjzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 21:33:31 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id t204so1720719oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 02:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UjacMVaKe7gKCUAo5GYMDTY1231tcICtfSoeSrw3PH0=;
 b=ofxEYCEJ41T69pJmLM/PvIiSlkCXL7IdcdhG8ocF7VbYBTB+XDf0Q1eZ8mcksnfQzn
 dahDlkSfv7/9Ml5VUxYPxH80CHi74oXyyS5yOJJ4+g3q7GhOxLwjuWrtIrx8rGAzBawg
 kpzii7XyIM1qhdjqAD0hZh7FEjFEmTT6kFavCY/n8OWjrDDspvlCc12b7uX7++Yr6vC1
 uiXDp9QbtQ2oaIU9zYI9V0xzSL0WOrAaKsbZfHF55H67fiz2jvZacR5VG/IRR2qp01BD
 tOF2+/TIE62awTR87+Pf+xXhALUgCAJI7Ayx7s8lbVJVztoKw16whGFEs1KH4ExJ2dIY
 DwLA==
X-Gm-Message-State: AJcUukfUwKSCS7Ei344f4E+ASwPumcdWGEpQo6n3HMeVFl0go7pBOdDg
 NA9hSOccrkkR+XxVYYL7EuFrBdKa7xf+9JV1WaQ=
X-Google-Smtp-Source: ALg8bN6JxhFQoAr6VPF54yG1pQWp5AWxTItpBpCBkSmpngvu70LaQ306RU8GndAFtLkgtFiADxKBn6Dk+9gDtuUaBwA=
X-Received: by 2002:aca:cf54:: with SMTP id f81mr1691651oig.16.1547548408672; 
 Tue, 15 Jan 2019 02:33:28 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 15 Jan 2019 11:33:15 +0100
Message-ID: <CA+7wUsz5_6JqATZ4sAdUOWfr5sgeTjo8q7ArPL6nTmYK818E4Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module
 build
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Tue, Jan 15, 2019 at 8:22 AM Masahiro Yamada
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
>
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

The above comment may need to be tweaked a bit

> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> --
> 2.7.4
>
