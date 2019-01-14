Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC34C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:04:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519562064C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mn52QhlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519562064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dmF95vQbzDqYq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 08:04:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="mn52QhlS"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dmCR0hGtzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 08:03:08 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so167231pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 13:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jTVcAFXStX1sZAD8oMmqfkPDtAlYSU21/wL+rcWrfuk=;
 b=mn52QhlSkLTZbyF9klGEw3avjcr5wkk+yMk8jhpNo8x1dtr+6jQJDmQc+xOT5hH2Qe
 XIPv8pncJgbVOTV3/i62Jaj1ScYufOqL3osR8d2INc2IMzVMNsgSZ4cBCIeEZB5Sc6GM
 fPNsBY/QT+B2ODJDan7Fl0YZyet7h5tRz59YnHpYJviAxzfMtcWDvYXhwVmJpQ/4g+jZ
 X6YOlUV4KuY1KRZSHFsItmiv4/DAhDT2E+XTCN3WPd59maNYrua6T6kO+8WX+1CCJ1Uz
 9lhH6P3rioA7WNyRHU1zG0vqu7UfnVxYPBeusXvMHrPottwkqdKYrMt5SCR4G/81hhQS
 SCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jTVcAFXStX1sZAD8oMmqfkPDtAlYSU21/wL+rcWrfuk=;
 b=U9N6MW9IsBEpY2b2G2I06REKlIy6Qbm05gHdPn/dZ8sOZgptyjbt0cWmYvMv6TLkpE
 OhIZHv4t/ia52i2JgDfN4qfBctzYhtcf8yv1lSe45eAbVp42AHPj07N7K/jP640zQLgi
 JgDp5V4v07h4m3rQSbACdfJi/g+qM03i4lZLL8cEXNfk4JrSmadYpcVSeiVfHd+4ufKg
 jAl9g/wftZtsMdJnz/EMdQTazNt3nPeN/JrOlZiMymbO1rsGG456GUm7oEEf7Ur/4l1+
 r9k3yMQLQXc83axFd+AC/vzECmJhS8UiFBfCtisGBCHsZBzSlwjWnSGw3t+B9HnT9Q16
 X1VQ==
X-Gm-Message-State: AJcUukf4VThRfrTpM7+hNuzc/GFnZroC/aX1FECFQCi+0FSNXNX5CU33
 Fl88bkvu/ZO71PAV8lmUX9kdASJYco8/FWdAF534ccE1B+CAFQ==
X-Google-Smtp-Source: ALg8bN6vNIMwPJ6iVhAqn4o0R/YSm6a2bS9aEFMZHOJYZcTqXsCzlFeV1j8gSIGCONaNxc5RLr5/RHXYX8T5O/0U+qE=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr428294pfs.174.1547499786643; 
 Mon, 14 Jan 2019 13:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20190111235056.27435-1-joel@jms.id.au>
In-Reply-To: <20190111235056.27435-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 14 Jan 2019 13:02:55 -0800
Message-ID: <CAKwvOdm8DVYGg2DXpT2HxHsA0grg_BrPwGV5d0M8Fnjz1R7o8Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Use ALIGN instead of BLOCK
To: Joel Stanley <joel@jms.id.au>
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
Cc: George Rimar <grimar@accesssoftek.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 11, 2019 at 3:51 PM Joel Stanley <joel@jms.id.au> wrote:
>
> In the ld documentation under Builtin Functions:
>
>   BLOCK(exp)
>
>     This is a synonym for ALIGN, for compatibility with older linker scripts.
>
> Clang's linker (lld) doesn't know about BLOCK so remove this use of it.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/253
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Should get a suggested-by tag:
Suggested-by: George Rimar <grimar@accesssoftek.com>
via:
https://github.com/ClangBuiltLinux/linux/issues/253#issuecomment-449715453
https://reviews.llvm.org/D56060#1340554

ftp://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC14
documents ALIGN while for BLOCK:
ftp://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC21

Looks like they do the same thing.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index ad1c77f71f54..3ae4c959f95b 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -86,11 +86,11 @@ SECTIONS
>
>  #ifdef CONFIG_PPC64
>         /*
> -        * BLOCK(0) overrides the default output section alignment because
> +        * ALIGN(0) overrides the default output section alignment because
>          * this needs to start right after .head.text in order for fixed
>          * section placement to work.
>          */
> -       .text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
> +       .text ALIGN(0) : AT(ADDR(.text) - LOAD_OFFSET) {
>  #ifdef CONFIG_LD_HEAD_STUB_CATCH
>                 KEEP(*(.linker_stub_catch));
>                 . = . ;
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
