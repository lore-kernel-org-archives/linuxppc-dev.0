Return-Path: <SRS0=eZMg=XG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF0C49ED6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 20:57:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EA22085B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O4HLFzuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EA22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46TDkB35h8zF3wy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 06:57:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="O4HLFzuL"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46TDhR1bQ7zF3rW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2019 06:56:06 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id t1so10682655plq.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2019 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hECyZnP2/Wb3+Wh7idFWgoa4zJGDS5Ymb1IJNhVMGsM=;
 b=O4HLFzuLvgRtaOYD+41+U97SXnxP09FStmC8vuSWi1/3Md/asn73q1z3atC6YBnIp0
 U0GJtUwMWu0aPVl70WI9gq1j3E3MWR/ca+WwxESdzEEcx2PiOYkgMHz8y/ZMfAikCgYc
 NdfD+1ztePAqXEIyFab7iXjCt7OUz+sJebpixEcD32vSZmCidk3dPa5OBoORsYy1Rsus
 +OTzjB8hgDGuPSUh3FEFQT+GonA4RRpOgCc1rNYQXkj/DXE8DKCEJwwpkJd2KwDcgxqY
 6kneExfgwdKVtAseOKzKSZFla1DbA8hUPPIRE78vmXEyVY+R8RD29XvNewSBrVrvf5b5
 MEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hECyZnP2/Wb3+Wh7idFWgoa4zJGDS5Ymb1IJNhVMGsM=;
 b=qRLSdFO5mUevhcmiMpdy8xV+6tEfKB0wsNzPLeddBqF+xjEqNaba2ayF70xtRZXb13
 CilonxdeCLL2JDcU6X74W3pTvXelQtUmTz9mWCKyD4zd9cqW9l7WGqaQ1FLVaLl87Kur
 pSITfNWnXOoffZp+fhKSln+Fr3Hlpd8fVqMOvW8rPxT/kqsx73xiU/Zb0uwwEKW8Yu62
 f1B8zTOPEILxHMCrRuWCAxcwRi2sYhsFfS01krOSMQRpOC05C5QvfW7oFRe1eBD2PTTO
 GKdobHkoj3jwD+bKO/YBXpPlLMaiG40OFk2SD2F5fF6Sly6c/RZkbAA1hPcO6ZaganU9
 xzSQ==
X-Gm-Message-State: APjAAAVDTFJmpeNwOKB6raNHSPGwcRY3AfU6QsJ2NPKIjeJ7TAYCJXoi
 pkQdHIEQ1yn9gJsQ/ZX+QnIl5vE4gH88uuphpiI0ag==
X-Google-Smtp-Source: APXvYqygXwwB3HrJAYGIzgZFaTxeGs7BobXjt9YTik0bsJO7DbpauDgLEBayH/87rd+PF6LMKAqF7jHu/7L1+MMzZfc=
X-Received: by 2002:a17:902:7296:: with SMTP id
 d22mr39066409pll.179.1568235363028; 
 Wed, 11 Sep 2019 13:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20190911182049.77853-3-natechancellor@gmail.com>
In-Reply-To: <20190911182049.77853-3-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 11 Sep 2019 13:55:52 -0700
Message-ID: <CAKwvOdn2vz0XGDQrbBiGFAp6vvBzmOgUH3GLkgGY4UAWLhhZUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] powerpc: Avoid clang warnings around setjmp and
 longjmp
To: Nathan Chancellor <natechancellor@gmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 11, 2019 at 11:21 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
> setjmp is used") disabled -Wbuiltin-requires-header because of a warning
> about the setjmp and longjmp declarations.
>
> r367387 in clang added another diagnostic around this, complaining that
> there is no jmp_buf declaration.
>
> In file included from ../arch/powerpc/xmon/xmon.c:47:
> ../arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
> built-in function 'setjmp' requires the declaration of the 'jmp_buf'
> type, commonly provided in the header <setjmp.h>.
> [-Werror,-Wincomplete-setjmp-declaration]
> extern long setjmp(long *);
>             ^
> ../arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of
> built-in function 'longjmp' requires the declaration of the 'jmp_buf'
> type, commonly provided in the header <setjmp.h>.
> [-Werror,-Wincomplete-setjmp-declaration]
> extern void longjmp(long *, long);
>             ^
> 2 errors generated.
>
> We are not using the standard library's longjmp/setjmp implementations
> for obvious reasons; make this clear to clang by using -ffreestanding
> on these files.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
https://godbolt.org/z/B2oQnl

>
> Cc: stable@vger.kernel.org # 4.14+
> Link: https://github.com/ClangBuiltLinux/linux/issues/625
> Link: https://github.com/llvm/llvm-project/commit/3be25e79477db2d31ac46493d97eca8c20592b07
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v3:
>
> * Use -ffreestanding instead of outright disabling the warning because
>   it is legitimate.
>
> I skipped v2 because the first patch in the series already had a v2.
>
>  arch/powerpc/kernel/Makefile | 4 ++--
>  arch/powerpc/xmon/Makefile   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index c9cc4b689e60..19f19c8c874b 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -5,8 +5,8 @@
>
>  CFLAGS_ptrace.o                += -DUTS_MACHINE='"$(UTS_MACHINE)"'
>
> -# Disable clang warning for using setjmp without setjmp.h header
> -CFLAGS_crash.o         += $(call cc-disable-warning, builtin-requires-header)
> +# Avoid clang warnings around longjmp/setjmp declarations
> +CFLAGS_crash.o         += -ffreestanding
>
>  ifdef CONFIG_PPC64
>  CFLAGS_prom_init.o     += $(NO_MINIMAL_TOC)
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index f142570ad860..c3842dbeb1b7 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for xmon
>
> -# Disable clang warning for using setjmp without setjmp.h header
> -subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
> +# Avoid clang warnings around longjmp/setjmp declarations
> +subdir-ccflags-y := -ffreestanding
>
>  GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
